FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

ENV ASPNETCORE_URLS=http://+:80

# Add environment variables for MySQL database
ENV MYSQL_HOST=your_mysql_host
ENV MYSQL_PORT=your_mysql_port
ENV MYSQL_DATABASE=your_database_name
ENV MYSQL_USER=your_mysql_user
ENV MYSQL_PASSWORD=your_mysql_password

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["FinkiRasporedi/FinkiRasporedi.csproj", "FinkiRasporedi/"]
RUN dotnet restore "FinkiRasporedi/FinkiRasporedi.csproj"
COPY FinkiRasporedi/. ./FinkiRasporedi/
WORKDIR "/src/FinkiRasporedi"
RUN dotnet build "FinkiRasporedi.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "FinkiRasporedi.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "FinkiRasporedi.dll"]
