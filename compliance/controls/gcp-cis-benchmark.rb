title "CIS GCP Benchmarks v1.1"

require_controls 'inspec-gcp-cis-benchmark' do
#  control 'cis-gcp-1.1-iam' - code error
#  control 'cis-gcp-1.2-iam' - not scored
#  control 'cis-gcp-1.3-iam' - not scored
  control 'cis-gcp-1.4-iam' do
    tag "control_ids": ["CC1"]
  end
  control 'cis-gcp-1.5-iam' do
    tag "control_ids": ["CC1","UA21"] 
  end
  control 'cis-gcp-1.6-iam'
  control 'cis-gcp-1.7-iam' do
    tag "control_ids": ["CC1"]
  end
  control 'cis-gcp-1.8-iam'
  control 'cis-gcp-1.9-iam' do
    tag "control_ids": ["CC1"]
  end
  control 'cis-gcp-1.10-iam' 
  control 'cis-gcp-1.11-iam'
#  control 'cis-gcp-1.12-iam' - not scored
#  control 'cis-gcp-1.13-iam' - not scored
#  control 'cis-gcp-1.14-iam' - not scored
#  control 'cis-gcp-1.15-iam' - not scored
  control 'cis-gcp-2.1-logging' do
    tag "control_ids": ["CC1"]
  end
  # control 'cis-gcp-2.2-logging' Control 2.2 covered by Control LM1  
  control 'cis-gcp-2.3-logging' do
    tag "control_ids": ["CC1"]
  end
  control 'cis-gcp-3.1-networking' do
    tag "control_ids": ["CC1","NS22"]
  end
  control 'cis-gcp-3.2-networking' do
    tag "control_ids": ["CC1","NS21"]
  end
  control 'cis-gcp-3.8-networking' do
    tag "control_ids": ["CC1", "NS6"]
  end
  control 'cis-gcp-4.1-vms'
  control 'cis-gcp-4.2-vms'
  control 'cis-gcp-4.3-vms'
  control 'cis-gcp-4.4-vms'
  control 'cis-gcp-4.5-vms'
  control 'cis-gcp-4.6-vms'
  # control 'cis-gcp-4.7-vms' Have added custom 4.7 test
  # control 'cis-gcp-2.4-logging' Controls 2.4-2.11 disabled as al logging metrics are set up in one project. Would need to rewrite the tests to prove these.
  # control 'cis-gcp-2.5-logging'
  # control 'cis-gcp-2.6-logging'
  # control 'cis-gcp-2.7-logging'
  # control 'cis-gcp-2.8-logging'
  # control 'cis-gcp-2.9-logging'
  # control 'cis-gcp-2.10-logging'
  # control 'cis-gcp-2.11-logging'
  control 'cis-gcp-5.1-storage' do
    tag "control_ids": ["CC1", "DS12"] 
  end
  control 'cis-gcp-5.2-storage' do
    tag "control_ids": ["CC1","DS1"]
  end
  control 'cis-gcp-7.1-bq' do
    tag "control_ids": ["CC1", "DS13"]
  end
end