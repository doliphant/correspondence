class CorrespondencePolicy < ApplicationPolicy

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
        scope.all
        .where(private: false)
      else
        scope.where("correspondences.creator_id = ? OR correspondences.participant_id = ? OR correspondences.private = ?", user, user, false)
        .order('correspondences.created_at DESC')
      end
    end

  end


end
