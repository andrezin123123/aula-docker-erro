FROM golang:1.22-alpine AS build

WORKDIR /app

COPY . /app

RUN go build main.go

# Build
FROM alpine:latest AS production
WORKDIR /app

EXPOSE 8080

ENV PORT 8080
ENV DB_HOST postgres
ENV DB_USER root
ENV DB_PASSWORD root
ENV DB_NAME root
ENV DB_PORT 5432

COPY ./assets/ /app/assets/
COPY ./templates/ /app/templates/
COPY --from=build /app/main /app/main

CMD ["./main"]