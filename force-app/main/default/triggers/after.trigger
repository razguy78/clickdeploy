trigger after on ContentDocument (after insert) {
    list<ContentDocument> docL = Trigger.New;
    system.debug('The size of the list is: ' + docL.size());
    for (ContentDocument docLi : docL){
         system.debug('The value of the file type for ContentDocument is: '+ docLi.FileType);
       // docL.addError('File Management Is not Permitted.');
    }
}