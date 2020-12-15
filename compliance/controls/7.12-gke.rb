title "Ensure the cluster client certificate is Enabled"

gcp_project_id = input('gcp_project_id')
gcp_project_region = input('gcp_project_region')
control_id = "7.12"
control_abbrev = "gke"

control "cap-gcp-#{control_id}-#{control_abbrev}" do
  impact 1.0
  title "[#{control_abbrev.upcase}] - Ensure the cluster client certificate is enabled"

  tag "control_ids": ['CC1']
  
  google_container_clusters(project: gcp_project_id, location: gcp_project_region).cluster_names.each do |name|
    describe google_container_cluster(project: gcp_project_id, location: gcp_project_region, name: name).master_auth do
      its("client_certificate") { should_not cmp nil }
    end
  end
end