// app/services/rabbitmq.js
const amqp = require('amqplib');

let channel;
const QUEUE = 'commandes';

async function connectRabbitMQ() {
  try {
    const conn = await amqp.connect('amqp://admin:admin@rabbitmq');
    channel = await conn.createChannel();
    await channel.assertQueue(QUEUE, { durable: true });
    console.log('✅ RabbitMQ connecté');
  } catch (err) {
    console.error('❌ Erreur RabbitMQ:', err.message);
    console.log('🔄 Reconnexion dans 5 secondes...');
    setTimeout(connectRabbitMQ, 5000);
  }
}

function publierCommande(commande) {
  if (!channel) {
    console.warn('⚠️ RabbitMQ non connecté. Impossible de publier.');
    return;
  }
  const msg = JSON.stringify(commande);
  channel.sendToQueue(QUEUE, Buffer.from(msg), { persistent: true });
  console.log('📤 Message publié dans RabbitMQ');
}

module.exports = { connectRabbitMQ, publierCommande };
