FROM microsoft/aspnetcore
WORKDIR /app
COPY ./publish .
EXPOSE 80
ENTRYPOINT ["dotnet", "Web.dll"]