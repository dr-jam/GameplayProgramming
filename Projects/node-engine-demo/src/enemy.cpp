#include "enemy.h"
#include <iostream>

void Enemy::notification(const Notification what) {
    switch (what) {
        case Notification::EnterTree:
            std::cout << get_name() << " entered tree\n";
            break;
        case Notification::Ready:
            std::cout << get_name() << " ready\n";
            break;
        case Notification::ExitTree:
            std::cout << get_name() << " exited tree\n";
            break;
        case Notification::Process:
            // Process notification handled by process() method
            break;
    }
}

void Enemy::process(const float delta_time) {
    time_alive_ += delta_time;
    // Could add animation or other per-frame logic here if desired
}
