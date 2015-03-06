class CommentPolicy < ApplicationPolicy

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
