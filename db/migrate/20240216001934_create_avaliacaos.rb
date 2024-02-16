class CreateAvaliacaos < ActiveRecord::Migration[7.1]
  def change
    create_table :avaliacaos do |t|
      t.float :media_ponderada
      t.references :projeto, null: false, foreign_key: true

      t.timestamps
    end
  end
end
