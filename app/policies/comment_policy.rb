class CommentPolicy < ApplicationPolicy
  def destroy?
    user_exists? && record_owned_by_user? || (user_is?('admin', 'moderator'))
  end
end