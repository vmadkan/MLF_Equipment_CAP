namespace sap.capire.MLF;

entity Equipment {
  key EquipmentID        : String;
      EquipmentName      : String;
      ModelNumber        : String;
      FunctionalLocation : String;
      Plant              : String;
      RepairHistory      : Composition of many {
        key RepairID     : String;
            FailureCode : String;
            Description : String;
            Resolution  : String;
            RepairDate  : Date;
      };
}

entity FailureCodes {
  key EquipmentID        : Association to Equipment;
      FailureCode        : String;
      FailureDescription : String;
      FailureCategory    : String;
}