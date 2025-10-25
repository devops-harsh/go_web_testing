FROM golang:1.21 as baseimage

WORKDIR /app

COPY go.mod .  
# we require to copy go.mod. - go.mod contians all the depnedencies of go application

RUN go mod download
# To download the dependencies we require run the RUN go mod download 

COPY . . 

RUN go build -o main .

# Second and final stage with distroless image 

FROM gcr.io/distroless/base

COPY --from=baseimage /app/main .

COPY --from=baseimage /app/static /static 

EXPOSE 8080 

CMD ["./main"]


