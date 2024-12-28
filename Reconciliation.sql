/*
 * Reconciliation Table Schema Definition
 * Purpose: Defines the schema for reconciliation transaction table
 * Database: BankNXT_DB
 * Schema: dbo
 */

SET NOCOUNT ON;
GO

-- Enable proper error handling
BEGIN TRY

    -- Create Reconciliation Transactions table if it doesn't exist
    IF NOT EXISTS (
        SELECT * 
        FROM sys.objects 
        WHERE object_id = OBJECT_ID(N'[dbo].[RowReconciliationTransactions]') 
        AND type = N'U'
    )
    BEGIN
        CREATE TABLE [BankNXT_DB].[dbo].[RowReconciliationTransactions] (
            Id INT IDENTITY(1,1) ,
            TransactionId VARCHAR(36) ,
            TransactionType VARCHAR(32) ,
            SwitchDate VARCHAR(10) ,
            TransactionTimeStamp VARCHAR(23) ,
            BankRole VARCHAR(14) ,
            
            -- Transaction Amounts
            TransactionAmount VARCHAR(18) ,
            TransactionAmountCurrency VARCHAR(3) ,
            
            -- Fee Information
            PayerPspFeesAmount VARCHAR(18) ,
            PayerPspFeesAmountCurrency VARCHAR(3) ,
            PayerPspBearFeesAmount VARCHAR(18) ,
            PayerPspBearFeesAmountCurrency VARCHAR(3) ,
            InterchangeAmount VARCHAR(18) ,
            InterchangeAmountAction VARCHAR(6) ,
            InterchangeAmountCurrency VARCHAR(3) ,
            
            -- Payer Information
            PayerMobileNumber VARCHAR(14) ,
            PayerIpa VARCHAR(100) ,
            PayerName VARCHAR(100) ,
            PayerAccountUniqueIdentifier VARCHAR(36) ,
            PayerIdentificationType VARCHAR(8) ,
            PayerIdentificationNumber VARCHAR(30) ,
            PayerClearAccountNumber VARCHAR(50) ,
            
            -- Payee Information
            PayeeMobileNumber VARCHAR(14) ,
            PayeeIpa VARCHAR(100) ,
            PayeeName VARCHAR(100) ,
            PayeeAccountUniqueIdentifier VARCHAR(36) ,
            PayeeIdentificationType VARCHAR(8) ,
            PayeeIdentificationNumber VARCHAR(30) ,
            PayeeClearAccountNumber VARCHAR(50) ,
            
            -- Terminal Information
            TerminalLocation VARCHAR(40) ,
            TerminalLongitude VARCHAR(15) ,
            TerminalLatitude VARCHAR(15) ,
            
            -- Transaction Details
            TransactionRemark VARCHAR(100) ,
            InterfaceId VARCHAR(15) ,
            InterfaceName VARCHAR(100) ,
            GatewayTransactionId VARCHAR(36) ,
            AuthorizationNumber VARCHAR(15) ,
            IsReversal VARCHAR(1) ,
            Result VARCHAR(15) ,
            ResponseCode VARCHAR(5) ,
            ResponseDescription VARCHAR(256) ,
            
            -- Bank Information
            PayerBankId VARCHAR(4) ,
            PayeeBankId VARCHAR(4) ,
            DebitPoolAccount VARCHAR(36) ,
            CreditPoolAccount VARCHAR(36) ,
            
            -- Additional Fee Information
            BankFeeAmount VARCHAR(18) ,
            BankFeeCurrency VARCHAR(3) ,
            ConvenienceFeeAmount VARCHAR(18) ,
            ConvenienceFeeCurrency VARCHAR(3) ,
            TipsFeeAmount VARCHAR(18) ,
            TipsFeeCurrency VARCHAR(3) ,
            
            EnteringTime DATETIME DEFAULT GETDATE() ,
            SourceFileName VARCHAR(255) ,

            
            -- Constraints
            CONSTRAINT [PK_RowReconciliationTransactions] PRIMARY KEY CLUSTERED (Id ASC)
            --CONSTRAINT [UQ_RowReconciliationTransactions_TransactionId] UNIQUE (TransactionId)
        );

        -- Create indexes for frequently queried columns
        CREATE NONCLUSTERED INDEX [IX_RowReconciliationTransactions_TransactionId] 
        ON [BankNXT_DB].[dbo].[RowReconciliationTransactions] (TransactionId);

        CREATE NONCLUSTERED INDEX [IX_RowReconciliationTransactions_SwitchDate] 
        ON [BankNXT_DB].[dbo].[RowReconciliationTransactions] (SwitchDate);
    END;

END TRY
BEGIN CATCH
    DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
    DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
    DECLARE @ErrorState INT = ERROR_STATE();

    RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
END CATCH;
GO

-- Commented out maintenance commands for safety
/*
-- Table maintenance commands
-- TRUNCATE TABLE [BankNXT_DB].[dbo].[RowReconciliationTransactions];
-- DROP TABLE IF EXISTS [BankNXT_DB].[dbo].[RowReconciliationTransactions];
*/

