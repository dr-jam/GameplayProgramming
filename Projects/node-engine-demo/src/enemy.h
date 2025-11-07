#pragma once
#include "node.h"

class Enemy : public Node {
public:
    Enemy(const std::string &name = "Enemy") : Node(name) {}
    void notification(int what) override;
    void _process(float dt) override;

private:
    float time_alive = 0.0f;
};
