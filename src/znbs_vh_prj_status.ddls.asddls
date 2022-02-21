@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help for Project Status'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.resultSet.sizeCategory: #XS


define view entity ZNBS_VH_PRJ_STATUS
  as select from znbs_prj_status
{
        @UI.hidden: true
        @ObjectModel.text.element: ['ProjectStatus']
  key   projectstatusid as ProjectstatusId,

        @UI:{ lineItem:       [ { position: 20, label: 'PfPos' } ],
              identification:      [ { position: 20, label: 'PfPos' } ],
              selectionField: [ { position: 20 }]}
  key   flowposition    as Flowposition,
        @UI.hidden: true
        statustype      as Statustype,
        projectstatus   as Projectstatus
}

where
  statustype = 'Project Status'
group by flowposition, projectstatusid,statustype,projectstatus
