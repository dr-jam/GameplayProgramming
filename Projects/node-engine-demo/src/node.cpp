#include "node.h"
#include "scene_tree.h"

#include <algorithm>
#include <iostream>
#include <stdexcept>

Node::Node(std::string name) : name_(std::move(name)) {}

Node::~Node() = default;

void Node::add_child(std::unique_ptr<Node> child) {
    if (!child) {
        throw std::invalid_argument("Cannot add null child to node '" + name_ + "'");
    }

    if (child->parent_ != nullptr) {
        throw std::runtime_error("Node '" + child->name_ + 
                               "' already has a parent, cannot add to '" + name_ + "'");
    }

    child->parent_ = this;
    
    if (tree_) {
        child->set_tree(tree_);
        child->notification(Notification::EnterTree);
        child->notification(Notification::Ready);
    }

    children_.push_back(std::move(child));
}

std::unique_ptr<Node> Node::remove_child(Node* child) {
    auto it = std::find_if(children_.begin(), children_.end(),
                          [child](const std::unique_ptr<Node>& node) {
                              return node.get() == child;
                          });
    
    if (it == children_.end()) {
        return nullptr;
    }

    std::unique_ptr<Node> removed = std::move(*it);
    children_.erase(it);

    if (removed->tree_) {
        removed->notification(Notification::ExitTree);
        removed->set_tree(nullptr);
    }

    removed->parent_ = nullptr;
    return removed;
}

void Node::set_tree(SceneTree* tree) {
    tree_ = tree;
    for (const auto& child : children_) {
        child->set_tree(tree);
    }
}

void Node::notification(Notification what) {
    switch (what) {
        case Notification::EnterTree:
            break;
        case Notification::Ready:
            break;
        case Notification::ExitTree:
            break;
        case Notification::Process:
            break;
    }
}

void Node::process(float /* delta_time */) {
}
