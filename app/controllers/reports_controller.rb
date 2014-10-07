class ReportsController < ApplicationController
  before_filter :session_required

  def show
    options = { grouper: GroupedFiles, weighter: WeighingScale }
    files   = WorkshareFileRetrieval.files current_session

    @report = WorkshareFileReport.new files, options
  end
end
