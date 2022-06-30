FROM mcr.microsoft.com/dotnet/runtime:6.0 AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["BankingDataStore.Console/BankingDataStore.Console.csproj", "BankingDataStore.Console/"]
RUN dotnet restore "BankingDataStore.Console/BankingDataStore.Console.csproj"
COPY . .
WORKDIR "/src/BankingDataStore.Console"
RUN dotnet build "BankingDataStore.Console.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "BankingDataStore.Console.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "BankingDataStore.Console.dll"]
