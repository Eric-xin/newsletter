module Admin
  class NewslettersController < ApplicationController
    include AdminAuthenticated
    layout "admin"

    def index
      @newsletters = Newsletter.order(created_at: :desc)
    end

    def new
      @newsletter = Newsletter.new
    end

    def create
      @newsletter = Newsletter.new(newsletter_params)
      if @newsletter.save
        redirect_to admin_newsletter_path(@newsletter), notice: "Newsletter created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def show
      @newsletter = Newsletter.find(params[:id])
    end

    def edit
      @newsletter = Newsletter.find(params[:id])
    end

    def update
      @newsletter = Newsletter.find(params[:id])
      if @newsletter.update(newsletter_params)
        redirect_to admin_newsletter_path(@newsletter), notice: "Newsletter updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @newsletter = Newsletter.find(params[:id])
      @newsletter.destroy
      redirect_to admin_newsletters_path, notice: "Newsletter deleted."
    end

    def send_newsletter
      @newsletter = Newsletter.find(params[:id])
      if @newsletter.draft?
        @newsletter.update!(status: "sending")
        NewsletterSendJob.perform_later(@newsletter.id)
        redirect_to admin_newsletter_path(@newsletter), notice: "Newsletter is being sent."
      else
        redirect_to admin_newsletter_path(@newsletter), alert: "Newsletter has already been sent or is being sent."
      end
    end

    def preview
      render html: params[:body].html_safe, layout: false
    end

    private

    def newsletter_params
      params.require(:newsletter).permit(:subject, :body, :is_public)
    end
  end
end
