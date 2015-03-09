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

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user == nil
        scope.where(private: false).order('discussions.created_at DESC')
      else
        scope.where("discussions.creator_id = ? OR discussions.participant_id = ? OR discussions.private = ?", user, user, false)
        .order('discussions.created_at DESC')
      end
    end

  end


end
