using System.Data;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;

try
{
    // --------------------
    // Get ConnectionString
    // --------------------
    var configuration = new ConfigurationBuilder()
        .SetBasePath(Directory.GetCurrentDirectory())      // Optional
        .AddJsonFile("appsettings.json", false, true)
        .Build();

    //var connectionString = configuration.GetConnectionString("KlantenDB");    // or
    var connectionString = configuration["ConnectionStrings:KlantenDB"];        // or
    //var connectionString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|Database.mdf;TrustServerCertificate=True";

    // ----------
    // Connection
    // ----------
    using var connection = new SqlConnection(connectionString);

    // -------
    // Command
    // -------
    var comKlanten = connection.CreateCommand();
    comKlanten.CommandType = CommandType.Text;
    comKlanten.CommandText = "select Voornaam, Familienaam from klanten";

    connection.Open();
    Console.WriteLine("Database geöpend");

    // ------
    // Reader
    // ------
    using var rdrKlanten = comKlanten.ExecuteReader();

    var klantFamilienaamPos = rdrKlanten.GetOrdinal("Familienaam");
    var klantVoornaamPos = rdrKlanten.GetOrdinal("Voornaam");

    while (rdrKlanten.Read())
        Console.WriteLine($"{rdrKlanten.GetString(klantVoornaamPos)} {rdrKlanten.GetString(klantFamilienaamPos)}");

    Console.WriteLine();
}
catch (Exception ex)
{
    Console.WriteLine($"{ex.Message}");
}
