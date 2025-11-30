-- Create database
CREATE DATABASE IF NOT EXISTS `SLM_secret_agency_db`
  CHARACTER SET = 'utf8mb4'
  COLLATE = 'utf8mb4_unicode_ci';
USE `SLM_secret_agency_db`;

-- STREET_DETAILS: master table for addresses (street, city, zipcode)
CREATE TABLE street_details (
  street VARCHAR(200) NOT NULL,
  city VARCHAR(100) NOT NULL ,
  zipcode VARCHAR(20) NOT NULL,
  PRIMARY KEY(street,city)
) ENGINE=InnoDB;

-- PEOPLE: citizens/subjects
CREATE TABLE people (
  ssn VARCHAR(20) NOT NULL PRIMARY KEY,          -- natural unique id
  fname VARCHAR(100) NOT NULL,
  lname VARCHAR(100) NOT NULL,
  age TINYINT UNSIGNED CHECK (age BETWEEN 0 AND 120),
  sex ENUM('M','F','O') DEFAULT 'O',             -- M/F/Other
  email VARCHAR(255) UNIQUE,
  street VARCHAR(200),
  city VARCHAR(100)   ,-- FK to street_details
  phone VARCHAR(10),
  CONSTRAINT fk_people_street FOREIGN KEY (street, city)
    REFERENCES street_details(street, city)
    ON DELETE SET NULL
    ON UPDATE CASCADE
) ENGINE=InnoDB;

-- CONTACT_DETAILS: phone/contact numbers for people (multiple allowed)
CREATE TABLE contact_details (
  ssn VARCHAR(20) NOT NULL,
  contact VARCHAR(30) NOT NULL,
  PRIMARY KEY (ssn, contact),
  CONSTRAINT fk_contact_people FOREIGN KEY (ssn)
    REFERENCES people(ssn)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB;

-- BUSINESS: businesses
CREATE TABLE business (
  business_id INT AUTO_INCREMENT PRIMARY KEY,
  business_name VARCHAR(255) NOT NULL UNIQUE,
  owner_ssn VARCHAR(20),               -- owner is a person
  revenue DECIMAL(18,2) DEFAULT 0 CHECK (revenue >= 0),
  CONSTRAINT fk_business_owner FOREIGN KEY (owner_ssn)
    REFERENCES people(ssn)
    ON DELETE SET NULL
    ON UPDATE CASCADE
) ENGINE=InnoDB;


-- SECRET_AGENT: agents (employees). Each agent optionally linked to a person record (ssn)
CREATE TABLE secret_agent (
  employee_id INT AUTO_INCREMENT PRIMARY KEY,
  ssn VARCHAR(20) NOT NULL,                    
  actual_name VARCHAR(50),
  post VARCHAR(100),
  CONSTRAINT fk_agent_person FOREIGN KEY (ssn)
    REFERENCES people(ssn)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB;

-- PI_DATA: private investigator data / collected intelligence
CREATE TABLE pi_data (
  pi_data_id INT NOT NULL,
  collected_info TEXT NOT NULL,
  PRIMARY KEY( pi_data_id)
) ENGINE=InnoDB;

-- REPORT_SUMMARY_DETAILS: reports (officer references secret_agent)
CREATE TABLE report_summary (
  report_id INT AUTO_INCREMENT PRIMARY KEY,
  report_date DATE NOT NULL,
  officer VARCHAR(20),            -- who filed the report
  summary TEXT,
  CONSTRAINT fk_report_officer FOREIGN KEY (officer)
    REFERENCES people(ssn)
    ON DELETE SET NULL
    ON UPDATE CASCADE
) ENGINE=InnoDB;

-- CRIMINAL_RECORDS: records linking a person to a report (one person may have many)
CREATE TABLE criminal_records (
  ssn VARCHAR(20) NOT NULL,
  report_id INT NOT NULL,
  CONSTRAINT fk_criminal_person FOREIGN KEY (ssn)
    REFERENCES people(ssn)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_criminal_report FOREIGN KEY (report_id)
    REFERENCES report_summary(report_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  PRIMARY KEY (ssn, report_id)
) ENGINE=InnoDB;

-- EMPLOYMENT_RECORDS: employment history for people
CREATE TABLE employment_records (
  ssn VARCHAR(20) NOT NULL PRIMARY KEY,
  organisation_name VARCHAR(255),
  occupation VARCHAR(150),
  salary DECIMAL(15,2) CHECK (salary >= 0),
  CONSTRAINT fk_employment_person FOREIGN KEY (ssn)
    REFERENCES people(ssn)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_organisation FOREIGN KEY (organisation_name)
    REFERENCES business(business_name)
    ON DELETE SET NULL
    ON UPDATE CASCADE
) ENGINE=InnoDB;

-- EVIDENCE_COLLECTION: evidence meta info
CREATE TABLE evidence_collection (
  evidence_id INT AUTO_INCREMENT PRIMARY KEY,
  chain_of_custody_status ENUM(
  'COLLECTED',
  'SEALED',
  'IN_TRANSIT',
  'RECEIVED',
  'PROCESSING',
  'ANALYZED',
  'STORED',
  'TRANSFERRED',
  'USED_IN_REPORT',
  'RELEASED',
  'CLOSED',
  'DISPOSED'
) DEFAULT 'COLLECTED',
  collection_date DATE,
  evidence_type ENUM(
  'BIOLOGICAL',
  'FINGERPRINT',
  'DNA',
  'BLOOD_SAMPLE',
  'HAIR_FIBER',
  'TRACE_FIBER',
  'WEAPON',
  'FIREARM',
  'AMMUNITION',
  'TOOLMARK',
  'DOCUMENT',
  'DIGITAL_DEVICE',
  'MOBILE_PHONE',
  'COMPUTER',
  'STORAGE_MEDIA',
  'AUDIO_RECORDING',
  'VIDEO_RECORDING',
  'PHOTO',
  'CHEMICAL_SUBSTANCE',
  'DRUGS',
  'EXPLOSIVE_MATERIAL',
  'FINANCIAL_RECORD',
  'PROPERTY_ITEM',
  'VEHICLE_PART',
  'OTHER'
)
) ENGINE=InnoDB;

-- PROPERTY_RECORDS: properties
CREATE TABLE property_records (
  property_id INT AUTO_INCREMENT PRIMARY KEY,
  bought_when DATE,
  worth DECIMAL(18,2) CHECK (worth >= 0)
) ENGINE=InnoDB;

-- PROPERTY_RECORDS_OWNED_BY_PEOPLE
CREATE TABLE property_owned_by_people (
  property_id INT NOT NULL PRIMARY KEY,
  ssn VARCHAR(20) NOT NULL,
  CONSTRAINT fk_prop_people_property FOREIGN KEY (property_id)
    REFERENCES property_records(property_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_prop_people_person FOREIGN KEY (ssn)
    REFERENCES people(ssn)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB;

-- PROPERTY_RECORDS_OWNED_BY_BUSINESS
CREATE TABLE property_owned_by_business (
  property_id INT NOT NULL PRIMARY KEY,
  business_id INT NOT NULL,
  CONSTRAINT fk_prop_business_property FOREIGN KEY (property_id)
    REFERENCES property_records(property_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_prop_business_business FOREIGN KEY (business_id)
    REFERENCES business(business_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB;

-- PROPERTY_RECORDS_OWNED_BY_GOVERNMENT
-- Government ownership simply records property_id and agency name
CREATE TABLE property_owned_by_government (
  property_id INT NOT NULL PRIMARY KEY,
  CONSTRAINT fk_prop_gov_property FOREIGN KEY (property_id)
    REFERENCES property_records(property_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB;

-- EXPENDITURE_RECORDS: transactions
CREATE TABLE expenditure_records (
  transaction_id INT AUTO_INCREMENT PRIMARY KEY,
  money_spent DECIMAL(18,2) NOT NULL CHECK (money_spent >= 0),
  transaction_date DATE NOT NULL
) ENGINE=InnoDB;

-- EXPENDITURE_RECORDS_BY_PEOPLE
CREATE TABLE expenditure_by_people (
  transaction_id INT NOT NULL PRIMARY KEY,
  ssn VARCHAR(20) NOT NULL,
  CONSTRAINT fk_exp_people_transaction FOREIGN KEY (transaction_id)
    REFERENCES expenditure_records(transaction_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_exp_people_person FOREIGN KEY (ssn)
    REFERENCES people(ssn)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB;

-- EXPENDITURE_RECORDS_BY_BUSINESS
CREATE TABLE expenditure_by_business (
  transaction_id INT NOT NULL PRIMARY KEY,
  business_id INT NOT NULL,
  CONSTRAINT fk_exp_business_transaction FOREIGN KEY (transaction_id)
    REFERENCES expenditure_records(transaction_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_exp_business_business FOREIGN KEY (business_id)
    REFERENCES business(business_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB;

-- EXPENDITURE_RECORDS_OWNED_BY_GOVERNMENT
CREATE TABLE expenditure_by_government (
  transaction_id INT NOT NULL PRIMARY KEY,
  CONSTRAINT fk_exp_gov_transaction FOREIGN KEY (transaction_id)
    REFERENCES expenditure_records(transaction_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB;

-- FINANCIAL_ANALYSIS: links employee (analyst) to sources and transactions
CREATE TABLE financial_analysis (
  employee_id INT NOT NULL,
  source_ssn VARCHAR(20) NOT NULL,  
  business_id INT NOT NULL,           
  transaction_id INT NOT NULL,        -- related transaction
  analysis_date DATE NOT NULL,
  analysis_note TEXT,
  PRIMARY KEY (source_ssn, business_id,transaction_id),
  CONSTRAINT fk_fin_analysis_employee FOREIGN KEY (employee_id)
    REFERENCES secret_agent(employee_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_fin_analysis_source FOREIGN KEY (source_ssn)
    REFERENCES people(ssn)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_fin_analysis_business FOREIGN KEY (business_id)
    REFERENCES business(business_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_fin_analysis_transaction FOREIGN KEY (transaction_id)
    REFERENCES expenditure_records(transaction_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB;

-- EVIDENCE_GATHERING: who found evidence, where stored, link to evidence
CREATE TABLE evidence_gathering (
  employee_id INT NOT NULL,
  subject_ssn VARCHAR(20) NOT NULL,
  found_at_property_id INT,
  stored_at_business_id INT,
  evidence_id INT NOT NULL,
  CONSTRAINT fk_ev_gather_employee FOREIGN KEY (employee_id)
    REFERENCES secret_agent(employee_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_ev_gather_subject FOREIGN KEY (subject_ssn)
    REFERENCES people(ssn)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_ev_gather_found_prop FOREIGN KEY (found_at_property_id)
    REFERENCES property_records(property_id)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT fk_ev_gather_store_business FOREIGN KEY (stored_at_business_id)
    REFERENCES business(business_id)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT fk_ev_gather_evidence FOREIGN KEY (evidence_id)
    REFERENCES evidence_collection(evidence_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  PRIMARY KEY( subject_ssn, evidence_id)   -- one gathering entry per evidence item
) ENGINE=InnoDB;

-- INVESTIGATES: agents investigating subjects and referencing PI data (many-to-many style)
CREATE TABLE investigates (
  subject_ssn VARCHAR(20) NOT NULL,
  employee_id INT NOT NULL,
  pi_data_id INT NOT NULL,          -- which PI record triggered/included
  CONSTRAINT fk_inv_subject FOREIGN KEY (subject_ssn)
    REFERENCES people(ssn)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_inv_employee FOREIGN KEY (employee_id)
    REFERENCES secret_agent(employee_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_inv_pi FOREIGN KEY (pi_data_id)
    REFERENCES pi_data(pi_data_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  PRIMARY KEY (subject_ssn, pi_data_id)
) ENGINE=InnoDB;

-- Helpful indexes for lookups
CREATE INDEX idx_people_name ON people (lname, fname);
CREATE INDEX idx_business_name ON business (business_name);
CREATE INDEX idx_property_worth ON property_records (worth);
CREATE INDEX idx_expenditure_date ON expenditure_records (transaction_date);
