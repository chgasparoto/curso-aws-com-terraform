// Replace with your load balancer's DNS or IP address
const targetUrl =
  "http://autoscaling-app-dev-1743440818.eu-central-1.elb.amazonaws.com";

// Number of requests to simulate
const numberOfRequests = 3;

// Function to make HTTP requests
async function makeRequest(index) {
  try {
    const res = await fetch(targetUrl);
    if (res.ok) {
      console.log(`Request ${index} successful`);
    } else {
      console.error(`Request ${index} failed`);
    }
  } catch (error) {
    console.error(`Request ${index} failed. Error: ${error.message}`);
  }
}

// Start making requests
// Function to simulate requests in parallel
async function makeParallelRequests(numberOfRequests) {
  // Create an array of request promises
  const requestPromises = Array.from({ length: numberOfRequests }, (_, index) =>
    makeRequest(index + 1)
  );

  // Initiate all requests concurrently
  await Promise.all(requestPromises);
}

// Start making requests in parallel
makeParallelRequests(numberOfRequests);
