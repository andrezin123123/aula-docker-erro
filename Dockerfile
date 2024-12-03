FROM golang:1.22-alpine AS build

WORKDIR /app

COPY ./assets/ /app/assets/
COPY ./controllers/ /app/controllers/
COPY ./database/ /app/database/
COPY ./models/ /app/models/
COPY ./routes/ /app/routes/
COPY ./templates/ /app/templates/
COPY ./main.go /app/main.go
COPY ./go.mod /app/go.mod
COPY ./go.sum /app/go.sum

RUN go build main.go

# Build aas df
FROM golang:1.22 AS production
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