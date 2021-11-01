trigger newaft on ContentVersion (after insert) {
    list<ContentVersion> docL = Trigger.New;
    system.debug('The size of the list is: ' + docL.size());
    for (ContentVersion docLi : docL){
        system.debug('Will put null after insert');
        //docLi.VersionData = null;
         system.debug('The value of the file type for ContentDocument is: '+ docLi.FileType);
       // docL.addError('File Management Is not Permitted.');
    }
}