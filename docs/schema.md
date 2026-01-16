# Firestore Schema (Reference)

## users
```
/users/{userId}
  name: string
  role: "hirer" | "mover" | "admin"
  rating: number
  vehiclesVerified: boolean
  licenseVerified: boolean
  completedJobs: number
```

## jobs
```
/jobs/{jobId}
  title: string
  description: string
  pickup: { label, latitude, longitude }
  dropoff: { label, latitude, longitude }
  size: string
  weightKg: number
  timeWindow: string
  budget: number
  handling: string
  status: "open" | "matched" | "in_transit" | "delivered"
  retailer: string | null
  createdAt: timestamp
```

## bids
```
/jobs/{jobId}/bids/{bidId}
  moverId: string
  price: number
  etaMinutes: number
  optimizationScore: number
```

## tracking
```
/jobs/{jobId}/tracking/{trackId}
  latitude: number
  longitude: number
  updatedAt: timestamp
```
