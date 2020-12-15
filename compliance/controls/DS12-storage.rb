title 'Ensure GCS buckets are private and not publicly exposed'
gcp_project_id = input('gcp_project_id')
gcp_project_region = input('gcp_project_region')
control_id = 'DS12'
control_abbrev = 'storage'



control "cap-gcp-#{control_id}-#{control_abbrev}" do
  impact 1.0

  tag "control_ids": ["DS10"]

  title "[#{control_abbrev.upcase}] - Ensure GCS buckets are private and not publicly exposed"
  google_storage_buckets(project: gcp_project_id).bucket_names.each do |bucket_name|
    google_storage_bucket_iam_bindings(bucket: bucket_name).iam_binding_roles.each do |iam_binding_role|
        describe google_storage_bucket_iam_binding(bucket: bucket_name,  role: iam_binding_role) do
            its('members') {should_not eq ["allUsers"] }
            its('members') {should_not eq ["allAuthenticatedUsers"] }
        end
    end
  end
end
