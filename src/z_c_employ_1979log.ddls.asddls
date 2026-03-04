@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Employees'
@Metadata.allowExtensions: true
define root view entity Z_C_EMPLOY_1979LOG
  as projection on Z_I_EMPLOY_1979LOG
{
//      @ObjectModel.text.element: [ 'EmployeeName' ]
  key e_number,
      e_name,
      e_department,
      status,
      job_tittle,
      start_date,
      end_date,
      email,
//      @ObjectModel.text.element: [ 'ManagerName' ]
      m_number,
      m_name,
      m_department,
      @Semantics.systemDateTime.createdAt: true
      crea_date_time,
      @Semantics.user.createdBy: true
      crea_uname,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      lchg_date_time,
      @Semantics.user.lastChangedBy: true
      lchg_uname
}
