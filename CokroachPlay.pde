import processing.sound.*;

ArrayList<Cokroach> coks;
PImage img;
PVector position;
SoundFile hitSound;

int spawnInterval = 5000; // 5 seconds
int lastSpawnTime = 0;

void setup() {
  size(800, 800);
  coks = new ArrayList<Cokroach>();
  img = loadImage("kecoa.png");
  hitSound = new SoundFile(this, "pencet.mp3");
}

void draw() {
  background(255); // Clear screen each frame

  // Spawn new cockroach every 5 seconds
  if (millis() - lastSpawnTime >= spawnInterval) {
    addRandomCockroach();
    lastSpawnTime = millis();
  }
  
  // Display and update all cockroaches
  for (int i = coks.size() - 1; i >= 0; i--) {
    Cokroach c = coks.get(i);
    c.display();
    
    // Remove cockroach if it’s marked as "dead"
    if (c.isDead) {
      coks.remove(i);
    }
  }
}
  
void addRandomCockroach() {
  PVector pos = new PVector(random(width), random(height));
  coks.add(new Cokroach(pos, img));
}

void mouseClicked() {
  for (Cokroach c : coks) {
    // Check if the cockroach was hit
    if (c.isHit(mouseX, mouseY)) {
      c.isDead = true; // Mark cockroach as dead
      hitSound.play(); // Play hit sound effect
      break;
    }
  }
}
