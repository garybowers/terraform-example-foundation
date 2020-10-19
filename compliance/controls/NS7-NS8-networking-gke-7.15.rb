title "Ensure the cluster is private cluster"

gcp_project_id = input('gcp_project_id')
gcp_project_region = input('gcp_project_region')
control_id = "7.15"
control_abbrev = "gke"

control "cap-gcp-#{control_id}-#{control_abbrev}" do
  impact 1.0
  title "[#{control_abbrev.upcase}] - Ensure the cluster is private cluster"

  tag "control_ids": ["NS7", "NS8"]
  
  google_container_clusters(project: gcp_project_id, location: gcp_project_region).cluster_names.each do |name|
    describe google_container_cluster(project: gcp_project_id, location: gcp_project_region, name: name).private_cluster_config do
      its("enable_private_nodes") { should cmp "true" }
    end
  end
end
