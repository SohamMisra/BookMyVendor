-- ============================================================
-- BookMyVendor (bmv) - Enriched Data Population Script
-- Adds vendors across Bengaluru, Udupi, Hubli, Hassan, Belagavi
-- Covers all 8 service categories: Catering, Decoration, Venue,
-- Photography, Transportation, Music & DJ, Makeup, Security
-- Run AFTER the original Dump20260330.sql
-- ============================================================

SET FOREIGN_KEY_CHECKS = 0;

-- ============================================================
-- SECTION 1: NEW USERS (user_id 78 onwards)
-- Cities: Bengaluru (BLR), Udupi (UDI), Hubli (HBL),
--         Hassan (HSN), Belagavi (BLG)
-- Services: All 8 categories
-- ============================================================

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;

INSERT INTO `users` VALUES
INSERT INTO users (
    is_verified,
    created_at,
    updated_at,
    email,
    first_name,
    last_name,
    password_hash,
    phone,
    profile_image_url,
    user_type
) VALUES

-- ---- BENGALURU: CATERING ----
    (b'1','2026-04-01 10:00:00','2026-04-01 10:00:00','cater_blr_1@bmv.com','Rajesh','Reddy','$2a$10$hash','903001001',NULL,'VENDOR'),
    (b'1','2026-04-01 10:00:00','2026-04-01 10:00:00','cater_blr_2@bmv.com','Sriram','Nair','$2a$10$hash','903001002',NULL,'VENDOR'),
    (b'1','2026-04-01 10:00:00','2026-04-01 10:00:00','cater_blr_3@bmv.com','Divya','Menon','$2a$10$hash','903001003',NULL,'VENDOR'),
    (b'1','2026-04-01 10:00:00','2026-04-01 10:00:00','cater_blr_4@bmv.com','Anand','Sharma','$2a$10$hash','903001004',NULL,'VENDOR'),
    (b'1','2026-04-01 10:00:00','2026-04-01 10:00:00','cater_blr_5@bmv.com','Kavitha','Iyer','$2a$10$hash','903001005',NULL,'VENDOR'),

-- ---- BENGALURU: DECORATION ----
    (b'1','2026-04-01 10:00:00','2026-04-01 10:00:00','decor_blr_1@bmv.com','Pooja','Nayak','$2a$10$hash','903002001',NULL,'VENDOR'),
    (b'1','2026-04-01 10:00:00','2026-04-01 10:00:00','decor_blr_2@bmv.com','Suresh','Pillai','$2a$10$hash','903002002',NULL,'VENDOR'),
    (b'1','2026-04-01 10:00:00','2026-04-01 10:00:00','decor_blr_3@bmv.com','Anitha','Kumar','$2a$10$hash','903002003',NULL,'VENDOR'),
    (b'1','2026-04-01 10:00:00','2026-04-01 10:00:00','decor_blr_4@bmv.com','Vivek','Gowda','$2a$10$hash','903002004',NULL,'VENDOR'),
    (b'1','2026-04-01 10:00:00','2026-04-01 10:00:00','decor_blr_5@bmv.com','Rekha','Hegde','$2a$10$hash','903002005',NULL,'VENDOR'),

-- ---- BENGALURU: VENUE ----
    (b'1','2026-04-01 10:00:00','2026-04-01 10:00:00','venue_blr_1@bmv.com','Mohan','Das','$2a$10$hash','903003001',NULL,'VENDOR'),
    (b'1','2026-04-01 10:00:00','2026-04-01 10:00:00','venue_blr_2@bmv.com','Sunita','Rao','$2a$10$hash','903003002',NULL,'VENDOR'),
    (b'1','2026-04-01 10:00:00','2026-04-01 10:00:00','venue_blr_3@bmv.com','Prakash','Verma','$2a$10$hash','903003003',NULL,'VENDOR'),
    (b'1','2026-04-01 10:00:00','2026-04-01 10:00:00','venue_blr_4@bmv.com','Nalini','Srinivas','$2a$10$hash','903003004',NULL,'VENDOR'),
    (b'1','2026-04-01 10:00:00','2026-04-01 10:00:00','venue_blr_5@bmv.com','Sudarshan','Bhat','$2a$10$hash','903003005',NULL,'VENDOR'),

-- ---- BENGALURU: PHOTOGRAPHY (93-97) ----
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',93,'photo_blr_1@bmv.com','Kiran','Murthy','$2a$10$hash','903004001',NULL,'VENDOR'),
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',94,'photo_blr_2@bmv.com','Deepa','Thomas','$2a$10$hash','903004002',NULL,'VENDOR'),
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',95,'photo_blr_3@bmv.com','Arun','Joshi','$2a$10$hash','903004003',NULL,'VENDOR'),
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',96,'photo_blr_4@bmv.com','Nandita','Rao','$2a$10$hash','903004004',NULL,'VENDOR'),
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',97,'photo_blr_5@bmv.com','Vinay','Shetty','$2a$10$hash','903004005',NULL,'VENDOR'),

-- ---- BENGALURU: TRANSPORTATION (98-100) ----
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',98,'trans_blr_1@bmv.com','Ravi','Shankar','$2a$10$hash','903005001',NULL,'VENDOR'),
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',99,'trans_blr_2@bmv.com','Gopal','Krishnan','$2a$10$hash','903005002',NULL,'VENDOR'),
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',100,'trans_blr_3@bmv.com','Saritha','Menon','$2a$10$hash','903005003',NULL,'VENDOR'),

-- ---- BENGALURU: MUSIC & DJ (101-103) ----
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',101,'dj_blr_1@bmv.com','DJ','Arjun','$2a$10$hash','903006001',NULL,'VENDOR'),
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',102,'dj_blr_2@bmv.com','Roshan','Dsouza','$2a$10$hash','903006002',NULL,'VENDOR'),
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',103,'dj_blr_3@bmv.com','Priya','Nambiar','$2a$10$hash','903006003',NULL,'VENDOR'),

-- ---- BENGALURU: MAKEUP & STYLING (104-106) ----
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',104,'makeup_blr_1@bmv.com','Shreya','Kapoor','$2a$10$hash','903007001',NULL,'VENDOR'),
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',105,'makeup_blr_2@bmv.com','Ankita','Singh','$2a$10$hash','903007002',NULL,'VENDOR'),
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',106,'makeup_blr_3@bmv.com','Bhavna','Patil','$2a$10$hash','903007003',NULL,'VENDOR'),

-- ---- BENGALURU: SECURITY (107-108) ----
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',107,'sec_blr_1@bmv.com','Suresh','Gupta','$2a$10$hash','903008001',NULL,'VENDOR'),
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',108,'sec_blr_2@bmv.com','Ramakrishna','Pillai','$2a$10$hash','903008002',NULL,'VENDOR'),

-- ---- UDUPI: CATERING (109-111) ----
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',109,'cater_udi_1@bmv.com','Madhava','Prabhu','$2a$10$hash','904001001',NULL,'VENDOR'),
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',110,'cater_udi_2@bmv.com','Sudha','Bhat','$2a$10$hash','904001002',NULL,'VENDOR'),
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',111,'cater_udi_3@bmv.com','Ganesh','Kamath','$2a$10$hash','904001003',NULL,'VENDOR'),

-- ---- UDUPI: DECORATION (112-113) ----
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',112,'decor_udi_1@bmv.com','Savitha','Rao','$2a$10$hash','904002001',NULL,'VENDOR'),
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',113,'decor_udi_2@bmv.com','Krishnamurthy','Nayak','$2a$10$hash','904002002',NULL,'VENDOR'),

-- ---- UDUPI: VENUE (114-116) ----
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',114,'venue_udi_1@bmv.com','Umesh','Shetty','$2a$10$hash','904003001',NULL,'VENDOR'),
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',115,'venue_udi_2@bmv.com','Vidya','Kamath','$2a$10$hash','904003002',NULL,'VENDOR'),
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',116,'venue_udi_3@bmv.com','Shashidhar','Bhat','$2a$10$hash','904003003',NULL,'VENDOR'),

-- ---- UDUPI: PHOTOGRAPHY (117-118) ----
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',117,'photo_udi_1@bmv.com','Gururaj','Shenoy','$2a$10$hash','904004001',NULL,'VENDOR'),
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',118,'photo_udi_2@bmv.com','Deepika','Nayak','$2a$10$hash','904004002',NULL,'VENDOR'),

-- ---- UDUPI: MUSIC & DJ (119) ----
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',119,'dj_udi_1@bmv.com','Prashanth','Shetty','$2a$10$hash','904006001',NULL,'VENDOR'),

-- ---- UDUPI: MAKEUP (120) ----
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',120,'makeup_udi_1@bmv.com','Sunanda','Rao','$2a$10$hash','904007001',NULL,'VENDOR'),

-- ---- HUBLI: CATERING (121-123) ----
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',121,'cater_hbl_1@bmv.com','Basavraj','Desai','$2a$10$hash','905001001',NULL,'VENDOR'),
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',122,'cater_hbl_2@bmv.com','Renuka','Patil','$2a$10$hash','905001002',NULL,'VENDOR'),
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',123,'cater_hbl_3@bmv.com','Chandrashekar','Kulkarni','$2a$10$hash','905001003',NULL,'VENDOR'),

-- ---- HUBLI: DECORATION (124-125) ----
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',124,'decor_hbl_1@bmv.com','Shruti','Deshpande','$2a$10$hash','905002001',NULL,'VENDOR'),
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',125,'decor_hbl_2@bmv.com','Shivanand','Patil','$2a$10$hash','905002002',NULL,'VENDOR'),

-- ---- HUBLI: VENUE (126-128) ----
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',126,'venue_hbl_1@bmv.com','Girish','Joshi','$2a$10$hash','905003001',NULL,'VENDOR'),
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',127,'venue_hbl_2@bmv.com','Lalitha','Goud','$2a$10$hash','905003002',NULL,'VENDOR'),
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',128,'venue_hbl_3@bmv.com','Santosh','Naik','$2a$10$hash','905003003',NULL,'VENDOR'),

-- ---- HUBLI: PHOTOGRAPHY (129-130) ----
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',129,'photo_hbl_1@bmv.com','Akash','Kulkarni','$2a$10$hash','905004001',NULL,'VENDOR'),
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',130,'photo_hbl_2@bmv.com','Sushma','Joshi','$2a$10$hash','905004002',NULL,'VENDOR'),

-- ---- HUBLI: TRANSPORTATION (131) ----
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',131,'trans_hbl_1@bmv.com','Rajendra','Patil','$2a$10$hash','905005001',NULL,'VENDOR'),

-- ---- HUBLI: MUSIC & DJ (132) ----
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',132,'dj_hbl_1@bmv.com','Shivaraj','Koli','$2a$10$hash','905006001',NULL,'VENDOR'),

-- ---- HASSAN: CATERING (133-135) ----
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',133,'cater_hsn_1@bmv.com','Nagendra','Gowda','$2a$10$hash','906001001',NULL,'VENDOR'),
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',134,'cater_hsn_2@bmv.com','Pushpalatha','Swamy','$2a$10$hash','906001002',NULL,'VENDOR'),
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',135,'cater_hsn_3@bmv.com','Lokesh','Hoysala','$2a$10$hash','906001003',NULL,'VENDOR'),

-- ---- HASSAN: VENUE (136-137) ----
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',136,'venue_hsn_1@bmv.com','Shivakumar','Urs','$2a$10$hash','906003001',NULL,'VENDOR'),
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',137,'venue_hsn_2@bmv.com','Meenakshi','Gowda','$2a$10$hash','906003002',NULL,'VENDOR'),

-- ---- HASSAN: PHOTOGRAPHY (138) ----
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',138,'photo_hsn_1@bmv.com','Veerendra','Prasad','$2a$10$hash','906004001',NULL,'VENDOR'),

-- ---- HASSAN: DECORATION (139) ----
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',139,'decor_hsn_1@bmv.com','Kaveri','Raju','$2a$10$hash','906002001',NULL,'VENDOR'),

-- ---- BELAGAVI: CATERING (140-142) ----
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',140,'cater_blg_1@bmv.com','Vinayak','Kulkarni','$2a$10$hash','907001001',NULL,'VENDOR'),
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',141,'cater_blg_2@bmv.com','Sunanda','Joshi','$2a$10$hash','907001002',NULL,'VENDOR'),
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',142,'cater_blg_3@bmv.com','Appasaheb','Mane','$2a$10$hash','907001003',NULL,'VENDOR'),

-- ---- BELAGAVI: DECORATION (143-144) ----
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',143,'decor_blg_1@bmv.com','Vandana','Patil','$2a$10$hash','907002001',NULL,'VENDOR'),
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',144,'decor_blg_2@bmv.com','Siddhesh','Ghate','$2a$10$hash','907002002',NULL,'VENDOR'),

-- ---- BELAGAVI: VENUE (145-147) ----
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',145,'venue_blg_1@bmv.com','Ravindra','Kore','$2a$10$hash','907003001',NULL,'VENDOR'),
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',146,'venue_blg_2@bmv.com','Sharada','Gaikwad','$2a$10$hash','907003002',NULL,'VENDOR'),
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',147,'venue_blg_3@bmv.com','Mahendra','Chougule','$2a$10$hash','907003003',NULL,'VENDOR'),

-- ---- BELAGAVI: PHOTOGRAPHY (148-149) ----
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',148,'photo_blg_1@bmv.com','Akshay','Deshpande','$2a$10$hash','907004001',NULL,'VENDOR'),
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',149,'photo_blg_2@bmv.com','Ranjita','Bhosale','$2a$10$hash','907004002',NULL,'VENDOR'),

-- ---- BELAGAVI: TRANSPORTATION (150) ----
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',150,'trans_blg_1@bmv.com','Suresh','Kamble','$2a$10$hash','907005001',NULL,'VENDOR'),

-- ---- BELAGAVI: MUSIC & DJ (151) ----
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',151,'dj_blg_1@bmv.com','Gaurav','Patil','$2a$10$hash','907006001',NULL,'VENDOR'),

-- ---- BELAGAVI: MAKEUP (152) ----
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',152,'makeup_blg_1@bmv.com','Priyanka','Nair','$2a$10$hash','907007001',NULL,'VENDOR'),

-- ---- MANGALORE: MISSING SERVICES - DECORATION (153-154) ----
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',153,'decor_mlr_2@bmv.com','Chetan','Shetty','$2a$10$hash','908002001',NULL,'VENDOR'),
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',154,'decor_mlr_3@bmv.com','Ashwini','Rao','$2a$10$hash','908002002',NULL,'VENDOR'),

-- ---- MANGALORE: TRANSPORTATION (155-157) ----
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',155,'trans_mlr_2@bmv.com','Naveen','Fernandes','$2a$10$hash','908005001',NULL,'VENDOR'),
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',156,'trans_mlr_3@bmv.com','Clifford','Pinto','$2a$10$hash','908005002',NULL,'VENDOR'),
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',157,'trans_mlr_4@bmv.com','Melvin','Dsouza','$2a$10$hash','908005003',NULL,'VENDOR'),

-- ---- MANGALORE: MUSIC & DJ (158-159) ----
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',158,'dj_mlr_2@bmv.com','DJ','Kevin','$2a$10$hash','908006001',NULL,'VENDOR'),
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',159,'dj_mlr_3@bmv.com','Shawn','Lobo','$2a$10$hash','908006002',NULL,'VENDOR'),

-- ---- MANGALORE: MAKEUP (160-161) ----
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',160,'makeup_mlr_2@bmv.com','Deepa','Crasta','$2a$10$hash','908007001',NULL,'VENDOR'),
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',161,'makeup_mlr_3@bmv.com','Sheryl','Dmello','$2a$10$hash','908007002',NULL,'VENDOR'),

-- ---- MANGALORE: SECURITY (162-163) ----
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',162,'sec_mlr_2@bmv.com','Wilson','Rodrigues','$2a$10$hash','908008001',NULL,'VENDOR'),
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',163,'sec_mlr_3@bmv.com','Alfred','Dsouza','$2a$10$hash','908008002',NULL,'VENDOR'),

-- ---- MYSORE: MISSING SERVICES - DECORATION (164-165) ----
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',164,'decor_mys_1@bmv.com','Shilpa','Gowda','$2a$10$hash','909002001',NULL,'VENDOR'),
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',165,'decor_mys_2@bmv.com','Manjunath','Urs','$2a$10$hash','909002002',NULL,'VENDOR'),

-- ---- MYSORE: TRANSPORTATION (166-167) ----
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',166,'trans_mys_1@bmv.com','Ramesh','Wodeyar','$2a$10$hash','909005001',NULL,'VENDOR'),
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',167,'trans_mys_2@bmv.com','Sunil','Hegde','$2a$10$hash','909005002',NULL,'VENDOR'),

-- ---- MYSORE: MUSIC & DJ (168) ----
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',168,'dj_mys_1@bmv.com','Karthik','Urs','$2a$10$hash','909006001',NULL,'VENDOR'),

-- ---- MYSORE: MAKEUP (169-170) ----
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',169,'makeup_mys_1@bmv.com','Rashmi','Nagaraj','$2a$10$hash','909007001',NULL,'VENDOR'),
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',170,'makeup_mys_2@bmv.com','Triveni','Urs','$2a$10$hash','909007002',NULL,'VENDOR'),

-- ---- MYSORE: SECURITY (171-172) ----
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',171,'sec_mys_1@bmv.com','Nagappa','Naidu','$2a$10$hash','909008001',NULL,'VENDOR'),
(_binary '\1','2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',172,'sec_mys_2@bmv.com','Krishnappa','Gowda','$2a$10$hash','909008002',NULL,'VENDOR');

/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;


-- ============================================================
-- SECTION 2: VENDOR PROFILES
-- vendor_id continues from 113 (AUTO_INCREMENT=113 in original)
-- ============================================================

LOCK TABLES `vendor_profiles` WRITE;
/*!40000 ALTER TABLE `vendor_profiles` DISABLE KEYS */;

INSERT INTO `vendor_profiles` VALUES
-- ---- BENGALURU CATERING ----
(_binary '\1',_binary '\1',4.80,210,10,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',78,113,'Indiranagar, Bengaluru','Premium multi-cuisine catering for weddings, corporate events and social functions across Bengaluru.','contact@bengalurufeast.com',NULL,'Bengaluru Feast Caterers','903001001','Bengaluru','India','560038','Karnataka',2800000),
(_binary '\1',_binary '\0',4.60,160,8,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',79,114,'Koramangala, Bengaluru','South Indian and North Indian fusion menus. Ideal for large-scale wedding receptions and corporate lunches.','info@spiceblr.com',NULL,'Spice Route Caterers','903001002','Bengaluru','India','560034','Karnataka',1900000),
(_binary '\1',_binary '\0',4.50,130,7,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',80,115,'Jayanagar, Bengaluru','Specializes in traditional Karnataka cuisine and Brahmin-style pure veg catering.','info@shravyacaters.com',NULL,'Shravya Caterers','903001003','Bengaluru','India','560041','Karnataka',1400000),
(_binary '\1',_binary '\0',4.30,95,5,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',81,116,'Whitefield, Bengaluru','Live counters, BBQ stations, and multi-cuisine buffet setups for tech parks and luxury weddings.','hello@techparkcatering.com',NULL,'Tech Park Caterers','903001004','Bengaluru','India','560066','Karnataka',1100000),
(_binary '\1',_binary '\1',4.90,240,15,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',82,117,'MG Road, Bengaluru','Award-winning wedding caterers with a Michelin-trained head chef. Customised menus and live cooking stations.','elite@royalfeastblr.com',NULL,'Royal Feast BLR','903001005','Bengaluru','India','560001','Karnataka',4500000),

-- ---- BENGALURU DECORATION ----
(_binary '\1',_binary '\1',4.70,190,9,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',83,118,'HSR Layout, Bengaluru','Luxury floral, LED, and mandap decoration for weddings and receptions in Bengaluru.','info@bloomsdecor.com',NULL,'Blooms & Beyond Decor','903002001','Bengaluru','India','560102','Karnataka',2600000),
(_binary '\1',_binary '\0',4.50,140,7,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',84,119,'Rajajinagar, Bengaluru','Stage setup, balloon art, and themed decor for birthdays, engagements and corporate events.','party@sparkleblr.com',NULL,'Sparkle Events Decor','903002002','Bengaluru','India','560010','Karnataka',1800000),
(_binary '\1',_binary '\0',4.40,110,6,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',85,120,'Sadashivanagar, Bengaluru','Traditional Carnatic and South Indian-themed decor with banana leaves, marigold and brass accents.','namaste@heritagedecorators.com',NULL,'Heritage Decorators BLR','903002003','Bengaluru','India','560080','Karnataka',1500000),
(_binary '\1',_binary '\0',4.20,85,4,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',86,121,'Marathahalli, Bengaluru','Budget-friendly yet elegant decoration packages for small and mid-size events.','events@budgetbloom.com',NULL,'Budget Bloom Decor','903002004','Bengaluru','India','560037','Karnataka',950000),
(_binary '\1',_binary '\0',4.60,175,8,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',87,122,'JP Nagar, Bengaluru','Full event transformation: venue dressing, centerpieces, lighting, and photo booth setups.','hello@dreamscapeblr.com',NULL,'Dreamscape Decor','903002005','Bengaluru','India','560078','Karnataka',2200000),

-- ---- BENGALURU VENUE ----
(_binary '\1',_binary '\1',4.80,250,12,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',88,123,'Palace Road, Bengaluru','Iconic banquet hall with 2000+ capacity, rooftop lawn, and premium in-house catering facilities.','book@palacegrounds.com',NULL,'Palace Grounds Convention','903003001','Bengaluru','India','560052','Karnataka',8500000),
(_binary '\1',_binary '\0',4.60,180,10,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',89,124,'Ulsoor, Bengaluru','Lake-facing banquet hall with modern AV, premium seating and in-house catering.','info@lakedgeblr.com',NULL,'Lakeside Grand','903003002','Bengaluru','India','560042','Karnataka',5200000),
(_binary '\1',_binary '\0',4.50,145,8,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',90,125,'Electronic City, Bengaluru','Versatile conference & wedding hall near tech corridor. Corporate and social events.','venue@techcity.com',NULL,'Tech City Convention','903003003','Bengaluru','India','560100','Karnataka',4100000),
(_binary '\1',_binary '\0',4.30,100,6,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',91,126,'Bannerghatta Road, Bengaluru','Open garden and indoor combo venue. Ideal for daytime weddings and engagement ceremonies.','hello@gardenbliss.com',NULL,'Garden Bliss Venue','903003004','Bengaluru','India','560076','Karnataka',3400000),
(_binary '\1',_binary '\0',4.70,200,11,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',92,127,'Hebbal, Bengaluru','Premium rooftop banquet with city views. Popular for evening receptions and corporate galas.','book@skylineblr.com',NULL,'Skyline Banquets','903003005','Bengaluru','India','560024','Karnataka',6800000),

-- ---- BENGALURU PHOTOGRAPHY ----
(_binary '\1',_binary '\1',4.90,300,14,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',93,128,'Richmond Town, Bengaluru','Award-winning wedding and portrait photography studio. Cinematic reels, drone shots, same-day edits.','hi@shutterblr.com',NULL,'Shutter Stories BLR','903004001','Bengaluru','India','560025','Karnataka',3900000),
(_binary '\1',_binary '\0',4.70,220,11,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',94,129,'Basavanagudi, Bengaluru','Traditional and candid photography. Full packages with videography, drone and USB delivery.','capture@momentumblr.com',NULL,'Momentum Photography','903004002','Bengaluru','India','560004','Karnataka',2800000),
(_binary '\1',_binary '\0',4.50,160,8,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',95,130,'Malleshwaram, Bengaluru','Pre-wedding shoots, wedding coverage, and short film reels. Quick turnaround guaranteed.','contact@prewedblr.com',NULL,'PreWed Chronicles','903004003','Bengaluru','India','560003','Karnataka',2100000),
(_binary '\1',_binary '\0',4.40,135,7,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',96,131,'BTM Layout, Bengaluru','Event photography for birthdays, baby showers, and corporate events.','info@snapsmileblr.com',NULL,'SnapSmile Photography','903004004','Bengaluru','India','560029','Karnataka',1700000),
(_binary '\1',_binary '\0',4.60,195,9,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',97,132,'Koramangala, Bengaluru','Fine art wedding photography. Film and digital. Albums printed and delivered.','studio@artpixblr.com',NULL,'ArtPix Studio','903004005','Bengaluru','India','560034','Karnataka',2500000),

-- ---- BENGALURU TRANSPORTATION ----
(_binary '\1',_binary '\0',4.60,140,8,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',98,133,'Yeshwanthpur, Bengaluru','Luxury sedans, SUVs and vintage cars for weddings. Baraat arrangements, procession vehicles available.','book@royalrideblr.com',NULL,'Royal Ride BLR','903005001','Bengaluru','India','560022','Karnataka',3200000),
(_binary '\1',_binary '\0',4.40,100,6,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',99,134,'KR Puram, Bengaluru','Mini buses, tempo travellers and AC coaches for guest logistics and airport transfers.','info@guestrideblr.com',NULL,'Guest Ride Travels BLR','903005002','Bengaluru','India','560036','Karnataka',2100000),
(_binary '\1',_binary '\0',4.20,75,5,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',100,135,'Yelahanka, Bengaluru','Budget-friendly event transport solutions. Innova, Ertiga, Tempo Traveller fleets available.','contact@bhagytravels.com',NULL,'Bhagya Travels BLR','903005003','Bengaluru','India','560064','Karnataka',1400000),

-- ---- BENGALURU MUSIC & DJ ----
(_binary '\1',_binary '\1',4.80,210,10,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',101,136,'Domlur, Bengaluru','Premium DJ services with international sound systems, laser shows, and live band integration.','dj@bassblr.com',NULL,'Bass Beats DJ BLR','903006001','Bengaluru','India','560071','Karnataka',2900000),
(_binary '\1',_binary '\0',4.60,175,9,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',102,137,'Kammanahalli, Bengaluru','Weddings, corporate events, and club nights. Professional emcee, dancer coordination included.','info@neondjblr.com',NULL,'Neon Nights DJ','903006002','Bengaluru','India','560084','Karnataka',2200000),
(_binary '\1',_binary '\0',4.30,115,6,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',103,138,'Jayanagar, Bengaluru','Carnatic and Hindustani live music bands for traditional weddings. Also DJ packages available.','music@swaramblr.com',NULL,'Swaram Live Music','903006003','Bengaluru','India','560041','Karnataka',1600000),

-- ---- BENGALURU MAKEUP & STYLING ----
(_binary '\1',_binary '\1',4.90,290,13,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',104,139,'Lavelle Road, Bengaluru','Celebrity and bridal makeup artist. HD and airbrush makeup, hair styling and saree draping.','glamour@priyankastudio.com',NULL,'Priyanka Glam Studio','903007001','Bengaluru','India','560001','Karnataka',3800000),
(_binary '\1',_binary '\0',4.60,200,10,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',105,140,'Cunningham Road, Bengaluru','South Indian bridal specialist. Team available for entire bridal party. Trial sessions included.','info@silkbridesblr.com',NULL,'Silk Brides Studio','903007002','Bengaluru','India','560052','Karnataka',2700000),
(_binary '\1',_binary '\0',4.40,140,7,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',106,141,'Electronic City, Bengaluru','Affordable yet professional makeup and hair for weddings, events, and photo shoots.','style@glowupblr.com',NULL,'GlowUp Makeovers','903007003','Bengaluru','India','560100','Karnataka',1500000),

-- ---- BENGALURU SECURITY ----
(_binary '\1',_binary '\0',4.50,130,8,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',107,142,'Shivajinagar, Bengaluru','Licensed security firm providing crowd management, VIP escort, and gate management for large events.','contact@shieldblr.com',NULL,'Shield Security Services','903008001','Bengaluru','India','560051','Karnataka',2100000),
(_binary '\1',_binary '\0',4.30,90,6,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',108,143,'Whitefield, Bengaluru','Trained guards for corporate events, exhibitions, tech park events and weddings.','info@guardplusBLR.com',NULL,'GuardPlus Security BLR','903008002','Bengaluru','India','560066','Karnataka',1600000),

-- ---- UDUPI CATERING ----
(_binary '\1',_binary '\1',4.90,185,12,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',109,144,'Car Street, Udupi','Famous for traditional Udupi Brahmin cuisine. Temple-style meals and wedding catering specialists.','contact@udupisatvika.com',NULL,'Udupi Satvika Caterers','904001001','Udupi','India','576101','Karnataka',2400000),
(_binary '\1',_binary '\0',4.60,135,8,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',110,145,'Manipal, Udupi','Multi-cuisine catering with focus on coastal Karnataka, North Indian and Chinese menus.','info@coastlinefeasts.com',NULL,'Coastline Feasts','904001002','Udupi','India','576104','Karnataka',1600000),
(_binary '\1',_binary '\0',4.40,95,6,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',111,146,'Kunjibettu, Udupi','Authentic home-style tulu Nadu cuisine, seafood, and sadhya-style wedding meals.','hello@tulucatering.com',NULL,'Tulu Feast Caterers','904001003','Udupi','India','576102','Karnataka',1100000),

-- ---- UDUPI DECORATION ----
(_binary '\1',_binary '\0',4.50,100,7,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',112,147,'Manipal, Udupi','Floral and LED decoration for weddings and temple ceremonies. Traditional Tulu style available.','info@bloompetal.com',NULL,'Bloom Petal Decor','904002001','Udupi','India','576104','Karnataka',1300000),
(_binary '\1',_binary '\0',4.30,75,5,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',113,148,'Kinnimulki, Udupi','Budget decoration for small functions, naming ceremonies, and small weddings.','decor@shreedecorators.com',NULL,'Shree Decorators Udupi','904002002','Udupi','India','576101','Karnataka',900000),

-- ---- UDUPI VENUE ----
(_binary '\1',_binary '\1',4.70,160,10,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',114,149,'Manipal, Udupi','Spacious convention hall near Manipal University. Academic and social events welcome.','book@manipalconvention.com',NULL,'Manipal Convention Centre','904003001','Udupi','India','576104','Karnataka',3800000),
(_binary '\1',_binary '\0',4.50,120,8,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',115,150,'Car Street, Udupi','Heritage hall with traditional architecture. Popular for weddings and cultural functions.','info@sriramahall.com',NULL,'Srirama Marriage Hall','904003002','Udupi','India','576101','Karnataka',2600000),
(_binary '\1',_binary '\0',4.20,70,5,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',116,151,'Brahmavar, Udupi','Open lawn venue with river view. Ideal for small weddings and outdoor functions.','venue@riversidetulunadu.com',NULL,'Riverside Venue Udupi','904003003','Udupi','India','576213','Karnataka',1500000),

-- ---- UDUPI PHOTOGRAPHY ----
(_binary '\1',_binary '\0',4.70,145,8,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',117,152,'Manipal, Udupi','Wedding and pre-wedding photography. Drone coverage, cinematic reels, and quick delivery.','lens@pixelmanipalmedia.com',NULL,'Pixel Manipal Media','904004001','Udupi','India','576104','Karnataka',1600000),
(_binary '\1',_binary '\0',4.50,110,6,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',118,153,'Udupi City','Creative portrait and wedding photography. Affordable packages for all event sizes.','photo@captureudi.com',NULL,'Capture Udupi Studio','904004002','Udupi','India','576101','Karnataka',1200000),

-- ---- UDUPI MUSIC & DJ ----
(_binary '\1',_binary '\0',4.40,80,5,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',119,154,'Manipal, Udupi','DJ and live band for college events, weddings, and cultural programs near Udupi-Manipal belt.','dj@coastalrhythmudi.com',NULL,'Coastal Rhythm DJ Udupi','904006001','Udupi','India','576104','Karnataka',800000),

-- ---- UDUPI MAKEUP ----
(_binary '\1',_binary '\0',4.60,115,7,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',120,155,'Car Street, Udupi','Bridal makeup specialist with expertise in traditional South Indian and Konkani bride looks.','beautify@sunandabeauty.com',NULL,'Sunanda Beauty Studio','904007001','Udupi','India','576101','Karnataka',1100000),

-- ---- HUBLI CATERING ----
(_binary '\1',_binary '\1',4.80,175,10,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',121,156,'Vidyanagar, Hubli','North Karnataka cuisine specialists. Jowar roti, puran poli, and wedding feast experts.','book@northkarnatakafeasts.com',NULL,'North Karnataka Feasts','905001001','Hubli','India','580031','Karnataka',2200000),
(_binary '\1',_binary '\0',4.50,120,7,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',122,157,'Keshwapur, Hubli','Multi-cuisine catering for corporate offices and large weddings in Hubli-Dharwad region.','info@dharwadcatering.com',NULL,'Dharwad Caterers','905001002','Hubli','India','580023','Karnataka',1700000),
(_binary '\1',_binary '\0',4.30,85,5,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',123,158,'Old Hubli, Hubli','Traditional Lingayat wedding style catering and homestyle cooking for family functions.','contact@siddeshwarcatering.com',NULL,'Siddeshwar Caterers','905001003','Hubli','India','580024','Karnataka',1000000),

-- ---- HUBLI DECORATION ----
(_binary '\1',_binary '\0',4.60,130,8,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',124,159,'Navanagar, Hubli','Floral, drapery, and LED stage decoration for weddings and cultural events in North Karnataka.','decor@manaswinibloomshubli.com',NULL,'Manaswini Blooms Decor','905002001','Hubli','India','580025','Karnataka',1500000),
(_binary '\1',_binary '\0',4.30,80,5,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',125,160,'Vidyanagar, Hubli','Themed décor for birthdays, engagements, and small weddings. Props and balloon art specialists.','party@shivarangdecor.com',NULL,'Shivarang Decor','905002002','Hubli','India','580031','Karnataka',900000),

-- ---- HUBLI VENUE ----
(_binary '\1',_binary '\1',4.70,150,10,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',126,161,'KSRTC Bus Stand Area, Hubli','Largest convention hall in Hubli with 1500+ capacity and full AV infrastructure.','book@hubligrandconvention.com',NULL,'Hubli Grand Convention','905003001','Hubli','India','580020','Karnataka',4200000),
(_binary '\1',_binary '\0',4.40,95,6,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',127,162,'Gokul Road, Hubli','AC banquet hall with in-house catering. Wedding and conference ready.','info@gokulhall.com',NULL,'Gokul Banquet Hall','905003002','Hubli','India','580030','Karnataka',2600000),
(_binary '\1',_binary '\0',4.20,65,4,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',128,163,'Keshwapur, Hubli','Open lawn and garden venue for outdoor weddings and cultural programs.','venue@greenmeadowshubli.com',NULL,'Green Meadows Venue','905003003','Hubli','India','580023','Karnataka',1800000),

-- ---- HUBLI PHOTOGRAPHY ----
(_binary '\1',_binary '\0',4.60,135,8,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',129,164,'Vidyanagar, Hubli','Wedding and event photography. Cinematic videography and short films for North Karnataka clients.','shoot@focuspointhubli.com',NULL,'Focus Point Studio Hubli','905004001','Hubli','India','580031','Karnataka',1500000),
(_binary '\1',_binary '\0',4.40,100,6,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',130,165,'Navanagar, Hubli','Budget photography for local weddings and events. Traditional and candid styles.','photo@clickmasterHubli.com',NULL,'Click Masters Hubli','905004002','Hubli','India','580025','Karnataka',1000000),

-- ---- HUBLI TRANSPORTATION ----
(_binary '\1',_binary '\0',4.50,110,7,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',131,166,'Old Hubli','Luxury cars and minibuses for weddings and corporate events across Hubli-Dharwad.','travel@amrutatravels.com',NULL,'Amruta Travels Hubli','905005001','Hubli','India','580024','Karnataka',1800000),

-- ---- HUBLI MUSIC & DJ ----
(_binary '\1',_binary '\0',4.40,90,6,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',132,167,'Gokul Road, Hubli','Experienced DJ for weddings, mehndi nights and college festivals. High-wattage sound systems.','dj@bassbeatshubli.com',NULL,'Bass Beats DJ Hubli','905006001','Hubli','India','580030','Karnataka',1000000),

-- ---- HASSAN CATERING ----
(_binary '\1',_binary '\1',4.70,130,9,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',133,168,'BM Road, Hassan','Traditional Vokkaliga wedding cuisine and Sadhya-style banquets for Hassan and surrounding areas.','cater@hoysalachoice.com',NULL,'Hoysala Choice Caterers','906001001','Hassan','India','573201','Karnataka',1900000),
(_binary '\1',_binary '\0',4.40,90,6,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',134,169,'Shanthinagar, Hassan','Multi-cuisine event catering for weddings, functions, and corporate events.','info@hassanfeastcatering.com',NULL,'Hassan Feast Caterers','906001002','Hassan','India','573201','Karnataka',1300000),
(_binary '\1',_binary '\0',4.20,65,4,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',135,170,'Hemavathi Colony, Hassan','Budget catering for small family functions and village-style outdoor events.','contact@gowricatering.com',NULL,'Gowri Caterers Hassan','906001003','Hassan','India','573201','Karnataka',750000),

-- ---- HASSAN VENUE ----
(_binary '\1',_binary '\0',4.60,120,8,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',136,171,'BM Road, Hassan','Spacious banquet hall with in-house catering near Hassan city center.','book@chamundihall.com',NULL,'Chamundi Banquet Hall Hassan','906003001','Hassan','India','573201','Karnataka',2400000),
(_binary '\1',_binary '\0',4.30,75,5,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',137,172,'Slum Area, Hassan','Open lawn venue for outdoor weddings, garden parties, and temple ceremonies.','venue@belurpurna.com',NULL,'Belur Purna Venue','906003002','Hassan','India','573201','Karnataka',1500000),

-- ---- HASSAN PHOTOGRAPHY ----
(_binary '\1',_binary '\0',4.50,105,6,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',138,173,'Hassan City','Wedding and documentary photography. Hoysala temple backdrop pre-wedding packages available.','lens@hoysalastudio.com',NULL,'Hoysala Photo Studio','906004001','Hassan','India','573201','Karnataka',1200000),

-- ---- HASSAN DECORATION ----
(_binary '\1',_binary '\0',4.40,85,5,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',139,174,'Shanthinagar, Hassan','Traditional floral and silk décor for Vokkaliga weddings and religious ceremonies.','decor@kaveriflowers.com',NULL,'Kaveri Flower Decor Hassan','906002001','Hassan','India','573201','Karnataka',900000),

-- ---- BELAGAVI CATERING ----
(_binary '\1',_binary '\1',4.70,145,9,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',140,175,'Tilakwadi, Belagavi','Authentic North Karnataka and Marathi-influenced wedding catering. Panchpakwan and thali specialists.','book@belgaumroyalcatering.com',NULL,'Belgaum Royal Caterers','907001001','Belagavi','India','590006','Karnataka',2100000),
(_binary '\1',_binary '\0',4.50,115,7,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',141,176,'Nehru Nagar, Belagavi','Multi-cuisine caterers for weddings, corporate events, and social functions in Belagavi district.','info@belgavicatering.com',NULL,'Belgavi Feast Caterers','907001002','Belagavi','India','590010','Karnataka',1700000),
(_binary '\1',_binary '\0',4.20,70,4,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',142,177,'Khanapur Road, Belagavi','Budget home-style catering for small family events and corporate lunch orders.','cater@deshpandecatering.com',NULL,'Deshpande Caterers Belagavi','907001003','Belagavi','India','590001','Karnataka',900000),

-- ---- BELAGAVI DECORATION ----
(_binary '\1',_binary '\0',4.60,125,8,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',143,178,'Camp Area, Belagavi','Stage and floral décor for weddings, birthday parties and cultural events in Belagavi.','flowers@vandanafloral.com',NULL,'Vandana Floral Decor','907002001','Belagavi','India','590001','Karnataka',1400000),
(_binary '\1',_binary '\0',4.30,80,5,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',144,179,'Tilakwadi, Belagavi','Themed décor, balloon art and photo walls for all types of functions.','info@siddheshdecorations.com',NULL,'Siddhesh Decorations BLG','907002002','Belagavi','India','590006','Karnataka',950000),

-- ---- BELAGAVI VENUE ----
(_binary '\1',_binary '\1',4.80,180,11,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',145,180,'Shahpur, Belagavi','Premium convention hall with 1200+ capacity. AC halls, outdoor lawns and full catering available.','book@belgaviconvention.com',NULL,'Belagavi Grand Convention','907003001','Belagavi','India','590003','Karnataka',4800000),
(_binary '\1',_binary '\0',4.50,110,7,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',146,181,'Camp Area, Belagavi','AC banquet hall for weddings and corporate events. Valet parking and in-house catering.','venue@campbanquets.com',NULL,'Camp Banquets Belagavi','907003002','Belagavi','India','590001','Karnataka',2900000),
(_binary '\1',_binary '\0',4.30,75,5,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',147,182,'Gokak Road, Belagavi','Open garden venue near Belagavi outskirts. Suitable for daytime weddings and outdoor parties.','venue@meadowsblg.com',NULL,'Meadows Garden Venue BLG','907003003','Belagavi','India','590015','Karnataka',1800000),

-- ---- BELAGAVI PHOTOGRAPHY ----
(_binary '\1',_binary '\0',4.60,130,8,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',148,183,'Tilakwadi, Belagavi','Cinematic wedding photography and videography. Quick turnaround and premium albums.','shoot@goldenlensblg.com',NULL,'Golden Lens BLG','907004001','Belagavi','India','590006','Karnataka',1600000),
(_binary '\1',_binary '\0',4.40,95,6,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',149,184,'Nehru Nagar, Belagavi','Traditional and candid photography for all event types. Affordable packages.','photo@snapmemories.com',NULL,'Snap Memories BLG','907004002','Belagavi','India','590010','Karnataka',1100000),

-- ---- BELAGAVI TRANSPORTATION ----
(_binary '\1',_binary '\0',4.50,105,7,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',150,185,'Goaves Road, Belagavi','Luxury and budget transport for weddings. Fleet includes vintage cars, SUVs and mini buses.','travel@deccanrides.com',NULL,'Deccan Rides Belagavi','907005001','Belagavi','India','590010','Karnataka',2000000),

-- ---- BELAGAVI MUSIC & DJ ----
(_binary '\1',_binary '\0',4.40,88,6,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',151,186,'Camp Area, Belagavi','DJ services for weddings, parties and college events. LED dance floor and laser setup available.','dj@neonpartyblg.com',NULL,'Neon Party DJ Belagavi','907006001','Belagavi','India','590001','Karnataka',1100000),

-- ---- BELAGAVI MAKEUP ----
(_binary '\1',_binary '\0',4.60,115,7,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',152,187,'Tilakwadi, Belagavi','Bridal and party makeup with expertise in Kannada and Marathi bridal traditions. Trial sessions available.','beauty@priyankasblg.com',NULL,'Priyanka Beauty Studio BLG','907007001','Belagavi','India','590006','Karnataka',1300000),

-- ---- MANGALORE MISSING SERVICES: DECORATION ----
(_binary '\1',_binary '\0',4.50,105,6,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',153,188,'Balmatta, Mangalore','Coastal-themed floral and LED decor for weddings and social events in Mangalore.','decor@artsandbloomsmlr.com',NULL,'Arts & Blooms Decor MLR','908002001','Mangalore','India','575001','Karnataka',1400000),
(_binary '\1',_binary '\0',4.30,75,4,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',154,189,'Kankanady, Mangalore','Budget decor with a local flavour for naming ceremonies, housewarmings, and mid-size events.','info@mydecorator.com',NULL,'My Decorator Mangalore','908002002','Mangalore','India','575002','Karnataka',800000),

-- ---- MANGALORE TRANSPORTATION (Additional) ----
(_binary '\1',_binary '\0',4.50,110,7,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',155,190,'Kuloor, Mangalore','Luxury car hire including Innova Crysta, Mercedes and vintage cars for weddings.','book@naveenevents.com',NULL,'Naveen Event Travels','908005001','Mangalore','India','575013','Karnataka',1900000),
(_binary '\1',_binary '\0',4.40,90,6,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',156,191,'Pumpwell, Mangalore','AC buses and tempo travellers for guest pickup, airport transfers and event logistics.','info@cliffcoachlines.com',NULL,'Cliff Coach Lines MLR','908005002','Mangalore','India','575007','Karnataka',1600000),
(_binary '\1',_binary '\0',4.20,65,4,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',157,192,'Bejai, Mangalore','Affordable taxis and vans for small events and family functions in Mangalore.','mel@dsouzatravels.com',NULL,'Dsouza Travels MLR','908005003','Mangalore','India','575004','Karnataka',1100000),

-- ---- MANGALORE MUSIC & DJ (Additional) ----
(_binary '\1',_binary '\0',4.60,130,8,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',158,193,'Lalbagh, Mangalore','High-energy DJ with professional sound and lighting for beach weddings and indoor events.','book@djkevinmlr.com',NULL,'DJ Kevin Mangalore','908006001','Mangalore','India','575003','Karnataka',1700000),
(_binary '\1',_binary '\0',4.40,100,6,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',159,194,'Kodialbail, Mangalore','Live Konkani and Tulu folk music bands for weddings, festive nights and cultural events.','music@shawnlive.com',NULL,'Shawn Live Music MLR','908006002','Mangalore','India','575003','Karnataka',1300000),

-- ---- MANGALORE MAKEUP (Additional) ----
(_binary '\1',_binary '\0',4.70,165,9,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',160,195,'Kadri, Mangalore','Specialist in Christian and Hindu bridal looks. Airbrush, HD makeup and Saree draping expert.','beauty@deepacrasta.com',NULL,'Deepa Crasta Bridal','908007001','Mangalore','India','575003','Karnataka',2100000),
(_binary '\1',_binary '\0',4.50,125,7,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',161,196,'Urwa, Mangalore','Bridal and guest makeup for Konkani, Tulu and GSB wedding traditions.','glam@sherylglam.com',NULL,'Sheryl Glam Studio MLR','908007002','Mangalore','India','575006','Karnataka',1600000),

-- ---- MANGALORE SECURITY (Additional) ----
(_binary '\1',_binary '\0',4.40,95,6,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',162,197,'Padil, Mangalore','Trained security staff for large weddings, beach events, and outdoor venues.','contact@wilsonguards.com',NULL,'Wilson Security MLR','908008001','Mangalore','India','575007','Karnataka',1200000),
(_binary '\1',_binary '\0',4.20,70,4,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',163,198,'Balmatta, Mangalore','Gate management, parking supervision and crowd control for events of all sizes.','security@alfredsmlr.com',NULL,'Alfreds Security MLR','908008002','Mangalore','India','575001','Karnataka',900000),

-- ---- MYSORE MISSING SERVICES: DECORATION ----
(_binary '\1',_binary '\0',4.60,135,8,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',164,199,'Vijayanagar, Mysore','Royal Mysore-style floral and silk decoration for weddings. Jasmine garland and elephant motif themes.','decor@shilpadecormys.com',NULL,'Shilpa Decor Mysore','909002001','Mysore','India','570017','Karnataka',1800000),
(_binary '\1',_binary '\0',4.40,95,5,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',165,200,'Saraswathipuram, Mysore','LED, drapery and balloon décor for birthdays, anniversaries, and engagement ceremonies.','decor@manjunathdecorators.com',NULL,'Manjunath Decorators Mys','909002002','Mysore','India','570009','Karnataka',1200000),

-- ---- MYSORE TRANSPORTATION (Additional) ----
(_binary '\1',_binary '\0',4.60,125,8,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',166,201,'Kuvempunagar, Mysore','Luxury cars and vintage vehicles for royal Mysore weddings. Trained chauffeurs.','travel@rameshwodyar.com',NULL,'Ramesh Wodeyar Travels','909005001','Mysore','India','570023','Karnataka',2200000),
(_binary '\1',_binary '\0',4.30,85,5,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',167,202,'Jayalakshmipuram, Mysore','Mini buses and coaches for guest transportation and Dasara event logistics.','info@sunilevents.com',NULL,'Sunil Event Travels Mys','909005002','Mysore','India','570012','Karnataka',1600000),

-- ---- MYSORE MUSIC & DJ ----
(_binary '\1',_binary '\0',4.70,155,9,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',168,203,'Gokulam, Mysore','DJ and live band services. Classical Carnatic fusion for royal weddings and cultural evenings.','music@karthikurs.com',NULL,'Karthik Urs Music Mys','909006001','Mysore','India','570002','Karnataka',1900000),

-- ---- MYSORE MAKEUP ----
(_binary '\1',_binary '\1',4.90,215,12,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',169,204,'Saraswathipuram, Mysore','Celebrated Mysore bridal specialist. Silk saree draping, HD makeup and gold jewellery styling.','beauty@rashmiglamurmys.com',NULL,'Rashmi Glamour Studio Mys','909007001','Mysore','India','570009','Karnataka',3400000),
(_binary '\1',_binary '\0',4.50,130,7,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',170,205,'Vijayanagar, Mysore','South Indian and North Indian bridal makeup. Team available for large wedding parties.','triveni@beautyurs.com',NULL,'Triveni Beauty Studio Mys','909007002','Mysore','India','570017','Karnataka',1700000),

-- ---- MYSORE SECURITY ----
(_binary '\1',_binary '\0',4.50,115,7,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',171,206,'Kuvempunagar, Mysore','Licensed event security for Mysore Palace area weddings, large conventions and Dasara events.','security@nagappaguards.com',NULL,'Nagappa Security Mysore','909008001','Mysore','India','570023','Karnataka',1800000),
(_binary '\1',_binary '\0',4.30,80,5,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',172,207,'Saraswathipuram, Mysore','Crowd management, gate control and VIP escort for events in and around Mysore.','security@krishnappaguards.com',NULL,'Krishnappa Security Mys','909008002','Mysore','India','570009','Karnataka',1200000);

/*!40000 ALTER TABLE `vendor_profiles` ENABLE KEYS */;
UNLOCK TABLES;


-- ============================================================
-- SECTION 3: VENDOR SERVICES
-- vendor_service_id continues from 124 (AUTO_INCREMENT=124)
-- service_id: 1=Catering, 2=Decoration, 3=Venue, 4=Photography,
--             5=Transportation, 6=Music & DJ, 7=Makeup, 8=Security
-- ============================================================

LOCK TABLES `vendor_services` WRITE;
/*!40000 ALTER TABLE `vendor_services` DISABLE KEYS */;

INSERT INTO `vendor_services` VALUES
-- ---- BENGALURU CATERING (vendor_id 113-117) ----
(_binary '\1',2000,50,350000.00,60000.00,'2026-04-01 10:00:00.000000',1,'2026-04-01 10:00:00.000000',113,124,'Multi-cuisine wedding and event catering with live counters and buffet. Serves North and South Indian, Chinese and Continental menus.','Wedding & Multi-Cuisine Catering'),
(_binary '\1',1800,50,280000.00,55000.00,'2026-04-01 10:00:00.000000',1,'2026-04-01 10:00:00.000000',114,125,'South and North Indian fusion catering. Custom menus for large receptions and corporate lunches.','Fusion Catering BLR'),
(_binary '\1',1500,60,220000.00,45000.00,'2026-04-01 10:00:00.000000',1,'2026-04-01 10:00:00.000000',115,126,'Pure veg Karnataka cuisine catering. Brahmin-style meals and Sadhya arrangements.','Traditional Veg Catering BLR'),
(_binary '\1',1200,80,200000.00,40000.00,'2026-04-01 10:00:00.000000',1,'2026-04-01 10:00:00.000000',116,127,'Live counters, BBQ, and multi-cuisine buffet for corporate and wedding events.','Live Counter Catering'),
(_binary '\1',2500,100,500000.00,90000.00,'2026-04-01 10:00:00.000000',1,'2026-04-01 10:00:00.000000',117,128,'Award-winning luxury catering. Custom menus with trained chefs and elegant presentation.','Premium Luxury Catering BLR'),

-- ---- BENGALURU DECORATION (vendor_id 118-122) ----
(_binary '\1',1000,30,200000.00,35000.00,'2026-04-01 10:00:00.000000',2,'2026-04-01 10:00:00.000000',118,129,'Luxury floral and LED decor for wedding and reception mandap. Custom themes available.','Luxury Floral & LED Decor BLR'),
(_binary '\1',700,20,120000.00,20000.00,'2026-04-01 10:00:00.000000',2,'2026-04-01 10:00:00.000000',119,130,'Stage, balloon and themed decor for birthdays, engagements, and corporate events.','Themed Stage Decor BLR'),
(_binary '\1',500,10,90000.00,15000.00,'2026-04-01 10:00:00.000000',2,'2026-04-01 10:00:00.000000',120,131,'South Indian traditional decor with marigold, banana leaves and brass accents.','Traditional South Indian Decor'),
(_binary '\1',400,10,75000.00,12000.00,'2026-04-01 10:00:00.000000',2,'2026-04-01 10:00:00.000000',121,132,'Budget-friendly yet elegant decor packages for small and mid-size events.','Budget Event Decor BLR'),
(_binary '\1',800,20,160000.00,30000.00,'2026-04-01 10:00:00.000000',2,'2026-04-01 10:00:00.000000',122,133,'Full event transformation: venue dressing, centerpieces, lighting, and photo booths.','Full Venue Transformation'),

-- ---- BENGALURU VENUE (vendor_id 123-127) ----
(_binary '\1',2000,100,700000.00,150000.00,'2026-04-01 10:00:00.000000',3,'2026-04-01 10:00:00.000000',123,134,'Iconic 2000+ capacity convention hall with rooftop lawn and premium in-house catering.','Palace Grounds Convention BLR'),
(_binary '\1',1500,100,500000.00,100000.00,'2026-04-01 10:00:00.000000',3,'2026-04-01 10:00:00.000000',124,135,'Lake-facing banquet hall with modern AV setup and premium seating arrangements.','Lakeside Grand Banquet'),
(_binary '\1',1200,80,400000.00,80000.00,'2026-04-01 10:00:00.000000',3,'2026-04-01 10:00:00.000000',125,136,'Versatile hall near tech corridor. Corporate events and social gatherings.','Tech City Convention BLR'),
(_binary '\1',800,60,280000.00,60000.00,'2026-04-01 10:00:00.000000',3,'2026-04-01 10:00:00.000000',126,137,'Open garden and indoor combo venue for daytime weddings and engagement ceremonies.','Garden Bliss Venue BLR'),
(_binary '\1',1000,80,450000.00,90000.00,'2026-04-01 10:00:00.000000',3,'2026-04-01 10:00:00.000000',127,138,'Premium rooftop banquet with city views. Popular for evening receptions and galas.','Skyline Banquets BLR'),

-- ---- BENGALURU PHOTOGRAPHY (vendor_id 128-132) ----
(_binary '\1',500,20,150000.00,35000.00,'2026-04-01 10:00:00.000000',4,'2026-04-01 10:00:00.000000',128,139,'Award-winning wedding photography with cinematic reels, drone shots, and same-day edits.','Cinematic Wedding Photography BLR'),
(_binary '\1',400,20,110000.00,28000.00,'2026-04-01 10:00:00.000000',4,'2026-04-01 10:00:00.000000',129,140,'Traditional and candid wedding photography with complete videography package.','Traditional & Candid BLR'),
(_binary '\1',350,15,90000.00,22000.00,'2026-04-01 10:00:00.000000',4,'2026-04-01 10:00:00.000000',130,141,'Pre-wedding and wedding photography with quick turnaround and online album delivery.','Pre-Wedding & Wedding BLR'),
(_binary '\1',300,10,75000.00,18000.00,'2026-04-01 10:00:00.000000',4,'2026-04-01 10:00:00.000000',131,142,'Event photography for birthdays, baby showers, corporate events and parties.','Event Photography BLR'),
(_binary '\1',450,20,120000.00,30000.00,'2026-04-01 10:00:00.000000',4,'2026-04-01 10:00:00.000000',132,143,'Fine art wedding photography with film and digital options. Premium printed albums.','Fine Art Photography BLR'),

-- ---- BENGALURU TRANSPORTATION (vendor_id 133-135) ----
(_binary '\1',500,10,100000.00,20000.00,'2026-04-01 10:00:00.000000',5,'2026-04-01 10:00:00.000000',133,144,'Luxury sedans, SUVs, and vintage wedding cars with trained chauffeurs.','Luxury Wedding Cars BLR'),
(_binary '\1',400,20,70000.00,15000.00,'2026-04-01 10:00:00.000000',5,'2026-04-01 10:00:00.000000',134,145,'Mini buses and AC coaches for guest logistics and airport transfers.','Event Guest Transport BLR'),
(_binary '\1',300,20,50000.00,10000.00,'2026-04-01 10:00:00.000000',5,'2026-04-01 10:00:00.000000',135,146,'Budget Innova, Ertiga, and Tempo Traveller fleet for small and mid-size events.','Budget Event Transport BLR'),

-- ---- BENGALURU MUSIC & DJ (vendor_id 136-138) ----
(_binary '\1',1500,30,120000.00,25000.00,'2026-04-01 10:00:00.000000',6,'2026-04-01 10:00:00.000000',136,147,'Premium DJ with international sound systems, laser shows, and live band integration.','Premium DJ & Sound BLR'),
(_binary '\1',1200,20,90000.00,20000.00,'2026-04-01 10:00:00.000000',6,'2026-04-01 10:00:00.000000',137,148,'Wedding and corporate event DJ with professional emcee and dancer coordination.','Wedding DJ & Emcee BLR'),
(_binary '\1',800,10,60000.00,12000.00,'2026-04-01 10:00:00.000000',6,'2026-04-01 10:00:00.000000',138,149,'Carnatic and Hindustani live music bands for traditional weddings. DJ package included.','Live Music & DJ BLR'),

-- ---- BENGALURU MAKEUP (vendor_id 139-141) ----
(_binary '\1',50,1,80000.00,15000.00,'2026-04-01 10:00:00.000000',7,'2026-04-01 10:00:00.000000',139,150,'Celebrity bridal makeup, HD and airbrush finish, hair styling and saree draping.','Celebrity Bridal Makeup BLR'),
(_binary '\1',40,1,60000.00,12000.00,'2026-04-01 10:00:00.000000',7,'2026-04-01 10:00:00.000000',140,151,'South Indian bridal specialist with team for entire bridal party. Trial sessions included.','South Indian Bridal Makeup BLR'),
(_binary '\1',30,1,40000.00,8000.00,'2026-04-01 10:00:00.000000',7,'2026-04-01 10:00:00.000000',141,152,'Professional makeup and hair for weddings, events, and photo shoots at affordable rates.','Affordable Makeovers BLR'),

-- ---- BENGALURU SECURITY (vendor_id 142-143) ----
(_binary '\1',3000,50,80000.00,20000.00,'2026-04-01 10:00:00.000000',8,'2026-04-01 10:00:00.000000',142,153,'Licensed security for large events: crowd control, VIP escort, and gate management.','Event Security BLR'),
(_binary '\1',2000,50,60000.00,15000.00,'2026-04-01 10:00:00.000000',8,'2026-04-01 10:00:00.000000',143,154,'Trained guards for corporate events, exhibitions, and weddings in Bengaluru.','Corporate & Event Guards BLR'),

-- ---- UDUPI CATERING (vendor_id 144-146) ----
(_binary '\1',1500,50,180000.00,30000.00,'2026-04-01 10:00:00.000000',1,'2026-04-01 10:00:00.000000',144,155,'Traditional Udupi Brahmin cuisine and temple-style wedding meals.','Udupi Brahmin Catering'),
(_binary '\1',1200,50,150000.00,25000.00,'2026-04-01 10:00:00.000000',1,'2026-04-01 10:00:00.000000',145,156,'Coastal Karnataka, North Indian and Chinese fusion menus for weddings and corporate.','Coastal Karnataka Catering'),
(_binary '\1',800,40,100000.00,18000.00,'2026-04-01 10:00:00.000000',1,'2026-04-01 10:00:00.000000',146,157,'Authentic Tulu Nadu and seafood catering. Sadhya-style wedding feasts.','Tulu Cuisine Catering'),

-- ---- UDUPI DECORATION (vendor_id 147-148) ----
(_binary '\1',600,20,90000.00,15000.00,'2026-04-01 10:00:00.000000',2,'2026-04-01 10:00:00.000000',147,158,'Floral and LED decor for weddings and temple ceremonies in the Udupi style.','Udupi Wedding Decor'),
(_binary '\1',400,10,55000.00,10000.00,'2026-04-01 10:00:00.000000',2,'2026-04-01 10:00:00.000000',148,159,'Budget decor for small functions, naming ceremonies and minor events.','Budget Decor Udupi'),

-- ---- UDUPI VENUE (vendor_id 149-151) ----
(_binary '\1',1500,100,400000.00,80000.00,'2026-04-01 10:00:00.000000',3,'2026-04-01 10:00:00.000000',149,160,'Spacious convention hall near Manipal University. Academic and social events.','Manipal Convention Hall'),
(_binary '\1',800,60,200000.00,50000.00,'2026-04-01 10:00:00.000000',3,'2026-04-01 10:00:00.000000',150,161,'Heritage marriage hall with traditional architecture for weddings and cultural functions.','Srirama Heritage Hall Udupi'),
(_binary '\1',400,40,100000.00,25000.00,'2026-04-01 10:00:00.000000',3,'2026-04-01 10:00:00.000000',151,162,'Open lawn with river view for small weddings and outdoor family functions.','Riverside Lawn Udupi'),

-- ---- UDUPI PHOTOGRAPHY (vendor_id 152-153) ----
(_binary '\1',300,15,80000.00,18000.00,'2026-04-01 10:00:00.000000',4,'2026-04-01 10:00:00.000000',152,163,'Wedding and pre-wedding photography with drone and cinematic reel coverage.','Wedding Photography Udupi'),
(_binary '\1',250,10,55000.00,12000.00,'2026-04-01 10:00:00.000000',4,'2026-04-01 10:00:00.000000',153,164,'Creative portrait and wedding photography at affordable rates.','Affordable Photography Udupi'),

-- ---- UDUPI MUSIC & DJ (vendor_id 154) ----
(_binary '\1',800,20,50000.00,10000.00,'2026-04-01 10:00:00.000000',6,'2026-04-01 10:00:00.000000',154,165,'DJ and live band for college events, weddings, and cultural programs near Udupi.','Coastal DJ & Live Music Udupi'),

-- ---- UDUPI MAKEUP (vendor_id 155) ----
(_binary '\1',30,1,35000.00,8000.00,'2026-04-01 10:00:00.000000',7,'2026-04-01 10:00:00.000000',155,166,'Bridal makeup specialist in South Indian and Konkani bridal looks.','Konkani Bridal Makeup Udupi'),

-- ---- HUBLI CATERING (vendor_id 156-158) ----
(_binary '\1',1500,60,200000.00,40000.00,'2026-04-01 10:00:00.000000',1,'2026-04-01 10:00:00.000000',156,167,'North Karnataka cuisine specialists. Jowar roti, puran poli, and large-scale wedding feasts.','North Karnataka Wedding Feast'),
(_binary '\1',1200,60,160000.00,35000.00,'2026-04-01 10:00:00.000000',1,'2026-04-01 10:00:00.000000',157,168,'Multi-cuisine catering for corporate offices and large weddings in Hubli-Dharwad.','Dharwad Multi-Cuisine Catering'),
(_binary '\1',800,40,100000.00,20000.00,'2026-04-01 10:00:00.000000',1,'2026-04-01 10:00:00.000000',158,169,'Traditional Lingayat wedding style catering and homestyle cooking for family functions.','Traditional Lingayat Catering'),

-- ---- HUBLI DECORATION (vendor_id 159-160) ----
(_binary '\1',700,20,100000.00,18000.00,'2026-04-01 10:00:00.000000',2,'2026-04-01 10:00:00.000000',159,170,'Floral, drapery and LED stage decoration for weddings in North Karnataka.','Floral & LED Decor Hubli'),
(_binary '\1',400,10,55000.00,10000.00,'2026-04-01 10:00:00.000000',2,'2026-04-01 10:00:00.000000',160,171,'Themed décor, balloon art, and photo booth setups for all event types.','Themed Decor Hubli'),

-- ---- HUBLI VENUE (vendor_id 161-163) ----
(_binary '\1',1500,100,450000.00,90000.00,'2026-04-01 10:00:00.000000',3,'2026-04-01 10:00:00.000000',161,172,'Largest convention hall in Hubli with 1500+ capacity and full AV setup.','Hubli Grand Convention Hall'),
(_binary '\1',900,80,280000.00,60000.00,'2026-04-01 10:00:00.000000',3,'2026-04-01 10:00:00.000000',162,173,'AC banquet hall with in-house catering for weddings and conferences.','Gokul Banquet Hall Hubli'),
(_binary '\1',500,50,150000.00,35000.00,'2026-04-01 10:00:00.000000',3,'2026-04-01 10:00:00.000000',163,174,'Open garden venue for outdoor weddings and cultural programs.','Green Meadows Outdoor Venue'),

-- ---- HUBLI PHOTOGRAPHY (vendor_id 164-165) ----
(_binary '\1',400,15,90000.00,20000.00,'2026-04-01 10:00:00.000000',4,'2026-04-01 10:00:00.000000',164,175,'Wedding and event photography with cinematic videography.','Cinematic Photography Hubli'),
(_binary '\1',300,10,60000.00,14000.00,'2026-04-01 10:00:00.000000',4,'2026-04-01 10:00:00.000000',165,176,'Traditional and candid photography for local weddings at affordable rates.','Budget Photography Hubli'),

-- ---- HUBLI TRANSPORTATION (vendor_id 166) ----
(_binary '\1',400,20,80000.00,18000.00,'2026-04-01 10:00:00.000000',5,'2026-04-01 10:00:00.000000',166,177,'Luxury cars and minibuses for weddings and corporate events in Hubli-Dharwad.','Event Transport Hubli'),

-- ---- HUBLI MUSIC & DJ (vendor_id 167) ----
(_binary '\1',1000,20,60000.00,12000.00,'2026-04-01 10:00:00.000000',6,'2026-04-01 10:00:00.000000',167,178,'Experienced DJ for weddings, mehndi nights and college festivals.','DJ & Sound Hubli'),

-- ---- HASSAN CATERING (vendor_id 168-170) ----
(_binary '\1',1200,50,160000.00,30000.00,'2026-04-01 10:00:00.000000',1,'2026-04-01 10:00:00.000000',168,179,'Traditional Vokkaliga wedding cuisine and Sadhya-style banquets.','Vokkaliga Wedding Feast Hassan'),
(_binary '\1',1000,50,130000.00,25000.00,'2026-04-01 10:00:00.000000',1,'2026-04-01 10:00:00.000000',169,180,'Multi-cuisine event catering for weddings and corporate functions.','Multi-Cuisine Catering Hassan'),
(_binary '\1',600,30,70000.00,15000.00,'2026-04-01 10:00:00.000000',1,'2026-04-01 10:00:00.000000',170,181,'Budget home-style catering for small family functions.','Home Style Catering Hassan'),

-- ---- HASSAN VENUE (vendor_id 171-172) ----
(_binary '\1',800,60,220000.00,45000.00,'2026-04-01 10:00:00.000000',3,'2026-04-01 10:00:00.000000',171,182,'Spacious banquet hall near Hassan city center with in-house catering.','Banquet Hall Hassan'),
(_binary '\1',500,40,130000.00,30000.00,'2026-04-01 10:00:00.000000',3,'2026-04-01 10:00:00.000000',172,183,'Open lawn venue for outdoor weddings and garden parties.','Lawn Venue Hassan'),

-- ---- HASSAN PHOTOGRAPHY (vendor_id 173) ----
(_binary '\1',300,10,70000.00,16000.00,'2026-04-01 10:00:00.000000',4,'2026-04-01 10:00:00.000000',173,184,'Wedding photography with Hoysala temple backdrop pre-wedding packages.','Hoysala Wedding Photography'),

-- ---- HASSAN DECORATION (vendor_id 174) ----
(_binary '\1',500,20,80000.00,15000.00,'2026-04-01 10:00:00.000000',2,'2026-04-01 10:00:00.000000',174,185,'Traditional Vokkaliga decor with silk, jasmine and floral arrangements.','Traditional Decor Hassan'),

-- ---- BELAGAVI CATERING (vendor_id 175-177) ----
(_binary '\1',1500,60,200000.00,40000.00,'2026-04-01 10:00:00.000000',1,'2026-04-01 10:00:00.000000',175,186,'North Karnataka and Marathi-influenced wedding catering. Panchpakwan and thali specialists.','Royal North Karnataka Catering'),
(_binary '\1',1200,60,160000.00,35000.00,'2026-04-01 10:00:00.000000',1,'2026-04-01 10:00:00.000000',176,187,'Multi-cuisine catering for weddings and corporate events in Belagavi district.','Multi-Cuisine Catering Belagavi'),
(_binary '\1',700,30,80000.00,18000.00,'2026-04-01 10:00:00.000000',1,'2026-04-01 10:00:00.000000',177,188,'Budget home-style and corporate lunch catering for small functions.','Budget Catering Belagavi'),

-- ---- BELAGAVI DECORATION (vendor_id 178-179) ----
(_binary '\1',700,20,100000.00,18000.00,'2026-04-01 10:00:00.000000',2,'2026-04-01 10:00:00.000000',178,189,'Stage and floral decor for weddings, birthdays, and cultural events.','Floral Decor Belagavi'),
(_binary '\1',400,10,55000.00,10000.00,'2026-04-01 10:00:00.000000',2,'2026-04-01 10:00:00.000000',179,190,'Themed décor, balloons and photo walls for all types of functions.','Themed Decor Belagavi'),

-- ---- BELAGAVI VENUE (vendor_id 180-182) ----
(_binary '\1',1200,80,480000.00,90000.00,'2026-04-01 10:00:00.000000',3,'2026-04-01 10:00:00.000000',180,191,'Premium convention hall with 1200+ capacity, outdoor lawns and catering.','Belagavi Grand Convention'),
(_binary '\1',800,60,250000.00,55000.00,'2026-04-01 10:00:00.000000',3,'2026-04-01 10:00:00.000000',181,192,'AC banquet with valet parking and in-house catering for all events.','Camp Banquet Belagavi'),
(_binary '\1',500,50,150000.00,35000.00,'2026-04-01 10:00:00.000000',3,'2026-04-01 10:00:00.000000',182,193,'Open garden venue for daytime weddings and outdoor parties.','Garden Venue Belagavi'),

-- ---- BELAGAVI PHOTOGRAPHY (vendor_id 183-184) ----
(_binary '\1',400,15,90000.00,20000.00,'2026-04-01 10:00:00.000000',4,'2026-04-01 10:00:00.000000',183,194,'Cinematic wedding photography and videography with premium album delivery.','Cinematic Photography Belagavi'),
(_binary '\1',300,10,60000.00,14000.00,'2026-04-01 10:00:00.000000',4,'2026-04-01 10:00:00.000000',184,195,'Traditional and candid photography for all event sizes at affordable rates.','Affordable Photography Belagavi'),

-- ---- BELAGAVI TRANSPORTATION (vendor_id 185) ----
(_binary '\1',400,20,80000.00,18000.00,'2026-04-01 10:00:00.000000',5,'2026-04-01 10:00:00.000000',185,196,'Luxury and budget transport fleet for weddings including vintage cars and SUVs.','Wedding Transport Belagavi'),

-- ---- BELAGAVI MUSIC & DJ (vendor_id 186) ----
(_binary '\1',1000,20,65000.00,14000.00,'2026-04-01 10:00:00.000000',6,'2026-04-01 10:00:00.000000',186,197,'DJ services with LED dance floor and laser setup for weddings and parties.','DJ & Sound Belagavi'),

-- ---- BELAGAVI MAKEUP (vendor_id 187) ----
(_binary '\1',30,1,40000.00,9000.00,'2026-04-01 10:00:00.000000',7,'2026-04-01 10:00:00.000000',187,198,'Bridal makeup for Kannada and Marathi wedding traditions. Trial sessions available.','Bridal Makeup Belagavi'),

-- ---- MANGALORE MISSING SERVICES: DECORATION (vendor_id 188-189) ----
(_binary '\1',800,20,150000.00,25000.00,'2026-04-01 10:00:00.000000',2,'2026-04-01 10:00:00.000000',188,199,'Coastal-themed floral and LED decor for weddings and social events.','Coastal Floral Decor MLR'),
(_binary '\1',400,10,60000.00,10000.00,'2026-04-01 10:00:00.000000',2,'2026-04-01 10:00:00.000000',189,200,'Budget decor for naming ceremonies, housewarmings, and small events.','Budget Decor MLR'),

-- ---- MANGALORE TRANSPORTATION (vendor_id 190-192) ----
(_binary '\1',500,10,90000.00,18000.00,'2026-04-01 10:00:00.000000',5,'2026-04-01 10:00:00.000000',190,201,'Luxury Innova Crysta, Mercedes, and vintage cars for weddings and events.','Luxury Car Hire MLR'),
(_binary '\1',400,20,70000.00,14000.00,'2026-04-01 10:00:00.000000',5,'2026-04-01 10:00:00.000000',191,202,'AC buses and tempo travellers for guest logistics and airport transfers.','Coach & Bus Hire MLR'),
(_binary '\1',300,15,50000.00,10000.00,'2026-04-01 10:00:00.000000',5,'2026-04-01 10:00:00.000000',192,203,'Affordable event transport with taxis and vans for family functions.','Affordable Transport MLR'),

-- ---- MANGALORE MUSIC & DJ (vendor_id 193-194) ----
(_binary '\1',1200,20,80000.00,15000.00,'2026-04-01 10:00:00.000000',6,'2026-04-01 10:00:00.000000',193,204,'High-energy DJ with professional sound and lighting for beach weddings and indoor events.','DJ Kevin - Beach & Indoor MLR'),
(_binary '\1',800,10,60000.00,10000.00,'2026-04-01 10:00:00.000000',6,'2026-04-01 10:00:00.000000',194,205,'Live Konkani and Tulu folk music bands for weddings and cultural events.','Live Folk Music Konkani MLR'),

-- ---- MANGALORE MAKEUP (vendor_id 195-196) ----
(_binary '\1',30,1,60000.00,12000.00,'2026-04-01 10:00:00.000000',7,'2026-04-01 10:00:00.000000',195,206,'Specialist in Christian and Hindu bridal looks. Airbrush and HD makeup.','Christian & Hindu Bridal Makeup'),
(_binary '\1',25,1,45000.00,10000.00,'2026-04-01 10:00:00.000000',7,'2026-04-01 10:00:00.000000',196,207,'Bridal and guest makeup for Konkani, Tulu, and GSB wedding traditions.','Konkani Bridal Makeup MLR'),

-- ---- MANGALORE SECURITY (vendor_id 197-198) ----
(_binary '\1',2000,50,70000.00,15000.00,'2026-04-01 10:00:00.000000',8,'2026-04-01 10:00:00.000000',197,208,'Trained security staff for large weddings, beach events, and outdoor venues.','Event Security MLR'),
(_binary '\1',1500,50,50000.00,10000.00,'2026-04-01 10:00:00.000000',8,'2026-04-01 10:00:00.000000',198,209,'Gate management, parking supervision and crowd control for all event sizes.','Gate & Crowd Control MLR'),

-- ---- MYSORE DECORATION (vendor_id 199-200) ----
(_binary '\1',800,20,150000.00,25000.00,'2026-04-01 10:00:00.000000',2,'2026-04-01 10:00:00.000000',199,210,'Royal Mysore-style floral and silk decor. Jasmine garland and elephant motif themes.','Royal Mysore Decor'),
(_binary '\1',500,15,90000.00,18000.00,'2026-04-01 10:00:00.000000',2,'2026-04-01 10:00:00.000000',200,211,'LED, drapery and balloon décor for birthdays, anniversaries and engagements.','Modern Event Decor Mysore'),

-- ---- MYSORE TRANSPORTATION (vendor_id 201-202) ----
(_binary '\1',500,10,90000.00,18000.00,'2026-04-01 10:00:00.000000',5,'2026-04-01 10:00:00.000000',201,212,'Luxury and vintage cars for royal Mysore weddings with trained chauffeurs.','Royal Wedding Cars Mysore'),
(_binary '\1',400,20,65000.00,14000.00,'2026-04-01 10:00:00.000000',5,'2026-04-01 10:00:00.000000',202,213,'Mini buses and coaches for guest transport and Dasara event logistics.','Event Coach Service Mysore'),

-- ---- MYSORE MUSIC & DJ (vendor_id 203) ----
(_binary '\1',1000,20,80000.00,15000.00,'2026-04-01 10:00:00.000000',6,'2026-04-01 10:00:00.000000',203,214,'DJ and live band. Classical Carnatic fusion for royal weddings and cultural evenings.','Carnatic Fusion DJ Mysore'),

-- ---- MYSORE MAKEUP (vendor_id 204-205) ----
(_binary '\1',30,1,70000.00,15000.00,'2026-04-01 10:00:00.000000',7,'2026-04-01 10:00:00.000000',204,215,'Celebrated Mysore bridal specialist. Silk saree draping, HD makeup, gold jewellery styling.','Mysore Silk Bridal Makeup'),
(_binary '\1',25,1,50000.00,10000.00,'2026-04-01 10:00:00.000000',7,'2026-04-01 10:00:00.000000',205,216,'South and North Indian bridal makeup with team available for large wedding parties.','Bridal Makeup Mysore'),

-- ---- MYSORE SECURITY (vendor_id 206-207) ----
(_binary '\1',2000,50,70000.00,15000.00,'2026-04-01 10:00:00.000000',8,'2026-04-01 10:00:00.000000',206,217,'Licensed security for Mysore Palace area weddings, large conventions and Dasara events.','Premium Event Security Mysore'),
(_binary '\1',1500,50,55000.00,12000.00,'2026-04-01 10:00:00.000000',8,'2026-04-01 10:00:00.000000',207,218,'Crowd management, gate control, and VIP escort for events in and around Mysore.','Crowd Control Security Mysore');

/*!40000 ALTER TABLE `vendor_services` ENABLE KEYS */;
UNLOCK TABLES;


-- ============================================================
-- SECTION 4: VENDOR SERVICE ADDONS
-- Popular add-on packages for key vendor services
-- ============================================================

LOCK TABLES `vendor_service_addons` WRITE;
/*!40000 ALTER TABLE `vendor_service_addons` DISABLE KEYS */;

INSERT INTO `vendor_service_addons` VALUES
-- BLR Premium Catering addons (vendor_service_id 128)
(_binary '\1',15000.00,1,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',128,'Live pasta, dosa, and chaat counters manned by trained chefs.','Live Cooking Counters'),
(_binary '\1',8000.00,2,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',128,'Custom dessert table with 20+ varieties of sweets and pastries.','Dessert Table Setup'),
(_binary '\1',12000.00,3,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',128,'Mocktail and fresh juice bar with dedicated bartender.','Welcome Drinks Bar'),
-- BLR Luxury Decoration addons (vendor_service_id 129)
(_binary '\1',10000.00,4,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',129,'Professional entry arch with flowers and fairy lights.','Floral Entry Arch'),
(_binary '\1',8000.00,5,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',129,'Custom photo booth with printed props and Polaroid prints.','Photo Booth Setup'),
(_binary '\1',12000.00,6,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',129,'Cold fog machine for bride and groom entry effect.','Fog Machine Entry'),
-- BLR Cinema Photography addons (vendor_service_id 139)
(_binary '\1',15000.00,7,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',139,'Professional drone footage with cinematic aerial shots.','Drone Coverage Package'),
(_binary '\1',10000.00,8,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',139,'Same-day edit highlights reel delivered by evening.','Same Day Edit Reel'),
(_binary '\1',8000.00,9,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',139,'Premium 200-page printed wedding album with custom cover.','Premium Photo Album'),
-- BLR Premium DJ addons (vendor_service_id 147)
(_binary '\1',15000.00,10,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',147,'Professional laser show synchronized to music.','Laser & Pyro Show'),
(_binary '\1',8000.00,11,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',147,'LED dance floor panel setup (16x16 ft).','LED Dance Floor'),
-- BLR Celebrity Makeup addons (vendor_service_id 150)
(_binary '\1',5000.00,12,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',150,'Full trial session 1 week before the event.','Bridal Trial Session'),
(_binary '\1',3000.00,13,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',150,'Saree draping service for bride and 2 family members.','Saree Draping Package'),
-- Udupi Catering addons (vendor_service_id 155)
(_binary '\1',5000.00,14,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',155,'Traditional banana leaf serving for all guests.','Banana Leaf Service'),
(_binary '\1',8000.00,15,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',155,'Paan counter with 20+ varieties of betel leaf combinations.','Paan Counter'),
-- Hubli Convention Hall addons (vendor_service_id 172)
(_binary '\1',20000.00,16,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',172,'Premium sound system and 4K projector for ceremonies.','AV & Projector Setup'),
(_binary '\1',15000.00,17,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',172,'Bridal preparation room with AC and vanity mirror setup.','Bridal Room Package'),
-- Belagavi Grand Convention addons (vendor_service_id 191)
(_binary '\1',25000.00,18,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',191,'Outdoor lawn with fairy lights and floral entrance.','Garden Lawn Add-on'),
(_binary '\1',10000.00,19,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',191,'Dedicated valet parking service for 200 vehicles.','Valet Parking Service'),
-- Mysore Bridal Makeup addons (vendor_service_id 215)
(_binary '\1',6000.00,20,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',215,'Silk saree draping in traditional Mysore Peta style.','Mysore Silk Saree Draping'),
(_binary '\1',4000.00,21,'2026-04-01 10:00:00.000000','2026-04-01 10:00:00.000000',215,'Hair styling with traditional flowers and gajra arrangement.','Gajra Hair Styling');

/*!40000 ALTER TABLE `vendor_service_addons` ENABLE KEYS */;
UNLOCK TABLES;

SET FOREIGN_KEY_CHECKS = 1;

-- ============================================================
-- SUMMARY OF ADDITIONS
-- ============================================================
-- New Users added:        95  (user_id 78–172)
-- New Vendor Profiles:    95  (vendor_id 113–207)
-- New Vendor Services:    95  (vendor_service_id 124–218)
-- New Service Addons:     21
--
-- Cities covered:
--   Bengaluru  - All 8 services (Catering, Decoration, Venue,
--                Photography, Transportation, DJ, Makeup, Security)
--   Udupi      - All 8 services
--   Hubli      - Catering, Decoration, Venue, Photography,
--                Transportation, DJ
--   Hassan     - Catering, Decoration, Venue, Photography
--   Belagavi   - All 8 services
--   Mangalore  - Added missing: Decoration, Transportation (3),
--                DJ, Makeup, Security
--   Mysore     - Added missing: Decoration, Transportation,
--                DJ, Makeup, Security
-- ============================================================
