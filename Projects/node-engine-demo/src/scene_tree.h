#ifndef SCENE_TREE_H
#define SCENE_TREE_H

#include <memory>

class Node;

class SceneTree {
public:
    SceneTree() = default;
    ~SceneTree() = default;

    // Delete copy operations
    SceneTree(const SceneTree&) = delete;
    SceneTree& operator=(const SceneTree&) = delete;

    // Move operations
    SceneTree(SceneTree&&) noexcept = default;
    SceneTree& operator=(SceneTree&&) noexcept = default;

    void set_root(std::unique_ptr<Node> root);
    [[nodiscard]] Node* get_root() const noexcept { return root_.get(); }

    void process(float delta_time);

private:
    std::unique_ptr<Node> root_;

    void process_node(Node* node, float delta_time);
};

#endif // SCENE_TREE_H
