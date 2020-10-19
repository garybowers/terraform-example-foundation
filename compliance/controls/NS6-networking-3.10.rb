title 'Ensure the default subnetwork does not exist in a project'

gcp_project_id = input('gcp_project_id')
gcp_project_region = input('gcp_project_region')
control_id = 'NS6'
control_abbrev = 'networking'


control "gcp-cap-#{control_id}-#{control_abbrev}" do
  impact 1.0

  tag "control_ids": ["NS6"]
  
  title "[#{control_abbrev.upcase}]- Ensure logging is enabled on all firewall rules"

  google_compute_firewalls(project: gcp_project_id).firewall_names.each do |name|
    next if name.to_s.start_with? (/gke-/)
      describe google_compute_firewall(project: gcp_project_id, name: name) do
        its('log_config_enabled?') { should be true }
      end
    end 
end