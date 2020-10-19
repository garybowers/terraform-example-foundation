title 'Ensure cloud armor security policies are enabled'
gcp_project_id = input('gcp_project_id')
gcp_project_region = input('gcp_project_region')
control_id = 'NS3-NS4'
control_abbrev = 'networking'


 
control "cap-gcp-#{control_id}-#{control_abbrev}" do
  impact 1.0

  tag "control_ids": ["NS3", "NS4"]

  title "[#{control_abbrev.upcase}] - Ensure cloud armor security policies are enabled"
  
  lb_names = google_compute_target_https_proxies(project: gcp_project_id).names

  if lb_names.empty?
    describe "[#{gcp_project_id}] does not have any load balancers. This test is Not Applicable." do
      skip "[#{gcp_project_id}] does not have any load balancers."
    end
  else
    describe google_compute_security_policies(project: gcp_project_id) do
      its('count') { should be >= 1 }
    end

    google_compute_security_policies(project: gcp_project_id).names.each do |security_policy|
      describe google_compute_security_policy(project: gcp_project_id, name: security_policy) do
        its('rules.size') { should be >= 1 }
      end  
    end
  end
end