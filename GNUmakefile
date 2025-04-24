BIN_NAME=terraform-provider-hashicups
BIN_DIR=$(PWD)/bin
HOSTNAME=hashicorp.com
NAMESPACE=edu
NAME=hashicups
VERSION=0.1.0
OS_ARCH=linux_amd64
LESSON=orders
TF_LOG=INFO # TRACE, DEBUG, INFO, WARN, ERROR
TF_LOG_PATH=logs/trace.txt

default: fmt lint install generate

# /home/nikita/Programming/test_terraform/terraform-provider-hashicups/bin
# build:
# 	mkdir -p $(BIN_DIR)
# 	go build -o $(BIN_NAME)
# 	mv $(BIN_NAME) $(BIN_DIR)
build:
	go build -o $(BIN_NAME)
	
build-linux:
	mkdir -p $(BIN_DIR)
	GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o $(BIN_NAME)
	mv $(BIN_NAME) $(BIN_DIR)


install_local: build
	rm -f .terraform.lock.hcl
	rm -f ~/.terraform.d/plugins/${HOSTNAME}/${NAMESPACE}/${NAME}/${VERSION}/${OS_ARCH}/${BIN_NAME}
	mkdir -p ~/.terraform.d/plugins/${HOSTNAME}/${NAMESPACE}/${NAME}/${VERSION}/${OS_ARCH}/
	mv ${BIN_NAME} ~/.terraform.d/plugins/${HOSTNAME}/${NAMESPACE}/${NAME}/${VERSION}/${OS_ARCH}


install: build
	go install -v ./...

lint:
	golangci-lint run

generate:
	cd tools; go generate ./...

fmt:
	gofmt -s -w -e .

test:
	go test -v -cover -timeout=120s -parallel=10 ./...

testacc:
	TF_ACC=1 go test -v -cover -timeout 120m ./...

terraform-init:
	cd examples/${LESSON}/ && terraform init -upgrade

terraform-plan:
	cd examples/${LESSON}/ && HASHICUPS_HOST=http://localhost:19090 \
	HASHICUPS_USERNAME=education \
	HASHICUPS_PASSWORD=test123 \
	TF_LOG=${TF_LOG} TF_LOG_PATH=${TF_LOG_PATH} terraform plan

docker-up:
	cd docker_compose && whoami && docker compose up


.PHONY: fmt lint test testacc build install generate
