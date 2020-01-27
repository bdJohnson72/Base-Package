/**
 * Created by bjohnson on 1/27/20.
 */

public with sharing class CustomMetaDataTriggerHandler  extends TriggerHandler{

    //The run() method from TriggerHandler is overridden to execute classes found in custom metadata

    public override void run() {

         //Our first task is to identify the object on which this trigger fired.


        String firedOnsObjectType = getSObjectType();

        /*
         * This query executes against our custom metadata to return records that detail
         * what trigger handlers, and in what order, they should be called.
         */
        List<TriggerHandlers__mdt> triggerHandlersToRun = [
                SELECT Execution_Order__c, Class_Name__c
                FROM TriggerHandlers__mdt
                WHERE SObject_Type__c = :firedOnsObjectType
                ORDER BY Execution_Order__c
        ];

        for (TriggerHandlers__mdt triggerHandler: triggerHandlersToRun) {

            TriggerHandler handler;
            try{
                handler = (TriggerHandler) Type.forName(triggerHandler.Class_Name__c).newInstance();
            } catch (NullPointerException npe) {
               //TODO tell someone about this.
                System.debug('Null pointer thrown from CMDT Trigger Handler');
                continue;
            }

            // dispatch to the correct handler method
            switch on this.context {
                when BEFORE_INSERT {
                    handler.beforeInsert();
                }
                when BEFORE_UPDATE {
                    handler.beforeUpdate();
                }
                when BEFORE_DELETE {
                    handler.beforeDelete();
                }
                when AFTER_INSERT {
                    handler.afterInsert();
                }
                when AFTER_UPDATE {
                    handler.afterUpdate();
                }
                when AFTER_DELETE {
                    handler.afterDelete();
                }
                when AFTER_UNDELETE {
                    handler.afterUndelete();
                }
            }
        }
    }

    // Helper Methods
    private String getSObjectType(){
        if(Trigger.new != null){
            return Trigger.new[0].getSObjectType().getDescribe().getName();
        }else {
            return Trigger.old[0].getSObjectType().getDescribe().getName();
        }
    }
}