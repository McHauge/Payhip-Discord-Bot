# Specifies a parent image
FROM golang:1.25.0-alpine

LABEL version="v1.0.3"

# Creates an app directory to hold your app’s source code
WORKDIR /app

# ENV Variables:
ENV PAYHIP_TOKEN ""
ENV BOT_TOKEN ""
ENV GUILD_ID ""
ENV ROLE_ID ""
ENV REMREMOVE_COMMANDS ""
ENV MAX_LICENSE_USES ""

# pre-copy/cache go.mod for pre-downloading dependencies and only redownloading them in subsequent builds if they change
COPY go.mod go.sum ./
RUN go mod download && go mod verify

# Copies everything from your root directory into /app
COPY . .

# Builds your app with optional configuration
RUN go build -v -o ./app/payhip-discord-bot .

# Specifies the executable command that runs when the container starts
CMD [ "./app/payhip-discord-bot" ]