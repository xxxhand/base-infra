// Setting up a replica set with a single member for development purposes
// In production, you would typically have multiple members for redundancy and failover
// Make sure to replace "mongodb:27017" with the actual hostname and port of your MongoDB instance if different

rs.initiate({
  _id: "rs0",
  members: [
    { _id: 0, host: "mongodb:27017" }, // Use the service name as the host
  ],
});
