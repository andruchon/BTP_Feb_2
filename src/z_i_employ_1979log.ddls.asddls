@AbapCatalog.sqlViewName: 'ZV_EMPLO_1979LOG'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Employees'
//@Metadata.ignorePropagatedAnnotations: true
define root view Z_I_EMPLOY_1979LOG
  as select from zemploy_1979log as Employee
{
  key e_number,
      e_name,
      e_department,
      status,
      job_tittle,
      start_date,
      end_date,
      email,
      m_number,
      m_name,
      m_department,
      crea_date_time,
      crea_uname,
      lchg_date_time,
      lchg_uname
}
