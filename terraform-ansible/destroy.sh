echo "terraform destoy"
tmp_value="allowed_source_ranges=[$IP_RANGE_ALLOW_SSH]"
terraform destroy -auto-approve -var project_id=${PROJECT_ID} -var region=${REGION} -var zone=${ZONE} -var $tmp_value

echo "deleting distributed credentials"
rm -f terraform/apiadmin.*
rm -f ansible/apiadmin.*

echo "delete GCP service account"
gcloud iam service-accounts delete \
  apiadmin@${PROJECT_ID}.iam.gserviceaccount.com