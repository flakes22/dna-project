# ==========================================
#  main_app.py  — Part 1
#  Utilities + Safe Input + DB Connection
# ==========================================

import pymysql
import sys


# ----------- SAFE USER INPUT ---------------
def safe_input(prompt):
    """Input wrapper to avoid crashes on CTRL+C or empty values."""
    try:
        value = input(prompt).strip()
        return value
    except KeyboardInterrupt:
        print("\nExiting.")
        sys.exit(0)


# ----------- DISPLAY ROWS NICELY -----------
def print_rows(rows):
    """Pretty print rows from MySQL query."""
    if not rows:
        print("\n[!] No records found.\n")
        return
    print("\n================= RESULT =================")
    for row in rows:
        print("------------------------------------------")
        for key, val in row.items():
            print(f"{key}: {val}")
    print("==========================================\n")


# ----------- CONNECT TO DATABASE -----------
def connect_to_db():
    """Connect to MySQL using pymysql."""
    dbname = safe_input("Enter database name (default 'SLM_secret_agency_db'): ")
    if dbname == "":
        dbname = "SLM_secret_agency_db"

    user = safe_input("Username: ")
    password = safe_input("Password: ")

    try:
        conn = pymysql.connect(
            host="localhost",
            user=user,
            password=password,
            database=dbname,
            cursorclass=pymysql.cursors.DictCursor,
            autocommit=True,
        )
        print("\n[✓] Connected successfully.\n")
        return conn
    except Exception as e:
        print(f"\n[ERROR] Could not connect: {e}\n")
        sys.exit(1)

# ==========================================
#  Part 2 — Search People / Business + Auto-ID
# ==========================================


# ----------- AUTO-GENERATE PI_DATA_ID --------
def get_next_pi_data_id(conn):
    """Returns next available pi_data_id (max+1)."""
    with conn.cursor() as cur:
        cur.execute("SELECT COALESCE(MAX(pi_data_id), 0) + 1 AS next_id FROM pi_data;")
        row = cur.fetchone()
        return row["next_id"]


# ----------- SEARCH PEOPLE -------------------
def search_people(conn):
    """
    Search people by name (fname/lname).
    User enters part of a name, list appears, user selects SSN.
    """
    term = safe_input("Enter name to search (fname/lname): ")

    sql = """
        SELECT ssn, fname, lname, age, sex
        FROM people
        WHERE fname LIKE %s OR lname LIKE %s
        ORDER BY lname, fname;
    """

    with conn.cursor() as cur:
        cur.execute(sql, (f"%{term}%", f"%{term}%"))
        rows = cur.fetchall()

    if not rows:
        print("\n[!] No matching people found.\n")
        return None

    print("\nSelect a person:")
    print("----------------------------------")
    for i, r in enumerate(rows, start=1):
        print(f"{i}. {r['fname']} {r['lname']}  (SSN: {r['ssn']})")

    print("----------------------------------")
    choice = safe_input("Enter number: ")

    if not choice.isdigit() or not (1 <= int(choice) <= len(rows)):
        print("[!] Invalid selection.")
        return None

    return rows[int(choice) - 1]["ssn"]


# ----------- SEARCH BUSINESS ------------------
def search_business(conn):
    """
    Search businesses by name.
    User selects business_id.
    """
    term = safe_input("Enter part of business name: ")

    sql = """
        SELECT business_id, business_name, revenue
        FROM business
        WHERE business_name LIKE %s
        ORDER BY business_name;
    """

    with conn.cursor() as cur:
        cur.execute(sql, (f"%{term}%",))
        rows = cur.fetchall()

    if not rows:
        print("\n[!] No businesses found.\n")
        return None

    print("\nSelect a business:")
    print("----------------------------------")
    for i, r in enumerate(rows, start=1):
        print(f"{i}. {r['business_name']}  (ID: {r['business_id']})")

    print("----------------------------------")
    choice = safe_input("Enter number: ")

    if not choice.isdigit() or not (1 <= int(choice) <= len(rows)):
        print("[!] Invalid selection.")
        return None

    return rows[int(choice) - 1]["business_id"]

# ==========================================
#  Part 3 — SECRET AGENCY FUNCTIONS
# ==========================================


# ----------- 1. VIEW AGENT DOSSIER -----------
def view_agent_dossier(conn):
    emp_id = safe_input("Enter agent employee_id: ")
    # ---------------- Block A: Basic Agent Profile ----------------
    sql_profile = """
        SELECT 
            sa.employee_id,
            sa.actual_name,
            sa.post,
            p.ssn,
            p.fname,
            p.lname,
            p.age,
            p.sex,
            p.email,
            p.street,
            p.city,
            sd.zipcode,
            er.organisation_name,
            er.occupation,
            er.salary
        FROM secret_agent sa
        JOIN people p ON sa.ssn = p.ssn
        LEFT JOIN street_details sd ON p.street = sd.street AND p.city = sd.city
        LEFT JOIN employment_records er ON p.ssn = er.ssn
        WHERE sa.employee_id = %s;
    """

    with conn.cursor() as cur:
        cur.execute(sql_profile, (emp_id,))
        profile = cur.fetchall()
        print("\n================ AGENT DOSSIER ================")
        print_rows(profile)


# ----------- NEW: VIEW PI DATA COLLECTED BY AGENT -----------
def view_agent_pi_data(conn):
    """Show PI data entries collected by a given agent (employee_id)."""
    emp_id = safe_input("Enter agent employee_id: ")

    sql_pi = """
        SELECT 
            inv.subject_ssn,
            p.fname,
            p.lname,
            pd.pi_data_id,
            pd.collected_info
        FROM investigates inv
        JOIN pi_data pd ON inv.pi_data_id = pd.pi_data_id
        JOIN people p ON inv.subject_ssn = p.ssn
        WHERE inv.employee_id = %s
        ORDER BY pd.pi_data_id;
    """

    with conn.cursor() as cur:
        cur.execute(sql_pi, (emp_id,))
        pi_rows = cur.fetchall()
        print("\n============= PI DATA COLLECTED BY AGENT =============")
        print_rows(pi_rows)



# ----------- 2. IDENTIFY SUSPECT --------------
def identify_suspect(conn):
    print("\nSearch suspect:")
    ssn = search_people(conn)
    if ssn is None:
        return

    sql = """
        SELECT 
            p.ssn,
            p.fname,
            p.lname,
            p.age,
            p.sex,
            p.email,
            p.street,
            p.city,
            sd.zipcode
        FROM people p
        LEFT JOIN street_details sd 
            ON p.street = sd.street AND p.city = sd.city
        WHERE p.ssn = %s;
    """

    with conn.cursor() as cur:
        cur.execute(sql, (ssn,))
        rows = cur.fetchall()
        print_rows(rows)
        # Also show criminal records for this person (if any)
        sql_crime = """
            SELECT 
                p.ssn,
                p.fname,
                p.lname,
                rs.report_id,
                rs.report_date,
                rs.officer,
                rs.summary
            FROM criminal_records cr
            JOIN report_summary rs ON cr.report_id = rs.report_id
            JOIN people p ON cr.ssn = p.ssn
            WHERE p.ssn = %s
            ORDER BY rs.report_date DESC;
        """

        cur.execute(sql_crime, (ssn,))
        crime_rows = cur.fetchall()
        if crime_rows:
            print("\n========== CRIMINAL RECORDS FOR PERSON ===========")
            print_rows(crime_rows)


# ----------- 3. LOG NEW INTELLIGENCE ----------
def log_new_intelligence(conn):
    print("\nSelect SUBJECT:")
    subject_ssn = search_people(conn)
    if subject_ssn is None:
        return

    print("\nSelect AGENT (investigator):")
    emp_id = safe_input("Enter agent employee_id: ")

    info = safe_input("Enter collected intelligence text: ")

    # Auto ID
    pi_id = get_next_pi_data_id(conn)
    print(f"[Auto] Assigned pi_data_id = {pi_id}")

    with conn.cursor() as cur:

        # Insert into pi_data
        sql1 = "INSERT INTO pi_data (pi_data_id, collected_info) VALUES (%s, %s);"
        cur.execute(sql1, (pi_id, info))

        # Link via investigates
        sql2 = """
            INSERT INTO investigates (subject_ssn, employee_id, pi_data_id)
            VALUES (%s, %s, %s);
        """
        cur.execute(sql2, (subject_ssn, emp_id, pi_id))

    print("\n[✓] Intelligence logged successfully.\n")


# ----------- 4. LOG NEW EVIDENCE --------------
def log_new_evidence(conn):
    chain_status = safe_input("Enter chain_of_custody_status (or press ENTER for default): ")
    if chain_status == "":
        chain_status = "COLLECTED"

    collection_date = safe_input("Enter collection_date (YYYY-MM-DD): ")

    # Get max length for evidence_type column
    with conn.cursor() as cur:
        cur.execute("SHOW COLUMNS FROM evidence_collection LIKE 'evidence_type';")
        col_info = cur.fetchone()
        maxlen = None
        if col_info and 'Type' in col_info:
            import re
            m = re.match(r'varchar\\((\\d+)\\)', col_info['Type'])
            if m:
                maxlen = int(m.group(1))

    while True:
        evidence_type = safe_input("Enter evidence_type (e.g. WEAPON, PHOTO, DNA): ")
        if maxlen and len(evidence_type) > maxlen:
            print(f"[!] Too long. Max length for evidence_type is {maxlen} characters. Please re-enter.")
        else:
            break

    print("\nSelect AGENT who found the evidence:")
    emp_id = safe_input("Enter agent employee_id: ")

    print("\nSelect SUBJECT related to evidence:")
    subject_ssn = search_people(conn)
    if subject_ssn is None:
        return

    print("\nSelect property where evidence was found (if any):")
    found_pid = safe_input("Enter property_id (or press ENTER for NULL): ")
    found_pid = found_pid if found_pid else None

    print("\nSelect business where evidence is stored (if any):")
    stored_bid = search_business(conn)
    # business can be NULL
    stored_bid = stored_bid if stored_bid else None

    with conn.cursor() as cur:

        # 1) Insert evidence_collection
        sql1 = """
            INSERT INTO evidence_collection 
            (chain_of_custody_status, collection_date, evidence_type)
            VALUES (%s, %s, %s);
        """
        cur.execute(sql1, (chain_status, collection_date, evidence_type))

        # Get new evidence_id
        cur.execute("SELECT LAST_INSERT_ID() AS eid;")
        eid = cur.fetchone()["eid"]

        # 2) Insert evidence_gathering
        sql2 = """
            INSERT INTO evidence_gathering
            (employee_id, subject_ssn, found_at_property_id, stored_at_business_id, evidence_id)
            VALUES (%s, %s, %s, %s, %s);
        """
        cur.execute(sql2, (emp_id, subject_ssn, found_pid, stored_bid, eid))

    print("\n[✓] Evidence logged successfully.\n")


# ----------- 5. UPDATE CHAIN OF CUSTODY -------
def update_chain_of_custody(conn):
    eid = safe_input("Enter evidence_id: ")
    status = safe_input("Enter new status: ")

    sql = """
        UPDATE evidence_collection
        SET chain_of_custody_status = %s
        WHERE evidence_id = %s;
    """

    with conn.cursor() as cur:
        cur.execute(sql, (status, eid))

    print("\n[✓] Chain of custody updated.\n")


# ----------- 6. CREATE FINANCIAL ANALYSIS -----
def create_financial_analysis(conn):

    print("\nSelect analyst (agent):")
    emp_id = safe_input("Enter analyst employee_id: ")

    print("\nSelect source PERSON:")
    source_ssn = search_people(conn)
    if source_ssn is None:
        return

    print("\nSelect BUSINESS related to analysis:")
    business_id = search_business(conn)
    if business_id is None:
        return

    transaction_id = safe_input("Enter transaction_id (must exist in expenditure_records): ")

    analysis_date = safe_input("Enter analysis_date (YYYY-MM-DD): ")
    note = safe_input("Enter analysis note: ")

    # Check if duplicate PK exists
    check_sql = """
        SELECT *
        FROM financial_analysis
        WHERE source_ssn = %s AND business_id = %s AND transaction_id = %s;
    """

    insert_sql = """
        INSERT INTO financial_analysis
        (employee_id, source_ssn, business_id, transaction_id, analysis_date, analysis_note)
        VALUES (%s, %s, %s, %s, %s, %s);
    """

    update_sql = """
        UPDATE financial_analysis
        SET employee_id=%s, analysis_date=%s, analysis_note=%s
        WHERE source_ssn = %s AND business_id = %s AND transaction_id = %s;
    """

    with conn.cursor() as cur:
        cur.execute(check_sql, (source_ssn, business_id, transaction_id))
        row = cur.fetchone()

        if row:
            print("\n[!] Record exists. Overwrite? (y/n)")
            if safe_input("> ").lower() == "y":
                cur.execute(update_sql,
                    (emp_id, analysis_date, note,
                     source_ssn, business_id, transaction_id))
                print("\n[✓] Analysis updated.\n")
            else:
                print("\n[!] Cancelled.\n")
        else:
            cur.execute(insert_sql,
                (emp_id, source_ssn, business_id, transaction_id,
                 analysis_date, note))
            print("\n[✓] New financial analysis added.\n")


# ----------- 7. UPDATE AGENT COVER -------------
def update_agent_cover(conn):

    print("\nSelect AGENT’s PERSON record:")
    ssn = search_people(conn)
    if ssn is None:
        return

    new_org = safe_input("New organisation_name (business): ")
    new_occ = safe_input("New occupation: ")
    new_salary = safe_input("New salary: ")

    sql = """
        UPDATE employment_records
        SET organisation_name = %s,
            occupation = %s,
            salary = %s
        WHERE ssn = %s;
    """

    with conn.cursor() as cur:
        cur.execute(sql, (new_org, new_occ, new_salary, ssn))

    print("\n[✓] Cover job updated.\n")


# ----------- 8. PURGE COMPROMISED ASSET -------
def purge_person(conn):
    ssn = search_people(conn)
    if ssn is None:
        return

    with conn.cursor() as cur:
        cur.execute("DELETE FROM people WHERE ssn=%s;", (ssn,))

    print("\n[✓] Person deleted.\n")


# ----------- 9. BURN INTELLIGENCE -------------
def burn_pi_data(conn):
    pi_id = safe_input("Enter pi_data_id to delete: ")

    with conn.cursor() as cur:
        cur.execute("DELETE FROM pi_data WHERE pi_data_id=%s;", (pi_id,))

    print("\n[✓] Intelligence entry removed.\n")

# ==========================================
#  Part 4 — POLICE DEPARTMENT FUNCTIONS
# ==========================================


# ----------- 1. SEARCH CRIMINAL HISTORY ------
def search_criminal_history(conn):
    print("\nSelect person to view criminal history:")
    ssn = search_people(conn)
    if ssn is None:
        return

    sql = """
        SELECT 
            p.ssn,
            p.fname,
            p.lname,
            rs.report_id,
            rs.report_date,
            rs.officer,
            rs.summary
        FROM people p
        JOIN criminal_records cr ON p.ssn = cr.ssn
        JOIN report_summary rs ON cr.report_id = rs.report_id
        WHERE p.ssn = %s
        ORDER BY rs.report_date DESC;
    """

    with conn.cursor() as cur:
        cur.execute(sql, (ssn,))
        rows = cur.fetchall()
        print_rows(rows)


# ----------- 2. FILE NEW CRIMINAL REPORT -----
def file_new_criminal_report(conn):
    print("\nSelect SUSPECT:")
    ssn = search_people(conn)
    if ssn is None:
        return
    
    print("\nSelect OFFICER (must be a PERSON by SSN):")
    officer_ssn = search_people(conn)  # Gets SSN
    if officer_ssn is None:
        return

    report_date = safe_input("Enter report_date (YYYY-MM-DD): ")
    summary = safe_input("Enter summary text: ")

    with conn.cursor() as cur:
        sql1 = """
            INSERT INTO report_summary (report_date, officer, summary)
            VALUES (%s, %s, %s);
        """
        cur.execute(sql1, (report_date, officer_ssn, summary))  # Uses SSN as officer

        # Get the new report_id
        cur.execute("SELECT LAST_INSERT_ID() AS rid;")
        rid = cur.fetchone()["rid"]

        # Link suspect → report
        sql2 = "INSERT INTO criminal_records (ssn, report_id) VALUES (%s, %s);"
        cur.execute(sql2, (ssn, rid))

    print("\n[✓] Criminal report filed.\n")


# ----------- 3. UPDATE CASE SUMMARY ----------
def update_case_summary(conn):
    rid = safe_input("Enter report_id to update: ")
    add_text = safe_input("Enter additional summary text: ")

    sql = """
        UPDATE report_summary
        SET summary = CONCAT(IFNULL(summary, ''), ' [UPDATE]: ', %s)
        WHERE report_id = %s;
    """

    with conn.cursor() as cur:
        cur.execute(sql, (add_text, rid))

    print("\n[✓] Case summary updated.\n")


# ----------- 4. DELETE CRIMINAL RECORD -------
def delete_criminal_record(conn):
    rid = safe_input("Enter report_id to delete: ")

    with conn.cursor() as cur:
        # First: remove link
        cur.execute("DELETE FROM criminal_records WHERE report_id=%s;", (rid,))
        # Then: remove report
        cur.execute("DELETE FROM report_summary WHERE report_id=%s;", (rid,))

    print("\n[✓] Criminal report deleted.\n")

# ==========================================
#  Part 5 — GOVERNMENT + PUBLIC PORTAL
# ==========================================


# ----------- GOVERNMENT 1: PROPERTY OWNERSHIP ----------
def view_property_ownership(conn):

    sql = """
        SELECT 'private_citizens' AS owner_type, COUNT(*) AS count
        FROM property_owned_by_people
        UNION
        SELECT 'businesses' AS owner_type, COUNT(*)
        FROM property_owned_by_business
        UNION
        SELECT 'government' AS owner_type, COUNT(*)
        FROM property_owned_by_government;
    """

    with conn.cursor() as cur:
        cur.execute(sql)
        rows = cur.fetchall()
        print_rows(rows)


# ----------- GOVERNMENT 2: BUSINESS REVENUE REPORT -----
def view_business_revenue(conn):

    sql = """
        SELECT business_name, revenue
        FROM business
        ORDER BY revenue DESC;
    """

    with conn.cursor() as cur:
        cur.execute(sql)
        rows = cur.fetchall()
        print_rows(rows)


# ----------- GOVERNMENT 3: PUBLIC EXPENDITURE ----------
def view_public_expenditures(conn):

    sql = """
        SELECT er.transaction_id, er.money_spent, er.transaction_date
        FROM expenditure_records er
        JOIN expenditure_by_government eg 
            ON er.transaction_id = eg.transaction_id
        ORDER BY er.money_spent DESC;
    """

    with conn.cursor() as cur:
        cur.execute(sql)
        rows = cur.fetchall()
        print_rows(rows)



# ==========================================
#              PUBLIC PORTAL
# ==========================================


# ----------- PUBLIC 1: BUSINESS DIRECTORY ------------
def search_business_directory(conn):
    term = safe_input("Enter part of business name: ")

    sql = """
        SELECT business_name, revenue
        FROM business
        WHERE business_name LIKE %s
        ORDER BY business_name;
    """

    with conn.cursor() as cur:
        cur.execute(sql, (f"%{term}%",))
        rows = cur.fetchall()
        print_rows(rows)


# ----------- PUBLIC 2: MAJOR GOVERNMENT PROJECTS ------
def view_major_projects(conn):
    min_amount = safe_input("Enter minimum project cost: ")

    sql = """
        SELECT er.transaction_id, er.money_spent, er.transaction_date
        FROM expenditure_records er
        JOIN expenditure_by_government eg 
            ON er.transaction_id = eg.transaction_id
        WHERE er.money_spent > %s
        ORDER BY er.money_spent DESC;
    """

    with conn.cursor() as cur:
        cur.execute(sql, (min_amount,))
        rows = cur.fetchall()
        print_rows(rows)


# ----------- PUBLIC 3: CONVICTED CRIMINAL LIST --------
def view_convicted_criminals(conn):

    sql = """
        SELECT DISTINCT p.fname, p.lname
        FROM people p
        JOIN criminal_records cr ON p.ssn = cr.ssn
        ORDER BY p.lname, p.fname;
    """

    with conn.cursor() as cur:
        cur.execute(sql)
        rows = cur.fetchall()
        print_rows(rows)

# ==========================================
#  Part 6 — MENU SYSTEM + MAIN PROGRAM
# ==========================================


# ----------- SECRET AGENCY MENU --------------
def secret_agency_menu(conn):
    while True:
        print("""
--- CLASSIFIED TERMINAL (SECRET AGENCY) ---
1. View Agent Dossier
2. Identify Suspect
3. Log New Intelligence
4. Evidence: Log New Item
5. Evidence: Update Chain of Custody
6. Financial Scrutiny: Create Analysis Record
7. Update Agent Cover (Fake Job/Salary)
8. Purge Compromised Asset (DELETE Person)
9. Burn Intelligence (DELETE PI Data)
10. View PI Data collected by Agent
q. Back to Main Menu
""")
        choice = safe_input("Enter choice: ")

        if choice == "1":
            view_agent_dossier(conn)
        elif choice == "2":
            identify_suspect(conn)
        elif choice == "3":
            log_new_intelligence(conn)
        elif choice == "4":
            log_new_evidence(conn)
        elif choice == "5":
            update_chain_of_custody(conn)
        elif choice == "6":
            create_financial_analysis(conn)
        elif choice == "7":
            update_agent_cover(conn)
        elif choice == "8":
            purge_person(conn)
        elif choice == "9":
            burn_pi_data(conn)
        elif choice == "10":
            view_agent_pi_data(conn)
        elif choice.lower() == "q":
            return
        else:
            print("[!] Invalid option.\n")



# ----------- POLICE MENU ---------------------
def police_menu(conn):
    while True:
        print("""
--- LAW ENFORCEMENT TERMINAL ---
1. Search Criminal History
2. File New Criminal Report
3. Update Case Status/Summary
4. Delete Criminal Record
q. Back to Main Menu
""")
        choice = safe_input("Enter choice: ")

        if choice == "1":
            search_criminal_history(conn)
        elif choice == "2":
            file_new_criminal_report(conn)
        elif choice == "3":
            update_case_summary(conn)
        elif choice == "4":
            delete_criminal_record(conn)
        elif choice.lower() == "q":
            return
        else:
            print("[!] Invalid option.\n")



# ----------- GOVERNMENT MENU -----------------
def government_menu(conn):
    while True:
        print("""
--- WELLSBURY CITY HALL ---
1. View Aggregate Property Ownership
2. View Business Revenue Report
3. View Public Expenditure Records
q. Back to Main Menu
""")
        choice = safe_input("Enter choice: ")

        if choice == "1":
            view_property_ownership(conn)
        elif choice == "2":
            view_business_revenue(conn)
        elif choice == "3":
            view_public_expenditures(conn)
        elif choice.lower() == "q":
            return
        else:
            print("[!] Invalid option.\n")



# ----------- PUBLIC PORTAL MENU --------------
def public_menu(conn):
    while True:
        print("""
--- WELLSBURY COMMUNITY PORTAL ---
1. Search Business Directory
2. View Major Government Projects
3. Convicted Criminal List
q. Back to Main Menu
""")
        choice = safe_input("Enter choice: ")

        if choice == "1":
            search_business_directory(conn)
        elif choice == "2":
            view_major_projects(conn)
        elif choice == "3":
            view_convicted_criminals(conn)
        elif choice.lower() == "q":
            return
        else:
            print("[!] Invalid option.\n")



# ----------- MAIN MENU ------------------------
def main_menu(conn):
    while True:
        print("""
WELCOME TO THE WELLSBURY DATABASE SYSTEM
Select User Level:
1. Secret Agency (Admin Access)
2. Police Department
3. Government Official
4. Public Portal
q. Quit
""")
        choice = safe_input("Enter choice: ")

        if choice == "1":
            secret_agency_menu(conn)
        elif choice == "2":
            police_menu(conn)
        elif choice == "3":
            government_menu(conn)
        elif choice == "4":
            public_menu(conn)
        elif choice.lower() == "q":
            print("\nGoodbye.\n")
            conn.close()
            sys.exit(0)
        else:
            print("[!] Invalid selection.\n")



# ----------- PROGRAM ENTRY POINT -------------
if __name__ == "__main__":
    conn = connect_to_db()
    main_menu(conn)