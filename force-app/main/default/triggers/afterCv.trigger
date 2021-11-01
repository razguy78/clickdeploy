trigger afterCv on ContentVersion (after insert) {
list<ContentVersion> docL = Trigger.New;
    system.debug('The size of the list is: ' + docL.size());
    for (ContentVersion docLi : docL){
         system.debug('The value of the file type is: '+docLi.FileType);
       // docL.addError('File Management Is not Permitted.');
    }
}