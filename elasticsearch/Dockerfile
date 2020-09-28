FROM elasticsearch:6.8.7

ENV ELASTIC_SERVER https://elasticsearch.developers.italia.it

RUN set -o pipefail \
        ; \
        curl -sL https://rpm.nodesource.com/setup_10.x | bash - \
        && yum install -y nodejs \
        && npm install -g elasticdump \
        \
        && elasticdump --input "$ELASTIC_SERVER/administrations" --output administrations.json --limit 10000 \
        && elasticdump --input "$ELASTIC_SERVER/indicepa_pec" --output indicepa_pec.json --limit 10000 \
        && elasticdump --input "$ELASTIC_SERVER/publiccodes" --output publiccodes.json --limit 10000

COPY elasticsearch.yml /usr/share/elasticsearch/config/
COPY entrypoint.sh /usr/local/bin/

ENTRYPOINT ["entrypoint.sh"]
