/*
===============================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================

Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files.
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from CSV files to bronze tables.

Parameters:
    None.
    This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;

===============================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		
		SET @batch_start_time = GETDATE()
		PRINT '====================================';
		PRINT 'LOADING BONZE LAYER';
		PRINT '====================================';


		PRINT '-------------------';
		PRINT 'LOADING CRM TABLES';
		PRINT '-------------------';

		SET @start_time = GETDATE();
		PRINT 'TURNCATE TABLE: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;
		PRINT 'INSERTING DATA INTO : bronze.crm_cust_info';

		BULK INSERT bronze.crm_cust_info
		FROM 'D:\SQL Data Warehouse Project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF( second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '>> -----------------+++++++++++';

		SET @start_time = GETDATE();
		PRINT 'TURNCATE TABLE: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;
		PRINT 'INSERTING DATA INTO : bronze.crm_prd_info';

		BULK INSERT bronze.crm_prd_info
		FROM 'D:\SQL Data Warehouse Project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF( second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '>> -----------------+++++++++++';


		SET @start_time = GETDATE();
		PRINT 'TURNCATE TABLE: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;
		PRINT 'INSERTING DATA INTO : bronze.crm_sales_details';

		BULK INSERT bronze.crm_sales_details
		FROM 'D:\SQL Data Warehouse Project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF( second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -----------------+++++++++++';


		PRINT '-------------------';
		PRINT 'LOADING ERP TABLES';
		PRINT '-------------------';


		SET @start_time = GETDATE();
		PRINT 'TURNCATE TABLE: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;
		PRINT 'INSERTING DATA INTO : bronze.erp_loc_a101';

		BULK INSERT bronze.erp_loc_a101
		FROM 'D:\SQL Data Warehouse Project\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF( second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -----------------+++++++++++';


		SET @start_time = GETDATE();
		PRINT 'TURNCATE TABLE: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;
		PRINT 'INSERTING DATA INTO : bronze.erp_cust_az12';

		BULK INSERT bronze.erp_cust_az12
		FROM 'D:\SQL Data Warehouse Project\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF( second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '>> -----------------+++++++++++';


		SET @start_time = GETDATE();
		PRINT 'TURNCATE TABLE: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		PRINT 'INSERTING DATA INTO : bronze.erp_px_cat_g1v2';

		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'D:\SQL Data Warehouse Project\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF( second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '>> -----------------+++++++++++';

		SET @batch_end_time = GETDATE();
		PRINT '================================================';
		PRINT ' - TOTAL LOAD DURATION: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' SECONDS' ;
		PRINT '=================================================';

		
	END TRY
	BEGIN CATCH 
		PRINT '==============';
		PRINT 'ERROR OCCURED DURING BRONZE LAYER';
		PRINT 'ERROR MESSAGE' + ERROR_MESSAGE();
		PRINT 'ERROR MESSAGE' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'ERROR MESSAGE' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '==============';

	END CATCH
END
