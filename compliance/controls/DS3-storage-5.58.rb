
title 'All buckets must have the mandatory labels set. (owner, cost_centre, dataclassification)'

gcp_project_id = input('gcp_project_id')
gcp_project_region = input('gcp_project_region')
control_id = '5.58'
control_abbrev = 'storage'

control "cap-gcp-#{control_id}-#{control_abbrev}" do
  impact 1.0
  title "[#{control_abbrev.upcase}] - All buckets must have the mandatory labels set. (owner, cost_centre, dataclassification)"

  tag "control_ids": ["DS3"]

  google_storage_buckets(project: gcp_project_id).bucket_names.each do |bucket_name|
    describe google_storage_bucket(name: bucket_name) do
      its('labels') { should include("owner")}
      its('labels') { should include("cost_centre")}
      its('labels') { should include("dataclassification")}
    end
  end
end