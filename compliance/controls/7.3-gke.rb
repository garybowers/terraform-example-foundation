title "Ensure the cluster's legacy authorization is disabled"

gcp_project_id = input('gcp_project_id')
gcp_project_region = input('gcp_project_region')
control_id = "7.3"
control_abbrev = "gke"

control "cap-gcp-#{control_id}-#{control_abbrev}" do
  impact 1.0
  title "[#{control_abbrev.upcase}] - Ensure the cluster's legacy authorization is disabled"

  tag "control_ids": ['CC1']
  
  google_container_clusters(project: gcp_project_id, location: gcp_project_region).cluster_names.each do |name|
    describe google_container_cluster(project: gcp_project_id, location: gcp_project_region, name: name).legacy_abac do
      its("enabled") { should_not cmp "true" }
    end
  end
end