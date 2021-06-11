# plaid-job-client
A simple HTTP client for applying for jobs posted in the Plaid website.

## Usage

```ballerina
import pubudu/plaid_job_client as plaid;

public function main() {
    // Create a client with your basic required details
    plaid:PlaidJobsClient jobsEp = new("John Doe", "john.doe@gmail.com", "+123456789");

    // Don't forget to add your resume!
    jobsEp.setResume("https://johndoe.me/resume");

    // Feel free to add any additional info
    jobsEp.addMiscInfo("cover_letter", "https://johndoe.me/cover-letter");
    jobsEp.addMiscInfo("github", "github.com/doejohn");

    // Give the relevant job ID and apply away!
    checkpanic jobsEp->apply("1234");
}
```
If all goes well, you should see the following message on the console
```
We got your application and we'll get back to you shortly!
```