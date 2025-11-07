#ifndef ENEMY_H
#define ENEMY_H

#include "node.h"
#include <string>

class Enemy : public Node {
public:
    explicit Enemy(std::string name = "Enemy") : Node(std::move(name)) {}
    ~Enemy() override = default;

    // Explicitly delete copy operations (inherited but good to be clear)
    Enemy(const Enemy&) = delete;
    Enemy& operator=(const Enemy&) = delete;

    // Move operations
    Enemy(Enemy&&) noexcept = default;
    Enemy& operator=(Enemy&&) noexcept = default;

    void notification(Notification what) override;
    void process(float delta_time) override;

    [[nodiscard]] float get_time_alive() const noexcept { return time_alive_; }

private:
    float time_alive_ = 0.0f;
};

#endif // ENEMY_H
