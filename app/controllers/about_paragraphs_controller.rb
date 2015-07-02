class AboutParagraphsController < ApplicationController
  layout 'admin'

  before_action :confirm_logged_in
  #before_action :find_paragraph, except: [:new, :create, :index]

  #def new
    #@paragraph = AboutParagraph.new
    #@paragraph_count = AboutParagraph.count + 1
  #end

  #def create
    #@paragraph = AboutParagraph.new(paragraph_params)
    #if @paragraph.save
      #flash[:success] = "New About Paragraph created!"
      #redirect_to action: :index
    #else
      #flash[:error] = "Create new About Pragraph failed!"
      #@paragraph_count = AboutParagraph.count + 1
      #render 'new'
    #end
  #end

  #def index
    #@paragraphs = AboutParagraph.sorted
    #@paragraph_count = AboutParagraph.count
  #end

  def edit
    @paragraph = AboutParagraph.first
  end
  
  def update
    @paragraph = AboutParagraph.first
    if @paragraph.update_attributes(paragraph_params)
      flash[:success] = "About Paragraph updated!"
      redirect_to action: :edit
    else
      flash[:error] = "About Paragraph update failed!"
      render 'edit'
    end
  end

  #def destroy
    #@paragraph.destroy
    #flash[:alert] = "About Paragraph deleted!"
    #redirect_to action: :index
  #end

  private

  def paragraph_params
    params.require(:about_paragraph).permit(:position, :text)
  end

  #def find_paragraph
    #@paragraph = AboutParagraph.find(params[:id])
    #@paragraph_count = AboutParagraph.count
  #end
end
