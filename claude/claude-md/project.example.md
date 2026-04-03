# Project: <project-name>

## Stack

- Language: TypeScript
- Framework: Next.js 14 (App Router)
- Database: PostgreSQL via Prisma
- Testing: Vitest + Playwright
- Package manager: pnpm

## Commands

- Build: `pnpm build`
- Test: `pnpm test`
- Lint: `pnpm lint`
- Dev server: `pnpm dev`
- Database migrations: `pnpm prisma migrate dev`

## Architecture

- `src/app/` — Next.js routes and pages
- `src/lib/` — Shared utilities and business logic
- `src/components/` — React components (barrel exports via index.ts)
- `src/server/` — Server-side services and API logic
- `prisma/` — Database schema and migrations

## Conventions

- API routes return `{ data, error }` shape consistently
- Use server actions for mutations, not API routes
- All database queries go through service files in `src/server/`
- Error boundaries at the route level, not per-component
- Feature flags via environment variables prefixed with `NEXT_PUBLIC_FF_`

## Important notes

- The auth middleware in `src/middleware.ts` handles session validation — don't bypass it
- Prisma client is singleton in `src/lib/db.ts` — always import from there
