

### **Objective:**

Create a multiplayer game in Godot where a ball bounces between two separate game instances over a network. This project will help students understand advanced networking concepts, state synchronization, and Remote Procedure Calls (RPCs) in Godot.

---

### **Introduction:**

In this project, you'll develop a game that simulates a ball bouncing from one player's screen to another's via networking. When the ball exits the right edge of one player's screen, it enters the left edge of the other player's screen, and vice versa. This activity covers:

- **Godot's High-Level Multiplayer API:** Understanding how to set up networking in Godot.
- **Client-Server Model:** Learning about network architectures used in multiplayer games.
- **State Synchronization:** Keeping game states consistent across multiple instances.
- **Remote Procedure Calls (RPCs):** Invoking functions across the network.

---

### **Activity Breakdown:**

#### **1. Understanding Godot's Networking (10 minutes)**

**Overview:**

- **Client-Server Model:** In multiplayer games, a common architecture is the client-server model. One instance acts as the server (host), managing the game's state, while other instances (clients) connect to it.
- **Godot's High-Level Multiplayer API (HLAPI):** Simplifies the networking process by handling low-level details like packet sending and receiving.
- **Remote Procedure Calls (RPCs):** Allow you to call functions on remote peers as if they were local, facilitating communication between instances.

**Key Concepts:**

- **Network Peer:** An abstraction representing either a server or a client.
- **Network Master:** The instance responsible for a particular object's state.
- **Synchronization:** Ensuring all players see the same game state.

---

#### **2. Setting Up the Project (10 minutes)**

**New Project Creation:**

1. **Open Godot Engine.**
2. **Create a New Project:**
   - Click on **"New Project"**.
   - Name it **"NetworkedBallBounce"**.
   - Choose a location to save the project.
   - Set the **Renderer** to **"Forward+"** (for Godot 4.x) or use the default (for Godot 3.x).
   - Click **"Create & Edit"**.

**Basic Scene Setup:**

1. **Create the Main Scene:**
   - In the Scene panel, click on **"2D Scene"** to create a root `Node2D`.
   - Rename it to **"Main"** by double-clicking on the node name.
   - Save the scene by pressing **Ctrl+S** or **Cmd+S** and name it **"Main.tscn"**.

---

#### **3. Designing the Game Environment (15 minutes)**

**Adding the Ball:**

1. **Create a New Scene for the Ball:**
   - Go to **Scene → New Scene**.
   - Add an **`RigidBody2D`** node as the root and rename it to **"Ball"**.
   - Save the scene as **"Ball.tscn"**.

2. **Adding a Sprite:**
   - Add a **`Sprite`** node as a child of the `Ball` node.
   - In the Inspector, assign a texture to the `Sprite`:
     - Click on **"Textures"** and load a simple ball image (you can use a placeholder like a colored circle).

3. **Adding Collision Shape:**
   - Add a **`CollisionShape2D`** node as a child of the `Ball`.
   - In the Inspector, set the **"Shape"** to **`CircleShape2D`**.
   - Adjust the radius to match the size of the sprite.

**Creating Boundaries:**

1. **Adding Top and Bottom Walls:**
   - In the **"Main"** scene, add two **`StaticBody2D`** nodes and name them **"TopWall"** and **"BottomWall"**.
   - For each wall:
     - Add a **`CollisionShape2D`** as a child.
     - Set the **"Shape"** to **`RectangleShape2D`**.
     - Adjust the size to span the width of the screen and position them at the top and bottom edges.

**Adding the Ball to the Main Scene:**

1. **Instance the Ball Scene:**
   - In the **"Main"** scene, click on **"Instance Child Scene"** (chain icon) or **Ctrl+I**.
   - Select **"Ball.tscn"** to instance it into the main scene.
   - Position the ball in the center of the screen.

---

#### **4. Implementing Ball Movement (15 minutes)**

**Ball Script (`Ball.gd`):**

1. **Attach a Script to the Ball:**
   - Select the `Ball` node in **"Ball.tscn"**.
   - Click on the **"Add Script"** button or **Ctrl+Shift+A**.
   - Save it as **"Ball.gd"**.

2. **Writing the Movement Code:**

   ```gdscript
   extends RigidBody2D

   var velocity = Vector2(200, 150)  # Initial velocity

   func _physics_process(delta):
       # Update position based on velocity
       position += velocity * delta

       # Get the viewport size
       var screen_size = get_viewport_rect().size

       # Bounce off the top wall
       if position.y <= 0:
           position.y = 0
           velocity.y = -velocity.y

       # Bounce off the bottom wall
       elif position.y >= screen_size.y:
           position.y = screen_size.y
           velocity.y = -velocity.y
   ```

**Explanation:**

- **Variables:**
  - `velocity`: A `Vector2` representing the ball's speed and direction.
- **Physics Processing:**
  - `_physics_process(delta)`: Called every physics frame; `delta` is the time since the last frame.
  - `position += velocity * delta`: Moves the ball according to its velocity.
- **Screen Bounds:**
  - `get_viewport_rect().size`: Retrieves the size of the game window.
- **Bouncing Logic:**
  - If the ball reaches the top (`position.y <= 0`) or bottom (`position.y >= screen_size.y`), invert the `y` component of the velocity to make it bounce.

---

#### **5. Setting Up Networking (20 minutes)**

**Decide on Network Architecture:**

- For simplicity, we'll use a client-server model where one instance acts as the server (network master), and the other acts as the client.

**Network Initialization:**

1. **Creating a Network Manager:**

   - In the **"Main"** scene, add a new **`Node`** and name it **"Network"**.
   - Attach a script to the `Network` node and save it as **"Network.gd"**.

2. **Writing the Network Script:**

   ```gdscript
   extends Node

   func _ready():
       # Check command-line arguments to determine if this instance is the server
       var args = OS.get_cmdline_args()
       if args.has("--server"):
           start_server()
       else:
           connect_to_server()

   func start_server():
       var peer = ENetMultiplayerPeer.new()
       peer.create_server(7777)
       multiplayer.multiplayer_peer = peer
       print("Server started on port 7777")

   func connect_to_server():
       var peer = ENetMultiplayerPeer.new()
       peer.create_client("localhost", 7777)
       multiplayer.multiplayer_peer = peer
       print("Connected to server")
   ```

**Explanation:**

- **Command-Line Arguments:**
  - `OS.get_cmdline_args()`: Retrieves command-line arguments passed when starting the game.
  - If the argument `--server` is present, this instance starts as a server.
- **Starting the Server:**
  - `ENetMultiplayerPeer.new()`: Creates a new network peer using the ENet protocol.
  - `peer.create_server(7777)`: Starts a server listening on port 7777.
  - `multiplayer.multiplayer_peer = peer`: Sets the network peer for the game's multiplayer API.
- **Connecting as a Client:**
  - `peer.create_client("localhost", 7777)`: Connects to the server at the specified address and port.

**Usage:**

- **Starting the Server:**
  - Run the game with the `--server` flag:
    - For Godot Editor: Use the **Project → Export** feature to create an executable.
    - For Command Line: If you have the Godot executable, run:
      ```
      godot -s Main.tscn --server
      ```
- **Starting the Client:**
  - Run another instance of the game without the `--server` flag to connect as a client.

---

#### **6. Synchronizing Ball State (25 minutes)**

**Setting Up Networked Autoload:**

1. **Convert the Ball Scene to a Networked Node:**

   - In the **"Ball.gd"** script, enable network synchronization by setting the class to **`[Networked]`** (for Godot 4.x).
     ```gdscript
     @tool
     extends Area2D
     ```

**Ball Script Enhancements:**

1. **Determine Network Master:**

   ```gdscript
   func _ready():
       if multiplayer.is_server():
           # The server controls the ball's movement
           set_physics_process(true)
       else:
           # Clients will receive updates but won't process physics
           set_physics_process(false)
   ```

2. **Implementing Networked Movement:**

   - **Updating Ball State Across the Network:**

     ```gdscript
     @rpc(any_peer)
     func update_ball_state(pos, vel):
         position = pos
         velocity = vel
     ```

   - **Sending Ball State from the Server:**

     ```gdscript
     func _physics_process(delta):
         if multiplayer.is_server():
             # Existing movement code
             position += velocity * delta
             # Bouncing logic remains the same

             # Send position and velocity to clients
             rpc_unreliable("update_ball_state", position, velocity)

             # Check if the ball exits the right edge
             if position.x >= get_viewport_rect().size.x:
                 # Transfer ball to client
                 rpc_id(2, "receive_ball", Vector2(0, position.y), velocity)
                 hide()
                 set_physics_process(false)
     ```

**Explanation:**

- **RPC Functions:**
  - `@rpc`: Marks a function as callable over the network.
  - `any_peer`: The function can be called by any peer.
  - `rpc_unreliable`: Sends data without guaranteeing delivery, suitable for frequent updates.
- **Server Logic:**
  - The server processes physics and updates the ball's position.
  - It broadcasts the ball's state to clients.
  - When the ball exits the right edge, it sends an RPC to the client to take over.

3. **Handling Ball Reception on Client:**

   ```gdscript
   @rpc(server)
   func receive_ball(pos, vel):
       position = pos
       velocity = vel
       show()
       set_physics_process(true)
   ```

**Explanation:**

- **Client Logic:**
  - The client receives the ball's position and velocity.
  - It sets its own ball instance to these values.
  - The client begins processing physics, taking over control of the ball.

---

#### **7. Handling Role Switching and Authority (10 minutes)**

**Transferring Network Master Role:**

- **Assigning Network Authority:**
  - When the ball transfers from server to client, we need to change who is the network master of the ball.

**Implementing Authority Transfer:**

1. **On the Server Side:**

   ```gdscript
   func _physics_process(delta):
       if multiplayer.is_server():
           # Existing movement code
           # ...

           # Ball exits right edge
           if position.x >= get_viewport_rect().size.x:
               # Assign network master to client (peer ID 2)
               set_network_master(2)
               rpc_id(2, "receive_ball", Vector2(0, position.y), velocity)
               hide()
               set_physics_process(false)
   ```

2. **On the Client Side:**

   ```gdscript
   @rpc(server)
   func receive_ball(pos, vel):
       position = pos
       velocity = vel
       show()
       set_physics_process(true)
       # Client now processes physics
   ```

**Explanation:**

- **`set_network_master(peer_id)`:** Changes the network master of the node to the specified peer.
- **Peer IDs:**
  - The server has a peer ID of 1.
  - Clients have peer IDs starting from 2.

**Client Sending Ball Back to Server:**

1. **Client Ball Processing:**

   ```gdscript
   func _physics_process(delta):
       if !multiplayer.is_server():
           # Client processes physics
           position += velocity * delta
           # Bouncing logic

           # Send position and velocity to server
           rpc_unreliable("update_ball_state", position, velocity)

           # Ball exits right edge (client's view)
           if position.x >= get_viewport_rect().size.x:
               # Transfer ball back to server
               set_network_master(1)
               rpc_id(1, "receive_ball", Vector2(0, position.y), velocity)
               hide()
               set_physics_process(false)
   ```

**Server Receiving Ball Back:**

```gdscript
@rpc(client)
func receive_ball(pos, vel):
    position = pos
    velocity = vel
    show()
    set_physics_process(true)
```

---

#### **8. Testing the Networked Game (10 minutes)**

**Running the Game Instances:**

1. **Start the Server Instance:**
   - Run the game with the `--server` flag.
   - Command Line:
     ```
     godot -s Main.tscn --server
     ```
   - Alternatively, in the Godot editor, set up **Project Settings → Command Line** to include `--server`.

2. **Start the Client Instance:**
   - Open a second instance of Godot or export the game to run separately.
   - Run the game normally without any flags.

**Observing the Behavior:**

- The ball should move on the server's screen.
- When it exits the right edge, it should appear on the client's screen from the left edge.
- The client now controls the ball.
- When the ball exits the client's right edge, it returns to the server.

**Troubleshooting Tips:**

- **Connection Issues:**
  - Ensure both instances are running on the same machine or network.
  - Check firewall settings to allow communication on port 7777.
- **Error Messages:**
  - Use the **Debugger** panel in Godot to view errors or warnings.
  - Confirm that peer IDs are correctly assigned.

---

#### **9. Handling Network Latency (10 minutes)**

**Implementing Smooth Movement with Interpolation:**

1. **Client-Side Prediction:**

   - **In the Ball Script:**

     ```gdscript
     var last_received_pos = Vector2()
     var last_received_time = 0

     @rpc(any_peer)
     func update_ball_state(pos, vel):
         last_received_pos = pos
         last_received_time = OS.get_ticks_msec()
         velocity = vel

     func _process(delta):
         if !is_physics_processing():
             # Interpolate position
             var t = (OS.get_ticks_msec() - last_received_time) / 1000.0
             position = position.linear_interpolate(last_received_pos, 0.1)
     ```

**Explanation:**

- **Variables:**
  - `last_received_pos`: The last position received from the network.
  - `last_received_time`: Timestamp of when the position was received.
- **Interpolation:**
  - In the `_process(delta)` function, which runs every frame, interpolate the position towards the last received position.
  - This smooths out the movement and reduces visual stuttering due to network latency.

**Understanding Network Latency:**

- **Latency Effects:**
  - Delays in data transmission can cause jerky or laggy movement.
- **Mitigation Strategies:**
  - Interpolation and extrapolation help smooth out the perceived motion.
  - Using `rpc_unreliable()` reduces network overhead for frequent updates.

---

#### **10. Enhancements and Extensions (10 minutes)**

**Ideas for Expansion:**

1. **Scoring System:**

   - **Implementing Scores:**
     - Add variables to keep track of each player's score.
     - Increment the score when the opponent fails to return the ball.
   - **Display Scores:**
     - Use `Label` nodes to display scores on the screen.

2. **Multiple Balls:**

   - **Adding Complexity:**
     - Introduce additional balls after certain conditions are met.
     - Manage multiple ball instances over the network.

3. **Power-ups:**

   - **Creating Power-ups:**
     - Design items that appear on the screen.
     - When collected, they affect the ball's speed or size.

4. **Player Interaction:**

   - **Adding Paddles:**
     - Create paddle nodes controlled by each player.
     - Use input actions to move the paddles up and down.
   - **Ball Collision with Paddles:**
     - Adjust the ball's velocity based on the collision point with the paddle.

5. **Visual and Audio Effects:**

   - **Enhancing Aesthetics:**
     - Add particle effects when the ball bounces.
     - Incorporate sound effects for collisions and scoring.

---

### **Materials Needed:**

- **Computers:**
  - At least two computers with Godot Engine installed (version 3.x or 4.x).
  - Alternatively, one computer running two instances of the game.

- **Network Connection:**
  - Ensure both computers are on the same local network or have the ability to connect over the internet.
  - For local testing, `localhost` can be used.

- **Assets:**
  - **Sprites:**
    - Simple images for the ball, paddles, and any additional game elements.
  - **Sounds (Optional):**
    - Audio files for sound effects.

---

### **Learning Outcomes:**

- **Technical Skills:**

  - **Networking in Godot:**
    - Understanding how to set up networked multiplayer games.
    - Proficiency with Godot's High-Level Multiplayer API.
  - **Remote Procedure Calls:**
    - Using `@rpc` functions to communicate between server and client.
    - Differentiating between reliable and unreliable RPCs.
  - **State Synchronization:**
    - Keeping game states consistent across multiple instances.
    - Handling authority transfer and network master assignments.
  - **Latency Handling:**
    - Implementing interpolation to smooth out network-induced lag.

- **Soft Skills:**

  - **Problem-Solving:**
    - Debugging network issues.
    - Optimizing code for real-time applications.
  - **Collaboration:**
    - Working in pairs or groups to test multiplayer functionality.
  - **Adaptability:**
    - Adjusting to unexpected challenges during development.

---

### **Additional Tips:**

- **Testing on Different Machines:**

  - **Adjusting IP Addresses:**
    - If running on different computers, replace `"localhost"` with the server's IP address in `connect_to_server()`.

- **Firewall and Security:**

  - **Allowing Network Traffic:**
    - Ensure that firewalls or antivirus software do not block the chosen port (default is 7777).

- **Debugging Network Code:**

  - **Print Statements:**
    - Use `print()` statements to log network events and data.
  - **Godot's Debugger:**
    - Monitor the **Debugger** panel for errors and warnings.

- **Performance Optimization:**

  - **Efficient Networking:**
    - Limit the frequency of RPC calls to what's necessary.
    - Use `rpc_unreliable()` for non-critical updates.

- **Security Considerations:**

  - **Validating Data:**
    - In a production environment, always validate incoming data to prevent cheating or malicious activity.

- **Learning Resources:**

  - **Godot Documentation:**
    - [Networking High-Level API](https://docs.godotengine.org/en/stable/tutorials/networking/high_level_multiplayer.html)
  - **Tutorials:**
    - Official Godot tutorials and community resources on multiplayer development.

---

### **Conclusion:**

By completing this project, you've gained practical experience with Godot's networking capabilities. You've learned how to:

- Set up a basic client-server architecture.
- Use RPCs to communicate between game instances.
- Synchronize game state and handle authority transfer.
- Mitigate network latency effects for smoother gameplay.

These skills are essential for developing multiplayer games and understanding the complexities of networked applications. You can build upon this foundation to create more sophisticated multiplayer experiences, implement security measures, and optimize performance for real-world scenarios.

---

**Feel free to reach out if you have any questions or need further assistance with any aspect of this project!**
