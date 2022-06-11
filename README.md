# MySQL Transparent Data Encryption (TDE)

This is a sandbox environment created in docker to check the encryption mechanism and LIKE clause search behavior on a mysql server with Transparent Data Encryption enabled.

# Usage

Basically, work in either the `use-tde` directory or the `normal` directory.

```
.
├── README.md
├── normal     <- Not tde environment
└── use-tde    <- Tde environment
```

The operation is the same for both directories.

## Init

Initialize the environment.

```
make init
```

## Start mysql server

Start mysql server

```
make run
```

If the following output is obtained, the program has been successfully started.

```
Version: '5.7.38'  socket: '/var/run/mysqld/mysqld.sock'  port: 3306  MySQL Community Server (GPL)
```

## Use MySQL CLI

Open another tab and start mysql client to execute SQL.

```
make cli
```

If the mysql prompt appears, the system has started successfully.

I have already put the initial data into the test table of the test database, so you will use it to check the encryption operation.

```
mysql> desc test.test;
+-------+---------------------+------+-----+---------+----------------+
| Field | Type                | Null | Key | Default | Extra          |
+-------+---------------------+------+-----+---------+----------------+
| id    | bigint(20) unsigned | NO   | PRI | NULL    | auto_increment |
| name  | varchar(255)        | NO   |     | NULL    |                |
+-------+---------------------+------+-----+---------+----------------+
```

# To check encrypted data

Since mysql writes in binary to the data file, open the data file with the `strings` command and make sure it is encrypted.

```
strings data/test/test.ibd
```

## normal directory

You can check the raw data by running it in the `normal` environment.

```
infimum
supremum
test
test2
```

## use-tde directory

On the other hand, when run in the `use-tde` environment, it can be seen that it is encrypted.

```
...
"ca~ue7}%+
:A^@gm
i&%A
b$E%
j7K=?
```

# Pattern maching

## normal directory

Naturally, you can search for LIKE in the `normal` environment.

```
mysql> select * from test.test where name like 'te%';
+----+-------+
| id | name  |
+----+-------+
|  1 | test  |
|  2 | test2 |
+----+-------+
```

## use-tde directory

We can confirm that the `use-tde` environment can also correctly search for LIKE.

```
mysql> select * from test.test where name like 'te%';
+----+-------+
| id | name  |
+----+-------+
|  1 | test  |
|  2 | test2 |
+----+-------+
```
