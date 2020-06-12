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
  var randomName = faker.company.companyName();
  var randomDescription = faker.company.catchPhrase();
  var randomAdresse = faker.address.streetAddress(true);
  var randomEmail = faker.internet.email();
  var randomPhone = faker.phone.phoneNumber("0#########");
  var randomDate = faker.date.past(10);
  const AssoQuery =
    "INSERT INTO na17p2.association(nom, description, adresse, email, telephone, date_creation) VALUES ($1, $2, $3, $4, $5, $6) RETURNING *";
  const values = [
    randomName,
    randomDescription,
    randomAdresse,
    randomEmail,
    randomPhone,
    randomDate,
  ];
  const q = await pool.query(AssoQuery, values);
  var id_asso = [q.rows[0].id_association];
  const FédéQuery =
    "INSERT INTO na17p2.fédération(id_federation, id_association) VALUES (1, $1) RETURNING *";
  pool.query(FédéQuery, id_asso);
  res.json(JSON.stringify(q.rows));
};
