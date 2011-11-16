# Rails 3 style validation:
class UniqueDJValidator < ActiveModel::Validator
  def validate(record)
    
    if record.payload_object.respond_to?(:unique?) && record.new_record?
      if record.payload_object.unique?
        if DJ.where(:worker_class_name => record.payload_object.worker_class_name, :finished_at => nil).count > 0
          record.errors.add(:base, "Only one #{record.payload_object.worker_class_name} can be queued at a time!")
        end
      end
    end
  end
end

Delayed::Worker.backend.send(:class_eval) do
  # Lars: Removed - it failed, and we're not using it - 2011-11-16
  # validates_with UniqueDJValidator
end