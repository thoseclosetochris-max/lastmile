const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();

const optimizationScore = ({
  capacityUtilization,
  routeEfficiency,
  timeCompliance,
  ecoFactor,
}) => {
  return (
    capacityUtilization * 0.4 +
    routeEfficiency * 0.3 +
    timeCompliance * 0.2 +
    ecoFactor * 0.1
  );
};

exports.scoreJobMatch = functions.https.onRequest(async (req, res) => {
  const payload = req.body || {};
  const score = optimizationScore({
    capacityUtilization: Number(payload.capacityUtilization || 0),
    routeEfficiency: Number(payload.routeEfficiency || 0),
    timeCompliance: Number(payload.timeCompliance || 0),
    ecoFactor: Number(payload.ecoFactor || 0),
  });

  res.json({
    score,
    notes: 'Demo scoring model for patented optimization formula.',
  });
});

exports.createJobFromRetailer = functions.https.onRequest(async (req, res) => {
  const retailer = req.query.retailer || 'unknown';
  const shipment = req.body || {};

  const job = {
    title: `Retail shipment: ${shipment.reference || 'unknown'}`,
    description: shipment.description || 'Retailer provided shipment.',
    pickup: shipment.pickup || null,
    dropoff: shipment.dropoff || null,
    size: shipment.size || 'Unknown',
    weightKg: shipment.weightKg || 0,
    timeWindow: shipment.timeWindow || 'TBD',
    budget: shipment.budget || 0,
    handling: shipment.handling || 'Standard',
    status: 'open',
    retailer,
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
  };

  await admin.firestore().collection('jobs').add(job);
  res.json({ status: 'queued', job });
});

exports.matchJobs = functions.https.onRequest(async (req, res) => {
  const jobsSnap = await admin.firestore().collection('jobs').get();
  const moversSnap = await admin.firestore().collection('movers').get();

  const jobs = jobsSnap.docs.map((doc) => ({ id: doc.id, ...doc.data() }));
  const movers = moversSnap.docs.map((doc) => ({ id: doc.id, ...doc.data() }));

  const matches = jobs.map((job) => {
    const mover = movers[0];
    const score = optimizationScore({
      capacityUtilization: 0.8,
      routeEfficiency: 0.75,
      timeCompliance: 0.85,
      ecoFactor: 0.7,
    });

    return {
      jobId: job.id,
      moverId: mover?.id || null,
      score,
      reasoning: 'Bundled with compatible route + capacity match.',
    };
  });

  res.json({ matches });
});

exports.releaseEscrow = functions.https.onRequest(async (req, res) => {
  const paymentIntentId = req.body?.paymentIntentId;

  res.json({
    status: 'released',
    paymentIntentId,
    message: 'Escrow release simulated. Integrate Stripe in production.',
  });
});
