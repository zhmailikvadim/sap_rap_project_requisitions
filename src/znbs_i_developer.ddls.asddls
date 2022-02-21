@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Developers BO View'
@ObjectModel.resultSet.sizeCategory: #XS

define root view entity ZNBS_I_DEVELOPER
  as select from znbs_developer as Developer
{
      @ObjectModel.text.element: ['DeveloperName']
  key developeruuid        as DeveloperUUID,
      developername        as DeveloperName,
      developerdescription as DeveloperDescription,
      developeremail       as DeveloperEmail
}
