# MINISHELL

The Minishell project at 42 school is an introductory project that focuses on building a simple Unix shell in the C programming language. A Unix shell is a command-line interpreter that allows users to interact with the operating system by executing commands.

This project introduces students to several key concepts in systems programming and Unix environment, including:

- *Command Parsing*: Students must implement a parser to tokenize and parse user input into individual command arguments and options.

- *Built-in Commands*: The shell must support a set of built-in commands, such as cd (change directory), echo (print text), and exit (terminate the shell).

- *External Commands*: The shell must also be able to execute external commands by forking a new process and using execve system call to execute the command.

- *Redirection and Pipes*: Students must implement redirection operators (<, >) and pipe operator (|) to redirect input and output streams between processes.

- *Environment Variables*: The shell must support environment variables, allowing users to set, unset, and expand environment variables in command arguments.

- *Signal Handling*: Proper signal handling is crucial to handle signals such as SIGINT (Ctrl+C) and SIGQUIT (Ctrl+\) to gracefully terminate the shell and child processes.

- *Job Control*: Advanced features such as job control, allowing users to suspend, resume, and manage background processes, can also be implemented for extra credit.

In summary, the Minishell project provides students with hands-on experience in systems programming and Unix shell scripting. It allows them to apply their knowledge of C programming and Unix system calls to create a functional command-line interface similar to popular Unix shells like Bash or Zsh.

# How to launch :

## First step
- You need to clone the repository with the following command in the terminal: 

```git clone https://github.com/Gl1tsh/42_minishell.git```

- Now you need to enter the folder of the clone you've made

## Start the program

- Run the command: ```make```
- Once compiled, launch it with the next commands : ```./minishell```
- To quit the program, use the ```exit``` command
