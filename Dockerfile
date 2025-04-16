FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

COPY . ./

WORKDIR /src/src/WebApplication

RUN dotnet restore "./src/WebApplication/Portfolio.WebApplication.csproj"
RUN dotnet publish "./Portfolio.WebApplication.csproj" -c Release -o /app/out

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

COPY --from=build /app/out ./

EXPOSE 80

ENTRYPOINT ["dotnet", "Portfolio.WebApplication.dll"]