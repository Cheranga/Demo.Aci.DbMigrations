using DbUp;

namespace BankingDataStore.Console;

public sealed record SqlDatabaseOptions(
    string ServerName,
    string DatabaseName,
    string UserName,
    string Password
);

public static class DatabaseMigrator
{
    public static int Migrate(string connectionString)
    {
        EnsureDatabase.For.SqlDatabase(connectionString);

        var upgradeEngineBuilder = DeployChanges.To
            .SqlDatabase(connectionString)
            .WithScriptsEmbeddedInAssembly(typeof(Program).Assembly)
            .WithTransactionPerScript()
            .LogToConsole();

        var upgradeEngine = upgradeEngineBuilder.Build();
        if (upgradeEngine.IsUpgradeRequired())
        {
            System.Console.WriteLine("Database migrations must be performed");

            var operation = upgradeEngine.PerformUpgrade();
            if (operation.Successful)
            {
                System.Console.WriteLine("Database migration successful");
                return 0;
            }

            System.Console.WriteLine("Database migration failed");
            return -1;
        }

        System.Console.WriteLine("Database migrations are not required");
        return 0;
    }

    public static int Migrate(SqlDatabaseOptions options)
    {
        var connectionString =
            $"Server={options.ServerName},1433;Database={options.DatabaseName};User Id={options.UserName};Password={options.Password};";
        return Migrate(connectionString);
    }
}