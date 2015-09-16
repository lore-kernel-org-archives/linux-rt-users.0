From: Josh Cartwright <joshc@ni.com>
Subject: Re: [PATCH rt-tests 9/9] cyclictest: add option for dumping the
 histogram in a file
Date: Wed, 16 Sep 2015 14:56:50 -0500
Message-ID: <20150916195650.GJ3126@jcartwri.amer.corp.natinst.com>
References: <cover.1441038216.git.joshc@ni.com>
 <ef2410217389a838ed5059c4ac23670fe22492ae.1441038216.git.joshc@ni.com>
 <alpine.LFD.2.20.1509160103140.13077@riemann.fritz.box>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SdvjNjn6lL3tIsv0"
Cc: Clark Williams <williams@redhat.com>,
	linux-rt-users@vger.kernel.org,
	Gratian Crisan <gratian.crisan@ni.com>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod2.natinst.com ([130.164.80.23]:46973 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752483AbbIPT4w (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 16 Sep 2015 15:56:52 -0400
In-Reply-To: <alpine.LFD.2.20.1509160103140.13077@riemann.fritz.box>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--SdvjNjn6lL3tIsv0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2015 at 01:05:51AM +0200, John Kacur wrote:
> On Mon, 31 Aug 2015, Josh Cartwright wrote:
> > From: Gratian Crisan <gratian.crisan@ni.com>
> >=20
> > Add an option '-J' or '--histfile' to dump the latency histogram to <pa=
th>
> > instead of stdout. This allows for live update of the current min, avg,=
 and max
> > numbers while retaining the option to save histogram data for later ana=
lysis.
> >=20
> > Signed-off-by: Gratian Crisan <gratian.crisan@ni.com>
> > Signed-off-by: Josh Cartwright <joshc@ni.com>
[..]
>=20
> We worked really hard to remove the large amount of options, and we may=
=20
> have been over zealous in some cases (Carsten?).

Fair enough, cyclictest has way too many knobs.  Regardless, we've at
least found this particular option useful.

> If I were to accept this patch, I would at least like you to remove
> the short form option, and just have it in the long form.

Here is a v2 with the short form -J dropped.

Thanks,
  Josh

-- 8< --
=46rom: Gratian Crisan <gratian.crisan@ni.com>
Subject: [PATCH v2] cyclictest: add option for dumping the histogram in a f=
ile

Add an option '--histfile' to dump the latency histogram to <path>
instead of stdout. This allows for live update of the current min, avg,
and max numbers while retaining the option to save histogram data for
later analysis.

Signed-off-by: Gratian Crisan <gratian.crisan@ni.com>
Signed-off-by: Josh Cartwright <joshc@ni.com>
---
 src/cyclictest/cyclictest.c | 96 ++++++++++++++++++++++++++++-------------=
----
 1 file changed, 59 insertions(+), 37 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 62f7cd9..5c9600c 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -188,6 +188,7 @@ static int aligned =3D 0;
 static int secaligned =3D 0;
 static int offset =3D 0;
 static int laptop =3D 0;
+static int use_histfile =3D 0;
=20
 static pthread_cond_t refresh_on_max_cond =3D PTHREAD_COND_INITIALIZER;
 static pthread_mutex_t refresh_on_max_lock =3D PTHREAD_MUTEX_INITIALIZER;
@@ -210,6 +211,7 @@ static char *procfileprefix =3D "/proc/sys/kernel/";
 static char *fileprefix;
 static char tracer[MAX_PATH];
 static char fifopath[MAX_PATH];
+static char histfile[MAX_PATH];
 static char **traceptr;
 static int traceopt_count;
 static int traceopt_size;
@@ -1049,6 +1051,7 @@ static void display_help(int error)
 	       "                           (with same priority about many threads=
)\n"
 	       "                           US is the max time to be be tracked in=
 microseconds\n"
 	       "-H       --histofall=3DUS    same as -h except with an additional=
 summary column\n"
+	       "	 --histfile=3D<path> dump the latency histogram to <path> instea=
d of stdout\n"
 	       "-i INTV  --interval=3DINTV   base interval of thread in us defaul=
t=3D1000\n"
 	       "-I       --irqsoff         Irqsoff tracing (used with -b)\n"
 	       "-l LOOPS --loops=3DLOOPS     number of loops: default=3D0(endless=
)\n"
@@ -1214,13 +1217,13 @@ static char *policyname(int policy)
 enum option_values {
 	OPT_AFFINITY=3D1, OPT_NOTRACE, OPT_BREAKTRACE, OPT_PREEMPTIRQ, OPT_CLOCK,
 	OPT_CONTEXT, OPT_DISTANCE, OPT_DURATION, OPT_LATENCY, OPT_EVENT,
-	OPT_FTRACE, OPT_FIFO, OPT_HISTOGRAM, OPT_HISTOFALL, OPT_INTERVAL,
-	OPT_IRQSOFF, OPT_LOOPS, OPT_MLOCKALL, OPT_REFRESH, OPT_NANOSLEEP,
-	OPT_NSECS, OPT_OSCOPE, OPT_TRACEOPT, OPT_PRIORITY, OPT_PREEMPTOFF,
-	OPT_QUIET, OPT_PRIOSPREAD, OPT_RELATIVE, OPT_RESOLUTION, OPT_SYSTEM,
-	OPT_SMP, OPT_THREADS, OPT_TRACER, OPT_UNBUFFERED, OPT_NUMA, OPT_VERBOSE,
-	OPT_WAKEUP, OPT_WAKEUPRT, OPT_DBGCYCLIC, OPT_POLICY, OPT_HELP, OPT_NUMOPT=
S,
-	OPT_ALIGNED, OPT_LAPTOP, OPT_SECALIGNED,
+	OPT_FTRACE, OPT_FIFO, OPT_HISTOGRAM, OPT_HISTOFALL, OPT_HISTFILE,
+	OPT_INTERVAL, OPT_IRQSOFF, OPT_LOOPS, OPT_MLOCKALL, OPT_REFRESH, OPT_NANO=
SLEEP,
+	OPT_NSECS, OPT_OSCOPE, OPT_TRACEOPT, OPT_PRIORITY, OPT_PREEMPTOFF, OPT_QU=
IET,
+	OPT_PRIOSPREAD, OPT_RELATIVE, OPT_RESOLUTION, OPT_SYSTEM, OPT_SMP, OPT_TH=
READS,
+	OPT_TRACER, OPT_UNBUFFERED, OPT_NUMA, OPT_VERBOSE, OPT_WAKEUP, OPT_WAKEUP=
RT,
+	OPT_DBGCYCLIC, OPT_POLICY, OPT_HELP, OPT_NUMOPTS, OPT_ALIGNED, OPT_LAPTOP,
+	OPT_SECALIGNED,
 };
=20
 /* Process commandline options */
@@ -1251,6 +1254,7 @@ static void process_options (int argc, char *argv[], =
int max_cpus)
 			{"fifo",             required_argument, NULL, OPT_FIFO },
 			{"histogram",        required_argument, NULL, OPT_HISTOGRAM },
 			{"histofall",        required_argument, NULL, OPT_HISTOFALL },
+			{"histfile",	     required_argument, NULL, OPT_HISTFILE },
 			{"interval",         required_argument, NULL, OPT_INTERVAL },
 			{"irqsoff",          no_argument,       NULL, OPT_IRQSOFF },
 			{"laptop",	     no_argument,	NULL, OPT_LAPTOP },
@@ -1348,6 +1352,10 @@ static void process_options (int argc, char *argv[],=
 int max_cpus)
 		case 'h':
 		case OPT_HISTOGRAM:
 			histogram =3D atoi(optarg); break;
+		case OPT_HISTFILE:
+			use_histfile =3D 1;
+			strncpy(histfile, optarg, strlen(optarg));
+			break;
 		case 'i':
 		case OPT_INTERVAL:
 			interval =3D atoi(optarg); break;
@@ -1653,74 +1661,88 @@ static void print_hist(struct thread_param *par[], =
int nthreads)
 	int i, j;
 	unsigned long long int log_entries[nthreads+1];
 	unsigned long maxmax, alloverflows;
+	FILE *fd;
=20
 	bzero(log_entries, sizeof(log_entries));
=20
-	printf("# Histogram\n");
+	if (use_histfile) {
+		fd =3D fopen(histfile, "w");
+		if (!fd) {
+			perror("opening histogram file:");
+			return;
+		}
+	} else {
+		fd =3D stdout;
+	}
+
+	fprintf(fd, "# Histogram\n");
 	for (i =3D 0; i < histogram; i++) {
 		unsigned long long int allthreads =3D 0;
=20
-		printf("%06d ", i);
+		fprintf(fd, "%06d ", i);
=20
 		for (j =3D 0; j < nthreads; j++) {
 			unsigned long curr_latency=3Dpar[j]->stats->hist_array[i];
-			printf("%06lu", curr_latency);
+			fprintf(fd, "%06lu", curr_latency);
 			if (j < nthreads - 1)
-				printf("\t");
+				fprintf(fd, "\t");
 			log_entries[j] +=3D curr_latency;
 			allthreads +=3D curr_latency;
 		}
 		if (histofall && nthreads > 1) {
-			printf("\t%06llu", allthreads);
+			fprintf(fd, "\t%06llu", allthreads);
 			log_entries[nthreads] +=3D allthreads;
 		}
-		printf("\n");
+		fprintf(fd, "\n");
 	}
-	printf("# Total:");
+	fprintf(fd, "# Total:");
 	for (j =3D 0; j < nthreads; j++)
-		printf(" %09llu", log_entries[j]);
+		fprintf(fd, " %09llu", log_entries[j]);
 	if (histofall && nthreads > 1)
-		printf(" %09llu", log_entries[nthreads]);
-	printf("\n");
-	printf("# Min Latencies:");
+		fprintf(fd, " %09llu", log_entries[nthreads]);
+	fprintf(fd, "\n");
+	fprintf(fd, "# Min Latencies:");
 	for (j =3D 0; j < nthreads; j++)
-		printf(" %05lu", par[j]->stats->min);
-	printf("\n");
-	printf("# Avg Latencies:");
+		fprintf(fd, " %05lu", par[j]->stats->min);
+	fprintf(fd, "\n");
+	fprintf(fd, "# Avg Latencies:");
 	for (j =3D 0; j < nthreads; j++)
-		printf(" %05lu", par[j]->stats->cycles ?
+		fprintf(fd, " %05lu", par[j]->stats->cycles ?
 		       (long)(par[j]->stats->avg/par[j]->stats->cycles) : 0);
-	printf("\n");
-	printf("# Max Latencies:");
+	fprintf(fd, "\n");
+	fprintf(fd, "# Max Latencies:");
 	maxmax =3D 0;
 	for (j =3D 0; j < nthreads; j++) {
-		printf(" %05lu", par[j]->stats->max);
+		fprintf(fd, " %05lu", par[j]->stats->max);
 		if (par[j]->stats->max > maxmax)
 			maxmax =3D par[j]->stats->max;
 	}
 	if (histofall && nthreads > 1)
-		printf(" %05lu", maxmax);
-	printf("\n");
-	printf("# Histogram Overflows:");
+		fprintf(fd, " %05lu", maxmax);
+	fprintf(fd, "\n");
+	fprintf(fd, "# Histogram Overflows:");
 	alloverflows =3D 0;
 	for (j =3D 0; j < nthreads; j++) {
-		printf(" %05lu", par[j]->stats->hist_overflow);
+		fprintf(fd, " %05lu", par[j]->stats->hist_overflow);
 		alloverflows +=3D par[j]->stats->hist_overflow;
 	}
 	if (histofall && nthreads > 1)
-		printf(" %05lu", alloverflows);
-	printf("\n");
+		fprintf(fd, " %05lu", alloverflows);
+	fprintf(fd, "\n");
=20
-	printf("# Histogram Overflow at cycle number:\n");
+	fprintf(fd, "# Histogram Overflow at cycle number:\n");
 	for (i =3D 0; i < nthreads; i++) {
-		printf("# Thread %d:", i);
+		fprintf(fd, "# Thread %d:", i);
 		for (j =3D 0; j < par[i]->stats->num_outliers; j++)
-			printf(" %05lu", par[i]->stats->outliers[j]);
+			fprintf(fd, " %05lu", par[i]->stats->outliers[j]);
 		if (par[i]->stats->num_outliers < par[i]->stats->hist_overflow)
-			printf(" # %05lu others", par[i]->stats->hist_overflow - par[i]->stats-=
>num_outliers);
-		printf("\n");
+			fprintf(fd, " # %05lu others", par[i]->stats->hist_overflow - par[i]->s=
tats->num_outliers);
+		fprintf(fd, "\n");
 	}
-	printf("\n");
+	fprintf(fd, "\n");
+
+	if (use_histfile)
+		fclose(fd);
 }
=20
 static void print_stat(FILE *fp, struct thread_param *par, int index, int =
verbose, int quiet)
--=20
2.5.1


--SdvjNjn6lL3tIsv0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJV+cmCAAoJEKp7ZBKwQFAre8UH/iCq2Id5U9g4H7GPoR3RWn5j
Qq8HG4YX4PBDSl0F/fTQE5cBNkxwcVtHjfgoAJwvPNBgdtvMa+HS9LaIXBsn+IYs
Fzo/rhiBussLhErciCYvKhFjA1iiwwdHHzeCRqwZ1rZOuvan15fnz+CQW5i5T5Zu
PhZnrxoVLlef26wTODQ+ftM0MaCKwFOCJ+niYbKd6SjXj0FtBI014XjqpGgHw0Kw
9DxoTJ5G7DLI63Vay4XLyvILsIV/p8v1UsjPlD7lypSmI8aEbXJGO0aXLUfLxGrs
oyOpvnNPiTmO5D5hhWIY059foSHjmeHjCDiD5+sPdJ/2tUuw2k6Kvt92ZjA4g+k=
=IPMA
-----END PGP SIGNATURE-----

--SdvjNjn6lL3tIsv0--
