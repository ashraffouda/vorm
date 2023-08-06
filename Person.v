module main

import time
import sqlite

struct Person {
	id            int       [primary; sql: serial]
	name          string    [nonull]
	date_of_birth time.Time [sql_type: 'DATETIME']
	address       string
	photo         []u8
}
