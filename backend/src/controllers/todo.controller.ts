import { Request, Response } from "express";
import { prisma } from "../lib/prisma.js";

export const getTodos = async (req: Request, res: Response) => {
    try {

        const todos = await prisma.todo.findMany({
            orderBy: {
                createdAt: "desc"
            }
        });

        res.json(todos);
        
    } catch (error) {
        console.error(error);

        res.status(500).json({
            message: "Failed to fetch todos",
        });
    }
}

export const getTodo = async (req: Request, res: Response) => {
    try {

        const id = Number(req.params.id);

        const todo = await prisma.todo.findUnique({
            where: {
                id,
            },
        });

        res.json(todo);
        
    } catch (error) {
        console.error(error);

        res.status(500).json({
            message: "Failed to fetch todo",
        });

    }
}

export const createTodo = async (req: Request, res: Response) => {
    try {

        const { title, description } = req.body;

        if (!title) {
            return res.status(400).json({
                message: "Title is required",
            });
        }

        const todo = await prisma.todo.create({
            data: {
                title, 
                description
            }
        });

        res.status(201).json(todo);
        
    } catch (error) {
        console.error(error);

        res.status(500).json({
            message: "Failed to create todo",
        });
    }
}

export const updateTodo = async (req: Request, res: Response) => {
    try {

        const id = Number(req.params.id);
        const { title, description, completed } = req.body;

        const todo = await prisma.todo.update({
            where: {
                id,
            },
            data: {
                title,
                description,
                completed
            }
        });

        res.json(todo);
        
    } catch (error) {
        console.error(error);

        res.status(500).json({
            message: "Failed to update todo",
        });
    }
}

export const deleteTodo = async (req: Request, res: Response) => {
    try {

        const id = Number(req.params.id);

        await prisma.todo.delete({
            where: {
                id,
            },
        });

        res.json({
         message: "Todo deleted successfully",
        });
        
    } catch (error) {
        console.error(error);

        res.status(500).json({
            message: "Failed to delete todo",
        });
    }
}