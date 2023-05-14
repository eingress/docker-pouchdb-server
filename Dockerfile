
ARG NODE_IMAGE_VERSION

FROM node:$NODE_IMAGE_VERSION

LABEL maintainer "Scott Mathieson <scott@eingress.io>"

RUN apk --update --no-cache --virtual .build-deps add curl g++ make && \
	npm install --global --omit=dev --unsafe-perm=true pouchdb-server && \
	rm -rf /root/.[^.]* && \
	apk del .build-deps

ADD add-admin.sh /bin/add-admin
ADD add-user.sh /bin/add-user
ADD lib.sh /bin/lib.sh

RUN chmod +x /bin/add-admin /bin/add-user

WORKDIR /pouchdb

ENTRYPOINT ["pouchdb-server"]

CMD ["--host", "0.0.0.0"]
