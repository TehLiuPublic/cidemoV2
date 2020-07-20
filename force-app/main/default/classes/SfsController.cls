public with sharing class SfsController {
    
    public List<CreditorInfo> jdataList { get; set; }
    public CreditorInfo creditorObj { get; set; }
    public double grandTotal { get; set; }
    public Integer rowcount { get; set; }
    
    public class CreditorInfo {
        public boolean isSelected {get;set;}
        public String id {get;set;}
        public String creditorName {get;set;}
        public String firstName {get;set;}
        public String lastName {get;set;}
        public Double minPaymentPercentage {get;set;}
        public Double balance {get;set;}
        
        
        public CreditorInfo() {
            isSelected = true;

        }
    }    
    
    public sfsController() {
    }
    
    public void basicAuthCallout(){
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://raw.githubusercontent.com/StrategicFS/Recruitment/master/data.json');
        req.setMethod('GET');
        
        Http http = new Http();
        HTTPResponse res = http.send(req);
        String httpData = res.getBody();
        
        List<CreditorInfo> jdataTmpList = (List<CreditorInfo>)JSON.deserialize(httpData, List<CreditorInfo>.class);
        jdataList = new List<CreditorInfo>();
        grandTotal = 0.0;
        for (CreditorInfo j: jdataTmpList) {
            grandTotal += j.balance;
            j.isSelected = true;
            jdataList.add(j);
            
        }
        rowcount = jdataTmpList.size();
    }
    
    public PageReference addField(){
        CreditorInfo  c = new CreditorInfo(); 
        jdataList.add(c);
        rowcount++;
        return null;    
    }     
}