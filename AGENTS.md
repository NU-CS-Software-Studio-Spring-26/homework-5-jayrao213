# AGENTS.md

## Stack
Rails 8.1.3 sample todo app using SQLite 3 database. View layer is built using vanilla HTML/CSS, Rails' Propshaft asset pipeline, and Hotwire (Turbo-rails / Stimulus with ES modules via Importmaps). Test framework is standard ActiveSupport::TestCase / Minitest with Capybara & Selenium. Background jobs utilize database-backed engine Solid Queue.

## Commands
* **Setup**: `bin/setup` (installs dependencies and initializes the SQLite database)
* **Run Server**: `bin/dev` (runs the local web server and dev tasks)
* **Test Suite**: `bin/rails test` (runs the Minitest suite, including system and integration tests)
* **Linting**: `bin/rubocop` (performs Ruby styling and standard Rails lint checks)
* **Security Scanning**: `bin/brakeman` (runs static vulnerability analysis)

## Conventions
* **Naming**: Strict Rails standards (singular `Todo` model, plural `TodosController`, plural `todos` DB table). Controllers leverage the new Rails 8 `params.expect` syntax for parameter filtering.
* **Authorization**: No authorization or authentication layer is currently configured; all controller actions are public.
* **Responses**: Resource controllers respond to both `HTML` and `JSON` formats via traditional `respond_to` blocks.
* **Shared Partials**: Reusable components and layout pieces must go under `app/views/shared/` or `app/views/layouts/`.

## Don'ts
* **No adding new gems without explicit approval**: Keep dependencies clean and do not modify the `Gemfile` unless authorized.
* **No bypassing strong parameters**: Never access raw params directly; always use the Rails 8 `params.expect` convention in controller actions.
* **No inline scripts or styles in views**: Keep CSS inside stylesheets compiled by Propshaft, and encapsulate javascript logic in Stimulus controllers.
* **No seeding raw user data**: Do not run manual seeds or inline migration data; keep all seed logic within `db/seeds.rb`.
