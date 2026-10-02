.PHONY: all validate diff render lint

all: validate

validate:
	@echo "==> Validating Kustomize base & overlays..."
	kubectl kustomize base > /dev/null
	kubectl kustomize overlays/staging > /dev/null
	kubectl kustomize overlays/production > /dev/null
	@echo "==> All manifests are syntactically valid!"

render-prod:
	@echo "==> Rendering production manifests..."
	kubectl kustomize overlays/production

lint:
	@echo "==> Linting kubernetes manifests..."
	@which kubeval >/dev/null 2>&1 && kubeval base/*.yaml || echo "Notice: kubeval not installed, syntax checked via kustomize."
