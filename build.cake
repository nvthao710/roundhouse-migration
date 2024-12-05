#tool "nuget:?package=roundhouse"

var target = Argument("target", "Default");
var environment = Argument<string>("environment", "Sandbox");
var password = Argument<string>("password", "0E79433E-F36B-1410-8650-00F91313348C");
var userId = Argument<string>("userId", "34E5EE62-429C-4724-B3D0-3891BD0A08C9");
var databaseName = Argument<string>("databaseName", "Sandbox");
var connectionStrings = Argument<string>("connectionStrings", "connectionStrings");
var sqlFolder = Argument<string>("sql", "sql");
var output = Argument<string>("output", "output");
var waitTime = Argument<int>("wait", 0);
var useTransaction = Argument<bool>("useTransaction", true);
var databaseType = Argument<string>("databaseType", "sqlserver");
var doNotCreateDatabase = Argument<bool>("doNotCreateDatabase", true);
var base64ConnectionString = Argument<bool>("base64ConnectionString", true);
var outputPath = Argument<string>("outputPath", "C:/roundhouse/");

Task("Migrate-Database")
    .Description("Migrate the current schema to target database")
    .Does(() =>
    {
        try{
            var settings = new RoundhouseSettings
            {
                ConnectionString = connectionStrings,
                DoNotCreateDatabase = doNotCreateDatabase,
                Silent = true,
                Drop = false,
                Debug = false,
                WithTransaction = useTransaction,
                SqlFilesDirectory = sqlFolder.Replace("{{environment}}", environment.Replace("-", "")),
                DatabaseType = databaseType,
                Environment = environment,
                CommandTimeout = 3600,
                OutputPath = outputPath
            };
            RoundhouseMigrate(settings);
        }
        catch (Exception ex)
        {
            Error($"An error occurred: {ex.Message}");
            Error($"Stack Trace: {ex.StackTrace}");
            if (ex.InnerException != null)
                {
                    Error($"Inner Exception: {ex.InnerException.Message}");
                    Error($"Inner Stack Trace: {ex.InnerException.StackTrace}");
                }
            throw; // Optionally rethrow to indicate failure
        }
    });

Task("Default")
    .IsDependentOn("Migrate-Database");

RunTarget(target);