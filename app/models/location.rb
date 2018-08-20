class Location < ApplicationRecord
    validates_uniqueness_of :name
    has_many :users
    has_many :products
    
    
end 
