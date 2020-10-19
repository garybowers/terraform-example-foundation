title "Ensure no service account should be using primitive roles of owner or editor."

gcp_project_id = input('gcp_project_id')
gcp_project_region = input('gcp_project_region')
control_id = "UA21"
control_abbrev = "serviceAccount"

iam_bindings_cache = IAMBindingsCache(project: gcp_project_id)

control "cap-gcp-#{control_id}-#{control_abbrev}" do
  impact 1.0
  title "[#{control_abbrev.upcase}] Ensure that ServiceAccount has no Admin privileges."

  tag "control_ids": ["IM1"]
 
  iam_bindings_cache.iam_bindings.keys.grep(%r{roles/editor}).each do |role|
    google_managed_service_accounts = []
    other_service_accounts = []
    iam_bindings_cache.iam_bindings[role].members.each do |member|
      if member.to_s.start_with? (/serviceAccount:service-[0-9]{12}/)
        google_managed_service_accounts.push(member)
      else
        other_service_accounts.push(member)
      end
    end
    describe "[#{gcp_project_id}] Project Editor Role should not be assigned to Service Accounts" do
    subject { other_service_accounts }
      it { should_not include(/gserviceaccount.com/) }
    end
  end


  iam_bindings_cache.iam_bindings.keys.grep(%r{roles/owner}).each do |role|
    google_managed_service_accounts = []
    other_service_accounts = []
    iam_bindings_cache.iam_bindings[role].members.each do |member|
      if member.to_s.start_with? (/serviceAccount:service-[0-9]{12}/)
        google_managed_service_accounts.push(member)
      else
        other_service_accounts.push(member)
      end
    end
    describe "[#{gcp_project_id}] Project Owner Role should not be assigned to Service Accounts" do
    subject { other_service_accounts }
      it { should_not include(/gserviceaccount.com/) }
    end
  end
end
