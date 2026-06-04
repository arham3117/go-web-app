 # ----------------- Stage 1: Build the application -----------------
  FROM golang:1.26 AS builder

  WORKDIR /app

  # Cache dependencies in their own layer
  COPY go.mod .
  RUN go mod download

  COPY . .

  # Static binary so it runs on distroless/static
  RUN CGO_ENABLED=0 GOOS=linux go build -o main .

  # ----------------- Stage 2: Create the final image -----------------
  FROM gcr.io/distroless/static:nonroot

  WORKDIR /app

  COPY --from=builder /app/main .
  COPY --from=builder /app/static ./static

  EXPOSE 8080

  CMD ["./main"]