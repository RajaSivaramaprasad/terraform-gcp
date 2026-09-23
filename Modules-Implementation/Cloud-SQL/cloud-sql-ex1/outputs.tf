output "instance_connection_name" {
  value       = google_sql_database_instance.primary.connection_name
  description = "Primary instance connection name"
}

output "public_ip" {
  value = try(
    (tolist([
      for ip in google_sql_database_instance.primary.ip_address : ip.ip_address
      if ip.type == "PRIMARY"
    ]))[0],
    null
  )
  description = "Primary instance public IPv4"
}

output "database_name" {
  value       = google_sql_database.db.name
  description = "Created database name"
}

output "db_user" {
  value       = google_sql_user.db_user.name
  sensitive   = true
  description = "DB user (sensitive)"
}

output "db_password" {
  value       = coalesce(try(google_sql_user.db_user.password, null), try(random_password.db_user_password.result, null))
  sensitive   = true
  description = "DB password (sensitive)"
}
