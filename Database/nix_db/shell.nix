{mypkgs ? import <nixpkgs> {}}:
with mypkgs; let
  inherit (lib) optional optionals;
in
  mkShell {
    buildInputs =
      [
        postgresql_16_jit
      ]
      ++ optional stdenv.isLinux inotify-tools # For file_system on Linux.
      ++ optionals stdenv.isDarwin (with darwin.apple_sdk.frameworks; [
        # For file_system on macOS.
        CoreFoundation
        CoreServices
      ]);

    # Put the PostgreSQL databases in the project diretory.
    shellHook = ''
      export PGDATA="$(pwd)/db"
      export PGHOST="$(pwd)"
      export PGPORT="5432"

      if [[ ! $(grep listen_address $PGDATA/postgresql.conf) ]]; then
      echo "db does not exist, creating "
      initdb -D $PGDATA --no-locale --encoding=UTF8 >> /dev/null
      cat >> "$PGDATA/postgresql.conf" <<-EOF
      listen_addresses = 'localhost'
      port = $PGPORT
      unix_socket_directories = '$PGHOST'
      EOF

      echo "CREATE USER postgres SUPERUSER;" | postgres --single -E postgres
      fi

      pg_ctl -D ./db -l logfile start
      echo "Database has been started"

      trap "pg_ctl -D ./db stop" EXIT
    '';
  }
