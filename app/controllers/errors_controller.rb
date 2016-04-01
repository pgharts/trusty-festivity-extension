class ErrorsController < ApplicationController
  trusty_layout 'base'

  def internal_server_error
    render(:status => 500)
  end
end
