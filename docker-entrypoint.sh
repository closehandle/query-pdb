#!/usr/bin/env bash
exec query_pdb_server --ip "${BIND_ADDR}" --port "${BIND_PORT}" --path "${DATA_PATH}"
