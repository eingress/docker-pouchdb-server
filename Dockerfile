
FROM node:14-alpine
LABEL maintainer "Scott Mathieson <scott@eingress.io>"

RUN apk --update --no-cache add curl g++ make python && \
	npm install --global --unsafe-perm=true pouchdb-server && \
	rm -rf /root/.[^.]* && \
	apk del g++ make python

ADD add-admin.sh /bin/add-admin
ADD add-user.sh /bin/add-user
ADD lib.sh /bin/lib.sh

RUN chmod +x /bin/add-admin /bin/add-user

WORKDIR /pouchdb

ENTRYPOINT ["pouchdb-server"]

CMD ["--host", "0.0.0.0"]
