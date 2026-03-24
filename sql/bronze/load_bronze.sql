/*
File Name      : load_bronze.sql
Layer          : Bronze
Purpose        : Load raw data into bronze tables.
Description    :
- Truncate existing bronze tables.
- Inserts data from source files into bronze-layer tables using BULK INSERT.
- Preserves original data structure and values.
- Acts as the ingestion step of the pipeline.

Notes          :
- Assumes source files are already available.
- No deduplication or cleansing is performed here.
- Should be executed after bronze table creation.
- TRUNCATE is intentional to ensure full reload.
- Source file paths are environment-specific.
- Designed for initial ingestion and reprocessing.
*/

-- Assumption: source CSV files are complete extracts (full load)

-- ============================================
-- Load appointments master data
-- ============================================

TRUNCATE TABLE bronze.appointments;

BULK INSERT bronze.appointments

-- Note: file paths should be parameterized or externalized in production

FROM 'C:\Users\91779\Desktop\Dhanya\Hospital management datawarehouse\Healthcare dataset\appointments.csv'
WITH
(
	FORMAT = 'CSV',
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '0x0a',
	CODEPAGE = '65001',
	TABLOCK
);

-- ============================================
-- Load billing master data
-- ============================================

TRUNCATE TABLE bronze.billing;

BULK INSERT bronze.billing
FROM 'C:\Users\91779\Desktop\Dhanya\Hospital management datawarehouse\Healthcare dataset\billing.csv'
WITH
(
	FORMAT = 'CSV',
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '0x0a',
	CODEPAGE = '65001',
	TABLOCK
);

-- ============================================
-- Load doctors master data
-- ============================================

TRUNCATE TABLE bronze.doctors;

BULK INSERT bronze.doctors
FROM 'C:\Users\91779\Desktop\Dhanya\Hospital management datawarehouse\Healthcare dataset\doctors.csv'
WITH
(
	FORMAT = 'CSV',
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '0x0a',
	CODEPAGE = '65001',
	TABLOCK
);

-- ============================================
-- Load patients master data
-- ============================================

TRUNCATE TABLE bronze.patients;

BULK INSERT bronze.patients
FROM 'C:\Users\91779\Desktop\Dhanya\Hospital management datawarehouse\Healthcare dataset\patients.csv'
WITH
(
	FORMAT = 'CSV',
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '0x0a',
	CODEPAGE = '65001',
	TABLOCK
);

TRUNCATE TABLE bronze.treatments;

-- ============================================
-- Load treatments master data
-- ============================================

BULK INSERT bronze.treatments
FROM 'C:\Users\91779\Desktop\Dhanya\Hospital management datawarehouse\Healthcare dataset\treatments.csv'
WITH
(
	FORMAT = 'CSV',
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '0x0a',
	CODEPAGE = '65001',
	TABLOCK
);
