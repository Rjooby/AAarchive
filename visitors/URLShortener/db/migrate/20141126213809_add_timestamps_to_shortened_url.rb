class AddTimestampsToShortenedUrl < ActiveRecord::Migration
  def change
    change_table :shortened_urls do |t|
      t.timestamps
    end
  end
end
