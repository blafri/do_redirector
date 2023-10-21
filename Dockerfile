FROM nginx
COPY default.conf /etc/nginx/conf.d/default.conf

COPY redirects_generator.sh ./
RUN chmod a+x ./redirects_generator.sh

RUN ./redirects_generator.sh "/etc/nginx/conf.d/default.conf"