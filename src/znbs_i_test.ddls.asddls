@AbapCatalog.sqlViewName: 'ZNBSITEST'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Read Mode test'
define view znbs_i_test as select from znbs_dev_profs as Test
    join znbs_i_profiles as Profile on Profile.Profileuuid = Test.profileuuid 

{

      @UI.facet          : [
               {
                 id      :    'DevProfile',
                 purpose :     #STANDARD,
                 type    :     #IDENTIFICATION_REFERENCE,
                 label   :    'Dev Profile Read Mode test',
                 position: 10 }
             ]

  key uuid                                       as Uuid,
      @UI                : {
      lineItem           : [{position: 10, label: 'Developer uuid', importance: #HIGH}],
      identification     : [{position: 10, label: 'Developer uuid'}]
      }
      developeruuid                              as Developeruuid,
      Test.profileuuid                           as DevProfileuuid,
      @UI                : {
      lineItem           : [{position: 15, label: 'Name', importance: #HIGH}],
      identification     : [{position: 15, label: 'Name'}]
      }      
      Profile.Name                               as Name,
      @Semantics.systemDateTime.createdAt: true
      cast(created as timestamp preserving type) as Created,
      @Semantics.systemDateTime.lastChangedAt: true
      cast(changed as timestamp preserving type) as Changed
     
      
}
