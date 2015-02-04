class AddMarketAndEventFields < ActiveRecord::Migration
  def up
    # page parts sponsor_area, video, description
    # fields
    # media(linking table?)

    # Event Fields
    add_column :pages, :featured_item, :boolean
    add_column :pages, :buy_url, :string

    # Market Fields
    add_column :pages, :booth_number, :string
    add_column :pages, :area_id, :integer
    add_column :pages, :maket_start_date, :date
    add_column :pages, :market_end_date, :date

  end

  def down

    # Event Fields
    remove_column :pages, :featured_item
    remove_column :pages, :buy_url

    # Market Fields
    remove_column :pages, :booth_number
    remove_column :pages, :area_id
    remove_column :pages, :market_start_date
    remove_column :pages, :market_end_date

  end
end
