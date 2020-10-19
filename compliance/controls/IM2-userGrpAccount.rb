title "Ensure no user or group should be using primitive roles of owner or editor."

gcp_project_id = input('gcp_project_id')
gcp_project_region = input('gcp_project_region')
control_id = "UA20"
control_abbrev = "usGrpAccount"

iam_bindings_cache = IAMBindingsCache(project: gcp_project_id)

control "cap-gcp-#{control_id}-#{control_abbrev}" do
  impact 1.0
  title "[#{control_abbrev.upcase}] Ensure that user or group has no primitive role."
  
  tag "control_ids": ["IM2"]

  iam_bindings_cache.iam_bindings.keys.grep(%r{roles/editor}).each do |role|
    describe "[#{gcp_project_id}] Project Editor Role should not be assigned to users" do
      subject { iam_bindings_cache.iam_bindings[role] }
      its('members') { should_not include(/user:/) }
    end
  end

  iam_bindings_cache.iam_bindings.keys.grep(%r{roles/owner}).each do |role|
    describe "[#{gcp_project_id}] Project Owner Role should not be assigned to users" do
      subject { iam_bindings_cache.iam_bindings[role] }
      its('members') { should_not include(/user:/) }
    end
  end

  iam_bindings_cache.iam_bindings.keys.grep(%r{roles/editor}).each do |role|
    describe "[#{gcp_project_id}] Project Editor Role should not be assigned to groups" do
      subject { iam_bindings_cache.iam_bindings[role] }
      its('members') { should_not include(/googlegroups.com/) }
    end
  end

  iam_bindings_cache.iam_bindings.keys.grep(%r{roles/owner}).each do |role|
    describe "[#{gcp_project_id}] Project Owner Role should not be assigned to groups" do
      subject { iam_bindings_cache.iam_bindings[role] }
      its('members') { should_not include(/googlegroups.com/) }
    end
  end
 
end