@EndUserText.label: 'Invvoice Table'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define root view entity ZC_INVOICE_TABLE
  provider contract transactional_query
  as projection on ZI_INVOICETABLE
{
  key Invoice,
      Comments,
      Attachment,
      MimeType,
      FileName,
      XDP,
      MimeType1,
      FileName1,
      PDF,
      MimeType2,
      FileName2,
      LocalLastChangedAt
}
