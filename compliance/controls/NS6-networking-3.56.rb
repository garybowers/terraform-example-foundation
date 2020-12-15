title 'Cloud Nats must have logging enabled'

gcp_project_id = input('gcp_project_id')
gcp_project_region = input('gcp_project_region')
control_id = '3.56'
control_abbrev = 'networking'

control "cap-gcp-#{control_id}-#{control_abbrev}" do
  impact 1.0
  title "[#{control_abbrev.upcase}] - Cloud Nats must have logging enabled"

  tag "control_ids": ["NS6"]

  google_compute_routers(project: gcp_project_id, region: gcp_project_region).names.each do |router_name|
    google_compute_router_nats(project: gcp_project_id, region: gcp_project_region, router: router_name).names.each do |nat_name|
      describe "[#{gcp_project_id}] Cloud NAT [#{nat_name}]" do
        subject { google_compute_router_nat(project: gcp_project_id, region: gcp_project_region, router: router_name, name: nat_name) }
        its('log_config.enable') { should cmp true }
      end
    end
  end
end