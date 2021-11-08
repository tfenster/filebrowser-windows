# escape=`
ARG BASE
FROM mcr.microsoft.com/windows/servercore:$BASE

ARG VERSION
ENV VERSION=$VERSION

LABEL org.opencontainers.image.authors="Tobias Fenster (https://tobiasfenster.io)"
LABEL org.opencontainers.image.source="https://github.com/filebrowser-windows"
LABEL org.opencontainers.image.description="Container image for the amazing https://github.com/filebrowser/filebrowser to run it on Windows"
LABEL org.opencontainers.image.version=$VERSION

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Write-Host "Downloading and expanding $($env:VERSION)"; `
    $url = ('https://github.com/filebrowser/filebrowser/releases/download/' + $env:VERSION + '/windows-amd64-filebrowser.zip'); `
	New-Item -ItemType Directory -Path 'c:\filebrowser' | Out-Null ; `
    Invoke-WebRequest -UseBasicParsing -Uri $url -OutFile 'c:\filebrowser.zip'; `
    Expand-Archive 'c:\filebrowser.zip' 'c:\filebrowser'; `
    Remove-Item 'c:\filebrowser.zip'; 

ENTRYPOINT [ "c:\\filebrowser\\filebrowser.exe" ]