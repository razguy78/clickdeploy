global class NIT_Contact_Write_Batch implements Database.Batchable<sObject> {
	
	String query = 'SELECT Id, FirstName, LastName, Gender__c, Birthdate, Email, Phone, IDNumber__c FROM Contact';
	
	global NIT_Contact_Write_Batch() {
		
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		System.debug('SF: Start Contact Write Batch');
		return Database.getQueryLocator(query);
	}

   	global void execute(Database.BatchableContext BC, List<Contact> scope) {
   		List<Contact> contactList = new List<Contact>();

   		for(Contact contact: scope){
   			if(!String.isEmpty(contact.FirstName)){
   				contact.FirstName = contact.FirstName + '_Batch';
   			}
   			if(!String.isEmpty(contact.LastName)){
   				contact.LastName = contact.LastName + '_Batch';
   			}
   			if(contact.Birthdate != null){
   				contact.Birthdate = contact.Birthdate.addDays(3);
   			}

   			System.debug('*************************************************');
			System.debug(contact);
			System.debug('+++++++++++++++++++++++++++++++++++++++++++++++++');

   			contactList.add(contact);
   		}

   		update contactList;
	}
	
	global void finish(Database.BatchableContext BC) {
		System.debug('SF: Finish Contact Write Batch');
	}
	
}