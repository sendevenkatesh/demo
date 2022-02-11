FROM alpine:3 AS download ## base image
RUN mkdir -p /usr/bin/cf
COPY . /bin/cf
WORKDIR /bin/cf
RUN apk update \
 && apk add curl \
 && curl -sL 'https://packages.cloudfoundry.org/stable?release=linux64-binary&version=6.53.0&source=github-rel' | tar -xzv \
 && chmod 0755 cf

FROM alpine:3
COPY --from=download /cf /usr/bin/cf
COPY entrypoint.sh /entrypoint.sh
EXPOSE 8080
ENTRYPOINT ["/entrypoint.sh"]
