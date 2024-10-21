# syntax=docker/dockerfile:1

# Create a stage for building the application.
FROM --platform=$BUILDPLATFORM mcr.microsoft.com/dotnet/sdk:8.0-alpine AS build

# Cài đặt tzdata để quản lý múi giờ
RUN apk add --no-cache tzdata

# Thiết lập múi giờ
ENV TZ=Asia/Ho_Chi_Minh
RUN cp /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY . /source

WORKDIR /source/Opal_Exe201.Controllers

# This is the architecture you’re building for, which is passed in by the builder.
ARG TARGETARCH

# Build the application.
RUN --mount=type=cache,id=nuget,target=/root/.nuget/packages \
    dotnet publish -a ${TARGETARCH/amd64/x64} --use-current-runtime --self-contained false -o /app

################################################################################
# Create a new stage for running the application
FROM mcr.microsoft.com/dotnet/aspnet:8.0-alpine AS final

# Cài đặt tzdata và icu-libs
RUN apk add --no-cache tzdata icu-libs

# Thiết lập múi giờ
ENV TZ=Asia/Ho_Chi_Minh
RUN cp /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=false

WORKDIR /app

# Copy everything needed to run the app from the "build" stage.
COPY --from=build /app .

# Switch to a non-privileged user
USER $APP_UID

ENTRYPOINT ["dotnet", "Opal_Exe201.Controllers.dll"]
