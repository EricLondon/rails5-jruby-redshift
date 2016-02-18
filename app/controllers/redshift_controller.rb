class RedshiftController < ApplicationController
  def index
    @table_names = Redshift.tables.map {|table| table['table_name'] }

    if params[:table_name].present? && @table_names.include?(params[:table_name])
      @table_data = Redshift.load_table params[:table_name]
    end
  end
end
