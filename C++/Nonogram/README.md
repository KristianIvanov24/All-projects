# Nonogram Puzzle Game

## Overview

This project implements a version of the game Nonogram (https://en.wikipedia.org/wiki/Nonogram). It uses image descriptions loaded from files that players must decipher. Each image is represented by a matrix of empty and filled cells along with a sequence of numbers above each column and to the left of each row. These numbers indicate continuous sequences of filled cells. For instance, in Figure 1, the numbers <1 2 4> correspond to one filled cell, followed by an unknown number of empty cells, then two consecutive filled cells, more empty cells, and finally four consecutive filled cells.

## Features

- The game supports player profiles (e.g., through files) to track a player's progress, including the highest difficulty level reached and the current state of the puzzle they're working on.
- When the game starts, players are prompted to enter their user profile. If successful, they can either resume their last attempt or start from scratch at a specific difficulty level they've already completed.
- The game offers at least five difficulty levels, each corresponding to a different puzzle size and a maximum number of allowed wrong answers (N).
- Each difficulty level has a minimum of two distinct puzzles to choose from, selected randomly.

## Gameplay

Players can perform the following actions:

1. When the game begins and after a successful login, players can choose to continue their last attempt or start fresh at a difficulty level they've previously completed (at the beginning of each level, the puzzle appears as shown in Figure 2).

2. Players can input coordinates on the matrix grid and indicate whether a cell is empty or filled.
   - If they choose "empty," the cell is marked accordingly.
   - If they choose "filled" and guess correctly, the cell is marked as known.
   - If they guess incorrectly, the number of wrong answers increases.
   - If the number of wrong answers reaches N, the player loses the game.

3. When players correctly guess all filled cells in a row or column, the remaining cells in that row or column are automatically marked as empty.

4. Once a player successfully solves the entire puzzle, they advance to the next difficulty level.

## Saving Progress

Players can exit the game while preserving their current puzzle state, including all assumptions they've made.

## Disclaimer

This README provides an overview of the project's purpose, features, and gameplay. Please consult the game's documentation for detailed instructions on compiling and running the game.
