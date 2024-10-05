import os

def StartVPN():
    os.system("terraform -chdir=./terraform/ init")
    os.system('source ./terraform/yandex_prov.sh')
    os.system('terraform -chdir=./terraform/ apply -auto-approve')

def StopVPN():
    os.system('source ./terraform/yandex_prov.sh')
    os.system('terraform -chdir=./terraform/ destroy -auto-approve')

