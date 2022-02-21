@EndUserText.label: 'Custom Entity view for ZNBS_PRJ_RQ'
@ObjectModel.query.implementedBy: 'ABAP:ZCL_CUSTOMENTITY'
@UI: {
  headerInfo: {
  typeName: 'Project',
  typeNamePlural: 'Projects'
  }
}
@Search.searchable: true
define custom entity ZNBS_I_PRJ_RQ_CHDO
{

      @UI.facet          : [
               {
                 id      :    'Project',
                 purpose :     #STANDARD,
                 type    :     #IDENTIFICATION_REFERENCE,
                 label   :    'Project',
                 position: 10 }
             ]
             
             
      @UI                : {
      lineItem           : [{position: 10, label: 'Document Number', importance: #HIGH}],
      identification     : [{position: 10, label: 'Document Number'}]
      }
key   changenr           : abap.char( 12 );

      @UI                : {
      lineItem           : [{position: 11, importance: #HIGH}],
      identification     : [{position: 11}]
      }
      @Search.defaultSearchElement: true
      projectuuid        : sysuuid_x16;
             
      @UI                : {
      lineItem           : [{position: 12, importance: #HIGH}],
      identification     : [{position: 12}]
      }
      @Search.defaultSearchElement: true
      projectid          : znbs_projectid;
      @UI                : {
          lineItem       : [{position: 20, importance: #HIGH}],
          identification : [{position: 20}]
          }
      @Search.defaultSearchElement: true    
      projectdescription    : znbs_projectdesc;

      @UI                : {
      lineItem           : [{position: 40, label: 'Change Document Item', importance: #HIGH}],
      identification     : [{position: 40, label: 'Change Document Item'}]
      }
      chngind               : abap.char( 1 );
      @UI                : {
      lineItem           : [{position: 50, label: 'Old Value', importance: #HIGH}],
      identification     : [{position: 50, label: 'Old Value'}]
      }
      f_old                 : abap.char( 254 );
      @UI                : {
      lineItem           : [{position: 60, label: 'New Value', importance: #HIGH}],
      identification     : [{position: 60, label: 'New Value'}]
      }
      f_new                 : abap.char( 254 );
      @UI                : {
      lineItem           : [{position: 70, label: 'User', importance: #HIGH}],
      identification     : [{position: 70, label: 'User'}]
      }
      username : abap.char(12);
      @UI                : {
      lineItem           : [{position: 80, label: 'Date', importance: #HIGH}],
      identification     : [{position: 80, label: 'Date'}]      
      }
      udate : abap.dats;
      @UI                : {
      lineItem           : [{position: 90, label: 'Time', importance: #HIGH}],
      identification     : [{position: 90, label: 'Time'}]      
      }
      utime : abap.tims;
      @UI                : {
      lineItem           : [{position: 100, label: 'Field Name', importance: #HIGH}],
      identification     : [{position: 100, label: 'Field Name'}]      
      }
      fname : abap.char(30) ;    

}
