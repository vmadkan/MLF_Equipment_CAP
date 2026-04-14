using {sap.capire.MLF as my} from '../db/schema';


service ProcessorService {
    entity Equipment        as projection on my.Equipment;
    /* entity RepairHistory as projection on my.RepairHistory;*/
    entity FailureCodes     as projection on my.FailureCodes;
    entity EquipmentContext as projection on my.EquipmentContext;
}

//@path: 'dms'
service DMSService {
    entity FolderContent {
        key objectId  : String;
            name      : String;
            type      : String; // folder | document
            mimeType  : String;
            size      : Integer64;
            createdAt : Timestamp;
            createdBy : String;
    }

    function GetFolderContent(repositoryId: String,
                              folderPath: String) returns array of FolderContent;
}
