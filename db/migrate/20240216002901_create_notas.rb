class CreateNotas < ActiveRecord::Migration[7.1]
  def change
    create_table :notas do |t|
      t.float :nota
      t.references :avaliacao, null: false, foreign_key: true
      t.references :criterio, null: false, foreign_key: true

      t.timestamps
    end
  end
end
