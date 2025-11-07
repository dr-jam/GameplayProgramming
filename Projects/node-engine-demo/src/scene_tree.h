#pragma once
class Node;

class SceneTree {
public:
    SceneTree() = default;
    ~SceneTree();

    void set_root(Node *p_root);
    Node *get_root() const { return root; }

    void process(float dt);

private:
    Node *root = nullptr;

    void process_node(Node *n, float dt);
};
