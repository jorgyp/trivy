# FROM alpine:3.13
# RUN apk --no-cache add ca-certificates git
# COPY trivy /usr/local/bin/trivy
# COPY contrib/*.tpl contrib/
# ENTRYPOINT ["trivy"]

FROM nginx:1.9.5