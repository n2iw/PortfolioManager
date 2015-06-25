class AboutController < ApplicationController
  layout 'admin'

  before_action :confirm_logged_in
  before_action :find_about, except: [:new, :create, :index]

  def new
    @about = About.new
    @about_count = About.count + 1
  end

  def create
    @about = About.new(about_params)
    if @about.save
      flash[:notice] = "New About Paragraph created!"
      redirect_to edit_about_path(@about.id)
    else
      flash[:notice] = "Create new About Pragraph failed!"
      @about_count = About.count + 1
      render 'new'
    end
  end

  def index
    @paragraphs = About.sorted
    @about_count = About.count
  end

  def edit
  end

  def update
    if @about.update_attributes(about_params)
      flash[:notice] = "About Paragraph updated!"
      redirect_to action: :show
    else
      flash[:notice] = "About Paragraph update failed!"
      render 'edit'
    end
  end

  def update_position
    if @about.update_attributes(about_params)
      flash[:notice] = "About Paragraph updated!"
      redirect_to action: :index
    else
      flash[:notice] = "About Paragraph update failed!"
      redirect_to action: :index
    end
  end

  def delete
  end

  def destroy
    @about.destroy
    flash[:notice] = "About Paragraph deleted!"
    redirect_to action: :index
  end

  private

  def about_params
    params.require(:about).permit(:position, :paragraph)
  end

  def find_about
    @about = About.find(params[:id])
    @about_count = About.count
  end
end
