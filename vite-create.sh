#!/bin/bash

PROJECTS_DIR="~/Projects"

read -p "Enter project name: " projectname
read -p "Choose framework (react/vue/svelte): " framework

mkdir -p $PROJECTS_DIR
cd $PROJECTS_DIR

echo "Creating Vite project..."
npm create vite@latest $projectname -- --template $framework

cd $projectname

echo "Installing dependencies..."
npm install

echo "Opening in VS Code..."
code .

echo "Done! Project created at $PROJECTS_DIR/$projectname"
