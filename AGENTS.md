# Repository Guidelines

## Project Structure & Module Organization
- `app/`: Rails MVC code — `controllers/`, `models/`, `views/`; assets in `app/assets/` (images, styles) and JS in `app/javascript/` (importmap + Stimulus).
- `config/`: environment, credentials, and router (`routes.rb`).
- `db/`: migrations and schema; test/dev databases use SQLite by default.
- `test/`: Minitest suites (`controllers/`, `models/`, `system/`, etc.).
- `bin/`: developer tools (`dev`, `setup`, `rails`, `rubocop`, `brakeman`).
- Deployment: `.kamal/` (Kamal deploy), `Dockerfile` (container build), `config.ru` (Rack entry).

## Build, Test, and Development Commands
- `bin/setup`: install gems, prepare DB, clear logs, then start the server.
- `bin/dev`: run the Rails 8 server locally at `http://localhost:3000`.
- `bin/rails db:prepare`: create/migrate databases for dev/test.
- `bin/rails test`: run unit/integration tests; `bin/rails test:system` for system specs.
- `bin/rubocop`: lint/style check; `bin/brakeman`: security scan.
- Optional: `bin/kamal` for deploy tasks; Docker example: `docker build -t blog . && docker run -p 3000:3000 blog`.

## Coding Style & Naming Conventions
- Ruby `3.2.2`, Rails `~> 8.0`. Use 2-space indentation, UTF-8, no trailing whitespace.
- Follow RuboCop Rails Omakase (`.rubocop.yml`). Run `bin/rubocop` before pushing.
- Classes/Modules: `CamelCase`; methods/variables: `snake_case`; constants: `SCREAMING_SNAKE_CASE`.
- Rails conventions: RESTful controllers, singular model names, migrations in `db/migrate/`.
- File naming mirrors code (e.g., `app/models/post.rb` with tests in `test/models/post_test.rb`).

## Testing Guidelines
- Framework: Minitest; system tests use Capybara + Selenium.
- Name tests `*_test.rb`; keep tests close to their subject (`test/models`, `test/controllers`).
- Add tests for new behavior and fixed bugs; prefer fast unit tests, reserve system tests for critical flows.
- Run locally with `bin/rails test`; ensure DB is prepared via `bin/rails db:prepare`.

## Commit & Pull Request Guidelines
- Commits: small, logical, imperative mood (e.g., "Add posts index").
- Branches: `feature/short-description` or `fix/issue-123`.
- PRs: include a clear description, linked issues, test steps, and screenshots/GIFs for UI changes.
- All checks must pass (tests, RuboCop, Brakeman). Call out migrations and any config changes.

## Security & Configuration Tips
- Do not commit secrets; use Rails credentials and/or `.kamal/secrets`.
- Prefer environment variables for deploy-time config; review `config/` for defaults.
