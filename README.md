# Wiremock

To create or update Wiremock version in registry you need to choose WIREMOCK_VERSION variable and run Jenkins job

WIREMOCK_VERSION variable is the version of wiremock server that you want to use, you can choose it from wiremock maven repository:

- https://repo1.maven.org/maven2/com/github/tomakehurst/wiremock-standalone/

You can build your own wiremock image with specific version locally:

`docker build -t <tag name> --build-arg WIREMOCK_VERSION=2.14.0 .`


To run docker container locally:

`docker run -d -it -v /tmp/repo:/repo/wiremock-mappings -p 8080:8080 --name <name for your container> <image_name:tag>`

/tmp/repo - directory on your host machine where git repo wiremock-mappings was cloned berfore
/repo/wiremock-mappings - directory in container where your local directory will be mounted

You can also change environment variables during docker run coomand with `-e` key and pass variables and their specific values for your needs, for example:

`docker run -d -it -v /tmp/repo:/repo/wiremock-mappings -p 8080:8080 -e SERVICE=mock -e THREADS=5 -e EXTENSIONS=com.*.*.wiremock.transformer.CutOffDateTransformer,com.*.*.wiremock.transformer.StartDateTransformer --name <name for your container> <image_name:tag>`

SERVICE variable is wiremock-mappings for different services

THREADS variable is number of `--container-threads` for Jetty application server

EXTENSIONS variable is classes that will be used during jar startup


Documentation about Wiremock: http://wiremock.org/docs/
