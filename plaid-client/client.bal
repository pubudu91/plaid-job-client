import ballerina/io;
import ballerina/http;

public client class PlaidJobsClient {

    private http:Client plaidEP;
    private string name;
    private string email;
    private string phone;
    private string resume;
    private map<string> miscInfo;

    public function init(string name, string email, string phone) {
        self.plaidEP = checkpanic new("https://contact.plaid.com");
        self.name = name;
        self.email = email;
        self.phone = phone;
        self.resume = "";
        self.miscInfo = {};
    }

    # Adds any additional information you may want to share.
    #
    # + key - The key for the JSON field  
    # + value - The info you want to add  
    public function addMiscInfo(string key, string value) {
        self.miscInfo[key] = value;
    }

    # Clears all the misc. info added so far.  
    public function resetMiscInfo() {
        self.miscInfo.removeAll();
    }

    # Sets the resume to the given URL.
    #
    # + url - URL to the location of the resume  
    public function setResume(string url) {
        self.resume = url;
    }

    # Sends a POST request to the Plaid jobs endpoint for the specified job ID.
    #
    # + jobId - ID of the job  
    # + return - Returns () if successfully applied
    remote function apply(string jobId) returns error? {
        if (self.resume == "") {
            return error("Don't forget to add the resume!");
        }

        json reqPayload = self.buildRequest(jobId);
        json resp = check self.plaidEP->post("/jobs", reqPayload);
        io:println(resp);
    }

    private function buildRequest(string jobId) returns json {
        map<json> fields = {};
        fields["name"] = self.name;
        fields["email"] = self.email;
        fields["resume"] = self.resume;
        fields["phone"] = self.phone;
        fields["job_id"] = jobId;

        foreach var [k, v] in self.miscInfo.entries() {
            fields[k] = v;
        }

        return fields;
    }
}