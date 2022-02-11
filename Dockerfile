##multi layer dockerfile

FROM openjdk:3-jre-alpine AS download ## base image
RUN mkdir usr/bin/cf    ## create the folder in container
COPY ./demo/target/  usr/bin/cf/ ## copy from local to container
WORKDIR /bin/cf
RUN apk update \
 && apk add curl \
 && curl -sL 'https://packages.cloudfoundry.org/stable?release=linux64-binary&version=6.53.0&source=github-rel' | tar -xzv \
 && chmod 0755 cf

FROM openjdk:3-jre-alpine
COPY --from=download /cf /usr/bin/cf
COPY entrypoint.sh /entrypoint.sh
EXPOSE 8080
ENTRYPOINT ["/entrypoint.sh"] ##set the default application to be used everytime container
