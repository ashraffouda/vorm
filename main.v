module main

import db.sqlite
import time
import os

struct Person {
	id            int       [primary; sql: serial]
	name          string    [nonull]
	date_of_birth time.Time [sql_type: 'DATETIME']
	address       string
	photo         []u8      [sql_type: 'BLOB']
}

fn main() {
	mut db := sqlite.connect('persons.db')!
	sql db {
		create table Person
	}!
	image_path := 'ashraf.jpg'
	image := os.read_bytes(image_path)!
	println(image)
	person := Person{
		name: 'Ashraf'
		date_of_birth: time.now()
		photo: image
		address: 'Cairo'
	}
	sql db {
		insert person into Person
	}!
	p := sql db {
		select from Person
	}!
	println(p)
}
