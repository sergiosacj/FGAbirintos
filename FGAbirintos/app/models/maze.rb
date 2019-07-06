class Maze < ApplicationRecord
    has_many :commentaries
    belongs_to :user
end
