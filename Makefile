PROTOFILES=$(shell find src | grep '\.proto')

default: clean build

.PHONY: test

test:
	go build ./...

.PHONY: build

build: protowrap grpc_gatway
	protowrap \
	  -Isrc \
	  -I$(GOPATH)/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
	  -I$(GOPATH)/src/github.com/golang/protobuf/ptypes/timestamp \
	  --go_out=plugins=grpc:go \
	  --grpc-gateway_out=logtostderr=true:go \
	  $(PROTOFILES)

protowrap:
	go get github.com/square/goprotowrap/...

grpc_gatway:
	go get github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway/...

clean:
	rm -rf ./go/*

