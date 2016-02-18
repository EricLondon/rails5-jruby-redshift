class Redshift < ActiveRecord::Base
  self.abstract_class = true
  establish_connection "redshift_#{Rails.env}".to_sym

  def self.create_active_record_models
    table_names.each do |table_name|
      Object.const_set(table_name.camelize, Class.new(Redshift) { self.table_name = table_name })
    end
  end

  def self.tables(options = {})
    options ||= {}
    options[:include_views] ||= false
    options[:table_schema_public_only] ||= true

    # base sql
    sql = 'select * from INFORMATION_SCHEMA.tables'

    # where clauses
    where = []
    where << "table_type != 'VIEW'" unless options[:include_views]
    where << "table_schema = 'public'" if options[:table_schema_public_only]
    sql << " where #{where.join(' and ')} " if where.present?

    # sql order
    sql << ' order by table_name asc '

    connection.execute sql
  end

  def self.table_names(options = {})
    tables(options).map { |t| t['table_name'] }
  end

  def self.load_table(table_name)
    raise 'Table does not exist' unless table_names.include? table_name

    klass = Object.const_get table_name.camelize
    klass.first(20)
  end

  create_active_record_models
end
