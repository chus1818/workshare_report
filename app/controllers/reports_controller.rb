class ReportsController < ApplicationController
  before_filter :session_required

  def show
    options = { grouper: GroupedFiles, weighter: WeighingScale }
    @report = WorkshareFileReport.new WorkshareFileRetrieval.files, options
  end
end
