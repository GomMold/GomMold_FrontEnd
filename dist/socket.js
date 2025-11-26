const WebSocket = require('ws');

const PORT = 3055;

const wss = new WebSocket.Server({ port: PORT }, () => {
    console.log(`MCP WebSocket server running at ws://localhost:${PORT}`);
});

wss.on('connection', (ws) => {
    console.log('Figma client connected');

    ws.on('message', (msg) => {
        console.log('Received:', msg.toString());
    });

    ws.send('Hello from MCP WebSocket server');
});
