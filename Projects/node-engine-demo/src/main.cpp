#include "scene_tree.h"
#include "node.h"
#include "enemy.h"

#include <iostream>
#include <thread>
#include <chrono>

int main() {
    SceneTree tree;

    Node *root = new Node("Root");
    tree.set_root(root);

    Enemy *e1 = new Enemy("EnemyA");
    Enemy *e2 = new Enemy("EnemyB");
    root->add_child(e1);
    root->add_child(e2);

    Enemy *e1_child = new Enemy("EnemyA_Minion");
    e1->add_child(e1_child);

    std::cout << "Starting main loop...\n";

    const float dt = 1.0f / 30.0f;
    for (int frame = 0; frame < 90; ++frame) {
        tree.process(dt);

        if (frame == 30) {
            std::cout << "Removing EnemyB from tree...\n";
            root->remove_child(e2);
            delete e2;
            e2 = nullptr;
        }

        std::this_thread::sleep_for(std::chrono::milliseconds(33));
    }

    std::cout << "Exiting.\n";
    return 0;
}
