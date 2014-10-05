class ReportsController < ApplicationController
  before_filter :session_required

  def show
    @report = FileRetrieval.new.report
  end
end
