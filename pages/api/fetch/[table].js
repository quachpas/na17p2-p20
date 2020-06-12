
const { Pool, Client } = require('pg')

const pool = new Pool({
  host: 'localhost',
  port: 5432,
  database: 'postgres',
  user: 'postgres',
  password: 'postgres',
})


export default async (req, res) => {
  const {
    query: { table },
  } = req

  // don't do this ↓ in production
  const q = await pool.query(`SELECT * FROM na17p2.${table}`)
  return res.json(JSON.stringify(q.rows))
}