module Concerns
  module FestivitySqlBuilder

    extend ActiveSupport::Concern

    included do

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