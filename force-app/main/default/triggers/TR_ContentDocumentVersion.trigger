trigger TR_ContentDocumentVersion on ContentVersion (before insert) {
//  system.assert(false, '@TR_ContentDocumentVersion on ContentVersion@');
system.debug('About to nullfy data');
for (ContentVersion docL : Trigger.New){
    if(docL.IsMajorVersion)
    {
        docL.IsMajorVersion = false;
    }
    system.debug('The value of the file type is: '+docL.FileType);
       // docL.addError('File Management Is not Permitted.');
    }
}