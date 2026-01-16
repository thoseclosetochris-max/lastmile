# Retailer Integrations

This demo simulates retailer shipping exports via webhooks. Configure webhook targets to point to:

- `POST /createJobFromRetailer?retailer=walmart`
- `POST /createJobFromRetailer?retailer=bestbuy`

Payload example:

```json
{
  "reference": "WM-12345",
  "description": "2 TVs",
  "pickup": { "label": "Walmart DC", "latitude": 40.7, "longitude": -73.9 },
  "dropoff": { "label": "Customer", "latitude": 40.6, "longitude": -73.8 },
  "size": "Large",
  "weightKg": 180,
  "timeWindow": "Tomorrow, 10-12",
  "budget": 120,
  "handling": "Fragile"
}
```

Authentication can be added with shared secrets (`WALMART_WEBHOOK_SECRET`, `BESTBUY_WEBHOOK_SECRET`).
