#include "enemy.h"
#include <iostream>

void Enemy::notification(int what) {
    if (what == NOTIFICATION_ENTER_TREE) {
        std::cout << get_name() << " entered tree\n";
    } else if (what == NOTIFICATION_READY) {
        std::cout << get_name() << " ready\n";
    } else if (what == NOTIFICATION_EXIT_TREE) {
        std::cout << get_name() << " exited tree\n";
    }
}

void Enemy::_process(float dt) {
    time_alive += dt;
    // we could print or animate here if desired
}
