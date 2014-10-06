class ReportsController < ApplicationController
  before_filter :session_required

  def show
    @report = WorkshareFileReport.new WorkshareFileRetrieval.files
  end
end
