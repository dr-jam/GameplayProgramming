#include "scene_tree.h"
#include "node.h"

SceneTree::~SceneTree() {
    delete root;
    root = nullptr;
}

void SceneTree::set_root(Node *p_root) {
    root = p_root;
    if (root) {
        root->_set_tree(this);
        root->notification(Node::NOTIFICATION_ENTER_TREE);
        root->notification(Node::NOTIFICATION_READY);
    }
}

void SceneTree::process(float dt) {
    if (!root) return;
    process_node(root, dt);
}

void SceneTree::process_node(Node *n, float dt) {
    n->notification(Node::NOTIFICATION_PROCESS);
    n->_process(dt);

    for (Node *c : n->get_children()) {
        process_node(c, dt);
    }
}
