# Etapa de build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

COPY . .

# Restaura os pacotes com base no .sln
RUN dotnet restore "Portfolio.Web.sln"

# Publica a aplicação
WORKDIR /src/src/WebApplication
RUN dotnet publish "Portfolio.WebApplication.csproj" -c Release -o /app/out

# Etapa de runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

COPY --from=build /app/out .

EXPOSE 80

ENTRYPOINT ["dotnet", "Portfolio.WebApplication.dll"]