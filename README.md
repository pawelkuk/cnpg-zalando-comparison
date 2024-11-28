# CNPG/zalando operator comparison

## Setup

### Local cluster

1. Multinode cluster:

   `kind create cluster --name cnpg-zalando-comparison --config kind.yaml`

2. Kind cloud provider to make loadBalancer type services work:

   `go install sigs.k8s.io/cloud-provider-kind@latest && sudo cloud-provider-kind`

## Comparison TODO
- backups
	- how is it triggered (via `Backup` and `ScheduledBackup` crds)
	- what instead of wal-g (barman-cloud)
	- how to do sth like `wal-g backup-list`
		- `export AWS_SECRET_ACCESS_KEY=minio1234 && export AWS_ACCESS_KEY_ID=minio`
		- `barman-cloud-backup-list --cloud-provider aws-s3 --endpoint-url http://minio.minio.svc.cluster.local:9000 s3://backups cluster`
- restore
	- multiple options: from Backup object, from object store, PIT, from volume snapshots
- leader election
	- what instead of patroni (everything handled by the operator)
	- how to gain insight into state of cluster (kubectl cnpg plugin, psql, barman commands from within container)
- switchover and failover 
	- can specify time to archive/replicate walls in order to ensure no data loss (or a fast failover in order to minimise downtime - recovery point objective RPO vs recovery time objective RTO)
- api 
	- what crds are provided
	- how to interact with it
- affinity/anti-affinity
	- can be configured without problems
	- by default preferred different nodes
- performance of the operator (is it as slow as zalando operator - not at all)
- secret creation and update (done differently then zalando - does not apply)
- customisation
	- users
	- databases
	- extensions (some predefined)
	- postgres.conf
	- sidecars (no sidecars!)
- image (can define custom images(!!!) which have some minimal requirements, no spilo image)
- debugability
	- cnpg kubectl plugin quite nice :)
- resizing (can do out of box if storage class supports, kind's local storage does not support this)
- delayed deletion (are pvcs deleted when scaling up/down?, you always can restore the instance from a backup)
- tls 
	- standard, works fine, example with self sign certificate
- how fast is the replica/primary exchange??
- upgrading postgres versions??
### Potential problems
- migration path
	- [Bootstrap from a live cluster (`pg_basebackup`)](https://cloudnative-pg.io/documentation/1.24/bootstrap/)
- switchover/failover downtime as function of load on database
