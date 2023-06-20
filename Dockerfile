FROM golang:1.18-alpine as builder

WORKDIR /usr/src/app

COPY go.mod ./
RUN go mod download && go mod verify

COPY . .
RUN CGO_ENABLED=0 go build -ldflags "-s -w" -v -o ./app ./main.go

FROM scratch

WORKDIR /usr/src/app

COPY --from=builder /usr/src/app/app ./

CMD [ "./app" ]
