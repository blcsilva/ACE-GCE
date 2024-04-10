cat > variables.tf <<EOF
variable "region" {
 default = "$REGION"
}

variable "zone" {
 default = "$ZONE"
}

variable "project_id" {
 default = "$PROJECT_ID"
}
EOF
