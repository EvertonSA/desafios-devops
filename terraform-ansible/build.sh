# export PROJECT_ID='sandbox-216902'
# export REGION='us-central1'
# export IP_RANGE_ALLOW_SSH='["0.0.0.0/0"]'

echo "install ansible"
sudo apt install ansible

echo "create (bad) GCP Service Account"
# create GCP SA 
gcloud iam service-accounts create apiadmin \
--display-name=apiadmin \
--project=${PROJECT_ID}

gcloud iam service-accounts keys create ./apiadmin.json \
--iam-account=apiadmin@${PROJECT_ID}.iam.gserviceaccount.com \
--project=${PROJECT_ID}

# need deeper granularity here... 
gcloud projects add-iam-policy-binding ${PROJECT_ID} \
--member=serviceAccount:apiadmin@${PROJECT_ID}.iam.gserviceaccount.com \
--role=roles/editor

echo "create apiadmin pubblickey/privatekey"
ssh-keygen -t rsa -C "apiadmin" -q -N "" -f apiadmin.pem

echo "distribute credentials to correct folders"
cp apiadmin.json apiadmin.pem.pub terraform
cp apiadmin.pem ansible

echo "terraform magic start"
cd terraform
terraform init
tmp_value="allowed_source_ranges=[$IP_RANGE_ALLOW_SSH]"
terraform apply -auto-approve -var project_id=${PROJECT_ID} -var region=${REGION} -var zone=${ZONE} -var $tmp_value
HOST_IP=$(terraform output ip)
cd ..
echo "terraform magic finish"

echo "feeding ansible config with terraform output"
# This should be done only on the inventory files, 
# but i did not want to invest to much time in adding this new gathered ip in a dns so, two seds are needed...
sed -i "s/HOST_IP/${HOST_IP}/g" ansible/playbook.yaml
sed -i "s/HOST_IP/${HOST_IP}/g" ansible/inventory/idwall.txt

echo "ansible magic start"
cd ansible 
ansible-playbook playbook.yaml
cd ../
echo "ansible magic finish"

echo "deleting distributed credentials"
rm -f terraform/apiadmin.*
rm -f ansible/apiadmin.*

echo "access http://${HOST_IP}"