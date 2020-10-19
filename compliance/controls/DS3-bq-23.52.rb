title "Ensure the database instance has all mandatory label (owner, dataclassification)"

gcp_project_id = input('gcp_project_id')
gcp_project_region = input('gcp_project_region')
control_id = '23.52'
control_abbrev = 'bq'

control "cap-gcp-#{control_id}-#{control_abbrev}" do
  impact 1.0
  title "[#{control_abbrev.upcase}] - All bigquery datasets and tables must with contain the mandatory labels"

  tag "control_ids": ["DS3"]

  if google_bigquery_datasets(project: gcp_project_id).ids.empty?
    impact 0
    describe "[#{gcp_project_id}] does not have BigQuery Datasets, this test is Not Applicable." do
      skip "[#{gcp_project_id}] does not have BigQuery Datasets"
    end
  else
    google_bigquery_datasets(project: gcp_project_id).ids.each do |name|
      describe google_bigquery_dataset(project: gcp_project_id, name: name.split(':').last) do
        its('labels') { should include("owner")}
        its('labels') { should include("dataclassification")}
      end
    
# currenlty diabled due to logging tables not having labels. 
#      google_bigquery_tables(project: gcp_project_id, dataset: name.split(':').last).table_references.each do |table_reference|
#        describe google_bigquery_table(project: gcp_project_id, dataset: name.split(':').last, name: table_reference.table_id) do
#          its('labels') { should include("owner")}
#          its('labels') { should include("dataclassification")}
#        end
#      end
    end
  end
end
