const { Pool, Client } = require('pg')
var faker = require('faker')

const pool = new Pool({
  host: process.env.DB_HOST,
  port: process.env.DB_PORT,
  database: process.env.DB_NAME,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
})

export default async (req, res) => {
  var randomName = faker.company.companyName(20)
  var randomDescription = faker.company.catchPhrase()
  var randomAdresse = faker.address.streetAddress(true)
  var randomEmail = faker.internet.email()
  var randomPhone = faker.phone.phoneNumberFormat(10)
  var randomDate = faker.date.past(10)
  const AssoQuery = 'INSERT INTO na17p2.Association(nom, description, adresse, telephone, email, date_creation) VALUES ($1, $2, $3, $4, $5, $6) RETURNING *'
  const values = [randomName, randomDescription, randomAdresse, randomEmail, randomPhone, randomDate]
  const q = await pool.query(AssoQuery, values)
  var id_asso = [q.rows[0].id_association]
  const FédéQuery = 'INSERT INTO na17p2.Fédération(id_federation, id_association) VALUEES (1, $1) RETURNING *'
  pool.query(FédéQuery, id_asso)
  res.json(JSON.stringify(q.rows))
}
