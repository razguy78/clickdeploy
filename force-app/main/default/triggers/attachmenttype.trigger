trigger attachmenttype on Attachment (before insert) {
    for (Attachment docL : Trigger.New){
         system.debug('attachmenttype The value of the file type is: '+docL.ContentType);
       // docL.addError('File Management Is not Permitted.');
    }
}