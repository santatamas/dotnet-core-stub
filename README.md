# Dotnet core stub
Stub for a simple dotnet core Webapp + api, running in Docker, building with CircleCI

# Build/Restore
run `make build`

# Build Api/Web Containers
run `make build-containers`

# Publish Release artifacts
run `make publish`

# Run Tests
run `make test`

# Push Containers to Docker Hub (you need to be logged in)
run `make push-containers`

```
# Run final container, mapping 8080 on the local machine to 80 on the container.
`docker run -p 8080:80 --rm -it sso-web`
```