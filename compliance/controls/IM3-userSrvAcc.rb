title 'Restrict service account role grants to only service accounts'

gcp_project_id = input('gcp_project_id')
gcp_project_region = input('gcp_project_region')
control_id = "UA4"
control_abbrev = 'usrSrvAcc'

iam_bindings_cache = IAMBindingsCache(project: gcp_project_id)

control "cap-gcp-#{control_id}-#{control_abbrev}" do
  impact 1.0
  title "[#{control_abbrev.upcase}] Restrict service account role grants to only service accounts"

  tag "control_ids": ["IM3"]

  sa_users = iam_bindings_cache.iam_bindings['roles/iam.serviceAccountUser']
  if sa_users.nil? || sa_users.members.count.zero?
    impact 'none'
    describe "[#{gcp_project_id}] does not contain users with roles/serviceAccountUser." do
      skip "[#{gcp_project_id}] does not contain users with roles/serviceAccountUser"
    end
  else
    describe "[#{gcp_project_id}] roles/serviceAccountUser" do
      subject { iam_bindings_cache.iam_bindings['roles/iam.serviceAccountUser'] }
      sa_users.members.each do |sa_user|
        its('members') { should_not include(/user:/) }
      end
    end
  end
end