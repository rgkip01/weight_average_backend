# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_02_16_002901) do
  create_table "avaliacaos", charset: "latin1", force: :cascade do |t|
    t.float "media_ponderada"
    t.bigint "projeto_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["projeto_id"], name: "index_avaliacaos_on_projeto_id"
  end

  create_table "criterios", charset: "latin1", force: :cascade do |t|
    t.float "peso"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notas", charset: "latin1", force: :cascade do |t|
    t.float "nota"
    t.bigint "avaliacao_id", null: false
    t.bigint "criterio_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["avaliacao_id"], name: "index_notas_on_avaliacao_id"
    t.index ["criterio_id"], name: "index_notas_on_criterio_id"
  end

  create_table "projetos", charset: "latin1", force: :cascade do |t|
    t.string "nome"
    t.float "media_total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "avaliacaos", "projetos"
  add_foreign_key "notas", "avaliacaos"
  add_foreign_key "notas", "criterios"
end
