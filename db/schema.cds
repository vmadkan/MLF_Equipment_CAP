using {
  cuid,
  managed,
  sap.common.CodeList
} from '@sap/cds/common';

namespace sap.capire.MLF;

/**
* Equipment.
*/

entity Equipment : cuid, managed {
key EquipmentID : String;
    EquipmentName : String;
    ModelNumber : String;
    FunctionalLocation : String;
    Plant : String;
}

entity RepairHistory : cuid, managed {
    key RepairID : String;
        EquipmentID : Association to Equipment;
        FailureCode : String;
        Description : String;
        Resolution : String;
        RepairDate : Date @UI.DateTimeStyle : 'YYYY-MM-DD';
}

entity FailureCodes : managed {
    FailureCode : String;
    FailureDescription : String;
    FailureCategory : String;
}