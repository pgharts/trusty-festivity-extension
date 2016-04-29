module Tags::FilterAndMenuTags
  include TrustyCms::Taggable

  desc "Meta Tags"
  tag "festivity_mobile_menus" do |tag|
    if request.env["action_controller.instance"].class == FestivityEventsController && request.env["action_controller.instance"].action_name == "index"
      selected_dates = request.env["action_controller.instance"].params["dates"] ? FestivityDatetimeFilterPresenter.parse(request.env["action_controller.instance"].params["dates"].split(","), Page.current_site.festivity_filter_type) : []
      selected_categories = request.env["action_controller.instance"].params["categories"] ? request.env["action_controller.instance"].params["categories"].split(",") : []
      request.env["action_controller.instance"].render_to_string :partial => "festivity_events/filters",
                                                               :locals => {:selected_dates => selected_dates,
                                                                           :selected_categories => selected_categories}
    end
  end

  desc "Render homepage performances on an hourly basis"
  tag "homepage_performances" do |tag|
    request.env["action_controller.instance"].render_to_string :partial => "festivity_events/hourly"
  end
end
