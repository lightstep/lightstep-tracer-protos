PROTOFILES=$(shell find src | grep '\.proto')

default: clean go

.PHONY: test

test:
	go build ./...

.PHONY: go proto_go gateways_go

go: proto_go gateways_go

proto_go: protowrap grpc_gatway
	protowrap \
	  -Isrc \
	  -I$(GOPATH)/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
	  -I$(GOPATH)/src/github.com/golang/protobuf/ptypes/timestamp \
	  --go_out=plugins=grpc:go \
	  $(PROTOFILES)

gateways_go: protowrap grpc_gatway
	protowrap \
	  -Isrc \
	  -I$(GOPATH)/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
	  -I$(GOPATH)/src/github.com/golang/protobuf/ptypes/timestamp \
	  --grpc-gateway_out=logtostderr=true:go \
	  $(PROTOFILES)

protowrap:
	go get github.com/square/goprotowrap/...

grpc_gatway:
	go get github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway/...

clean:
	rm -rf ./go/*

