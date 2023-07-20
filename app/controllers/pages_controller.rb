class PagesController < ApplicationController
  def login
    # Logic here
  end

  def about
    # userArr = User.all
    @message = ['Number 1', 'number 2', 'number 3'] # testing
  end
end
