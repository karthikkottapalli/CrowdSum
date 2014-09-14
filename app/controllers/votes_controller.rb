class VotesController < ApplicationController
  before_action :load_post_and_vote

  def up_vote
    update_vote!(1)    
  end

  def down_vote
    update_vote!(-1)
  end

  private

  def load_post_and_vote
    @post = Post.find(params[:post_id])
    @vote = @post.votes.where(user_id: current_user.id).first
  end

  def update_vote!(vote_val)
    if @vote 
      authorize @vote, :update?
      @vote.update_attribute(:value, vote_val)
    else
      @vote = current_user.votes.build(value: vote_val, post: @post)
      authorize @vote, :create?
      @vote.save
    end
    redirect_to :back
  end
end