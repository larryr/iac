

help:
	@echo -- Realm --
	@echo help -- display this
	@echo check -- check environment and tools
	@echo

check:
	terraform version

k8s: k8s1 k8s0

k8s0:
	az aks get-credentials -g raufed-0-realm-0-rg  -n raufed-0-realm-0-k8s

k8s1:
	az aks get-credentials -g raufed-0-realm-1-rg  -n raufed-0-realm-1-k8s
