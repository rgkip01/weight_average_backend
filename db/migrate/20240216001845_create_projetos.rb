class CreateProjetos < ActiveRecord::Migration[7.1]
  def change
    create_table :projetos do |t|
      t.string :nome
      t.float :media_total

      t.timestamps
    end
  end
end
