# Runtime Petrostar DR — meniru VM produksi:
#   Ubuntu 22.04 + Apache 2.4 + PHP 8.1-FPM & 8.2-FPM (proxy_fcgi)
# Kode aplikasi TIDAK dibakar ke image; dipasang lewat volume /var/www/html
FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive TZ=Asia/Jakarta

RUN apt-get update && apt-get install -y --no-install-recommends \
      ca-certificates curl gnupg lsb-release software-properties-common tzdata \
    && add-apt-repository -y ppa:ondrej/php \
    && add-apt-repository -y ppa:ondrej/apache2 \
    && apt-get update

# Ekstensi disamakan dengan produksi (php8.2 -m / php8.1 -m)
ARG EXT="bcmath calendar curl exif gd gettext igbinary imagick intl mbstring \
         opcache pgsql redis soap sockets xml xsl zip"
RUN apt-get install -y --no-install-recommends apache2 \
    && for V in 8.1 8.2; do \
         apt-get install -y --no-install-recommends php$V-fpm php$V-cli $(for e in $EXT; do echo -n "php$V-$e "; done) ; \
       done \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN a2enmod proxy_fcgi setenvif rewrite headers ssl \
    && a2enconf php8.2-fpm \
    && mkdir -p /run/php /var/www/html

COPY masuk.sh /masuk.sh
RUN chmod +x /masuk.sh
EXPOSE 80
ENTRYPOINT ["/masuk.sh"]
