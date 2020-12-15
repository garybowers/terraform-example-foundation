
title 'Highly confidential data must have CMEK with HSM Protection'

gcp_project_id = input('gcp_project_id')
gcp_project_region = input('gcp_project_region')
control_id = '5.52'
control_abbrev = 'storage'

control "cap-gcp-#{control_id}-#{control_abbrev}" do
  impact 1.0
  title "[#{control_abbrev.upcase}] - Highly confidential buckets must have CMEK with HSM Protection"

  tag "control_ids": ["DE1", "DS5", "DS3", "DP2"]

  google_storage_buckets(project: gcp_project_id).bucket_names.each do |bucket_name|
    bucket = google_storage_bucket(name: bucket_name)
    if bucket.labels.nil?
      describe "[#{gcp_project_id}] GCS Bucket [#{bucket_name}]" do
      subject { bucket }      
        its("labels") { should_not cmp nil }      
      end
    else
      if (bucket.labels['dataclassification'].eql? "highlyconfidential") 
        describe "[#{gcp_project_id}] GCS Bucket [#{bucket_name}]" do
          subject { bucket }
          its('encryption.default_kms_key_name') { should_not be nil }
        end
      else 
        describe "[#{gcp_project_id}] [#{bucket_name}] is not a highlyconfidential bucket. This test is not applicable" do
          skip "[#{gcp_project_id}] [#{bucket_name}] is not a highlyconfidential bucket"
        end
      end
    end
  end

  
  google_bigquery_datasets(project: gcp_project_id).ids.each do |name|
    dataset = google_bigquery_dataset(project: gcp_project_id, name: name.split(':').last)
    if dataset.labels.nil?
      describe "[#{gcp_project_id}] BigQuery [#{name}]" do
        subject { dataset }      
        its("labels") { should_not cmp nil }      
      end
    else
      if (dataset.labels['dataclassification'].eql? "highlyconfidential")
        describe "[#{gcp_project_id}] BigQuery Dataset [#{name}]" do
          subject { dataset }
          its('default_encryption_configuration.kms_key_name') { should_not be nil }
        end
      else 
        describe "[#{gcp_project_id}] [#{name}] is not a highlyconfidential dataset. This test is not applicable" do
          skip "[#{gcp_project_id}] [#{name}] is not a highlyconfidential dataset"
        end
      end
    end
  end

  google_pubsub_topics(project: gcp_project_id).names.each do |topic_name|
    topic = google_pubsub_topic(project: gcp_project_id, name: topic_name)
    if topic.labels.nil?
      describe "[#{gcp_project_id}] PubSub Topic [#{topic_name}]" do
        subject { topic }      
        its("labels") { should_not cmp nil }      
      end
    else
      if (topic.labels['dataclassification'].eql? "highlyconfidential")
        describe "[#{gcp_project_id}] PubSub Topic [#{topic_name}]" do
          subject { topic }
          its('kms_key_name') { should_not be nil }
        end
      else 
        describe "[#{gcp_project_id}] [#{topic_name}] is not a highlyconfidential topic. This test is not applicable" do
          skip "[#{gcp_project_id}] [#{topic_name}] is not a highlyconfidential topic"
        end
      end
    end
  end
end
