class PublicController < ApplicationController
  layout 'public'

  before_action :find_work, only: [:show, :show_process]
  before_action :set_og_tag_site_name

  def about
    @og_title = "About Moyu Zhang"
    @og_type = 'profile'
    @og_url = about_url
    @og_image = view_context.asset_url('moyuzhang.jpg')
    @og_description = 'About Moyu Zhang'
  end

  def contact
    @og_title = "Contact Moyu Zhang"
    @og_type = 'profile'
    @og_url = contact_url
    @og_image = view_context.asset_url('contact.jpg')
    @og_description = 'Contact Moyu Zhang'
  end

  def index
    @works = Work.visible.sorted
    @og_title = "Moyu Zhang Design"
    @og_type = 'website'
    @og_url = root_url
    @og_image = view_context.asset_url('moyuzhang_seal.png')
    @og_description = 'Works of Moyu Zhang'
  end

  def show
    unless @work.visible
      redirect_to action: :index
    end
    @pictures = @work.pictures.sorted
    @process_picture_count = @work.process_pictures.count
  end

  def show_process
    unless @work.visible
      redirect_to action: :index
    end
    @pictures = @work.process_pictures.sorted
    render 'show'
  end

  private
    def find_work
      @work = Work.find(params[:id])
      set_og_tags(@work)
    end

    def set_og_tags(work)
      @og_title = work.name
      @og_type = 'article'
      @og_url = work_url(@work)
      @og_image = URI.join(request.url, work.thumbnail.url(:large))
      @og_description = work.description
    end

    def set_og_tag_site_name
      @og_site_name = 'Moyu Zhang Design'
    end

end
