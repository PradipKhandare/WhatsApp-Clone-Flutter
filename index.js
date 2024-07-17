const express = require("express");
const http = require("http");
const cors = require("cors");
const socketIo = require("socket.io");

const app = express();
const port = process.env.PORT || 6000;

const server = http.createServer(app);
const io = socketIo(server, {
    cors: {
        origin: "*",
        methods: ["GET", "POST"]
    }
});

// Middleware
app.use(express.json());
var clients = {};
app.use(cors());

io.on("connection", (socket) => {
    console.log("Connected");
    console.log(socket.id, "has joined");

    socket.on("signin", (id) => {
        console.log(id);
        clients[id] = socket;
        console.log(clients);
    });

    app.route("/check").get((req, res) => {
        return res.json("Your app is working fine");
    })

    socket.on("message", (message) => {
        console.log(message);
        let targetId = message.targetId;
        if (clients[targetId]) clients[targetId].emit("message", message);
    });
});

server.listen(port, "0.0.0.0", () => {
    console.log(`Server started on port ${port}`);
});
