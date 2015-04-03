# VERSION 1.0
# AUTHOR: Matthieu "Puckel_" Roisil
# DESCRIPTION: Basic Graphite container
# BUILD: docker build --rm -t puckel/docker-graphite
# SOURCE: https://github.com/puckel/docker-graphite

FROM puckel/docker-base
MAINTAINER Puckel_

# Never prompts the user for choices on installation/configuration of packages
ENV DEBIAN_FRONTEND noninteractive
ENV TERM linux
# Work around initramfs-tools running on kernel 'upgrade': <http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=594189>
ENV INITRD No
ENV GRAFANA_RELEASE 1.9.1

RUN apt-get update -yqq \
    && apt-get install -yqq \
    build-essential expect python-dev python-pip python-cairo python-flup \
    pkg-config libffi-dev libcairo2 libcairo2-dev supervisor apache2 libapache2-mod-wsgi \
    && curl -sL http://grafanarel.s3.amazonaws.com/grafana-${GRAFANA_RELEASE}.tar.gz | tar xz \
    && mv grafana-${GRAFANA_RELEASE} /var/www/grafana \
    && apt-get clean \
    && rm -rf \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/* \
    /usr/share/man \
    /usr/share/doc \
    /usr/share/doc-base

ADD config/requirements.txt /root/requirements.txt
RUN pip install -r /root/requirements.txt

ADD config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD config/storage-schemas.conf /opt/graphite/conf/storage-schemas.conf
ADD config/local_settings.py /opt/graphite/webapp/graphite/local_settings.py
ADD config/vhost_graphite.conf /etc/apache2/sites-available/graphite.conf
ADD config/vhost_grafana.conf /etc/apache2/sites-available/grafana.conf
ADD config/vhost_elasticsearch.conf /etc/apache2/sites-available/elastic.conf
ADD config/grafana_config.js /var/www/grafana/config.js
ADD config/initial_data.json /opt/graphite/webapp/graphite/initial_data.json

RUN a2dissite 000-default && a2ensite grafana graphite elastic && a2enmod headers proxy_http proxy
RUN cd /opt/graphite/webapp/graphite && python manage.py syncdb --noinput
RUN mv /opt/graphite/conf/carbon.conf.example /opt/graphite/conf/carbon.conf
RUN mv /opt/graphite/conf/aggregation-rules.conf.example /opt/graphite/conf/aggregation-rules.conf
RUN mv /opt/graphite/conf/storage-aggregation.conf.example /opt/graphite/conf/storage-aggregation.conf
RUN mv /opt/graphite/conf/dashboard.conf.example /opt/graphite/conf/dashboard.conf
RUN mv /opt/graphite/conf/graphTemplates.conf.example /opt/graphite/conf/graphTemplates.conf
RUN mv /opt/graphite/conf/graphite.wsgi.example /opt/graphite/conf/graphite.wsgi
RUN chown -R www-data:www-data /opt/graphite/storage/

EXPOSE 80 8080 2003 2004 7002

CMD ["/usr/bin/supervisord"]
