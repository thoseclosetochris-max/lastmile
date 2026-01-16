# LastMile P2P Logistics

A Flutter + Firebase reference implementation for a peer-to-peer logistics marketplace that matches movers with delivery jobs using an optimization formula. The project includes a Flutter mobile app, Firebase Cloud Functions, Firestore rules, and sample data for local testing.

## Repository Structure

- `frontend/` - Flutter mobile app (iOS/Android).
- `backend/functions/` - Firebase Cloud Functions (Node.js).
- `backend/firestore/` - Firestore rules and indexes.
- `docs/` - Schema notes, API integration details, and UX notes.

## Features

- User registration with roles (hirer or mover), vehicle/license verification flags, and ratings.
- Job posting with location, size/weight, urgency, handling requirements, and budget.
- Matching algorithm using a proprietary weighted scoring model.
- Bidding workflow with optimization score and suggested pricing.
- Stripe payment placeholders and escrow concept.
- Real-time tracking and notifications (modeled, uses mock data in UI).
- Admin dashboard for monitoring disputes and optimization tuning.
- Retailer integration simulation (webhooks for Walmart/Best Buy shipments).
- GDPR-style privacy and insurance prompts.

## Quick Start

### Flutter App

```bash
cd frontend
flutter pub get
flutter run
```

> The Flutter UI uses mock data from `lib/services/mock_data.dart`. Integrate Firebase SDKs in `lib/services/firebase_service.dart` when ready.

### Firebase Functions

```bash
cd backend/functions
npm install
npm run serve
```

### Firebase Emulators (optional)

```bash
firebase emulators:start --only functions,firestore
```

## Environment Variables

For production integration, create a `.env` file in `backend/functions`:

```
GOOGLE_MAPS_API_KEY=your-key
STRIPE_SECRET_KEY=your-key
WALMART_WEBHOOK_SECRET=your-secret
BESTBUY_WEBHOOK_SECRET=your-secret
```

## Testing

No automated tests are included. Run the app and inspect UI screens. Use `npm run lint` for function linting.

## Patent + Compliance Notice

The optimization formula in this repo is a demonstrative scoring model and not a real patented implementation. Ensure compliance with GDPR/CCPA and local insurance regulations before production use.
