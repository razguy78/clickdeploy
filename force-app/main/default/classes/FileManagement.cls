@RestResource(urlMapping='/V1/Files/*')
global without sharing class FileManagement {
       //@HttpGet
    @HTTPPatch
    global static void setExternalId(id Versionid,String ExternalId)
    {

//commit 1 file 1
        ContentVersion cv = [select id,IsMajorVersion,ContentDocumentId from Contentversion where id = :versionid];
        if(cv != null)
        {
            if (!cv.IsMajorVersion)
            {
        cv.VersionData = blob.valueOf('This file has been successfully uploaded to documnets store');
        cv.successfully_uploaded__c = true;
        cv.DocId__c = ExternalId;
        // cv.IsMajorVersion= false;   
        update cv;
            }
            else
            {
               ContentVersion v2 = new ContentVersion();
                Contentdocument CD  = [select id from Contentdocument where id = :cv.ContentDocumentId ];
                v2.VersionData = blob.valueOf('Look at this');
                v2.PathOnClient = 'KishKush.txt';
                v2.IsMajorVersion = false;
                v2.Title = 'Updated version';
                insert v2;
delete CD;
            }
            }
    }

}