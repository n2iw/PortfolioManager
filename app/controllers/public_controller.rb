class PublicController < ApplicationController
  layout 'public'

  def index
    @works = Work.visible.sorted
  end

  def show
    @work = Work.find(params[:id])
    unless @work.visible
      redirect_to action: :index
    end
    @pictures = @work.pictures.sorted
  end
end
