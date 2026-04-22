using { sap.capire.MLF as my } from '../db/schema';

service ProcessorService {
    @cds.redirection.target: true
    entity Equipment as projection on my.Equipment;

    entity FailureCodes as projection on my.FailureCodes;

    @cds.redirection.target: false
    entity EquipmentContext as projection on my.Equipment {
        key EquipmentID,
        EquipmentName,
        FunctionalLocation,
        ModelNumber,
        Plant
    };
}

service DMSService {
    entity FolderContent {
        key objectId  : String;
            name      : String;
            type      : String;
            mimeType  : String;
            size      : Integer64;
            createdAt : Timestamp;
            createdBy : String;
    }

    type FolderContentItem : {
        objectId  : String;
        name      : String;
        type      : String;
        mimeType  : String;
        size      : Integer64;
        createdAt : Timestamp;
        createdBy : String;
    };

    function GetFolderContent(
        EquipmentID : String
    ) returns {
        value : many FolderContentItem;
    };
}