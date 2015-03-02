class SummaryController < ApplicationController
  def new
    @summary = Summary.new
  end

  def create
    @summary = current_user.summary.build(params.require(:summary).permit(:description))
  end

  def show
    @summary = Summary.find(params[:id])
  end
end
