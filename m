From: Clark Williams <williams@redhat.com>
Subject: change to cyclictest -h option?
Date: Thu, 29 Sep 2011 09:28:19 -0500
Message-ID: <20110929092819.39119817@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/D91dIg4cPdCFA+OheoMXeEC"; protocol="application/pgp-signature"
Cc: Frank Rowand <frank.rowand@am.sony.com>,
	RT <linux-rt-users@vger.kernel.org>
To: Carsten Emde <ce@ceag.ch>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:27209 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755018Ab1I2O20 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 29 Sep 2011 10:28:26 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/D91dIg4cPdCFA+OheoMXeEC
Content-Type: multipart/mixed; boundary="MP_/EbX58fU_.MizyXsiMftpZf9"

--MP_/EbX58fU_.MizyXsiMftpZf9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Carsten,

I'm considering applying the following patch to cyclictest, which will
change an implied behavior for the -h/--histogram option. Currently
when you specify -h without --smp or --numa, any realtime priority
specified is spread across the range of measurement threads. This patch
makes that spread an explicit option, rather than implicit in the
histogram option.=20

Previous command line:

	$ sudo cyclictest --h -t -p90

New command line:

	$ sudo cyclictest --h -t -p90 -Q

Where the -Q/--priospread option causes the priority assigned to
measurement threads to be decremented after each thread is created.
With this option in place, the first command line would create a
measurement thread for each core, all running at fifo:90.

Is this going to cause you pain and heartache in your automated tests?

Clark

P.S. Yes, I know that -Q makes no sense, but I couldn't come up with a
one-letter option that did, that wasn't already taken :)

--MP_/EbX58fU_.MizyXsiMftpZf9
Content-Type: text/x-patch
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=priospread.patch

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 731b4bd..c0cde4a 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -170,6 +170,7 @@ static int duration =3D 0;
 static int use_nsecs =3D 0;
 static int refresh_on_max;
 static int force_sched_other;
+static int priospread =3D 0;
=20
 static pthread_cond_t refresh_on_max_cond =3D PTHREAD_COND_INITIALIZER;
 static pthread_mutex_t refresh_on_max_lock =3D PTHREAD_MUTEX_INITIALIZER;
@@ -845,6 +846,7 @@ static void display_help(int error)
 	       "-p PRIO  --prio=3DPRIO       priority of highest prio thread\n"
 	       "-P       --preemptoff      Preempt off tracing (used with -b)\n"
 	       "-q       --quiet           print only a summary on exit\n"
+	       "-Q       --priospread       spread priority levels starting at sp=
ecified value\n"
 	       "-r       --relative        use relative timer instead of absolute=
\n"
 	       "-s       --system          use sys_nanosleep and sys_setitimer\n"
 	       "-t       --threads         one thread per available processor\n"
@@ -984,9 +986,10 @@ static void process_options (int argc, char *argv[])
 			{"smp", no_argument, NULL, 'S'},
 			{"numa", no_argument, NULL, 'U'},
 			{"latency", required_argument, NULL, 'e'},
+			{"priospread", no_argument, NULL, 'Q'},
 			{NULL, 0, NULL, 0}
 		};
-		int c =3D getopt_long(argc, argv, "a::b:Bc:Cd:Efh:H:i:Il:MnNo:O:p:PmqrsS=
t::uUvD:wWT:y:e:",
+		int c =3D getopt_long(argc, argv, "a::b:Bc:Cd:Efh:H:i:Il:MnNo:O:p:PmqQrs=
St::uUvD:wWT:y:e:",
 				    long_options, &option_index);
 		if (c =3D=3D -1)
 			break;
@@ -1045,6 +1048,7 @@ static void process_options (int argc, char *argv[])
 			}
 			break;
 		case 'q': quiet =3D 1; break;
+		case 'Q': priospread =3D 1; break;
 		case 'r': timermode =3D TIMER_RELTIME; break;
 		case 's': use_system =3D MODE_SYS_OFFSET; break;
 		case 't':
@@ -1140,6 +1144,12 @@ static void process_options (int argc, char *argv[])
 	if (priority < 0 || priority > 99)
 		error =3D 1;
=20
+	if (priospread && priority =3D=3D 0) {
+		fprintf(stderr, "defaulting realtime priority to %d\n",=20
+			num_threads+1);
+		priority =3D num_threads+1;
+	}
+
 	if (priority && (policy !=3D SCHED_FIFO && policy !=3D SCHED_RR)) {
 		fprintf(stderr, "policy and priority don't match: setting policy to SCHE=
D_FIFO\n");
 		policy =3D SCHED_FIFO;
@@ -1456,7 +1466,7 @@ int main(int argc, char **argv)
 			par->policy =3D SCHED_OTHER;
 			force_sched_other =3D 1;
 		}
-		if (priority && !histogram && !smp && !numa)
+		if (priospread)
 			priority--;
 		par->clock =3D clocksources[clocksel];
 		par->mode =3D mode;

--MP_/EbX58fU_.MizyXsiMftpZf9--

--Sig_/D91dIg4cPdCFA+OheoMXeEC
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iEYEARECAAYFAk6EgIMACgkQHyuj/+TTEp1e+ACghall20u09yKdJsqh9FP7TOTN
ft0AoLEVoxwd1EA3Hs7cqOMBQXCkgBA8
=1spE
-----END PGP SIGNATURE-----

--Sig_/D91dIg4cPdCFA+OheoMXeEC--
