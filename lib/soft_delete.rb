require "soft_delete/version"
require "active_support"

module SoftDelete
  extend ActiveSupport::Concern

  included do
    scope :not_deleted, -> { where(deleted_at: nil) }
    scope :deleted, -> { where("#{table_name}.deleted_at IS NOT NULL").
      references(table_name.to_sym) }
  end

  # "remove" record from database but don't run callbacks
  def delete(type = :soft)
    if type == :soft
      touch(:deleted_at)
    elsif type == :hard
      super()
    end
  end

  def delete!
    delete(:hard)
  end

  def deleted?
    deleted_at.present?
  end

  # "remove" record from database and run callbacks
  def destroy(type = :soft)
    if type == :soft
      touch(:deleted_at)
    elsif type == :hard
      super()
    end
  end

  def destroy!
    destroy(:hard)
  end

  def restore
    update_attributes(deleted_at: nil)
  end
end
