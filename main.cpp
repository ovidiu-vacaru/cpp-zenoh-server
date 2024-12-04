#include "zenoh.hxx"
using namespace zenoh;

int main(int argc, char **argv) {
   try {
      Config config = Config::create_default();
      auto session = Session::open(std::move(config));
      session.put(KeyExpr("demo/example/simple"), "Simple!");
   } catch (ZException e) {
      std::cout << "Received an error :" << e.what() << "\n";
   }
}
