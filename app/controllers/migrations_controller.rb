class MigrationsController < ApplicationController
  def run
    begin
      ActiveRecord::MigrationContext.new(
        ActiveRecord::Migrator.migrations_paths,
        ActiveRecord::SchemaMigration
      ).migrate

      render plain: "Migrations ran successfully."
    rescue => e
      render plain: "Error running migrations: #{e.message}"
    end
  end
end
