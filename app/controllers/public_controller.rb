class PublicController < ApplicationController
  def index
    @works = Work.visible.sorted
  end

  def show
    @work = Work.find(params[:id])
  end
end
