public with sharing class NIT_ISRAELFLOWS_CTR {

	public String strToFind {get;set;}
	public Customer__c custToUpdate {get;set;}
	public List<List<Customer__c>> searchList {get;set;}
	public String inputMail {get;set;}
	public Address__c customerLookupSupplier {get;set;}

	public NIT_ISRAELFLOWS_CTR() {
		this.customerLookupSupplier = new Address__c();
		this.custToUpdate = new Customer__c();
	}

	public void getSoslResults(){
		this.searchList = null;
		if(String.isNotBlank(this.strToFind)){
			try{
				this.searchList = [FIND :strToFind IN ALL FIELDS 
                                      RETURNING Customer__c(Name, Description__c, Industry__c, FullName__c)];
            }
            catch(Exception x){
            	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Search failed, try to add more characters..'));
            }
            if(this.searchList == null || this.searchList.size() == 0 || (this.searchList.size() == 1 && this.searchList[0].size() == 0)){
            	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info,'No customers were found for the keyword '+'"'+this.strToFind+'"'));
            }	
		}
		else{
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Please enter a value to search for'));
		}
	}

	public void sendEmailWithDecryptedFields(){
		List<Customer__c> custList = [SELECT FullName__c, Name, Industry__c, Description__c FROM Customer__c WHERE Id =: this.customerLookupSupplier.Customer__c];
		Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
		String[] toAddresses = new String[] {};
		toAddresses.add(inputMail);
		mail.setToAddresses(toAddresses);
		mail.setSubject('Test mail');
		mail.setSenderDisplayName('Salesforce Support');
		if(custList != null && custList.size() > 0){
			mail.setHtmlBody('The customer info: name: '+custList[0].Name+', full name: '+custList[0].FullName__c+', industry: '+custList[0].Industry__c+', description: '+custList[0].Description__c);
			try{
				Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
				ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm,'Email sent to '+inputMail+' !'));
			}
			catch(Exception x){
				ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Please enter a valid Email!'));
			}
		}
		else{
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Please select a customer!'));
		}
	}

	public void updateCustomer(){
		try{
			this.custToUpdate.Id = this.customerLookupSupplier.Customer__c;
			system.debug('this.custToUpdate.Id: '+this.custToUpdate.Id);
			update this.custToUpdate;
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm,'Customer has been updated!'));
		}
		catch(Exception x){
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Could not update the customer!'));
		}
	}
}