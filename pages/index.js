// Exemple module node.js d'une API avec la BDD
// npm i
// npm run dev
import { Socket } from '@supabase/realtime-js'
import axios from 'axios'
var React = require('react')
const REALTIME_URL = process.env.REALTIME_URL || 'ws://localhost:4000/socket'

export default class Index extends React.Component {
  constructor() {
    super()
    this.state = {
      received: [],
      socketState: 'CONNECTING',
      utilisateurs: [],
      associations: [],
    }
    this.messageReceived = this.messageReceived.bind(this)

    this.socket = new Socket(REALTIME_URL)
    this.channelList = []
  }
  componentDidMount() {
    this.socket.connect()
    this.addChannel('realtime:*')
    this.addChannel('realtime:na17p2:associations')
    this.addChannel('realtime:na17p2:utilisateurs')
    this.addChannel('realtime:na17p2:utilisateurs:id=eq.2')
    this.fetchData()
  }
  addChannel(topic) {
    let channel = this.socket.channel(topic)
    channel.on('INSERT', (msg) => this.messageReceived(topic, msg))
    // channel.on('*', msg => console.log('INSERT', msg))
    // channel.on('INSERT', msg => console.log('INSERT', msg))
    // channel.on('UPDATE', msg => console.log('UPDATE', msg))
    // channel.on('DELETE', msg => console.log('DELETE', msg))
    channel
      .join()
      .receive('ok', () => console.log('Connecting'))
      .receive('error', () => console.log('Failed'))
      .receive('timeout', () => console.log('Waiting...'))
    this.channelList.push(channel)
  }
  messageReceived(channel, msg) {
    let received = [...this.state.received, { channel, msg }]
    this.setState({ received })
    if (channel === 'realtime:na17p2:utilisateurs') {
      this.setState({ utilisateurs: [...this.state.utilisateurs, msg.record] })
    }
    if (channel === 'realtime:na17p2:associations') {
      this.setState({ associations: [...this.state.associations, msg.record] })
    }
  }
  async fetchData() {
    try {
      let { data: utilisateurs } = await axios.get('/api/fetch/Utilisateur')
      let { data: associations } = await axios.get('/api/fetch/Association')
      this.setState({ utilisateurs, associations })
    } catch (error) {
      console.log('error', error)
    }
  }
  async insertUser() {
    let { data: user } = await axios.post('/api/new_user', {})
  }
  async insertAsso() {
    let { data: asso } = await axios.post('/api/new-asso', {})
  }
  render() {
    return (
      <div style={styles.main}>
        <div style={styles.row}>
          <div style={styles.col}>
            <h3>Changements</h3>
            <p>Écoute en temps-réel sur {REALTIME_URL}</p>
            <p>Cliquer sur les boutons ! </p>
          </div>
          <div style={styles.col}>
            <h3>Utilisateurs</h3>
            <button onClick={() => this.insertUser()}>Ajouter un utilisateur au hasard</button>
          </div>
          <div style={styles.col}>
            <h3>Associations</h3>
            <button onClick={() => this.insertAsso()}>Ajouter une association au hasard</button>
          </div>
        </div>
        <div style={styles.row}>
          <div style={styles.col}>
            {this.state.received.map((x) => (
              <div key={Math.random()}>
                <p>Received on {x.channel}</p>
                <pre style={styles.pre}>
                  <code style={styles.code}>{JSON.stringify(x.msg, null, 2)}</code>
                </pre>
              </div>
            ))}
          </div>
          <div style={styles.col}>
            {this.state.utilisateurs.map((user) => (
              <pre style={styles.pre} key={user.id}>
                <code style={styles.code}>{JSON.stringify(user, null, 2)}</code>
              </pre>
            ))}
          </div>
          <div style={styles.col}>
            {this.state.associations.map((Asso) => (
              <pre style={styles.pre} key={Asso.id}>
                <code style={styles.code}>{JSON.stringify(Asso, null, 2)}</code>
              </pre>
            ))}
          </div>
        </div>
      </div>
    )
  }
}

const styles = {
  main: { fontFamily: 'monospace', height: '100%', margin: 0, padding: 0 },
  pre: {
    whiteSpace: 'pre',
    overflow: 'auto',
    background: '#333',
    maxHeight: 200,
    borderRadius: 6,
    padding: 5,
  },
  code: { display: 'block', wordWrap: 'normal', color: '#fff' },
  row: { display: 'flex', flexDirection: 'row', height: '100%' },
  col: { width: '33%', maxWidth: '33%', padding: 10, height: '100%', overflow: 'auto' },
}
