/**
 * Created by bjohnson on 1/27/20.
 */

trigger ContactTrigger on Contact (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    new CustomMetaDataTriggerHandler().run();

}