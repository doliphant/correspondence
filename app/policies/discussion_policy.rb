class DiscussionPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    (scope.where(:id => record.id).exists? && !record.private) ||
    record.creator == user || record.participant == user
  end

  def update?
    user.present? && (record.creator == user || record.participant == user)
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end

end
