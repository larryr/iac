
# Mac tool installs
help:
	setup    -- install all client tools
	check    -- check versions of client tools
	kubeup   -- upgrade kubernetes-cli
	tfupdate -- upgrade terraform
	azup     -- upgrade azure client
	upall    -- upgrade all client tools

setup:
	brew update
	brew tap hashicorp/tap
	brew install hashicorp/tap/terraform
	brew install azure-cli
	brew install kubernetes-cli

check:
	terraform --version
	az --version
	docker version
	kubectl version --client

brewup:
	brew update

kubeup: brewup
	brew upgrade kubernetes-cli

tfupdate: brewup
	brew upgrade hashicorp/tap/terraform

upall: kubeup tfupdate

