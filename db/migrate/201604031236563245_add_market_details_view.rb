class AddMarketDetailsView < ActiveRecord::Migration
  def up
    execute <<-SQL
      CREATE OR REPLACE VIEW festivity_market_details AS
        SELECT
          market.id AS market_id, market.title AS market_title, market.short_description,
          market.header, market.sub_header, market.site_id,
          market.market_start_date as start_date, market.market_end_date as end_date,
          area.id AS area_id, area.slug as area_slug, area.title AS area_title
        FROM pages market
        INNER JOIN pages area
          ON area.id = market.area_id
    SQL

  end

  def down
    execute 'DROP VIEW festivity_market_details'
  end
end


