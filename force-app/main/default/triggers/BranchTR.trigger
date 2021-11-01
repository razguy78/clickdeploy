trigger BranchTR on Branch__c (before insert) {
	public class customException extends Exception{}
/*
    try{
    	throw new customException();
    }catch(Exception e){
        system.debug(e);
        Trigger.new[0].addError('no good amigo');
    }

*/
}