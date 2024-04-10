instances_output=$(gcloud compute instances list --format="value(id)")

# Read instance IDs into variables
IFS=$'\n' read -r -d '' instance_id_1 instance_id_2 <<< "$instances_output"

# Output instance IDs with custom name
export INSTANCE_ID_1=$instance_id_1
export INSTANCE_ID_2=$instance_id_2
