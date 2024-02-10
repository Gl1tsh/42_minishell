NAME = minishell
CC = gcc
CFLAGS = -Wall -Werror -Wextra -g -I/usr/local/opt/readline/include
LDFLAGS = -L/usr/local/opt/readline/lib -lreadline
BUILDDIR = build/
LIBFT = libft/libft.a
INCLUDES = -I./include -I./libft
CRED = \033[1;31m
CGRN = \033[1;32m
CYEL = \033[1;33m
RSET = \033[0m
CVIO = \033[1;35m

SRCS1 = src/builtin/cd.c src/builtin/echo.c src/builtin/env.c src/builtin/exit.c src/builtin/pwd.c src/builtin/unset.c src/builtin/export.c
SRCS2 = src/run_command.c src/run_command2.c src/parsing.c src/parsing2.c src/path.c src/dstr.c src/heredoc.c src/env.c src/utils.c src/main.c
OBJS1 = $(patsubst src/%.c,$(BUILDDIR)%.o,$(SRCS1))
OBJS2 = $(patsubst src/%.c,$(BUILDDIR)%.o,$(SRCS2))

# Variable pour stocker si des avertissements ont été générés lors de la compilation
HAS_WARNINGS :=

# Règle pour compiler un fichier .c en fichier .o
.c.o:
	@printf "\r\033[K│ Compiling $<... "
	@$(CC) $(CFLAGS) -c $< -o $@ 2> temp_warnings || (cat temp_warnings && printf "${CRED}minishell compiling failed${RSET}     " && exit 1)
	@if grep -q "warning" temp_warnings; then \
		echo 1 > has_warnings; \
	fi

# Règle pour compiler un fichier .c en fichier .o dans le répertoire BUILDDIR
${BUILDDIR}%.o: src/%.c
	@mkdir -p $(dir $@)
	@${CC} ${CFLAGS} ${INCLUDES} -c $< -o $@ 2> temp_warnings || (printf "│ Compiling ${CRED}$< = failed${RSET}\n" && cat temp_warnings && printf "├──────────\n├─>>> ${CRED}minishell compiling failed!${RSET}\n└──────────\n" && exit 1)
	@if grep -q "warning" temp_warnings; then \
		printf "│ Compiling ${CVIO}$< = warnings${RSET}\n"; \
		echo 1 > has_warnings; \
	else \
		printf "│ Compiling ${CGRN}$< = OK${RSET}\n"; \
	fi
	@cat temp_warnings
	@rm -f temp_warnings


# Règle pour créer l'exécutable
${NAME}: 
	@printf "\n"
	@printf "${CGRN}MINISHELL COMPILING${RSET}\n"
	@printf "├──────────\n"
	@printf "│ Compiling ${CGRN}libft${RSET}...\n"
	@${MAKE} -s -C libft all
	@printf "├──────────\n"
	@${MAKE} ${OBJS1}
	@printf "├──────────\n"
	@${MAKE} ${OBJS2}
	@printf "├──────────\n"
	@if [ -f has_warnings ]; then \
		printf "├─>>>${CGRN} minishell compiled ${CVIO}but with warnings!${RSET}\n"; \
	else \
		printf "├─>>>${CGRN} minishell compiled!${RSET}\n"; \
	fi
	@printf "└──────────\n"
	@rm -f has_warnings
	@${CC} -o ${NAME} ${OBJS1} ${OBJS2} ${LIBFT} ${LDFLAGS}

${LIBFT}:
	@printf "│ Compiling ${CGRN}libft${RSET}...\n"
	@${MAKE} -C libft all

# Règle pour nettoyer les fichiers objets
clean:
	@printf "┌──────────\n"
	@printf "│\tRemoving ${CRED}${BUILDDIR}${RSET} for ${CYEL}${NAME}${RSET}\n"
	@find ${BUILDDIR} -type f -delete
	@${MAKE} -C libft clean

# Règle pour nettoyer les fichiers objets et l'exécutable
fclean: clean
	@if [ -e "./${NAME}" ]; then \
		printf "│\tRemoving ${CYEL}${NAME}${RSET}\n└──────────\n"; \
		rm -f ${NAME}; \
	fi
	@${MAKE} -C libft fclean

all: ${NAME}

# Règle pour recompiler les fichiers objets et l'exécutable
re:
	@printf "\n┌──────────\n│ Cleaning and ${CGRN}recompiling${RSET}...\n"
	@${MAKE} fclean
	@${MAKE} all

error:
	@printf "${CVIO}├─>>> Warnings:${RSET}\n"
	@printf "${CGRN}No warnings were generated during the last build.${RSET}\n"

.PHONY: all clean fclean re