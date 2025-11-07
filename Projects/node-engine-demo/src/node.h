#ifndef NODE_H
#define NODE_H

#include <string>
#include <vector>
#include <memory>

class SceneTree;

class Node {
public:
    enum class Notification {
        EnterTree = 10,
        Ready = 11,
        Process = 12,
        ExitTree = 13,
    };

    explicit Node(std::string name = "Node");
    virtual ~Node();

    // Delete copy operations
    Node(const Node&) = delete;
    Node& operator=(const Node&) = delete;

    // Move operations
    Node(Node&&) noexcept = default;
    Node& operator=(Node&&) noexcept = default;

    void add_child(std::unique_ptr<Node> child);
    std::unique_ptr<Node> remove_child(Node* child);

    [[nodiscard]] Node* get_parent() const noexcept { return parent_; }
    [[nodiscard]] const std::vector<std::unique_ptr<Node>>& get_children() const noexcept { return children_; }
    [[nodiscard]] const std::string& get_name() const noexcept { return name_; }
    [[nodiscard]] SceneTree* get_tree() const noexcept { return tree_; }

    virtual void notification(Notification what);
    virtual void process(float delta_time);

    void set_tree(SceneTree* tree);

protected:
    std::string name_;

private:
    Node* parent_ = nullptr;
    std::vector<std::unique_ptr<Node>> children_;
    SceneTree* tree_ = nullptr;
};

#endif // NODE_H
