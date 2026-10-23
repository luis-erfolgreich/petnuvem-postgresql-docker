# Dockerfile — PetNuvem
# Banco de dados PostgreSQL em container para a startup PetNuvem.

# Requisito 1: imagem oficial com versão fixa (sem latest)
FROM postgres:16-alpine

# Requisito 2: labels com nome da startup e mantenedor
LABEL org.opencontainers.image.title="PetNuvem Database" \
      org.opencontainers.image.description="Banco de dados PostgreSQL da startup PetNuvem" \
      maintainer="Luís Marsseli"

# Requisito 3: variável de ambiente para o nome do banco
ENV POSTGRES_DB=petnuvem

# Requisito 4: a senha NÃO está definida aqui.
# Ela deve ser fornecida em tempo de execução via variável de ambiente
# POSTGRES_PASSWORD ou por meio de um secrets manager (ex: Docker secrets).
# Exemplo de execução:
#   docker run -e POSTGRES_PASSWORD=suasenha ...

# Requisito 5: copia o script de inicialização para o diretório padrão do entrypoint
COPY init.sql /docker-entrypoint-initdb.d/init.sql

# Requisito 6: declara a porta padrão do PostgreSQL
EXPOSE 5432

# Requisito 7: healthcheck usando pg_isready verificando o banco petnuvem
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
  CMD pg_isready -U "${POSTGRES_USER:-postgres}" -d petnuvem || exit 1
