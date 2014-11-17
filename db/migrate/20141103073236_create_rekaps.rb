class CreateRekaps < ActiveRecord::Migration
  def change
    create_table :rekaps do |t|
      t.integer    :jumlah_suara
      t.string      :presentase
      t.integer    :urut
      t.string      :pasangan
      t.integer    :provinsi_id
    end
    add_index :rekaps, [:urut, :provinsi_id]
  end
end
