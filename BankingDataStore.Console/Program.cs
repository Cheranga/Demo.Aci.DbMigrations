using BankingDataStore.Console;

Console.WriteLine("Starting database migrations");

var serverName = Environment.GetEnvironmentVariable("SERVER_NAME");
var userName = Environment.GetEnvironmentVariable("USERNAME");
var password = Environment.GetEnvironmentVariable("PASSWORD");
var databaseName = Environment.GetEnvironmentVariable("DATABASE_NAME");

ArgumentNullException.ThrowIfNull(serverName);
ArgumentNullException.ThrowIfNull(databaseName);
ArgumentNullException.ThrowIfNull(userName);
ArgumentNullException.ThrowIfNull(password);

DatabaseMigrator.Migrate(new SqlDatabaseOptions(serverName, databaseName, userName, password));