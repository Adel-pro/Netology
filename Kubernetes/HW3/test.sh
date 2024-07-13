export loop=0 
until [ $loop -eq 1 ]
do kubectl get service | grep net-busybox-svc 
if [[ $? -eq 0 ]] 
then loop=1 && echo Good
fi 
sleep 2 
done