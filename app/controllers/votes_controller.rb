class VotesController < ApplicationController

  def index
    @votes = Vote.all
  end

  def create
    if session[:user_id]
      @user = User.find(session[:user_id])
      @vote = Vote.new(user_id: @user.id, work_id: params[:work_id])
      if @vote.save
        flash[:success] = "You've successfully upvoted for #{@work.title}."
      else
        flash[:error] = "Looks like you've already voted for #{@work.title}."
        redirect_to works_path
        return
      end
    elsif session[:user_id] == nil
      flash[:error] = "Error! You must logged in to vote."
      redirect_to works_path
  end

  def vote_params
    return params.require(:vote).permit(:user_id, :work_id)
  end

end
