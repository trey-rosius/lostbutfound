class Product < ApplicationRecord
  belongs_to :user
  belongs_to :location


  validates :name,presence: true, length: {minimum:3, maximum:50}
  validates :details,presence: true, length: {minimum:10, maximum:300}
  validates :user_id, presence: true
  validates :location_id, presence: true


  def self.search(param)
    param.strip!
    param.downcase!
    to_send_back = (owner_name_matches(param)).uniq
    return nil unless to_send_back
    to_send_back

  end
  def mark_as_retrieved
    update retrieved: !retrieved
   end

  def self.matches(field_name,param)
      Product.where("#{field_name} like ?", "%#{param}%")
    end

    def self.owner_name_matches(param)
      matches('owner_name',param)
    end
   
end
