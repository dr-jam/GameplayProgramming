#include "scene_tree.h"
#include "node.h"

void SceneTree::set_root(std::unique_ptr<Node> root) {
    root_ = std::move(root);
    if (root_) {
        root_->set_tree(this);
        root_->notification(Node::Notification::EnterTree);
        root_->notification(Node::Notification::Ready);
    }
}

void SceneTree::process(const float delta_time) {
    if (!root_) {
        return;
    }
    process_node(root_.get(), delta_time);
}

void SceneTree::process_node(Node* node, const float delta_time) {
    node->notification(Node::Notification::Process);
    node->process(delta_time);

    for (const auto& child : node->get_children()) {
        process_node(child.get(), delta_time);
    }
}
