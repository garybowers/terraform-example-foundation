title "Ensure compute instances do not have public IP addresses"

gcp_project_id = input('gcp_project_id')
gce_zones = input('gce_zones')
control_id = '4.9'
control_abbrev = 'vms'

gce_instances = GCECache(project: gcp_project_id, gce_zones: gce_zones).gce_instances_cache

control "cis-gcp-#{control_id}-#{control_abbrev}" do
  impact 'medium'

  title "[#{control_abbrev.upcase}] Ensure compute instances do not have public IP addresses"

  # Required tags to be added here
  tag "control_ids": []
  
  gce_instances.each do |instance|
    google_compute_instance(project: gcp_project_id, zone: instance[:zone], name: instance[:name]).network_interfaces.each do |network_interface|
      describe "[#{gcp_project_id}] Instance #{instance[:zone]}/#{instance[:name]}" do
        subject { network_interface.access_configs }
        it { should cmp nil }
      end
    end
  end
end