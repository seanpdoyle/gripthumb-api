Paperclip::Attachment.default_options.merge!(
  url: "/system/:class/:attachment/:id/:style/:filename",
  s3_credentials: {
    bucket: ENV['S3_BUCKET'],
    access_key_id: ENV['S3_ACCESS_KEY_ID'],
    secret_access_key: ENV['S3_SECRET_ACCESS_KEY']
  }
)

if Rails.env.staging? || Rails.env.production?
  Paperclip::Attachment.default_options.merge!(
    storage: :s3
  )
end
