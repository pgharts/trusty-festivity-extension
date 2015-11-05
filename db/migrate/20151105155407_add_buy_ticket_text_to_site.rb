class AddBuyTicketTextToSite < ActiveRecord::Migration
  def change
    add_column :sites, :festivity_buy_ticket_text, :string, default: "Buy Tickets"
  end
end
