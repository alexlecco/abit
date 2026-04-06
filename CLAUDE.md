# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
bin/dev                  # Start dev server (Rails + Tailwind watcher via Foreman)
rspec                    # Run all tests
rspec spec/path/to_spec.rb  # Run a single test file
bin/rubocop              # Ruby linting (inherits Omakase Rails rules)
bin/brakeman             # Security scan
bin/ci                   # Full CI pipeline: rubocop + bundler-audit + importmap audit + brakeman
bin/rails db:migrate     # Run migrations
```

## Architecture

**Core models:**
- `User` — Devise-authenticated with Google OAuth; has_many habits and habit_logs
- `Habit` — belongs to user; tracks `current_streak`, `longest_streak`, `start_date`, `color`, `active`
- `HabitLog` — records daily completions via `completed_on` date (unique per habit per day)

**Controllers:**
- `DashboardController#index` — root page, renders 30-day habit grid
- `HabitsController` — CRUD; destroy archives rather than deletes
- `HabitLogsController` — create/destroy via AJAX (Turbo Streams) for toggling day cells
- `LocalesController` — switches `I18n.locale` (en/es)
- `Users::OmniauthCallbacksController` — Google OAuth2 callback

**Authorization:** Pundit policies in `app/policies/`. `ApplicationPolicy` denies everything by default; always scope queries via `policy_scope`.

**Frontend:** No Node/bundler — uses Importmap + Propshaft. Hotwire (Turbo + Stimulus) for interactivity. Tailwind CSS v4 via `tailwindcss-rails`. Dark theme throughout (slate-900/800 background, teal accents).

**Localization:** English and Spanish (`config/locales/en.yml`, `es.yml`). All user-facing strings should use `t()` helpers.

**Background jobs / caching:** Solid Queue, Solid Cache, Solid Cable — all database-backed (no Redis needed).

**Auth:** Devise with `database_authenticatable`, `recoverable`, `rememberable`, `validatable`, plus OmniAuth Google OAuth2 (popup flow). Mailer sender: `noreply@abit.app`.

**Deployment:** Kamal (Docker) and Render (`render.yaml`).
