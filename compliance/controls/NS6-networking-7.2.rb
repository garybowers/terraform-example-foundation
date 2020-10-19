title "Ensure the cluster monitoring is enabled"

gcp_project_id = input('gcp_project_id')
gcp_project_region = input('gcp_project_region')
control_id = "7.2"
control_abbrev = "gke"

control "cap-gcp-#{control_id}-#{control_abbrev}" do
  impact 1.0
  title "[#{control_abbrev.upcase}] - Ensure the cluster monitoring is enabled"

  tag "control_ids": ["NS6"]
  
  google_container_clusters(project: gcp_project_id, location: gcp_project_region).cluster_names.each do |name|
    describe google_container_cluster(project: gcp_project_id, location: gcp_project_region, name: name) do
      its("monitoring_service") { should cmp "monitoring.googleapis.com/kubernetes" }
    end
  end
end
