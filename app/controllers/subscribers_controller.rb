class SubscribersController < ApplicationController
  def create
    @subscriber = Subscriber.new(email: params[:email])
    if @subscriber.save
      redirect_to root_path, notice: "You have been subscribed successfully!"
    else
      redirect_to root_path, alert: @subscriber.errors.full_messages.join(", ")
    end
  end

  def unsubscribe
    @subscriber = Subscriber.find_by(token: params[:token])
    if @subscriber
      @subscriber.unsubscribe!
      render :unsubscribed
    else
      redirect_to root_path, alert: "Invalid unsubscribe link."
    end
  end
end
