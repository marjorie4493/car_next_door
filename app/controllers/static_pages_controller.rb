class StaticPagesController < ApplicationController
  before_action :logged_in?
  
  def contact
  end

  private
    def logged_in?
      redirect_to root_path unless is_logged_in?
    end
end
