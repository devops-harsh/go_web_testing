FROM golang:1.21 as BaseImage 

WORKDIR /app

COPY go.mod .  
# we require to copy go.mod. go.mod contians all the depnedencies of go application

RUN go mod download
# To download the dependencies we require run the RUN go mod download 

COPY . . 

RUN go build -o main .

# Second and final stage with distroless image 

FROM gcr.io/distroless/base

COPY --from=BaseImage /app/main .

COPY --from=BaseImage /app/static /static 

EXPOSE 8080 

CMD["./main"]


