# Bookmarks

**About this project**

This is a bookmark manager. A bookmark manager is a website to maintain a collection of bookmarks (URLs). You can use it to save a webpage you found useful. You can add tags to the webpages you saved to find them later. You can browse bookmarks other users have added. You can comment on the bookmarks.

**Project goals**

To build a simple web app with a database.

**Creating databases from scratch**

1. Connect to psql
2. Create the database using the psql command

```sh
CREATE DATABASE manager_bookmark;
```

3. Connect to the database using the psql command

```sh
\c bookmark_manager;
```

4. Run the quer we have saved in the file

```sh
01_create_bookmarks_table.sql
```

**Running the tests**

```sh
rspec
```

**Running the program**

```sh
rackup
```
