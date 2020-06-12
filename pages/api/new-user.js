const { Pool, Client } = require("pg");
var faker = require("faker");

const pool = new Pool({
  host: "localhost",
  port: 5432,
  database: "postgres",
  user: "postgres",
  password: "postgres",
});

export default async (req, res) => {
  var randomFirstName = faker.name.firstName();
  var randomLastName = faker.name.lastName();
  var randomPassword = faker.internet.password(255);
  var randomBool1 = faker.random.boolean();
  var randomBool2 = faker.random.boolean();
  var randomBool3 = faker.random.boolean();
  var randomDateInscription = faker.date.past(1);
  var randomDateDerniereConnexion = faker.date.recent(5);
  var randomAdresse = faker.address.streetAddress(true);
  var randomEmail = faker.internet.email(randomFirstName, randomLastName);
  var randomPhone = faker.phone.phoneNumber("0#########");
  var randomWebsite = faker.internet.url();
  const IdUserQuery = 'SELECT id_user FROM na17p2.utilisateur'
  const q_id_user = await pool.query(IdUserQuery);
  var IdUser = q_id_user.rows.length+1;
  const UserQuery =
    "INSERT INTO na17p2.utilisateur(id_user, nom, prenom, mdp, vnom, vprenom, vphoto, date_inscription, date_derniere_connexion, adresse, email, phone, website) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13) RETURNING *";
  const values = [
    IdUser,
    randomLastName,
    randomFirstName,
    randomPassword,
    randomBool1,
    randomBool2,
    randomBool3,
    randomDateInscription,
    randomDateDerniereConnexion,
    randomAdresse,
    randomEmail,
    randomPhone,
    randomWebsite,
  ];
  const q = await pool.query(UserQuery, values);
  const RoleUserQuery =
    "INSERT INTO na17p2.role_utilisateur(id_role, id_user) VALUES (1,$1) RETURNING *";
  pool.query(RoleUserQuery, IdUser);
  res.json(JSON.stringify(q.rows));
};
