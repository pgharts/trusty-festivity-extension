class FixTypoInMarketStart < ActiveRecord::Migration
  def up

    rename_column :pages, :maket_start_date, :market_start_date

  end

  def down

    rename_column :pages, :market_start_date, :maket_start_date

  end
end
