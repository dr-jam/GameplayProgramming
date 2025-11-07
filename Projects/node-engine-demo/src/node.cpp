#include "node.h"
#include "scene_tree.h"

#include <algorithm>
#include <iostream>
#include <cassert>

Node::Node(const std::string &p_name) : name(p_name) {}

Node::~Node() {
    for (Node *c : children) {
        delete c;
    }
    children.clear();
}

void Node::add_child(Node *child) {
    assert(child != nullptr);

    if (child->parent != nullptr) {
        std::cerr << "Node '" << child->name
                  << "' already has a parent, cannot add to '" << name << "'\n";
        return;
    }

    child->parent = this;
    children.push_back(child);

    if (tree) {
        child->_set_tree(tree);
        child->notification(NOTIFICATION_ENTER_TREE);
        child->notification(NOTIFICATION_READY);
    }
}

void Node::remove_child(Node *child) {
    auto it = std::find(children.begin(), children.end(), child);
    if (it == children.end())
        return;

    if (child->tree) {
        child->notification(NOTIFICATION_EXIT_TREE);
        child->_set_tree(nullptr);
    }

    child->parent = nullptr;
    children.erase(it);
}

void Node::_set_tree(SceneTree *p_tree) {
    tree = p_tree;
    for (Node *c : children) {
        c->_set_tree(p_tree);
    }
}

void Node::notification(int what) {
    switch (what) {
        case NOTIFICATION_ENTER_TREE:
            break;
        case NOTIFICATION_READY:
            break;
        case NOTIFICATION_EXIT_TREE:
            break;
    }
}

void Node::_process(float) {
}
