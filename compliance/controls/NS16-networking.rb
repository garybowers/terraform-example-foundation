title 'Cloud NATs should not exist unless in an approved vpc networks'
gcp_project_id = input('gcp_project_id')
gcp_project_region = input('gcp_project_region')
control_id = 'NS16'
control_abbrev = 'networking'

control "cap-gcp-#{control_id}-#{control_abbrev}" do
  impact 1.0
  tag "control_ids": ["NS16"]
  title "[#{control_abbrev.upcase}] - Cloud NATs should not exist unless in an approved vpc networks"



  google_compute_routers(project: gcp_project_id, region: gcp_project_region).names.each do |router_name|      
    google_compute_router_nats(project: gcp_project_id, region: gcp_project_region, router: router_name).names.each do |nat_name|   
      describe google_compute_router_nat( project: gcp_project_id ,region: gcp_project_region, router: router_name, name: nat_name) do
        its('source_subnetwork_ip_ranges_to_nat') { should cmp 'LIST_OF_SUBNETWORKS' }
      end
      describe google_project(project: gcp_project_id) do
        its('project_id') {should match /mgmt/}
      end
    end
  end
 end
