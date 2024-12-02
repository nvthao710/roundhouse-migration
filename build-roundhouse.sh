#! /bin/sh

echo "Using pwd string: $(pwd)"
echo "Using target name string: $TARGET"
echo "Using environment string: $ENVIRONMENT"
echo "Using database name string: $DATABASENAME"
echo "Using user id string: $USERID"
echo "Using password string: $PASSWORD"
echo "Using server name string: $SERVERNAME"

echo "Running migrations..."
#dotnet cake build.cake --target=Migrate-Database --projects="./**/*.csproj" --sql="./db/SQLServer/{{environment}}" --environment=$ENVIRONMENT --password="0E79433E-F36B-1410-8650-00F91313348C" --userId="34E5EE62-429C-4724-B3D0-3891BD0A08C9" --DatabaseName="RoundHouse" --connectionStrings="Data Source=THAONGUYEN-DEV;Initial Catalog=RoundHouse;Integrated Security=True; TrustServerCertificate=True;" --doNotCreateDatabase=false

cake /src/build.cake \
--verbosity=diagnostic \
--target=$TARGET \
--sql="./db/SQLServer/{{environment}}" \
--environment=$ENVIRONMENT \
--password=$PASSWORD \
--userId=$USERID \
--databaseName=$DATABASENAME \
--connectionStrings="Server=$SERVERNAME;Database=$DATABASENAME;User Id=$USERID;Password=$PASSWORD;" \
--doNotCreateDatabase=false
#--connectionStrings="Server=172.16.97.207,1422;Database={{databaseName}};User Id={{userid}};Password={{password}};" \