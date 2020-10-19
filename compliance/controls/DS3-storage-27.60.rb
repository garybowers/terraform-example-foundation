title "Ensure the database instance has all mandatory label (owner, dataclassification)"

gcp_project_id = input('gcp_project_id')
gcp_project_region = input('gcp_project_region')
control_id = '27.60'
control_abbrev = 'cloudsql'

control "cap-gcp-#{control_id}-#{control_abbrev}" do
  impact 1.0
  title "[#{control_abbrev.upcase}] - All database instances must have the mandatory labels set. (owner, dataclassification)"

  tag "control_ids": ["DS3"]

  google_sql_database_instances(project: gcp_project_id).instance_names.each do |name|
    describe google_sql_database_instance(project: gcp_project_id, database: name).settings do
      its('user_labels') { should include("owner")}
      its('user_labels') { should include("dataclassification")}
    end
  end
end
