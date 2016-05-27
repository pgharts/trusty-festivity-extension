require 'spec_helper'

RSpec.describe FestivityEventPage, :type => :model do
  before do
    Site.destroy_all
    FestivityEventPage.destroy_all
  end

  before do
    @site = FactoryGirl.create(:site)
    @festivity_event = FactoryGirl.create(:festivity_event_page, site_id: @site.id)
  end

  it "has a valid factory" do
    FactoryGirl.create(:festivity_event_page, title: "Degrees of Separation", site_id: @site.id).should be_valid
  end

  it "has the right relationship between the event page and site" do
    expect(@festivity_event.site).to eq(@site)
  end
end