cd modules/instances/

cat > instances.tf <<EOF
resource "google_compute_instance" "tf-instance-1" {
  # Configuration for instance 1
}

resource "google_compute_instance" "tf-instance-2" {
  # Configuration for instance 2
}
EOF
