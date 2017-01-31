# Build the dotnet core apps inside the aspnetcore-build container.
build:
	docker run -v `pwd`:/sln --workdir /sln -e NUGET_PACKAGES=/sln/package_cache cl0sey/dotnet-mono-docker:1.1-sdk bash build.sh -t Build

test:
	docker run -v `pwd`:/sln --workdir /sln -e NUGET_PACKAGES=/sln/package_cache cl0sey/dotnet-mono-docker:1.1-sdk bash build.sh -t Test
	awk 'NR==1{sub(/^\xef\xbb\xbf/,"")}{print}' report/junit/TestResult.xml > report/junit/TestResult.fixed.xml
	rm -rf report/junit/TestResult.xml

publish:
	docker run -v `pwd`:/sln --workdir /sln -e NUGET_PACKAGES=/sln/package_cache cl0sey/dotnet-mono-docker:1.1-sdk bash build.sh -t publish --scriptargs "--tag=$(TAG)"

# Build the docker images.
build-containers:
	docker build -t sso-web ./src/Web && \
	docker build -t sso-api ./src/Api

push-containers:
	sh push.sh