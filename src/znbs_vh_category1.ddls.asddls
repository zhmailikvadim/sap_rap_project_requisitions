@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value help for Category1'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZNBS_VH_CATEGORY1
  as select from znbs_i_categories
{
      @UI.hidden: true
      @ObjectModel.text.element: ['Name']
  key Uuid,
      @UI.hidden: true
      Type,
      Name
}
