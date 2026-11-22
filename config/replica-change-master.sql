-- ajetaan serverillä B. Oikea salasana ei ole täällä repossa.
CHANGE MASTER TO
  MASTER_HOST='192.168.1.201',
  MASTER_USER='replicator',
  MASTER_PASSWORD='<REPLICATION_PASSWORD>',
  MASTER_LOG_FILE='primary-bin.000001',
  MASTER_LOG_POS=1201,
  MASTER_USE_GTID=no;
START REPLICA;
