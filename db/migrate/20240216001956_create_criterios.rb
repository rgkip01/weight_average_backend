# frozen_string_literal: true

class CreateCriterios < ActiveRecord::Migration[7.1]
  def change
    create_table :criterios do |t|
      t.float :peso

      t.timestamps
    end
  end
end
