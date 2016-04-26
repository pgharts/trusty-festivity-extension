class ErrorsController < ApplicationController
  include Concerns::FestivityCustomPage

  def internal_server_error
    render(:status => 500)
  end
end
