title "Ensure the database instance does not have public IP address"

gcp_project_id = input('gcp_project_id')
gcp_project_region = input('gcp_project_region')
control_id = "27.52"
control_abbrev = "cloudsql"

control "cap-gcp-#{control_id}-#{control_abbrev}" do
  impact 1.0
  title "[#{control_abbrev.upcase}] - Ensure the database instance does not have public ip address"

  tag "control_ids": ["NS10"]
  
  google_sql_database_instances(project: gcp_project_id).instance_names.each do |name|
    describe google_sql_database_instance(project: gcp_project_id, database: name).settings.ip_configuration do
      its("ipv4_enabled") { should cmp "false" }
    end
  end
end
