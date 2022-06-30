CREATE TABLE [dbo].[tblBankAccounts]
(
    [Id] INT NOT NULL IDENTITY PRIMARY KEY,
    [BankAccountId] NVARCHAR(200) NOT NULL,
    [CorrelationId] NVARCHAR(200) NOT NULL,
    [ClientId] NVARCHAR(100) NOT NULL,
    [Name] NVARCHAR(200) NOT NULL,
    [Address] NVARCHAR(200) NOT NULL,
    [OpeningBalance] MONEY NOT NULL,
    [CreatedAt] DATETIME NOT NULL
    )