class AddEventPerformancesView < ActiveRecord::Migration
  def up
    execute <<-SQL
      CREATE OR REPLACE VIEW festivity_event_performances AS
        SELECT
          performance.id AS performance_id, performance.start_date, performance.end_date,
          event.id AS event_id, event.title AS event_title, event.short_description, event.buy_url,
          event.featured_item, event.header, event.sub_header, location.id as location_id,
          location.slug AS location_slug, location.title AS location_title, location.festivity_directions_url,
          area.id AS area_id, area.slug as area_slug, area.title AS area_title
        FROM festivity_performances performance
        INNER JOIN pages event
          ON event.id = performance.event_page_id
        INNER JOIN pages location
          ON location.id = performance.location_page_id
        INNER JOIN pages area
          ON area.id = location.parent_id
    SQL

  end

  def down
    execute 'DROP VIEW festivity_event_performances'
  end
end


