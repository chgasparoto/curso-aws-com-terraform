// Replace with your load balancer's DNS or IP address
const targetUrl =
  "http://autoscaling-app-dev-79566164.eu-central-1.elb.amazonaws.com";

// Number of requests to simulate
const numberOfRequests = 150;

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

async function makeParallelRequests(numberOfRequests) {
  // Create an array of request promises
  const requestPromises = Array.from({ length: numberOfRequests }, (_, index) =>
    makeRequest(index + 1)
  );

  // Initiate all requests concurrently
  await Promise.all(requestPromises);
}

async function makeSequentialRequests() {
  for (let i = 0; i < numberOfRequests; i++) {
    try {
      const response = await fetch(targetUrl);

      if (response.ok) {
        console.log(`Request ${i + 1} successful.`);
      } else {
        console.error(`Request ${i + 1} failed.`);
      }
    } catch (error) {
      console.error(`Request ${i + 1} failed. Error: ${error.message}`);
    }
  }
}

// makeParallelRequests(numberOfRequests);
makeSequentialRequests(numberOfRequests);
