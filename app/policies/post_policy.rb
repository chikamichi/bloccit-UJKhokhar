class PostPolicy < ApplicationPolicy
  class Scope < Scope
    # If there is no user, resolves with no records.
    # If the user is a moderator or an admin, resolves with all records.
    # Otherwise, resolves with records owned by the user only.
    def resolve
      return scope.none unless user

      if user.moderator? or user.admin?
        scope.all
      else
        scope.where(user_id: user.id)
      end
    end
  end

  def index?
    true
  end

  def show?
    super && (record_owned_by_user? || user_is?('moderator', 'admin'))
  end

  def destroy?
    # Can I use this: super || user_is?('moderator')
    user_exists? && (record_owned_by_user? || user_is?('admin', 'moderator'))
  end
end
