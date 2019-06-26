#installation

first run:  sudo sysctl -w vm.max_map_count=262144    //to enable elastic to allocated memory.

second run  docker-compose up.

third run   docker-compose run web bundle exec rake db:setup   // to setup database.

rails server run on http://localhost:3000.


Here is postman collection for apis : https://www.getpostman.com/collections/34aea43526943c07ab23
