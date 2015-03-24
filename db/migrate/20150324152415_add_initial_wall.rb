class AddInitialWall < ActiveRecord::Migration
  def change
    Wall.create
  end
end
