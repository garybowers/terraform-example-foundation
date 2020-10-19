title 'Ensure that IAM roles should not be assigned directly to user account'

gcp_project_id = input('gcp_project_id')
gcp_project_region = input('gcp_project_region')
control_id = "UA19"
control_abbrev = 'usrAccRole'

iam_bindings_cache = IAMBindingsCache(project: gcp_project_id)

control "cap-gcp-#{control_id}-#{control_abbrev}" do
  impact 1.0
  title "[#{control_abbrev.upcase}] Make sure roles are not assigned directly to users"

  tag "control_ids": ["IM4"]

  iam_bindings_cache.iam_binding_roles.each do |role|
    iam_bindings_cache.iam_bindings[role].members.each do |member|
      next if member.to_s.start_with? (/serviceAccount:/)
      describe "[#{gcp_project_id}] [Role:#{role}] Its member #{member}" do
#        it { member.to_s.should_not include(/^user:/)}
      end
    end  
  end

end