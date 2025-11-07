#include "scene_tree.h"
#include "node.h"
#include "enemy.h"

#include <iostream>
#include <thread>
#include <chrono>
#include <memory>

namespace {
    constexpr float kFramesPerSecond = 30.0f;
    constexpr float kDeltaTime = 1.0f / kFramesPerSecond;
    constexpr int kTotalFrames = 90;
    constexpr int kRemovalFrame = 30;
    constexpr int kMillisecondsPerFrame = 33;
}

int main() {
    try {
        SceneTree tree;

        // Create root node
        auto root = std::make_unique<Node>("Root");
        Node* root_ptr = root.get();
        tree.set_root(std::move(root));

        // Create enemies and add to tree
        auto enemy_a = std::make_unique<Enemy>("EnemyA");
        auto enemy_b = std::make_unique<Enemy>("EnemyB");
        
        // Keep pointer to enemy_a for adding child later
        Node* enemy_a_ptr = enemy_a.get();
        
        // Keep pointer to enemy_b for removal later
        Node* enemy_b_ptr = enemy_b.get();
        
        root_ptr->add_child(std::move(enemy_a));
        root_ptr->add_child(std::move(enemy_b));

        // Add child to enemy_a
        auto enemy_a_minion = std::make_unique<Enemy>("EnemyA_Minion");
        enemy_a_ptr->add_child(std::move(enemy_a_minion));

        std::cout << "Starting main loop...\n";

        // Main game loop
        for (int frame = 0; frame < kTotalFrames; ++frame) {
            tree.process(kDeltaTime);

            if (frame == kRemovalFrame) {
                std::cout << "Removing EnemyB from tree...\n";
                auto removed = root_ptr->remove_child(enemy_b_ptr);
                // removed goes out of scope here and is automatically deleted
            }

            std::this_thread::sleep_for(std::chrono::milliseconds(kMillisecondsPerFrame));
        }

        std::cout << "Exiting.\n";
        return 0;
        
    } catch (const std::exception& e) {
        std::cerr << "Error: " << e.what() << '\n';
        return 1;
    }
}
