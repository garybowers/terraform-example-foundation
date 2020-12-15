title 'Ensure that there are seperate centralised log sinks for each category of data (audit, log)'

gcp_project_id = input('gcp_project_id')
gcp_project_region = input('gcp_project_region')
control_id = 'LM1'
control_abbrev = 'logging'

control "cap-gcp-#{control_id}-#{control_abbrev}" do
  impact 1.0
  title "[#{control_abbrev.upcase}] - Ensure that there are seperate centralised log sinks for each category of data (audit, log)"

  tag "control_ids": ["LM1", "UA7"]

  google_logging_project_sinks(project: gcp_project_id, region: gcp_project_region) do |sink|
    describe "[#{gcp_project_id}] Sink [#{sink}]" do
      its('name') { should match /.*-(audit|log)-(bigquery|pubsub|bucket)/ }

      only_if its('name') { should match /.*-audit-(bigquery|pubsub|bucket)/ } do
        its('filter') { should eq "protoPayload.\"@type\"=\"type.googleapis.com/google.cloud.audit.AuditLog\"" }
      end

      only_if its('name') { should match /.*-log-(bigquery|pubsub|bucket)/ } do
        its('filter') { should eq "NOT protoPayload.\"@type\"=\"type.googleapis.com/google.cloud.audit.AuditLog\"" }
      end
    end
  end
end
