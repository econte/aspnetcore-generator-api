# Buld stage
FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS buld-env
WORKDIR /generator

# Restore
COPY api/api.csproj ./api/
RUN dotnet restore api/api.csproj

COPY tests/tests.csproj ./tests/
RUN dotnet restore tests/tests.csproj

# Copy sources
COPY . .

# Run tests
ENV TEAMCITY_PROJECT_NAME=fake
RUN dotnet test tests/tests.csproj

# Publish app
RUN dotnet publish api/api.csproj -o /publish -c Release

# Runtime stage
FROM mcr.microsoft.com/dotnet/core/aspnet:2.2

WORKDIR /publish
COPY --from=buld-env /publish .

ENTRYPOINT ["dotnet", "api.dll"]