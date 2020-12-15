title 'Ensure default egress rule exists that blocks egress traffic'

gcp_project_id = input('gcp_project_id')
control_id = '3.53'
control_abbrev = 'networking'

control "cap-gcp-#{control_id}-#{control_abbrev}" do
  impact 1.0
  title "[#{control_abbrev.upcase}] - Ensure default egress rule exists that blocks egress traffic"

  tag "control_ids": ["NS19"]

  describe.one do
    google_compute_firewalls(project: gcp_project_id).where(firewall_direction: 'EGRESS').firewall_names.each do |name|
      firewall_rule = google_compute_firewall(project: gcp_project_id, name: name)

      if (!firewall_rule.denied.nil?)
        describe "[#{gcp_project_id}] Firewall Rule [#{name}]" do
          subject { firewall_rule }
          it { should allow_ip_ranges ["0.0.0.0/0"] }
        end
      else 
        describe "[#{gcp_project_id}] [#{name}] has contains no denied targets. This test is not applicable" do
          skip "[#{gcp_project_id}] [#{name}] has contains no denied targets"
        end
      end
    end
  end
end