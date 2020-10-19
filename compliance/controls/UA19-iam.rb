title 'Ensure that user accounts do not have roles mapped to them directly'
gcp_project_id = input('gcp_project_id')
gcp_project_region = input('gcp_project_region')
control_id = 'UA19'
control_abbrev = 'iam'


iam_bindings_cache = IAMBindingsCache(project: gcp_project_id)

control "cap-gcp-#{control_id}-#{control_abbrev}" do
  impact 1.0
  title "[#{control_abbrev.upcase}] - Ensure that user accounts do not have roles mapped to them directly"

  tag "control_ids": ["UA11", "UA18", "UA19"]
  
  google_project_iam_policy(project: gcp_project_id).bindings.each do |binding|
    describe binding do
      its('members') { should_not include(/^user:/)}
    end
  end
end
