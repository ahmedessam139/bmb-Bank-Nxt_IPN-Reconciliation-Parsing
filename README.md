# IPN Reconciliation Parsing

This project is an automated solution for parsing and processing IPN (Instant Payment Network) reconciliation transaction files. It reads transaction data from text files, processes them, and stores the information in a SQL Server database for reconciliation purposes.

## Project Overview

The project is built using UiPath RPA (Robotic Process Automation) and is designed to handle large volumes of transaction data efficiently. It includes automatic error handling and file management to ensure reliable processing of transaction records.

## Features

- Automated parsing of transaction files from a designated input folder
- Structured database storage of transaction data
- Automatic file management (moving processed and failed files)
- Error handling and logging
- Support for multiple transaction fields including amounts, currencies, and party information

## Directory Structure

```
├── in-out/
│   ├── unprocessed/    # Place new transaction files here
│   ├── processed/      # Successfully processed files are moved here
│   └── Failed/         # Files that failed processing are moved here
```

## Prerequisites

- Windows Operating System
- SQL Server with appropriate permissions
- UiPath Studio (version 24.10.8.0 or compatible)
- Required UiPath packages:
  - UiPath.Database.Activities (1.9.0)
  - UiPath.Excel.Activities (2.24.4)
  - UiPath.Mail.Activities (1.24.2)
  - UiPath.System.Activities (24.10.7)
  - UiPath.Testing.Activities (24.10.3)
  - UiPath.UIAutomation.Activities (24.10.10)

## Configuration

The project requires the following configuration:

1. Database connection string (configured in the workflow)
2. Input/Output folders:
   - Unprocessed files folder
   - Processed files folder
   - Failed files folder

## Transaction File Format

### File Naming Convention

File name is unique. File name consists of:

- File Type (Transaction)
- Separator [-]
- Cycle id [YYYYMMDDX]
- File extension [.txt]

Example: Transaction-20231225A.txt

### File Content Structure

The input files should be text files with fixed-width fields containing the following information:

| Field Name                     | Length |
| ------------------------------ | ------ |
| TransactionId                  | 36     |
| TransactionType                | 32     |
| SwitchDate                     | 10     |
| TransactionTimeStamp           | 23     |
| BankRole                       | 14     |
| TransactionAmount              | 18     |
| TransactionAmountCurrency      | 3      |
| PayerPspFeesAmount             | 18     |
| PayerPspFeesAmountCurrency     | 3      |
| PayerPspBearFeesAmount         | 18     |
| PayerPspBearFeesAmountCurrency | 3      |
| InterchangeAmount              | 18     |
| InterchangeAmountAction        | 6      |
| InterchangeAmountCurrency      | 3      |
| PayerMobileNumber              | 14     |
| PayerIpa                       | 100    |
| PayerName                      | 100    |
| PayerAccountUniqueIdentifier   | 36     |
| PayerIdentificationType        | 8      |
| PayerIdentificationNumber      | 30     |
| PayerClearAccountNumber        | 50     |
| PayeeMobileNumber              | 14     |
| PayeeIpa                       | 100    |
| PayeeName                      | 100    |
| PayeeAccountUniqueIdentifier   | 36     |
| PayeeIdentificationType        | 8      |
| PayeeIdentificationNumber      | 30     |
| PayeeClearAccountNumber        | 50     |
| TerminalLocation               | 40     |
| TerminalLongitude              | 15     |
| TerminalLatitude               | 15     |
| TransactionRemark              | 100    |
| InterfaceId                    | 15     |
| InterfaceName                  | 100    |
| GatewayTransactionId           | 36     |
| AuthorizationNumber            | 15     |
| IsReversal                     | 1      |
| Result                         | 15     |
| ResponseCode                   | 5      |
| ResponseDescription            | 256    |
| PayerBankId                    | 4      |
| PayeeBankId                    | 4      |
| DebitPoolAccount               | 36     |
| CreditPoolAccount              | 36     |
| BankFeeAmount                  | 18     |
| BankFeeCurrency                | 3      |
| ConvenienceFeeAmount           | 18     |
| ConvenienceFeeCurrency         | 3      |
| TipsFeeAmount                  | 18     |
| TipsFeeCurrency                | 3      |

## Database Schema

Table Name: `IPNReconciliation_RowIPNReconciliationTransactions` in database `UiPath Processes Data`

### Columns:

| Column Name                    | Data Type | Length |
| ------------------------------ | --------- | ------ |
| Id                             | INT       | -      |
| TransactionId                  | VARCHAR   | 36     |
| TransactionType                | VARCHAR   | 32     |
| SwitchDate                     | VARCHAR   | 10     |
| TransactionTimeStamp           | VARCHAR   | 23     |
| BankRole                       | VARCHAR   | 14     |
| TransactionAmount              | VARCHAR   | 18     |
| TransactionAmountCurrency      | VARCHAR   | 3      |
| PayerPspFeesAmount             | VARCHAR   | 18     |
| PayerPspFeesAmountCurrency     | VARCHAR   | 3      |
| PayerPspBearFeesAmount         | VARCHAR   | 18     |
| PayerPspBearFeesAmountCurrency | VARCHAR   | 3      |
| InterchangeAmount              | VARCHAR   | 18     |
| InterchangeAmountAction        | VARCHAR   | 6      |
| InterchangeAmountCurrency      | VARCHAR   | 3      |
| PayerMobileNumber              | VARCHAR   | 14     |
| PayerIpa                       | VARCHAR   | 100    |
| PayerName                      | VARCHAR   | 100    |
| PayerAccountUniqueIdentifier   | VARCHAR   | 36     |
| PayerIdentificationType        | VARCHAR   | 8      |
| PayerIdentificationNumber      | VARCHAR   | 30     |
| PayerClearAccountNumber        | VARCHAR   | 50     |
| PayeeMobileNumber              | VARCHAR   | 14     |
| PayeeIpa                       | VARCHAR   | 100    |
| PayeeName                      | VARCHAR   | 100    |
| PayeeAccountUniqueIdentifier   | VARCHAR   | 36     |
| PayeeIdentificationType        | VARCHAR   | 8      |
| PayeeIdentificationNumber      | VARCHAR   | 30     |
| PayeeClearAccountNumber        | VARCHAR   | 50     |
| TerminalLocation               | VARCHAR   | 40     |
| TerminalLongitude              | VARCHAR   | 15     |
| TerminalLatitude               | VARCHAR   | 15     |
| TransactionRemark              | VARCHAR   | 100    |
| InterfaceId                    | VARCHAR   | 15     |
| InterfaceName                  | VARCHAR   | 100    |
| GatewayTransactionId           | VARCHAR   | 36     |
| AuthorizationNumber            | VARCHAR   | 15     |
| IsReversal                     | VARCHAR   | 1      |
| Result                         | VARCHAR   | 15     |
| ResponseCode                   | VARCHAR   | 5      |
| ResponseDescription            | VARCHAR   | 256    |
| PayerBankId                    | VARCHAR   | 4      |
| PayeeBankId                    | VARCHAR   | 4      |
| DebitPoolAccount               | VARCHAR   | 36     |
| CreditPoolAccount              | VARCHAR   | 36     |
| BankFeeAmount                  | VARCHAR   | 18     |
| BankFeeCurrency                | VARCHAR   | 3      |
| ConvenienceFeeAmount           | VARCHAR   | 18     |
| ConvenienceFeeCurrency         | VARCHAR   | 3      |
| TipsFeeAmount                  | VARCHAR   | 18     |
| TipsFeeCurrency                | VARCHAR   | 3      |
| EnteringTime                   | DATETIME  | -      |
| SourceFileName                 | VARCHAR   | 255    |

## Usage

1. Place the transaction files to be processed in the `in-out/unprocessed` folder
2. Run the UiPath workflow
3. Monitor the following locations:
   - Successfully processed files will be moved to `in-out/processed`
   - Failed files will be moved to `in-out/Failed`
   - Check the execution logs for any errors or issues

## Error Handling

The workflow includes comprehensive error handling:

- Failed files are automatically moved to the Failed folder
- Error messages are logged for troubleshooting
- Transaction processing continues even if individual files fail

## Version

Current Version: 1.0.0
