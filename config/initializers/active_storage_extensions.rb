# frozen_string_literal: true

module AttachmentsExtension
  extend ActiveSupport::Concern

  included do
    include ULID::Rails

    ulid :id, auto_generate: true
    ulid :record_id
    ulid :blob_id
  end
end

module BlobsExtension
  extend ActiveSupport::Concern

  included do
    include ULID::Rails

    ulid :id, auto_generate: true
  end
end

module VariantRecordsExtension
  extend ActiveSupport::Concern

  included do
    include ULID::Rails

    ulid :id, auto_generate: true
    ulid :blob_id
  end
end

Rails.configuration.to_prepare do
  ActiveStorage::Attachment.include AttachmentsExtension
  ActiveStorage::Blob.include BlobsExtension
  ActiveStorage::VariantRecord.include VariantRecordsExtension
end
