title 'GCS buckets storing log data must be protected from unauthorised access and the integrity of the logs must be assured.'

input('retention_period', value: 7.776e+6) # 90 day retention

gcp_project_id = input('gcp_project_id')
gcp_project_region = input('gcp_project_region')
control_id = '5.59'
control_abbrev = 'storage'

control "cap-gcp-#{control_id}-#{control_abbrev}" do
  impact 1.0
  title "[#{control_abbrev.upcase}] - GCS buckets storing log data must be protected from unauthorised access and the integrity of the logs must be assured."

  tag "control_ids": ["DS3", "LM13"] 

  google_storage_buckets(project: gcp_project_id).bucket_names.each do |bucket_name|
    bucket = google_storage_bucket(project: gcp_project_id, name: bucket_name)
   
    if bucket.labels.nil?
      describe "[#{gcp_project_id}] GCS Bucket [#{bucket_name}]" do
      subject { bucket }      
        its("labels") { should_not cmp nil }      
      end
    else
      if (bucket.labels[:dataclassification].eql? "highlyconfidential") 
        describe "[#{gcp_project_id}] GCS Bucket [#{bucket_name}]" do
          subject { bucket }
          its(logging) { should_not be nil }
          its('retention_policy.retention_period') { should cmp input('retention_period') }
        end
      else 
        describe "[#{gcp_project_id}] [#{bucket_name}] does not contain logs. This test is not applicable" do
          skip "[#{gcp_project_id}] [#{bucket_name}] does not contain logs"
        end
      end
    end
  end
end


