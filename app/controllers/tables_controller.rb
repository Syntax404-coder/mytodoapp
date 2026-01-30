class TablesController < ApplicationController
  before_action :require_login

  def index
    @tables = Table.where("start_time > ?", Time.current).order(:start_time)
  end
end
