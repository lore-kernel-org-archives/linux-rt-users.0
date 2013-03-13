From: Clark Williams <williams@redhat.com>
Subject: RFC: cyclictest patch to dump stats on demand via fifo
Date: Wed, 13 Mar 2013 16:35:05 -0500
Message-ID: <20130313163505.7302675d@riff.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/cGgiM7CNCDrnOCegsIFaR5x"; protocol="application/pgp-signature"
To: John Kacur <jkacur@redhat.com>, RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54737 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933334Ab3CMVfI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 13 Mar 2013 17:35:08 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r2DLZ89s013026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-rt-users@vger.kernel.org>; Wed, 13 Mar 2013 17:35:08 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/cGgiM7CNCDrnOCegsIFaR5x
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

This patch is in addition to the dump-stats-on-SIGUSR1 I posted
previously.

I occurred to me that dumping stats to stdout was cool, except for when
someone had stdout redirected to a pipe; then not so much. So I came up
with an option to create a named fifo and to dump the current run stats
out to the fifo whenever someone opened and read it.=20

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 0a15dcb..a8f9534 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1,6 +1,8 @@
 /*
  * High resolution timer test software
  *
+ * (C) 2013      Clark Williams <williams@redhat.com>
+ * (C) 2013      John Kacur <jkacur@redhat.com>
  * (C) 2008-2012 Clark Williams <williams@redhat.com>
  * (C) 2005-2007 Thomas Gleixner <tglx@linutronix.de>
  *
@@ -178,6 +180,8 @@ static int force_sched_other;
 static int priospread =3D 0;
 static int check_clock_resolution;
 static int ct_debug;
+static int use_fifo =3D 0;
+static pthread_t fifo_threadid;
=20
 static pthread_cond_t refresh_on_max_cond =3D PTHREAD_COND_INITIALIZER;
 static pthread_mutex_t refresh_on_max_lock =3D PTHREAD_MUTEX_INITIALIZER;
@@ -195,10 +199,16 @@ static struct kvars {
 static char *procfileprefix =3D "/proc/sys/kernel/";
 static char *fileprefix;
 static char tracer[MAX_PATH];
+static char fifopath[MAX_PATH];
 static char **traceptr;
 static int traceopt_count;
 static int traceopt_size;
=20
+static struct thread_param **parameters;
+static struct thread_stat **statistics;
+
+static void print_stat(FILE *fp, struct thread_param *par, int index, int =
verbose, int quiet);
+
 static int latency_target_fd =3D -1;
 static int32_t latency_target_value =3D 0;
=20
@@ -961,6 +971,7 @@ static void display_help(int error)
 	       "-e       --latency=3DPM_QOS  write PM_QOS to /dev/cpu_dma_latency=
\n"
 	       "-E       --event           event tracing (used with -b)\n"
 	       "-f       --ftrace          function trace (when -b is active)\n"
+	       "-F       --fifo=3D<path>     create a named pipe at path and writ=
e stats to it\n"
 	       "-h       --histogram=3DUS    dump a latency histogram to stdout a=
fter the run\n"
 	       "                           (with same priority about many threads=
)\n"
 	       "                           US is the max time to be be tracked in=
 microseconds\n"
@@ -1099,6 +1110,7 @@ static void process_options (int argc, char *argv[])
 			{"latency",          required_argument, NULL, 'e'},
 			{"event",            no_argument,       NULL, 'E'},
 			{"ftrace",           no_argument,       NULL, 'f'},
+			{"fifo",             required_argument, NULL, 'F'},
 			{"histogram",        required_argument, NULL, 'h'},
 			{"histofall",        required_argument, NULL, 'H'},
 			{"interval",         required_argument, NULL, 'i'},
@@ -1163,6 +1175,10 @@ static void process_options (int argc, char *argv[])
 			break;
 		case 'E': enable_events =3D 1; break;
 		case 'f': tracetype =3D FUNCTION; ftrace =3D 1; break;
+		case 'F':=20
+			use_fifo =3D 1;=20
+			strncpy(fifopath, optarg, strlen(optarg));
+			break;
 		case 'H': histofall =3D 1; /* fall through */
 		case 'h': histogram =3D atoi(optarg); break;
 		case 'i': interval =3D atoi(optarg); break;
@@ -1368,6 +1384,19 @@ static int check_timer(void)
=20
 static void sighand(int sig)
 {
+	if (sig =3D=3D SIGUSR1) {
+		int i;
+		int oldquiet =3D quiet;
+
+		quiet =3D 0;
+		printf("#---------------------------\n");
+		printf("# cyclictest current status:\n");
+		for (i =3D 0; i < num_threads; i++)
+			print_stat(stdout, parameters[i], i, 0, 0);
+		printf("#---------------------------\n");
+		quiet =3D oldquiet;
+		return;
+	}
 	shutdown =3D 1;
 	if (refresh_on_max)
 		pthread_cond_signal(&refresh_on_max_cond);
@@ -1460,7 +1489,7 @@ static void print_hist(struct thread_param *par[], in=
t nthreads)
 	printf("\n");
 }
=20
-static void print_stat(struct thread_param *par, int index, int verbose)
+static void print_stat(FILE *fp, struct thread_param *par, int index, int =
verbose, int quiet)
 {
 	struct thread_stat *stat =3D par->stats;
=20
@@ -1473,10 +1502,10 @@ static void print_stat(struct thread_param *par, in=
t index, int verbose)
 			else
 				fmt =3D "T:%2d (%5d) P:%2d I:%ld C:%7lu "
 					"Min:%7ld Act:%5ld Avg:%5ld Max:%8ld\n";
-				printf(fmt, index, stat->tid, par->prio,
-				       par->interval, stat->cycles, stat->min, stat->act,
-				       stat->cycles ?
-				       (long)(stat->avg/stat->cycles) : 0, stat->max);
+			fprintf(fp, fmt, index, stat->tid, par->prio,
+				par->interval, stat->cycles, stat->min, stat->act,
+				stat->cycles ?
+				(long)(stat->avg/stat->cycles) : 0, stat->max);
 		}
 	} else {
 		while (stat->cycles !=3D stat->cyclesread) {
@@ -1488,8 +1517,8 @@ static void print_stat(struct thread_param *par, int =
index, int verbose)
 				stat->cycleofmax =3D stat->cyclesread;
 			}
 			if (++stat->reduce =3D=3D oscope_reduction) {
-				printf("%8d:%8lu:%8ld\n", index,
-				       stat->cycleofmax, stat->redmax);
+				fprintf(fp, "%8d:%8lu:%8ld\n", index,
+					stat->cycleofmax, stat->redmax);
 				stat->reduce =3D 0;
 				stat->redmax =3D 0;
 			}
@@ -1498,13 +1527,49 @@ static void print_stat(struct thread_param *par, in=
t index, int verbose)
 	}
 }
=20
+
+/*=20
+ * thread that creates a named fifo and hands out run stats when someone
+ * reads from the fifo.
+ */
+void *fifothread(void *param)
+{
+	int ret;
+	int fd;
+	FILE *fp;
+	int i;
+
+	if (use_fifo =3D=3D 0)
+		return NULL;
+
+	unlink(fifopath);
+	ret =3D mkfifo(fifopath, 0666);
+	if (ret) {
+		fprintf(stderr, "Error creating fifo %s: %s\n", fifopath, strerror(errno=
));
+		return NULL;
+	}
+	while (!shutdown) {
+		fd =3D open(fifopath, O_WRONLY|O_NONBLOCK);
+		if (fd < 0) {
+			usleep(500000);
+			continue;
+		}
+		fp =3D fdopen(fd, "w");
+		for (i=3D0; i < num_threads; i++)
+			print_stat(fp, parameters[i], i, 0, 0);
+		fclose(fp);
+		usleep(250);
+	}
+	unlink(fifopath);
+	return NULL;
+}
+
+
 int main(int argc, char **argv)
 {
 	sigset_t sigset;
 	int signum =3D SIGALRM;
 	int mode;
-	struct thread_param **parameters;
-	struct thread_stat **statistics;
 	int max_cpus =3D sysconf(_SC_NPROCESSORS_CONF);
 	int i, ret =3D -1;
 	int status;
@@ -1642,6 +1707,7 @@ int main(int argc, char **argv)
=20
 	signal(SIGINT, sighand);
 	signal(SIGTERM, sighand);
+	signal(SIGUSR1, sighand);
=20
 	parameters =3D calloc(num_threads, sizeof(struct thread_param *));
 	if (!parameters)
@@ -1755,6 +1821,8 @@ int main(int argc, char **argv)
 			fatal("failed to create thread %d: %s\n", i, strerror(status));
=20
 	}
+	if (use_fifo)
+		status =3D pthread_create(&fifo_threadid, NULL, fifothread, NULL);
=20
 	while (!shutdown) {
 		char lavg[256];
@@ -1784,7 +1852,7 @@ int main(int argc, char **argv)
=20
 		for (i =3D 0; i < num_threads; i++) {
=20
-			print_stat(parameters[i], i, verbose);
+			print_stat(stdout, parameters[i], i, verbose, quiet);
 			if(max_cycles && statistics[i]->cycles >=3D max_cycles)
 				allstopped++;
 		}
@@ -1816,7 +1884,7 @@ int main(int argc, char **argv)
 		if (statistics[i]->threadstarted) {
 			pthread_join(statistics[i]->thread, NULL);
 			if (quiet && !histogram)
-				print_stat(parameters[i], i, 0);
+				print_stat(stdout, parameters[i], i, 0, 0);
 		}
 		if (statistics[i]->values)
 			threadfree(statistics[i]->values, VALBUF_SIZE*sizeof(long), parameters[=
i]->node);

--Sig_/cGgiM7CNCDrnOCegsIFaR5x
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlFA8QkACgkQHyuj/+TTEp1wtACfYMRdCM6ZL3zvB5HCl9uQ1BmS
WGkAnAviBHL6zkWqBYgnRAlKbcjHmubE
=rmvq
-----END PGP SIGNATURE-----

--Sig_/cGgiM7CNCDrnOCegsIFaR5x--
