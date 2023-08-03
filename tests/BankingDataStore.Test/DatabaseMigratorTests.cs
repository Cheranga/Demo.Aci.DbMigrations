using BankingDataStore.Console;
using FluentAssertions;

namespace BankingDataStore.Test;

public class DatabaseMigratorTests : IClassFixture<DatabaseFixture>
{
    private readonly DatabaseFixture _dbFixture;

    public DatabaseMigratorTests(DatabaseFixture dbFixture) => _dbFixture = dbFixture;

    [Fact(DisplayName = "Database migration must be successful")]
    public void DatabaseMigration()
    {
        var status = DatabaseMigrator.Migrate(_dbFixture.DbContainer.GetConnectionString());
        status.Should().BeGreaterOrEqualTo(0);
    }
}