using {sap.capire.MLF as my} from '../db/schema';


service ProcessorService {
    entity Equipment as projection on my.Equipment;
   /* entity RepairHistory as projection on my.RepairHistory;*/
    entity FailureCodes as projection on my.FailureCodes;

}

/**
 * Service used by administrators to manage Equipments.
 */
/*service AdminService {
    entity Equipment as projection on my.Equipment;
    entity RepairHistory as projection on my.RepairHistory;
    entity FailureCodes as projection on my.FailureCodes;

}*/