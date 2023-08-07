module main

import db.sqlite
import time
import os
import encoding.base64
struct Person {
	id            int       [primary; sql: serial]
	name          string    [nonull]
	date_of_birth time.Time [sql_type: 'DATETIME']
	address       string
	photo         string      [sql_type: 'BLOB']
}

fn main() {
	mut db := sqlite.connect('persons.db')!
	sql db {
		create table Person
	}!
	image_path := 'ashraf.jpg'
	image := os.read_bytes(image_path)!
	image_base64 := base64.encode(image)
	person := Person{
		name: 'Ashraf'
		date_of_birth: time.now()
		photo: image_base64
		address: 'Cairo'
	}
	sql db {
		insert person into Person
	}!
	p := sql db {
		select from Person
	}!
	image_bytes := base64.decode(p[0].photo)
	mut f := os.create('copy.jpg')!
	f.write(image_bytes)!
	f.close()
	
}
