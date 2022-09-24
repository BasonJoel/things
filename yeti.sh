cd ~/
git clone https://github.com/yeti-platform/yeti
cd yeti 
cd extras/docker/dev
wget https://raw.githubusercontent.com/BasonJoel/things/main/requirements.txt 
cd ~/yeti
docker-compose -p yeti -f extras/docker/dev/docker-compose.yaml run -d -p 8080:8080 yeti /docker-entrypoint.sh uwsgi-http > dockertmp.txt
docker cp extras/docker/dev/requirements.txt  $(cat dockertmp.txt):/opt/yeti/requirements.txt
docker restart $(cat dockertmp.txt)
docker exec $(cat dockertmp.txt) /bin/sh -c "cp yeti.conf yeti.conf.sample && pip3 install -r requirements.txt && yarn install && mv yeti.conf.sample yeti.conf && sed -i '35s/# host = 127.0.0.1/host = mongodb/' yeti.conf && sed -i '49s/# host = 127.0.0.1/host = redis/' yeti.conf"
echo yeti started on http://localhost:8080
