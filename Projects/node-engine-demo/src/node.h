#pragma once
#include <string>
#include <vector>

class SceneTree;

class Node {
public:
    enum Notification {
        NOTIFICATION_ENTER_TREE = 10,
        NOTIFICATION_READY      = 11,
        NOTIFICATION_PROCESS    = 12,
        NOTIFICATION_EXIT_TREE  = 13,
    };

    explicit Node(const std::string &p_name = "Node");
    virtual ~Node();

    void add_child(Node *child);
    void remove_child(Node *child);

    Node *get_parent() const { return parent; }
    const std::vector<Node*> &get_children() const { return children; }
    const std::string &get_name() const { return name; }

    SceneTree *get_tree() const { return tree; }

    virtual void notification(int what);
    virtual void _process(float dt);

    void _set_tree(SceneTree *p_tree);

protected:
    std::string name;

private:
    Node *parent = nullptr;
    std::vector<Node*> children;
    SceneTree *tree = nullptr;
};
