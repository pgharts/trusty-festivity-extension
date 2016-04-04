class ChangeMarketDatesToDatetime < ActiveRecord::Migration
  def up

    remove_column :pages, :market_start_date
    remove_column :pages, :market_end_date
    add_column :pages, :market_start_date, :datetime
    add_column :pages, :market_end_date, :datetime

  end

  def down

    remove_column :pages, :market_start_date
    remove_column :pages, :market_end_date
    add_column :pages, :market_start_date, :date
    add_column :pages, :market_end_date, :date

  end
end


