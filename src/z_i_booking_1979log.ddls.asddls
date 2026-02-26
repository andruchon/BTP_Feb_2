@AbapCatalog.sqlViewName: 'ZVBOOK_1979LOG'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Interface - Booking'
//@Metadata.ignorePropagatedAnnotations: true
define view Z_I_BOOKING_1979LOG
  as select from zbooking_1979log as Booking
  composition [0..*] of Z_I_BOOKSUPPL_1979LOG as _BookingSupplement
  association        to parent Z_I_TRAVEL_1979LOG    as _Travel on $projection.travel_id = _Travel.travel_id
  association [1..1] to /DMO/I_Customer       as _Customer      on $projection.customer_id = _Customer.CustomerID
  association [1..1] to /DMO/I_Carrier        as _Carrier       on $projection.carrier_id = _Carrier.AirlineID
  association [1..*] to /DMO/I_Connection     as _Connection    on $projection.connection_id = _Connection.ConnectionID
{
  key travel_id,
  key booking_id,
      booking_date,
      customer_id,
      carrier_id,
      connection_id,
      flight_date,
      flight_price,
      currency_code,
      booking_status,
      last_change_at,
      _Travel,
      _BookingSupplement,
      _Customer,
      _Carrier,
      _Connection
}
