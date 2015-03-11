class TopicPolicy < ApplicationPolicy

  def index?
    true
  end

  def create?
    user_exists? && user_is?('admin')
  end

  def update?
    create?
  end

  def show?
    record.public? || user_exists?
  end

end