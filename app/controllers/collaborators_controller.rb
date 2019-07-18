class CollaboratorsController < ApplicationController


  def new
    @collaborator = Collaborator.new
  end

# POST
  def create
    @collab_user = User.find_by(email: params[:add_collaborator])
    @wiki = Wiki.find(params[:wiki_id])
    if @wiki.collaborators.exists?(user_id: @collab_user.id)
      flash[:alert] = "This user is already a collaborator for this wiki."
      redirect_to @wiki
    else
      @collaborator = Collaborator.new(user_id: @collab_user.id, wiki_id: @wiki.id)
      @collaborator.save!
      flash[:notice] = "You have successfully added #{params[:add_collaborator]} as a collaborator."
      redirect_to @wiki
    end
  end


  def destroy
    @collab_user = User.find_by(email: params[:remove_collaborator])
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = @wiki.collaborators.where(user_id: @collab_user.id)
    if @collaborator
      @collaborator.destroy
      flash[:notice] = "You have successfully removed #{params[:remove_collaborator]} from this wiki."
      redirect_to @wiki
    else
      flash[:notice] = "Error, either: #{params[:remove_collaborator]} was spelled wrong, or #{params[:remove_collaborator]} is not a collaborator on this wiki."
      redirect_to @wiki
    end
  end

end
