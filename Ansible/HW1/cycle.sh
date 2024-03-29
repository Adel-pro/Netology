# Launch containers
gnome-terminal -x sh -c "docker run --name centos7 -it centos:7 bash; bash"
gnome-terminal -x sh -c "docker run --name ubuntu -it ubuntu bash; bash"
gnome-terminal -x sh -c "docker run --name fedora -it pycontribs/fedora bash; bash"

# Launch ansible-playbook
ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass --ask-pass

# Stop containers
docker stop $(docker ps -aq)