// Based on the processing flocking example: http://processing.org/examples/flocking.html

Flock flock;

void setup() {
  size(640, 360);
  flock = new Flock();
  // Add an initial set of boids into the system
  for (int i = 0; i < 50; i++) {
    flock.addBoid(new Boid(width/2,height/2));
  }
}

void draw() {
  background(50);
  flock.run();
}

// Remove a new boid from the System
void mousePressed() {
//  flock.addBoid(new Boid(mouseX,mouseY));
  flock.removeBoid(mouseX,mouseY);
}



// The Boid class

class Boid {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed
  float brightness;    // the stroke alpha

    Boid(float x, float y) {
    acceleration = new PVector(0, 0);

    // This is a new PVector method not yet implemented in JS
    // velocity = PVector.random2D();

    // Leaving the code temporarily this way so that this example runs in JS
    float angle = random(TWO_PI);
    velocity = new PVector(cos(angle), sin(angle));

    location = new PVector(x, y);
    r = random(1,5);
    r = 5;
    maxspeed = random(1,8)/2;
    maxforce = 0.03;
    brightness = random(0,255);
  }

  void run(ArrayList<Boid> boids) {
    flock(boids);
    update();
    borders();
    render();
  }

  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }

  // We accumulate a new acceleration each time based on three rules
  void flock(ArrayList<Boid> boids) {
    PVector sep = separate(boids);   // Separation
    PVector ali = align(boids);      // Alignment
    PVector coh = cohesion(boids);   // Cohesion
    // Arbitrarily weight these forces
    sep.mult(1.5);
    ali.mult(1.0);
    coh.mult(1.0);
    // Add the force vectors to acceleration
    applyForce(sep);
    applyForce(ali);
    applyForce(coh);
  }

  // Method to update location
  void update() {
    // Update velocity
    velocity.add(acceleration);
    // Limit speed
    velocity.limit(maxspeed);
    location.add(velocity);
    // Reset accelertion to 0 each cycle
    acceleration.mult(0);
  }

  // A method that calculates and applies a steering force towards a target
  // STEER = DESIRED MINUS VELOCITY
  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, location);  // A vector pointing from the location to the target
    // Scale to maximum speed
    desired.normalize();
    desired.mult(maxspeed);

    // Above two lines of code below could be condensed with new PVector setMag() method
    // Not using this method until Processing.js catches up
    // desired.setMag(maxspeed);

    // Steering = Desired minus Velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);  // Limit to maximum steering force
    return steer;
  }

  void render() {
    // Draw a triangle rotated in the direction of velocity
    float theta = velocity.heading2D() + radians(90);
    // heading2D() above is now heading() but leaving old syntax until Processing.js catches up
    
    fill(200, 100);
    fill(brightness);
    stroke(brightness);
    pushMatrix();
    translate(location.x, location.y);
    rotate(theta);
    beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();
    popMatrix();
  }

  // Wraparound
  void borders() {
    if (location.x == 1000) location.x = 1000;
    else if (location.x < -r) location.x = width+r;
    else if (location.x > width+r) location.x = -r;
    if (location.y < -r) location.y = height+r;
    if (location.y > height+r) location.y = -r;
  }

  // Separation
  // Method checks for nearby boids and steers away
  PVector separate (ArrayList<Boid> boids) {
    float desiredseparation = 25.0f;
    PVector steer = new PVector(0, 0, 0);
    int count = 0;
    // For every boid in the system, check if it's too close
    for (Boid other : boids) {
      float d = PVector.dist(location, other.location);
      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
      if ((d > 0) && (d < desiredseparation)) {
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(location, other.location);
        diff.normalize();
        diff.div(d);        // Weight by distance
        steer.add(diff);
        count++;            // Keep track of how many
      }
    }
    // Average -- divide by how many
    if (count > 0) {
      steer.div((float)count);
    }

    // As long as the vector is greater than 0
    if (steer.mag() > 0) {
      // First two lines of code below could be condensed with new PVector setMag() method
      // Not using this method until Processing.js catches up
      // steer.setMag(maxspeed);

      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalize();
      steer.mult(maxspeed);
      steer.sub(velocity);
      steer.limit(maxforce);
    }
    return steer;
  }

  // Alignment
  // For every nearby boid in the system, calculate the average velocity
  PVector align (ArrayList<Boid> boids) {
    float neighbordist = 50;
    PVector sum = new PVector(0, 0);
    int count = 0;
    for (Boid other : boids) {
      float d = PVector.dist(location, other.location);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.velocity);
        count++;
      }
    }
    if (count > 0) {
      sum.div((float)count);
      // First two lines of code below could be condensed with new PVector setMag() method
      // Not using this method until Processing.js catches up
      // sum.setMag(maxspeed);

      // Implement Reynolds: Steering = Desired - Velocity
      sum.normalize();
      sum.mult(maxspeed);
      PVector steer = PVector.sub(sum, velocity);
      steer.limit(maxforce);
      return steer;
    } 
    else {
      return new PVector(0, 0);
    }
  }

  // Cohesion
  // For the average location (i.e. center) of all nearby boids, calculate steering vector towards that location
  PVector cohesion (ArrayList<Boid> boids) {
    float neighbordist = 50;
    PVector sum = new PVector(0, 0);   // Start with empty vector to accumulate all locations
    int count = 0;
    for (Boid other : boids) {
      float d = PVector.dist(location, other.location);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.location); // Add location
        count++;
      }
    }
    if (count > 0) {
      sum.div(count);
      return seek(sum);  // Steer towards the location
    } 
    else {
      return new PVector(0, 0);
    }
  }
}




// The Flock (a list of Boid objects)

class Flock {
  ArrayList<Boid> boids; // An ArrayList for all the boids
  int count = 0;

  Flock() {
    boids = new ArrayList<Boid>(); // Initialize the ArrayList
  }

  void run() {
    count = count+1;
      for (Boid b : boids) {
        b.run(boids);  // Passing the entire list of boids to each boid individually
      }
    if (count == 1000) {
      int parent1 = 0;
      int parent2 = parent1 + 1;
      Boid bp1 = boids.get(parent1);
      Boid bp2 = boids.get(parent2);
      float r_rand = random(100);
      float maxspeed_rand = random(100);
      float brightness_rand = random(100);
      for (Boid b : boids) {
        r_rand = random(100);
        maxspeed_rand = random(100);
        brightness_rand = random(100);
        // scroll through all boids
        // for each boid, take two living boids (x<width) and split their traits
        // recreate boid with new traits
        // reinitialize position and velocity
        while (bp1.maxspeed == 0) {
         // it's dead - reassign the parent
         parent1 = parent1 + 2;
         if (parent1 >= boids.size()) parent1 = 0;
         bp1 = boids.get(parent1);
        }
        while (bp2.maxspeed == 0) {
         // it's dead - reassign the parent
         parent2 = parent2 + 2;
         if (parent2 >= boids.size()) parent2 = 1;
         bp2 = boids.get(parent2);
        }
        b.location.x = width/2;
        b.location.y = height/2;
        float angle = random(TWO_PI);
        b.velocity = new PVector(cos(angle), sin(angle));
        
        if (r_rand < 47) b.r = bp1.r;
        else if (r_rand > 94) b.r = random(1,5);
        else b.r = bp2.r;
        b.r = 5;
        
        if (maxspeed_rand < 47) b.maxspeed = bp1.maxspeed;
        else if (maxspeed_rand > 94) b.maxspeed = random(1,8)/2;
        else b.maxspeed = bp2.maxspeed;
        
        if (brightness_rand < 47) b.brightness = bp1.brightness;
        else if (brightness_rand > 94) b.brightness = random(0,255);
        else b.brightness = bp2.brightness;
        
        parent1 = parent1 + 2;
        if (parent1 >= boids.size()) parent1 = 0;
        bp1 = boids.get(parent1);
        parent2 = parent2 + 2;
        if (parent2 >= boids.size()) parent2 = 1;
        bp2 = boids.get(parent2);
      }
      count = 0;
    }
  }

  void addBoid(Boid b) {
    boids.add(b);
  }
  
  void removeBoid(int remX, int remY) {
    for (Boid b : boids) {
      if ( sqrt(sq(b.location.x - remX) + sq(b.location.y - remY)) < 3*b.r ) {
        //boids.remove(b);
        b.maxspeed = 0;
        b.r = 0;
        b.location.x = 1000;
        b.location.y = 1000;
      }
    }
    // for (int i = boids.size()-1; i>=0; i--) Boid b = boids.get(i);
  }

}

