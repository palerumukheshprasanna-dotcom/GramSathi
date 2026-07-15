-- Sample Seed Data for GramSathi

USE gramsathi;

-- Insert Admin & Users (Passwords are pre-hashed versions of 'admin123' and 'user123')
-- Hash value for 'admin123': 'pbkdf2:sha256:260000$yB4d6hWp$a9a2c3a502c5bc5462cf4c3ee2585f67a21648a1d7fcd72e81fa2c23be3f07a2'
-- Hash value for 'user123': 'pbkdf2:sha256:260000$jWqCgV3D$e4ea23554e15de58fbc8d6263e8a49ba3b9b47e5200ee3b92efb18e7e1f40fa7'
INSERT INTO users (id, name, email, phone, password_hash, role) VALUES 
(1, 'Village Admin', 'admin@gramsathi.in', '9876543210', 'pbkdf2:sha256:260000$yB4d6hWp$a9a2c3a502c5bc5462cf4c3ee2585f67a21648a1d7fcd72e81fa2c23be3f07a2', 'admin'),
(2, 'Ramesh Kumar', 'ramesh@gmail.com', '9988776655', 'pbkdf2:sha256:260000$jWqCgV3D$e4ea23554e15de58fbc8d6263e8a49ba3b9b47e5200ee3b92efb18e7e1f40fa7', 'user'),
(3, 'Sita Devi', 'sita@gmail.com', '9888776655', 'pbkdf2:sha256:260000$jWqCgV3D$e4ea23554e15de58fbc8d6263e8a49ba3b9b47e5200ee3b92efb18e7e1f40fa7', 'user');

-- Insert Government Schemes
INSERT INTO schemes (id, name, description, benefits, required_documents, eligibility_age_min, eligibility_age_max, eligibility_gender, eligibility_occupation, eligibility_income_max, eligibility_category, eligibility_state, application_process, official_link) VALUES
(1, 'PM Kisan Samman Nidhi', 'Income support scheme for small and marginal landholder farmer families to buy inputs.', '₹6,000 per year in three equal installments of ₹2,000.', 'Aadhaar Card, Land ownership papers, Bank Account Passbook.', 18, 100, 'All', 'Farmer', 300000, 'All', 'All', 'Register online on PM-Kisan portal or visit nearest Common Service Center (CSC).', 'https://pmkisan.gov.in'),
(2, 'Post Matric Scholarship Scheme', 'Financial assistance to SC, ST, and OBC students pursuing post-matric courses.', 'Tuition fees coverage, maintenance allowance of up to ₹1,200/month.', 'Caste Certificate, Income Certificate, Previous Class Marksheet, Fee Receipt.', 15, 30, 'All', 'Student', 250000, 'OBC', 'All', 'Apply via National Scholarship Portal (NSP) online.', 'https://scholarships.gov.in'),
(3, 'YSR Cheyutha (Andhra Pradesh)', 'Empowerment of women from minority categories by providing financial assistance to set up business.', 'Financial assistance of ₹75,000 over 4 years (₹18,750 per year).', 'Aadhaar Card, Caste Certificate, Bank Account Details, Rice Card.', 45, 60, 'Female', 'All', 150000, 'SC', 'Andhra Pradesh', 'Submit application form to Grama Sachivalayam (Village Secretariat).', 'https://navasakam.ap.gov.in'),
(4, 'PM Swanidhi', 'Micro-credit scheme for street vendors to resume their livelihood post pandemic.', 'Collateral-free working capital loan up to ₹10,000 with interest subsidy.', 'Voter ID, Aadhaar Card, Vendor Certificate of Vending.', 18, 70, 'All', 'Unemployed', 200000, 'All', 'All', 'Apply online directly or through a nearby banking correspondent.', 'https://pmsvanidhi.mohua.gov.in');

-- Insert Local Jobs
INSERT INTO jobs (id, title, description, employer_name, location, type, salary, contact_phone, status) VALUES
(1, 'Organic Farm Supervisor', 'Supervise harvesting of tomatoes, weed removal, and organic fertilizer spray control.', 'Kalyan Farm Estates', 'Khammam Rural', 'Farm Job', '₹15,000 - ₹18,000 / month', '9440123456', 'Open'),
(2, 'Primary School Spoken English Tutor', 'Teach English speaking and reading skills to rural primary children in local center.', 'Vikas Educational NGO', 'Nelakondapally', 'Skilled Job', '₹12,000 / month', '9848011223', 'Open'),
(3, 'Gram Panchayat Road Layer', 'Laying cement roads inside village under MNREGA scheme.', 'Panchayat Contractor Association', 'Nelakondapally', 'Daily Wage', '₹400 / day', '9955112233', 'Open'),
(4, 'Tailoring Assistant & Sewing Trainer', 'Train rural self-help group women in stitching, cloth cutting, and custom dress embroidery.', 'Mahila Swashakti Sangham', 'Khammam Rural', 'Women Employment', '₹10,000 / month', '9000123456', 'Open');

-- Insert Agriculture Guide Data
INSERT INTO agriculture_data (id, crop_name, soil_type, fertilizer_info, pest_control, market_price, seasonal_tips) VALUES
(1, 'Paddy (Rice)', 'Clayey or Loamy soils with high water holding capacity', 'Apply Urea, Single Super Phosphate (SSP), and Muriate of Potash (MOP) in 3 splits.', 'Control stem borer using Cartap Hydrochloride granules. Prevent blast disease with Tricyclazole.', '₹2,300 / Quintal', 'Transplant seedlings when 21-25 days old. Keep standing water of 2-5 cm during vegetative stage.'),
(2, 'Cotton', 'Deep black cotton soils or well-drained loamy soils', 'Apply NPK mixture (20:20:0) and top-dress with Urea at 30 and 60 days.', 'Use Neem seed kernel extract (NSKE) 5% against sucking pests. Install pheromone traps.', '₹7,200 / Quintal', 'Sow early during monsoon onset. Maintain plant-to-plant spacing of 30-45 cm.'),
(3, 'Chilli', 'Sandy loam to clay loam with good drainage', 'Incorporate Farm Yard Manure (FYM). Apply Nitrogen, Phosphorus, and Potassium balance.', 'Control thrips and mites with Spinosad. Prevent damping-off disease by seed treatment.', '₹18,500 / Quintal', 'Ensure proper irrigation interval. Avoid water logging as it causes root rot immediately.');

-- Insert Nearby Hospitals
INSERT INTO hospitals (id, name, address, contact_number, latitude, longitude, distance_km) VALUES
(1, 'Community Health Centre (CHC)', 'Main Road, Nelakondapally', '08742-282123', 17.1852, 80.0543, 1.5),
(2, 'District Government General Hospital', 'Wyra Road, Khammam', '08742-222045', 17.2473, 80.1514, 18.0),
(3, 'Prathima Rural Health Clinic', 'Temple Road, Kusumanchi', '08742-273567', 17.2023, 79.9543, 12.4);

-- Insert Nearby Pharmacies
INSERT INTO pharmacies (id, name, address, contact_number, latitude, longitude, distance_km) VALUES
(1, 'Sri Rama Medical & General Store', 'Bazar Street, Nelakondapally', '9848123456', 17.1848, 80.0538, 0.8),
(2, 'Apollo Pharmacy Rural Outpost', 'Near Bus Stand, Nelakondapally', '9989012345', 17.1861, 80.0551, 1.2);

-- Insert Village Events
INSERT INTO events (id, title, description, category, event_date, location) VALUES
(1, 'Free Mega Health & Vaccination Camp', 'Free medical check-up, ECG, blood pressure tests, and free distribution of basic medicines.', 'Health Camp', '2026-07-20 09:00:00', 'Gram Panchayat Hall, Nelakondapally'),
(2, 'Monthly Gram Sabhe (Panchayat Meeting)', 'Discussion on drinking water pipes extension, street lighting repair budgets, and new ration card approvals.', 'Panchayat Notice', '2026-07-25 14:00:00', 'Open Meeting Ground (Rachabanda)'),
(3, 'Rural Job & Placement Mela', 'Private security, delivery executives, tailoring centers, and agricultural companies recruiting youth.', 'Job Fair', '2026-08-05 10:00:00', 'Zilla Parishad High School Ground');
