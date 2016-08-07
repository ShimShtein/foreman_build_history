class CreateBuildHistoryFacets < ActiveRecord::Migration
  def change
    create_table :build_history_facets do |t|
      t.integer :host_id
      t.datetime :build_started
      t.datetime :build_finished

      t.timestamps null: false
    end
  end
end
