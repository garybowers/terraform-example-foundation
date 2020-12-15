title 'Ensure a retention policy that specifies a retention period on bucket'
gcp_project_id = input('gcp_project_id')
gcp_project_region = input('gcp_project_region')
control_id = 'DS10'
control_abbrev = 'storage'




control "cap-gcp-#{control_id}-#{control_abbrev}" do
  impact 1.0
  title "[#{control_abbrev.upcase}] - Ensure a retention policy that specifies a retention period on bucket"

  tag "control_ids": ["DS10"]

  google_storage_buckets(project: gcp_project_id).bucket_names.each do |bucket_name|
    describe google_storage_bucket(name: bucket_name) do
        its('retention_policy.retention_period') { should_not eq nil }
    end
  end
end
