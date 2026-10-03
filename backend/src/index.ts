import express from "express"
import { configDotenv } from "dotenv"
import todoRoutes from "./routes/todo.routes.js";

configDotenv();

const app = express()
const port = process.env.PORT || 4000

app.use(express.json());

app.use("/api/todos", todoRoutes);

app.listen(port, () => {
    console.log(`Server is running on port ${port}`)
})

app.get("/", (req, res) => {
    res.json({
        message: "Todo api is running"
    });
});