class CommentPolicy < ApplicationPolicy

  def create?
    user.present? && !user.in_discussion?(record.discussion)
  end

  def new?
    create?
  end

  def update?
    user.present? && (record.user == user)
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end

end
