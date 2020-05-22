class CreateSetups < ActiveRecord::Migration[6.0]
  def change
    create_table :setups do |t|
      t.string :reqOne
      t.string :reqTwo
      t.string :reqThree
      t.string :reqFour
      t.string :reqFive
      t.string :reqSix
      t.string :reqSeven
      t.string :reqEight
      t.string :reqNine
      t.string :reqTen

      t.timestamps
    end
  end
end
