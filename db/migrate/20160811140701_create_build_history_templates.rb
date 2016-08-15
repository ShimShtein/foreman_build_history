class CreateBuildHistoryTemplates < ActiveRecord::Migration
  def change
    create_table :build_history_templates do |t|
      t.references :build_history_facet, index: true, foreign_key: true
      t.timestamp :request_time
      t.string :template_kind

      t.timestamps null: false
    end
  end
end
