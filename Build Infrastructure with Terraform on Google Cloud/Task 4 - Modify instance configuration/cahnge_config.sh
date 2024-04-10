cd modules/instances/

cat > instances.tf <<EOF
resource "google_compute_instance" "tf-instance-1" {
  # Configuration for instance 1 (updated)
}

resource "google_compute_instance" "tf-instance-2" {
  # Configuration for instance 2 (updated)
}
EOF

cd ~
terraform init
terraform apply --auto-approve
