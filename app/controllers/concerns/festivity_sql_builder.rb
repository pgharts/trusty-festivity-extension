module Concerns
  module FestivitySqlBuilder

    extend ActiveSupport::Concern

    included do

      # Create a condition for start and end date between midnight and 11:59pm
      # for each date passed in and return the SQL condition
      def self.datetime_criteria(datetimes_string, filter_type)
        date_queries = datetimes_string.split(',').map do |date_string|
          start_date = Chronic.parse(URI.decode(date_string)).utc
          end_date = start_date.advance(advance_by(filter_type))
          <<-SQL
        (
          (start_date >= '#{start_date}' AND start_date <= '#{end_date}')
          OR
          (end_date >= '#{start_date}' AND end_date <= '#{end_date}')
        )
          SQL
        end
        date_queries.join(" OR ")
      end

      def self.advance_by(filter_type)
        advance_by_hash = {minutes: 59}
        advance_by_hash[:hours] = 23 if filter_type == "date"
        advance_by_hash
      end

      def self.parse_categories(category_ids)
        grouped_ids = FestivityCategory.find(category_ids).group_by {|category| category.festivity_category_type}
        category_clauses = grouped_ids.map do |categories|
          "page_id IN (SELECT page_id FROM festivity_page_categories WHERE festivity_category_id IN (#{categories[1].map {|category| category.id}.join(",")}))"
        end
        "(#{category_clauses.join(" AND ")})"

      end

    end
  end
end