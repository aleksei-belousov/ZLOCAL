@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Invoice Table'
define root view entity ZI_INVOICETABLE as select from zinvoicetable
{
  key invoice               as Invoice,

      comments              as Comments,

      @Semantics.largeObject:
      { mimeType: 'MimeType',
      fileName: 'FileName',
      contentDispositionPreference: #INLINE }
      attachment            as Attachment,

      @Semantics.mimeType: true
      mimetype              as MimeType,
      filename              as FileName,

      @Semantics.largeObject:
      { mimeType: 'MimeType1',
      fileName: 'FileName1',
      contentDispositionPreference: #INLINE }
      xdp                   as XDP,

      @Semantics.mimeType: true
      mimetype1             as MimeType1,
      filename1             as FileName1,

      @Semantics.largeObject:
      { mimeType: 'MimeType2',
      fileName: 'FileName2',
      contentDispositionPreference: #INLINE }
      pdf                   as PDF,

      @Semantics.mimeType: true
      mimetype2             as MimeType2,
      filename2             as FileName2,

      @Semantics.user.createdBy: true
      local_created_by      as LocalCreatedBy,

      @Semantics.systemDateTime.createdAt: true
      local_created_at      as LocalCreatedAt,

      @Semantics.user.lastChangedBy: true
      local_last_changed_by as LocalLastChangedBy,

      //local ETag field --> OData ETag

      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,

      //total ETag field

      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt
}
