/*using {
  cuid,
  managed,
  sap.common.CodeList
} from '@sap/cds/common';
*/
namespace sap.capire.MLF;

/**
* Equipment.
*/
entity Equipment {
  key EquipmentID        : String;
      EquipmentName      : String;
      ModelNumber        : String;
      FunctionalLocation : String;
      Plant              : String;
      RepairHistory      : Composition of many {
                                 //  key EquipmentID : String;
                             key RepairID    : String;
                                 FailureCode : String;
                                 Description : String;
                                 Resolution  : String;
                                 RepairDate  : Date;
                           }
}

entity FailureCodes {
  key EquipmentID        : Association to Equipment;
      FailureCode        : String;
      FailureDescription : String;
      FailureCategory    : String;
}

entity EquipmentContext {
  key EquipmentID        : Association to Equipment;
      EquipmentName      : String;
      FunctionalLocation : String;
      ModelNumber        : String;
      Plant              : String;
}
