@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Developers BO View'
@ObjectModel.resultSet.sizeCategory: #XS

define root view entity ZNBS_I_DEVELOPER_SEPARATE
  as select from znbs_developer as Developer
  composition [0..*] of ZNBS_I_DEVELOPER_PROFILES as _DeveloperProfiles
  composition [0..*] of ZNBS_I_DEVELOPER_EPICS as _DeveloperEpics

{
      @ObjectModel.text.element: ['DeveloperName']
  key developeruuid                              as DeveloperUUID,
      developername                              as DeveloperName,
      developerdescription                       as DeveloperDescription,
      developeremail                             as DeveloperEmail,
      @Semantics.systemDateTime.createdAt: true
      cast(created as timestamp preserving type) as Created,
      @Semantics.systemDateTime.lastChangedAt: true
      cast(changed as timestamp preserving type) as Changed,

      _DeveloperProfiles,
      _DeveloperEpics
}
