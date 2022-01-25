#Commands used in this Hello World Skaffold Demo

# Initially tested few commands manually before doing with skaffold to have the right image and working code

gcloud beta container --project "veerahemannthnag" clusters create "cluster" --zone "asia-south1-a" --no-enable-basic-auth --cluster-version "1.21.5-gke.1302" --release-channel "regular" --machine-type "e2-small" --image-type "COS_CONTAINERD" --disk-type "pd-standard" --disk-size "100" --metadata disable-legacy-endpoints=true --scopes "https://www.googleapis.com/auth/cloud-platform" --max-pods-per-node "110" --num-nodes "1" --logging=SYSTEM,WORKLOAD --monitoring=SYSTEM --enable-ip-alias --network "projects/veerahemannthnag/global/networks/default" --subnetwork "projects/veerahemannthnag/regions/asia-south1/subnetworks/default" --no-enable-intra-node-visibility --default-max-pods-per-node "110" --no-enable-master-authorized-networks --addons HorizontalPodAutoscaling,HttpLoadBalancing,GcePersistentDiskCsiDriver --enable-autoupgrade --enable-autorepair --max-surge-upgrade 1 --max-unavailable-upgrade 0 --enable-shielded-nodes --node-locations "asia-south1-a"

skaffold config set default-repo gcr.io/veerahemannthnag/helloworld

cd skaffold-demo

docker build -t helloworldimage:latest .

docker tag helloworldimage gcr.io/veerahemannthnag/helloworld
#docker tag helloworldimage gcr.io/<[gcp_project_name]>/helloworld

docker push gcr.io/veerahemannthnag/helloworld

kubectl apply -f ./k8s-deployment.yaml -f ./k8s-service.yaml

kubectl get pods
#
# NAME                           READY   STATUS    RESTARTS   AGE
# hello-world-5886b79bd6-ftvtj   1/1     Running   0

kubectl get svc
#
# NAME          TYPE           CLUSTER-IP    EXTERNAL-IP     PORT(S)          AGE
# hello-world   LoadBalancer   10.72.6.150   34.93.205.142   8080:30074/TCP   104s
# kubernetes    ClusterIP      10.72.0.1     <none>          443/TCP          18m

curl 34.93.205.142:8080
curl <E-IP:port>
# Hello world - Test Page 1


#-------------------#
# Change index.html and do skaffold dev or skaffold run
skaffold dev 
#skaffold run

curl 34.93.205.142:8080
# Hello world - Test Page 1+1 =2

#Below is the output for "skaffold dev" command

C:\Users\heman\skaffold-demo>skaffold dev
Listing files to watch...
 - gcr.io/veerahemannthnag/helloworld
Generating tags...
 - gcr.io/veerahemannthnag/helloworld -> gcr.io/veerahemannthnag/helloworld:latest
Some taggers failed. Rerun with -vdebug for errors.
Checking cache...
 - gcr.io/veerahemannthnag/helloworld: Not found. Building
Starting build...
Building [gcr.io/veerahemannthnag/helloworld]...
Sending build context to Docker daemon  3.072kB
Step 1/3 : FROM nginx
 ---> 605c77e624dd
Step 2/3 : COPY index.html /usr/share/nginx/html/
 ---> 5968155fd79a
Step 3/3 : WORKDIR /usr/share/nginx/html
 ---> Running in eb176c36faee
 ---> da6890a16e66
Successfully built da6890a16e66
Successfully tagged gcr.io/veerahemannthnag/helloworld:latest
The push refers to repository [gcr.io/veerahemannthnag/helloworld]
2e2cbbc4f752: Preparing
d874fd2bc83b: Preparing
32ce5f6a5106: Preparing
f1db227348d0: Preparing
b8d6e692a25e: Preparing
e379e8aedd4d: Preparing
2edcec3590a4: Preparing
e379e8aedd4d: Waiting
2edcec3590a4: Waiting
b8d6e692a25e: Layer already exists
f1db227348d0: Layer already exists
d874fd2bc83b: Layer already exists
32ce5f6a5106: Layer already exists
2edcec3590a4: Layer already exists
e379e8aedd4d: Layer already exists
2e2cbbc4f752: Pushed
latest: digest: sha256:b76e39d762a83a50e8cd5d38ccf636013be9595327a5380a149563e730f86c22 size: 1777
Tags used in deployment:
 - gcr.io/veerahemannthnag/helloworld -> gcr.io/veerahemannthnag/helloworld:latest@sha256:b76e39d762a83a50e8cd5d38ccf636013be9595327a5380a149563e730f86c22
Starting deploy...
 - deployment.apps/hello-world created
 - service/hello-world created
Waiting for deployments to stabilize...
 - deployment/hello-world: creating container hello-world
    - pod/hello-world-6f4859c487-qrsn8: creating container hello-world
 - deployment/hello-world is ready.
Deployments stabilized in 6.535 seconds
Press Ctrl+C to exit
Watching for changes...
[hello-world] /docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
[hello-world] /docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
[hello-world] /docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
[hello-world] 10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
[hello-world] 10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
[hello-world] /docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
[hello-world] /docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
[hello-world] /docker-entrypoint.sh: Configuration complete; ready for start up
[hello-world] 2022/01/25 13:18:53 [notice] 1#1: using the "epoll" event method
[hello-world] 2022/01/25 13:18:53 [notice] 1#1: nginx/1.21.5
[hello-world] 2022/01/25 13:18:53 [notice] 1#1: built by gcc 10.2.1 20210110 (Debian 10.2.1-6)
[hello-world] 2022/01/25 13:18:53 [notice] 1#1: OS: Linux 5.4.144+
[hello-world] 2022/01/25 13:18:53 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
[hello-world] 2022/01/25 13:18:53 [notice] 1#1: start worker processes
[hello-world] 2022/01/25 13:18:53 [notice] 1#1: start worker process 33
[hello-world] 2022/01/25 13:18:53 [notice] 1#1: start worker process 34
[hello-world] 10.68.0.1 - - [25/Jan/2022:13:19:39 +0000] "GET / HTTP/1.1" 200 30 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/97.0.4692.99 Safari/537.36" "-"
[hello-world] 10.68.0.1 - - [25/Jan/2022:13:19:40 +0000] "GET /favicon.ico HTTP/1.1" 404 555 "http://34.93.193.183:8080/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/97.0.4692.99 Safari/537.36" "-"
[hello-world] 2022/01/25 13:19:40 [error] 33#33: *1 open() "/usr/share/nginx/html/favicon.ico" failed (2: No such file or directory), client: 10.68.0.1, server: localhost, request: "GET /favicon.ico HTTP/1.1", host: "34.93.193.183:8080", referrer: "http://34.93.193.183:8080/"
Cleaning up...
 - deployment.apps "hello-world" deleted
 - service "hello-world" deleted

#--------------------------------------------------------------------------#

skaffold run

#Below is the output for "skaffold run" command
C:\Users\heman\skaffold-demo>skaffold run
Generating tags...
 - gcr.io/veerahemannthnag/helloworld -> gcr.io/veerahemannthnag/helloworld:latest
Some taggers failed. Rerun with -vdebug for errors.
Checking cache...
 - gcr.io/veerahemannthnag/helloworld: Found Remotely
Starting test...
Tags used in deployment:
 - gcr.io/veerahemannthnag/helloworld -> gcr.io/veerahemannthnag/helloworld:latest@sha256:b76e39d762a83a50e8cd5d38ccf636013be9595327a5380a149563e730f86c22
Starting deploy...
 - deployment.apps/hello-world created
 - service/hello-world created
Waiting for deployments to stabilize...
 - deployment/hello-world is ready.
Deployments stabilized in 3.553 seconds
You can also run [skaffold run --tail] to get the logs





#--------------------------------------------------------------------------#
skaffold delete
#Below is the output for "skaffold delete" command

Cleaning up...
 - deployment.apps "hello-world" deleted
 - service "hello-world" deleted