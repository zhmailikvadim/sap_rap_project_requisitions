@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value help for Sistems'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZNBS_VH_SYSTEMS
  as select from ZNBS_I_SYSTEMS
{
      @UI.hidden: true
      @ObjectModel.text.element: ['Systemids']
  key Uuid,
      Systemids
}
