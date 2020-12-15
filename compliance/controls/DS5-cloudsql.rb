title "Ensure the database instance has backups enabled."

gcp_project_id = input('gcp_project_id')
gcp_project_region = input('gcp_project_region')
control_id = 'DS5'
control_abbrev = 'cloudsql'

control "cap-gcp-#{control_id}-#{control_abbrev}" do
  impact 1.0
  title "[#{control_abbrev.upcase}] - All database instances must have backups enabled."

  tag "control_ids": ["DS5"]

  google_sql_database_instances(project: gcp_project_id).instance_names.each do |name|
    describe google_sql_database_instance(project: gcp_project_id, database: name).settings do
      its('backup_configuration.enabled') { should cmp "true" }
    end
  end
end