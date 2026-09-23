

# Output
output "vm_name" {
  value = google_compute_instance.tf_gce_vm.name
}

output "bucket_name" {
  value = google_storage_bucket.tf_bucket.name
}