#include <thread>
#include <iostream>

int main() {
    std::thread t([](){ std::cout << "Thread running\n"; });
    t.join();
    return 0;
}