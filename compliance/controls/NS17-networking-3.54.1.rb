title 'Ensure that No INGRESS firewall rules allow 0.0.0.0/0 from any sources'

gcp_project_id = input('gcp_project_id')
control_id = '3.54.1'
control_abbrev = 'networking'

control "cap-gcp-#{control_id}-#{control_abbrev}" do
  impact 1.0
  title "[#{control_abbrev.upcase}] - Ensure that No INGRESS firewall rules allow 0.0.0.0/0 from any sources"

  tag "control_ids": ["NS17"]

  google_compute_firewalls(project: gcp_project_id).where(firewall_direction: 'INGRESS').firewall_names.each do |name|
    firewall_rule = google_compute_firewall(project: gcp_project_id, name: name)

    if (!firewall_rule.allowed.nil?)
      describe "[#{gcp_project_id}] Firewall Rule [#{name}]" do
        subject { firewall_rule }
        it { should_not allow_ip_ranges ["0.0.0.0/0"] }
      end
    else 
      describe "[#{gcp_project_id}] [#{name}] has contains no allowed targets. This test is not applicable" do
        skip "[#{gcp_project_id}] [#{name}] has contains no allowed targets"
      end
    end
  end
end