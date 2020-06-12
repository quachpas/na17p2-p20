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
  var randomFirstName = faker.name.firstName()
  var randomLastName = faker.name.lastName()
  var randomPassword = faker.internet.password(255)
  var randomBool = faker.random.boolean()
  var randomDateInscription = faker.date.past(1)
  var randomDateDerniereConnexion= faker.date.recent(5)
  var randomAdresse = faker.address.streetAddress(true)
  var randomEmail = faker.internet.email(randomFirstName, randomLastName)
  var randomPhone = faker.phone.phoneNumberFormat(10)
  var randomWebsite = faker.internet.url()
  const UserQuery = 'INSERT INTO na17p2.utilisateurs(nom, prenom, mdp, vnom, vprenom, vphoto, date_inscription, date_derniere_connexion, adresse, email, phone, website) VALUES($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13) RETURNING *'
  const values = [randomLastName, randomFirstName, randomPassword, randomBool, randomDateInscription, randomDateDerniereConnexion, randomAdresse, randomEmail, randomPhone, randomWebsite]
  const q = await pool.query(UserQuery, values)
  var idUser = [q.rows[0].id_user]
  const RoleUserQuery = 'INSERT INTO na17p2.Role_utilisateur(id_role, id_user) VALUES (1,$1) RETURNING *'
  pool.query(RoleUserQuery, idUser)
  res.json(JSON.stringify(q.rows))
}
