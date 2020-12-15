title 'Ensure VM disks for critical VMs are encrypted with CustomerManaged Encryption Keys (CMEK)'

gcp_project_id = input('gcp_project_id')
gce_zones = input('gce_zones')
control_id = '4.07'
control_abbrev = 'vms'

gce_instances = GCECache(project: gcp_project_id, gce_zones: gce_zones).gce_instances_cache

control "cis-gcp-#{control_id}-#{control_abbrev}" do
  impact 'medium'

  title "[#{control_abbrev.upcase}] Ensure VM disks for critical VMs are encrypted with CustomerManaged Encryption Keys (CMEK)"

  gce_instances.each do |instance|
    google_compute_instance(project: gcp_project_id, zone: instance[:zone], name: instance[:name]).disks.each do |disk|
      describe "[#{gcp_project_id}] Instance #{instance[:zone]}/#{instance[:name]}" do
        subject { disk.disk_encryption_key }
        it { should_not cmp nil  }
      end
    end
  end
end
