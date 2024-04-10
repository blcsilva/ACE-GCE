cd ../storage/

cat > storage.tf <<EOF
resource "google_storage_bucket" "storage-bucket" {
  # Configuration for storage bucket
}
EOF
