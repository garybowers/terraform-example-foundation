title 'Domain Restricted Sharing should be enabled'

gcp_org_id = input('gcp_org_id')
gcp_project_id = input('gcp_project_id')
gcp_project_region = input('gcp_project_region')

control_id = 'DS13'
control_abbrev = 'org-policy'

control "cap-gcp-#{control_id}-#{control_abbrev}" do
  impact 1.0
  title "[#{control_abbrev.upcase}] - Ensure that BigQuery datasets are not anonymously or publicly accessible"
		
	describe google_organization_policy(name: "organizations/#{gcp_org_id}", constraint: 'constraints/iam.allowedPolicyMemberDomains') do
		it { should exist }
	end
end