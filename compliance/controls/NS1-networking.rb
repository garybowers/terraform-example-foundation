title 'Ensure GCLBs are associated with at least one cloud Armor security policy'
gcp_project_id = input('gcp_project_id')
gcp_project_region = input('gcp_project_region')
control_id = 'NS1'
control_abbrev = 'networking'


 
control "cap-gcp-#{control_id}-#{control_abbrev}" do
  impact 1.0

  tag "control_ids": ["NS1"]

  title "[#{control_abbrev.upcase}] - Ensure GCLBs are associated with at least one cloud Armor security policy"
  be_names = google_compute_backend_services(project: gcp_project_id).names

  if be_names.empty?
    describe "[#{gcp_project_id}] does not have any load balancers. This test is Not Applicable." do
      skip "[#{gcp_project_id}] does not have any load balancers."
    end
  else
    google_compute_backend_services(project: gcp_project_id).names.each do |name|
      describe google_compute_backend_service(project: gcp_project_id, name: name) do
        its('security_policy') { should_not eq nil }
      end
    end
  end
end

