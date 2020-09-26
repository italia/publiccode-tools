#!/bin/bash

echo "************************************************"
echo "* This image is only for development purposes. *"
echo "* Don't use it in production                   *"
echo "************************************************"

populate_elasticsearch() {
    TIMEOUT=60

    echo Populating elasticsearch with development data...
    count=0
    while true; do
        RES=$(curl -sLf -m 2 -w "%{http_code}\n" "http://localhost:9200/" -o /dev/null)
        if [ "$RES" -ne "000" ]; then
            break
        fi

        count=$((count + 1))
        if [ $count -gt $TIMEOUT ]; then
            echo "Can't connect to Elasticsearch after $TIMEOUT seconds"
            exit 0
        fi
        sleep 1
    done


    elasticdump --input administrations.json --output "http://localhost:9200/administrations" --limit -1
    elasticdump --input indicepa_pec.json    --output "http://localhost:9200/indicepa_pec" --limit -1
    elasticdump --input publiccodes.json     --output "http://localhost:9200/publiccodes"  --limit -1
}

populate_elasticsearch &

/usr/local/bin/docker-entrypoint.sh

exec $@
