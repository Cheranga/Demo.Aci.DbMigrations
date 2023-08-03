using Testcontainers.MsSql;

namespace BankingDataStore.Test;

public class DatabaseFixture : IAsyncLifetime
{
    public MsSqlContainer DbContainer { get; }

    public DatabaseFixture() =>
        DbContainer = new MsSqlBuilder()
            .WithImage("mcr.microsoft.com/mssql/server:2019-latest")
            .WithName(nameof(DatabaseMigratorTests))
            .WithPassword("Password666!!")
            .WithAutoRemove(true)
            .Build();

    public Task InitializeAsync() => DbContainer.StartAsync();

    public Task DisposeAsync() => DbContainer.StopAsync();
}