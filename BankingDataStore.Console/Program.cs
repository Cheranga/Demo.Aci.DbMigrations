using DbUp;

Console.WriteLine("Starting database migrations");

var serverName = Environment.GetEnvironmentVariable("SERVER_NAME");
var userName = Environment.GetEnvironmentVariable("USERNAME");
var password = Environment.GetEnvironmentVariable("PASSWORD");
var databaseName = Environment.GetEnvironmentVariable("DATABASE_NAME");

var connectionString = $"Server={serverName},1433;Database={databaseName};User Id={userName};Password={password};";

EnsureDatabase.For.SqlDatabase(connectionString);

var upgradeEngineBuilder = DeployChanges.To
    .SqlDatabase(connectionString)
    .WithScriptsEmbeddedInAssembly(typeof(Program).Assembly)
    .WithTransactionPerScript()
    .LogToConsole();

var upgradeEngine = upgradeEngineBuilder.Build();
if (upgradeEngine.IsUpgradeRequired())
{
    Console.WriteLine("Database migrations must be performed");

    var operation = upgradeEngine.PerformUpgrade();
    if (operation.Successful)
    {
        Console.WriteLine("Database migration successful");
        return 0;
    }

    Console.WriteLine("Database migration failed");
    return -1;
}

Console.WriteLine("Database migrations are not required");
return 0;