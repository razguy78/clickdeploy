// Allow customization of the content Download experience
public class ContentDownloadHandlerFactoryImpl implements Sfc.ContentDownloadHandlerFactory {

public Sfc.ContentDownloadHandler getContentDownloadHandler(List<ID> ids, Sfc.ContentDownloadContext context) {
    Sfc.ContentDownloadHandler contentDownloadHandler = new Sfc.ContentDownloadHandler();
    List<ContentVersion> cvlist = [SELECT Checksum,ContentBodyId,ContentDocumentId,
                                   ContentLocation,ContentModifiedById,ContentModifiedDate,ContentSize,
                                   ContentUrl,CreatedById,CreatedDate,Description,ExternalDataSourceId,
                                   ExternalDocumentInfo1,ExternalDocumentInfo2,FeaturedContentBoost,
                                   FeaturedContentDate,FileExtension,FileType,FirstPublishLocationId,
                                   Id,IsAssetEnabled,IsDeleted,IsEncrypted,IsLatest,IsMajorVersion,
                                   LastModifiedById,LastModifiedDate,NegativeRatingCount,Origin,OwnerId,
                                   PathOnClient,SharingOption,SharingPrivacy,Title,
                                   VersionNumber FROM ContentVersion where id in :ids and successfully_uploaded__c = false]; 
    system.debug('list has '+ cvlist.size() +' Items');
if(cvlist.size() >=1)// == Sfc.ContentDownloadContext.MOBILE)
{
        contentDownloadHandler.isDownloadAllowed = false;
        contentDownloadHandler.downloadErrorMessage = 'Some files have yet to be uploaded sucessfully';
        return contentDownloadHandler;
    }
    contentDownloadHandler.isDownloadAllowed = true;
    contentDownloadHandler.downloadErrorMessage = 'מדיניות אבטחת המידע מונעת הורדה של קובץ זה';
    //contentDownloadHandler.redirectUrl= '/lightning/o/Case/list?filterName=Recent';
    return contentDownloadHandler;
}
}