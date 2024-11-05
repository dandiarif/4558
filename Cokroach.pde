class Cokroach {
  PVector position;
  PVector velocity;
  PImage img;
  boolean isDead = false; // Tracks if the cockroach is dead
  
  Cokroach(PVector pos, PImage img) {
    this.position = pos;
    this.img = img;
    // Assign a random velocity for movement
    this.velocity = new PVector(random(-2, 2), random(-2, 2));
  }

  void display() {
    if (!isDead) { // Only display if not dead
      float angle = atan2(velocity.y, velocity.x); // Calculate angle of movement

      pushMatrix();
      translate(position.x, position.y); // Move to cockroach's position
      rotate(angle); // Rotate to face movement direction
      imageMode(CENTER);
      image(img, 0, 0); // Draw image centered at (0, 0) after rotation
      popMatrix();
      
      move(); // Update position each frame
    }
  }

  void move() {
    // Update the position by adding the velocity
    position.add(velocity);

    // Reverse direction if the cockroach hits the screen edges
    if (position.x < 0 || position.x > width) velocity.x *= -1;
    if (position.y < 0 || position.y > height) velocity.y *= -1;
  }
  
  boolean isHit(float x, float y) {
    // Check if mouse is within cockroach bounds
    float d = dist(x, y, position.x, position.y);
    return d < img.width / 2; // Adjust based on image dimensions
  }
}
