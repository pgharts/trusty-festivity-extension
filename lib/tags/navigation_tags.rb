module Tags::NavigationTags
  include TrustyCms::Taggable


  desc %{One Column Subnavigation Tag

          *Usage:*
<pre><r:subnav_one_column /></pre>
}
  tag "subnav_one_column" do |tag|
    request.env["action_controller.instance"].render_to_string :partial => "navigation/subnav_one_column",
                                                               :locals => {:current_page => tag.locals.page,
                                                                           :top_level_page => top_level_page(tag.locals.page)}
  end

  desc %{Two Column Subnavigation Tag

          *Usage:*
<pre><r:subnav_two_column /></pre>
}
  tag "subnav_two_column" do |tag|
    request.env["action_controller.instance"].render_to_string :partial => "navigation/subnav_two_column",
                                                               :locals => {:current_page => tag.locals.page,
                                                                           :top_level_page => top_level_page(tag.locals.page)}
  end

  desc %{Three Column Subnavigation Tag

          *Usage:*
<pre><r:subnav_three_column show_detail="true" /></pre>

show_detail will display the page abstract and a Read More link.
}
  tag "subnav_three_column" do |tag|

    request.env["action_controller.instance"].render_to_string :partial => "navigation/subnav_three_column",
                                                               :locals => {:current_page => tag.locals.page,
                                                                           :top_level_page => top_level_page(tag.locals.page),
                                                                           :show_detail => show_detail(tag.attr["show_detail"])}
  end


  def top_level_page(page)
    page = page.parent while page.parent.slug != '/'
    page
  end

  def show_detail(show_detail)
    if show_detail
      return show_detail.downcase == "true" ? true : false
    end
  end

end

