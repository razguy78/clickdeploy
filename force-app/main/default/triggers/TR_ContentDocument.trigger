trigger TR_ContentDocument on ContentDocument (before insert) {
    for (ContentDocument docL : Trigger.New){
         system.debug('The value of the file type is: '+docL.FileType);
      // docL.addError('File Management Is not Permitted.');
    }
}