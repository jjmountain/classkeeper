class PagesController < ApplicationController
  skip_before_action :authenticate!, only: [:home, :login, :signup]

  def home
  end

  def login
  end

  def dashboard
  end

  def signup
  end
end
