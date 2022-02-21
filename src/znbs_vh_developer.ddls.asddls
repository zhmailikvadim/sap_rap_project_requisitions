@AbapCatalog.sqlViewName: 'ZNBS_VH_DEVELOP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value help for reported by'
define view ZNBS_VH_DEVELOPER
  as select from ZNBS_I_DEVELOPER
{
      @UI.hidden: true
      @ObjectModel.text.element: ['DeveloperName']
  key DeveloperUUID,
      DeveloperName,
      DeveloperDescription,
      DeveloperEmail
}
