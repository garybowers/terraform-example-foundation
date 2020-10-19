const results = require("./vs-results.json");
const fs = require("fs");

const control_mapping = {
  UA1: {
    description:
      "Create and grant predefined roles to allow the least-permissive access necessary",
    status: "DONE",
    tests: [],
  },
  UA2: {
    description:
      "Create a separate service account for each of the service and grant only the required permissions to each service account.",
    status: "IN_PROGRESS",
    tests: [],
  },
  UA3: {
    description:
      "Grant roles at the smallest scope needed. For example, if a user only needs access to publish Pub/Sub topics, grant the Publisher role to the user for that topic.",
    status: "DONE",
    tests: [],
  },
  UA4: {
    description:
      "Restrict service accounts role grants to only service accounts(If users don't need permission to manage or use service accounts, then remove them from the applicable IAM policy)",
    status: "NOT_STARTED",
    tests: [],
  },
  UA5: {
    description:
      "Implement service account key rotation using the IAM service account API",
    status: "NOT_STARTED",
    tests: [],
  },
  UA6: {
    description:
      "Implement automated processes to manage user-managed service account keys where applicable.",
    status: "NOT_APPLICABLE",
    tests: [],
  },
  UA7: {
    description:
      "Implement auditing of IAM policy changes through the use of Cloud Audit Logs",
    status: "DONE",
    tests: [],
  },
  UA8: {
    description:
      "Implement role base access control using Cloud IAM to Manage access to resources example  access to logs are only possible using Logging roles.",
    status: "IN_PROGRESS",
    tests: [],
  },
  UA10: {
    description:
      "Set organization-level IAM policies to grant and manage access to projects within the organization.",
    status: "IN_PROGRESS",
    tests: [],
  },
  UA11: {
    description:
      "Configure role Grants at group level instead of individual users when possible.",
    status: "IN_PROGRESS",
    tests: [],
  },
  UA12: {
    description:
      "All passwords should be stored as a cryptographic and salted hashed value using SHA256 at minimum, The hash should be salted with a value unique to that specific login credential",
    status: "NOT_APPLICABLE",
    tests: [],
  },
  UA13: {
    description:
      "Federate Google IDP with internal IDP and implement external identity providers alongside your existing internal authentication system  where applicable",
    status: "NOT_APPLICABLE",
    tests: [],
  },
  UA14: {
    description:
      "Implement low coupling and high cohesion for user account to separate the concept of user identity, user account and password",
    status: "NO_TESTS",
    tests: [],
  },
  UA15: {
    description: "Set/Specify a maximum length user sessions",
    status: "NOT_APPLICABLE",
    tests: [],
  },
  UA16: {
    description:
      "Configure multifactor authentication at a minimum for administrative user accounts",
    status: "NOT_APPLICABLE",
    tests: [],
  },
  UA17: {
    description:
      "Control access to apps by using Identity-Aware Proxy (IAP) to verify user identity and the context of the request to determine if a user should be granted access.",
    status: "NOT_APPLICABLE",
    tests: [],
  },
  UA18: {
    description:
      "Ensure that user accounts are added to groups to access GCP resources",
    status: "IN_PROGRESS",
    tests: [],
  },
  UA19: {
    description:
      "Ensure that user accounts do not have roles mapped to them directly",
    status: "DONE",
    tests: [],
  },
  UA20: {
    description:
      "Ensure no IAM group or user should be using primitive roles of owner or editor",
    status: "DONE",
    tests: [],
  },
  UA21: {
    description:
      "Ensure no service account should be using primitive roles of owner or editor.",
    status: "DONE",
    tests: [],
  },
  UA22: {
    description:
      "Use the IAM API to audit the service accounts, the keys, and the policies on those service accounts.",
    status: "NOT_STARTED",
    tests: [],
  },
  NS1: {
    description:
      "Ensure all GCLB is associated with at least one cloud Armor security policy",
    status: "DONE",
    tests: [],
  },
  NS2: {
    description:
      "Implement Identity aware proxy to control access to VMs and Apps",
    status: "NOT_APPLICABLE",
    tests: [],
  },
  NS3: {
    description: "Ability to filter IP based traffic, Region based traffic",
    status: "DONE",
    tests: [],
  },
  NS4: {
    description:
      "Ability to protect against OWASP top 10 vulnerabilities at runtime - Enable WAF on Armor",
    status: "DONE",
    tests: [],
  },
  NS5: {
    description: "Ability to apply layer 7 based filtering",
    status: "NOT_APPLICABLE",
    tests: [],
  },
  NS6: {
    description: "Ability to monitor, log and alert in real time",
    status: "DONE",
    tests: [],
  },
  NS7: {
    description: "Deploy container with only private IPs",
    status: "DONE",
    tests: [],
  },
  NS8: {
    description: "Deploy private GKE clusters",
    status: "DONE",
    tests: [],
  },
  NS9: {
    description:
      "Load Balance organisation policy constraint shall be applied to allow the provisioning of Internal Load Balancer in all projects, except for the selected Ingress project approved through exception.",
    status: "NOT_STARTED",
    tests: [],
  },
  NS10: {
    description: "Access GCP PaaS Services privately",
    status: "DONE",
    tests: [],
  },
  NS11: {
    description: "Ensure that egress to the internet is centralised",
    status: "IN_PROGRESS",
    tests: [],
  },
  NS12: {
    description:
      "Mitigate exfilteration risks - implement VPC service controls",
    status: "IN_PROGRESS",
    tests: [],
  },
  NS13: {
    description:
      "Restrict communication between VM based applications - Implement firewall rules by grouping VMs together using tags",
    status: "NOT_APPLICABLE",
    tests: [],
  },
  NS14: {
    description:
      "Control communication between container based applications - implement network policies, split applications into namespaces",
    status: "DONE",
    tests: [],
  },
  NS15: {
    description:
      "Ensure that networks for different environments are segregated",
    status: "DONE",
    tests: [],
  },
  NS16: {
    description:
      "Cloud NATs should not exist unless in an approved vpc networks",
    status: "DONE",
    tests: [],
  },
  NS17: {
    description:
      "Ensure that No INGRESS firewall rules allow 0.0.0.0/0 from any source",
    status: "DONE",
    tests: [],
  },
  NS18: {
    description:
      "Ensure that No EGRESS firewall rules allow 0.0.0.0/0 to any destination",
    status: "DONE",
    tests: [],
  },
  NS19: {
    description: "Ensure default egress rule exists that blocks egress traffic",
    status: "DONE",
    tests: [],
  },
  NS20: {
    description:
      "Ensure google private access is enabled for every subnet in VPC Network",
    status: "DONE",
    tests: [],
  },
  NS21: {
    description: "Ensure legacy networks does not exists for a project",
    status: "DONE",
    tests: [],
  },
  NS22: {
    description: "Ensure the default network does not exist in a project",
    status: "DONE",
    tests: [],
  },
  LM1: {
    description:
      "Create separate centralized log sinks per category of log data (eg. security logs bucket, application logs bucket, etc)",
    status: "DONE",
    tests: [],
  },
  LM2: {
    description:
      "Enable storage.write and logging.write IAM permissions. Container service account should have write capability to the the logs sink",
    status: "NOT_STARTED",
    tests: [],
  },
  LM3: {
    description:
      "Enable stack driver tracing - Stackdriver Tracing, gather timing data needed to troubleshoot latency problems in service architectures",
    status: "NOT_APPLICABLE",
    tests: [],
  },
  LM4: {
    description:
      "Setup log base alerting with stack driver by creating alerts for metrics through the log based metric explorer",
    status: "DONE",
    tests: [],
  },
  LM5: {
    description:
      "Configure and enable stack driver profiler to monitor CPU usage & memory",
    status: "NOT_APPLICABLE",
    tests: [],
  },
  LM6: {
    description:
      "Create stack driver groups to monitor logical groups of resources",
    status: "NOT_APPLICABLE",
    tests: [],
  },
  LM8: {
    description:
      "Define webhooks to integrate into third part services for alerts that are triggered if needed",
    status: "NOT_APPLICABLE",
    tests: [],
  },
  LM10: {
    description:
      "Configure stack driver for SRE service level indicator monitoring SRE",
    status: "NOT_APPLICABLE",
    tests: [],
  },
  LM11: {
    description: "confiure alert metrics for monitoring:",
    status: "DONE",
    tests: [],
  },
  LM12: {
    description:
      "implement gaurdrails to protect GCS buckets/log sinks storing log data against unauthorised access",
    status: "NOT_STARTED",
    tests: [],
  },
  LM13: {
    description:
      "implement guardrail to enforce appropriate log rention periods for logs stored",
    status: "DONE",
    tests: [],
  },
  DS1: {
    description:
      "Turn on uniform bucket-level access and its org policy, Restrict access to the bucket using GCP cloud identity",
    status: "DONE",
    tests: [],
  },
  DS2: {
    description:
      "Implement naming convention for GCS buckets that avoids sensitive data description in name",
    status: "NOT_APPLICABLE",
    tests: [],
  },
  DS3: {
    description:
      "Create separate buckets to hold data at different classification",
    status: "DONE",
    tests: [],
  },
  DS4: {
    description:
      "Enable domain-restricted sharing, to enforce the domain-restricted sharing constraint in an organization policy to  prevent accidental public data sharing, or sharing beyond your organization",
    status: "NOT_STARTED",
    tests: [],
  },
  DS5: {
    description: "Encrypt your Cloud Storage data with Cloud KMS",
    status: "DONE",
    tests: [],
  },
  DS6: {
    description:
      "Audit your Cloud Storage data with Cloud Audit Logging, Cloud Audit Logs bring visibility into user activity and data access across Google Cloud,including Cloud Storage.",
    status: "NOT_STARTED",
    tests: [],
  },
  DS7: {
    description:
      "Use Operations (formerly Stackdriver) APIs for programmatic access and ingesting Cloud Storage audit logs into your threat detection analytics systems",
    status: "NOT_APPLICABLE",
    tests: [],
  },
  DS8: {
    description:
      "Secure your data with VPC Service Controls, With VPC Service Controls, you can configure security perimeters around the resources of your Cloud Storage service and control exfiltration of data across the perimeter boundary",
    status: "IN_PROGRESS",
    tests: [],
  },
  DS9: {
    description:
      "Implement continuous checks using cloud DLP and data discovery - text to be modified",
    status: "NOT_APPLICABLE",
    tests: [],
  },
  DS10: {
    description:
      "Configure A retention policy that specifies a retention period on buckets ( An object in the bucket cannot be deleted or overwritten until it reaches the specified age.)",
    status: "DONE",
    tests: [],
  },
  DS11: {
    description:
      "Implement Cloud Storage cookie-based authentication.  Using cloud Identity for managing authentication Where appropriate to make specific files available to specific individuals",
    status: "NOT_APPLICABLE",
    tests: [],
  },
  DS12: {
    description: "Ensure GCS buckets are private and not public exposed",
    status: "DONE",
    tests: [],
  },
  DS13: {
    description:
      "Ensure that BigQuery datasets are not anonymously or publicly accessible",
    status: "DONE",
    tests: [],
  },
  DP1: {
    description:
      "Use a Google Cloud global HTTP(S) load balancer to enforce transport level encryption and to support high availability and scaling for your internet-facing services.",
    status: "DONE",
    tests: [],
  },
  DP2: {
    description: "encrypt all data at rest",
    status: "NO_TESTS",
    tests: [],
  },
  DE1: {
    description: "All data must be encrypted with CMEK using HSM backed keys",
    status: "DONE",
    tests: [],
  },
  CC1: {
    description: "Implement GCP Gaurdrails and GCP CIS Benchmarks",
    status: "DONE",
    tests: [],
  },
};

const removeDuplicateTests = (array) =>
  array.filter(
    (item, index, self) => index === self.findIndex((x) => x.id === item.id)
  );

results.profiles.forEach(({ controls }) =>
  controls.forEach((control) => {
    const test = {
      id: control.id,
      title: control.title,
      passed: control.results.reduce(
        (acc, result) => acc && result.status === "passed",
        true
      ),
    };

    if (control.tags.control_ids) {
      control.tags.control_ids.forEach((control_id) => {
        if (control_mapping[control_id]) {
          control_mapping[control_id].tests = removeDuplicateTests([
            ...control_mapping[control_id].tests,
            test,
          ]);
        } else {
          control_mapping[control_id] = {
            description: "UNKNOWN",
            status: "UNKOWN_CONTROL",
            tests: [test],
          };
        }
      });
    }
  })
);

fs.writeFileSync(
  "./control-mappings.json",
  JSON.stringify(control_mapping, null, 4)
);
