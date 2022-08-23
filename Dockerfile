#FROM klakegg/hugo:0.78.2-alpine AS build
FROM registry.ficld.ir/alpine:latest AS build
RUN apk add -U git
COPY . /src
RUN make init
RUN make build

FROM registry.ficld.ir/nginx:latest
RUN mv /usr/share/nginx/html/index.html /usr/share/nginx/html/old-index.html
COPY --from=build /src/public /usr/share/nginx/html
EXPOSE 80
