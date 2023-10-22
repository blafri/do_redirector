FROM ruby:3
WORKDIR /usr/local/src
COPY redirects.rb ./
ARG REDIRECTS
RUN ["ruby", "./redirects.rb"]

FROM nginx:latest
COPY default.conf /etc/nginx/conf.d/
COPY --from=0 /usr/local/src/redirects.conf /etc/nginx/conf.d/
