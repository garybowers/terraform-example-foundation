title 'Ensure google private access is enabled for every subnet in VPC Network'

gcp_project_id = input('gcp_project_id')
gcp_project_region = input('gcp_project_region')
control_id = '3.51'
control_abbrev = 'networking'

control "cap-gcp-#{control_id}-#{control_abbrev}" do
  impact 1.0
  title "[#{control_abbrev.upcase}] - Ensure google private access is enabled for every subnet in VPC Network"

  tag "control_ids": ["NS20"]

  google_compute_subnetworks(project: gcp_project_id, region: gcp_project_region).subnetwork_names.each do |subnetwork|
    describe "[#{gcp_project_id}] Subnetwork [#{subnetwork}]" do
      subject { google_compute_subnetwork(project: gcp_project_id, region: gcp_project_region, name: subnetwork) }
      its('private_ip_google_access') { should cmp true }
    end
  end
end