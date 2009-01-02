ActiveRecord::ConnectionAdapters::SchemaStatements.module_eval do       
  def add_column_with_attachment(table_name, column_name, type, options = {})
    if type.to_s == 'attachment'
      PaperclipMigration.columns.each do |column|
        add_column(table_name, "#{column_name}#{column.first}", column.last, options)
      end
    else
      add_column_without_attachment(table_name, column_name, type, options)
    end
  end
  alias_method_chain :add_column, :attachment
  
  def remove_attachment_column(table_name, *column_names)
    column_names.flatten.each do |column_name|
      remove_column(PaperclipMigration.columns.map { |column| "#{column_name}#{column.first}" })
    end
  end
end

ActiveRecord::ConnectionAdapters::TableDefinition.class_eval do
  def column_with_attachment(name, type, options = {})
    if type.to_s == 'attachment'
      PaperclipMigration.columns.each do |column|
        column("#{column_name}#{column.first}", column.last, options)
      end
    else
      column_without_attachment(name, type, options)
    end
  end
  alias_method_chain :column, :attachment

  def attachment(*args)
    options = args.extract_options!
    column_names = args

    column_names.each do |name|
      PaperclipMigration.columns.each do |column|
        column("#{name}#{column.first}", column.last, options)
      end
    end
  end
end
