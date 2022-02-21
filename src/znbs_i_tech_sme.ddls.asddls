@AbapCatalog.viewEnhancementCategory: [#NONE]
@EndUserText.label: 'Technical SME view'
@AccessControl.authorizationCheck: #CHECK
define root view entity ZNBS_I_TECH_SME
  as select from znbs_tech_sme
{
  key technicalsmeid as TechnicalSMEID,
      technicalsme   as TechnicalSME
}
