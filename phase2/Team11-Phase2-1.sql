-- Team11-Phase2-1.sql
DROP TABLE CLIENT CASCADE CONSTRAINT;
create table CLIENT(
	ID  VARCHAR(10) NOT NULL,
	Name VARCHAR(10),
	Sex CHAR,
	Birthday    DATE,
	C_address   VARCHAR(70),
	Phone_num  VARCHAR(15),
	PRIMARY KEY (ID)
);
DROP TABLE SYMPTOM CASCADE CONSTRAINT;
create table SYMPTOM(
	Symptom_num  NUMBER  NOT NULL,
	Name    VARCHAR(20),
	Condition   CHAR(5),
	Site  VARCHAR(50),
	PRIMARY KEY (Symptom_num)
);
DROP TABLE HAVE CASCADE CONSTRAINT;
create table HAVE(
	Client_ID   VARCHAR(10)   NOT NULL,
	Symptom_num   NUMBER  NOT NULL,
	PRIMARY KEY (Client_ID, Symptom_num)
);

ALTER TABLE HAVE ADD FOREIGN KEY (Client_ID) REFERENCES CLIENT (ID)
ON DELETE SET NULL;
ALTER TABLE HAVE ADD FOREIGN KEY (Symptom_num) REFERENCES SYMPTOM (Symptom_num)
ON DELETE SET NULL;

DROP TABLE CASE_HISTORY CASCADE CONSTRAINT;
create table CASE_HISTORY(
	Case_num    NUMBER  NOT NULL,
	Record_date DATE,
	Record_name VARCHAR(60),
	Client_ID   VARCHAR(10)  NOT NULL,
	PRIMARY KEY (Case_num, Client_ID)
);
ALTER TABLE CASE_HISTORY ADD FOREIGN KEY (Client_ID) REFERENCES CLIENT (ID)
ON DELETE SET NULL;

DROP TABLE PHARMACY CASCADE CONSTRAINT;
create table PHARMACY(
	Pharmacy_num    NUMBER  NOT NULL,
	Address   VARCHAR(120),
	Name      VARCHAR(30),
	PRIMARY KEY (Pharmacy_num)
);
DROP TABLE CHEMIST CASCADE CONSTRAINT;
create table CHEMIST(
	ID  NUMBER  NOT NULL,
	Name    VARCHAR(10),
	Pharmacy_num    NUMBER,
	PRIMARY KEY (ID)
);
ALTER TABLE CHEMIST ADD FOREIGN KEY (Pharmacy_num) REFERENCES PHARMACY (Pharmacy_num)
ON DELETE SET NULL;

DROP TABLE M_ORDER CASCADE CONSTRAINT;
create table M_ORDER(
	Order_num   NUMBER  NOT NULL,
	Order_date   DATE,
	Prescription  NUMBER,
	Chemist_ID   NUMBER  NOT NULL,
	Client_ID      VARCHAR(10) NOT NULL,
	PRIMARY KEY (Order_num, Chemist_ID, Client_ID)
);
ALTER TABLE M_ORDER ADD FOREIGN KEY (Chemist_ID) REFERENCES CHEMIST (ID)
ON DELETE SET NULL;
ALTER TABLE M_ORDER ADD FOREIGN KEY (Client_ID) REFERENCES CLIENT (ID)
ON DELETE SET NULL;

DROP TABLE MEDICINE CASCADE CONSTRAINT;
create table MEDICINE(
	Name    VARCHAR(50),
	M_number    NUMBER  NOT NULL,
	Info    VARCHAR(1500),
	Price      NUMBER,
	Dosing_interval VARCHAR(15),
	Drug_type   VARCHAR(20),
	PRIMARY KEY (M_number)
);

DROP TABLE M_STORE CASCADE CONSTRAINT;
create table M_STORE(
	M_number    NUMBER  NOT NULL,
	Pharmacy_num    NUMBER  NOT NULL,
	Stock   NUMBER,
	PRIMARY KEY (M_number, Pharmacy_num)
);
ALTER TABLE M_STORE ADD FOREIGN KEY (M_number) REFERENCES MEDICINE (M_number)
ON DELETE SET NULL;
ALTER TABLE M_STORE ADD FOREIGN KEY (Pharmacy_num) REFERENCES PHARMACY (Pharmacy_num)
ON DELETE SET NULL;

DROP TABLE CONTAIN CASCADE CONSTRAINT;
create table CONTAIN(
	M_number    NUMBER  NOT NULL,
	Order_num   NUMBER  NOT NULL,
	Count   NUMBER,
	Chemist_ID  NUMBER NOT NULL,
	Client_ID   VARCHAR(10) NOT NULL,
	PRIMARY KEY (M_number, Order_num, Chemist_ID, Client_ID)
);
ALTER TABLE CONTAIN ADD FOREIGN KEY (M_number) REFERENCES MEDICINE (M_number)
ON DELETE SET NULL;
ALTER TABLE CONTAIN ADD FOREIGN KEY (Order_num, Chemist_ID, Client_ID) REFERENCES M_ORDER (Order_num, Chemist_ID, Client_ID)
ON DELETE SET NULL;

commit;