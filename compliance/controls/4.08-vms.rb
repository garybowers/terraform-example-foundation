title "Ensure compute instances are launched with shielded VM enabled"

gcp_project_id = input('gcp_project_id')
gcp_project_region = input('gcp_project_region')
gce_zones = input('gce_zones')
control_id = '4.8'
control_abbrev = 'vms'

gce_instances = GCECache(project: gcp_project_id, gce_zones: gce_zones).gce_instances_cache

control "cis-gcp-#{control_id}-#{control_abbrev}" do
  impact 'medium'

  title "[#{control_abbrev.upcase}] Ensure compute instances are launched with shielded VM enabled"
  
  # Required tags to be added here
  tag "control_ids": []

  gce_instances.each do |instance|
    describe "[#{gcp_project_id}] Instance #{instance[:zone]}/#{instance[:name]}" do
      subject { google_compute_instance(project: gcp_project_id, zone: instance[:zone], name: instance[:name]).shielded_instance_config.enable_secure_boot }
      it { should be true }
    end
  end
end