require File.dirname(__FILE__) + '/paperclip_migration/rails_extensions/migration'

module PaperclipMigration
  mattr_accessor :columns
  
  self.columns = [
    [ '_file_name', 'string' ],
    [ '_content_type', 'string'],
    [ '_file_size', 'integer'],
    [ '_updated_at', 'datetime'],
    ]
end