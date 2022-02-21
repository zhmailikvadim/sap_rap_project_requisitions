@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Dev'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZNBS_DEVELOPERS_EPIC as select from znbs_epic 
//association to parent ZNBS_I_DEVELOPER_SEPARATE as Developer on $projection.
{
    key epicuuid as Epicuuid,
    projectuuid as Projectuuid,
    semanticid as Semanticid,
    epicdescription as Epicdescription,
    epicstatus as Epicstatus,
    functionalexpert as Functionalexpert,
    created as Created,
    changed as Changed,
    dueby as Dueby,
    mptstatus as Mptstatus,
    ddnumber as Ddnumber,
    fsnumber as Fsnumber,
    developer as Developer
}
