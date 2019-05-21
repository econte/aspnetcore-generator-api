FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build-env
WORKDIR /integration

COPY integration.csproj .
RUN dotnet restore

COPY . .

ENTRYPOINT [ "dotnet", "test" ]