# README

* Ruby version: 3.2.2
* Rails version: 7.0.4.3
* Postrgresql 13

To start:

1. At the root folder: run `bundle install`

2. run `rails db:drop`

3. run `rails db:create`

4. run `rails db:migrate`

5. run `rails c` and copy paste the commands from `db commands.txt`

6. run `rails s`

7. On your Chrome browser, go to `localhost:3000`

8. To access the isbn converter on the frontend, click the `Contact` button at the top right

9. For Endpoints:

  a. To access book information endpoint
    - http://localhost:3000/books/get_json_search?isbn=978-1-891830-02-0
    - replace 978-1-891830-02-0 with your isbn
  b. To access isbn transformer endpoint (isbn10 to 13 or vice versa)
    - http://localhost:3000/books/isbn_transformer?isbn=1-891-83085-6
    - replace the 1-891-83085-6 with your isbn