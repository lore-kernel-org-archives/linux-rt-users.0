From: Clark Williams <williams@redhat.com>
Subject: Re: RFC: patch to trigger thread stats output from cyclictest with
 SIGHUP
Date: Mon, 11 Mar 2013 12:16:39 -0500
Message-ID: <20130311121639.5d77684a@riff.lan>
References: <20130311111607.587cda32@riff.lan>
	<CAP=VYLrV7QbA_+L66WVGSYoJaF-+sh8uyw0boq8hDCkF0xrQtw@mail.gmail.com>
	<513E0C2D.1050401@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/HFGzyFR0p._0gaGg82UPzAd"; protocol="application/pgp-signature"
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	John Kacur <jkacur@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	RT <linux-rt-users@vger.kernel.org>
To: David Sommerseth <davids@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39754 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752462Ab3CKRQo (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 11 Mar 2013 13:16:44 -0400
In-Reply-To: <513E0C2D.1050401@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/HFGzyFR0p._0gaGg82UPzAd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Mar 2013 17:54:05 +0100
David Sommerseth <davids@redhat.com> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> On 11/03/13 17:25, Paul Gortmaker wrote:
> > On Mon, Mar 11, 2013 at 12:16 PM, Clark Williams=20
> > <williams@redhat.com> wrote:
> >> John,
> >>=20
> >> Steven suggested a feature for cyclictest that I'd actually been
> >>  whining about (internally anyway). During long rteval runs=20
> >> there's really no feedback available if you want to know how the=20
> >> run is progressing. Steven suggested sending SIGHUP and dumping=20
> >> the current state. Below is a patch that seems to work for=20
> >> cyclictest; just wanted to get some feedback on whether this=20
> >> would be acceptable behaviour.
> >=20
> > Is USR1 already in use for something?  That would be consistent=20
> > with how things like dd use USR1 signal - to report interim stats.
> >=20
> > P.
>=20
> +1 ... I was just about to say exactly the same.
>=20
>=20

Good points. As I recall SIGHUP is usually used to force a re-read of
configs (which doesn't really apply here).

Here's a revised version using SIGUSR1:

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 0a15dcb..be4046f 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -199,6 +199,11 @@ static char **traceptr;
 static int traceopt_count;
 static int traceopt_size;
=20
+static struct thread_param **parameters;
+static struct thread_stat **statistics;
+
+static void print_stat(struct thread_param *par, int index, int verbose);
+
 static int latency_target_fd =3D -1;
 static int32_t latency_target_value =3D 0;
=20
@@ -1368,6 +1373,19 @@ static int check_timer(void)
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
+			print_stat(parameters[i], i, 0);
+		printf("#---------------------------\n");
+		quiet =3D oldquiet;
+		return;
+	}
 	shutdown =3D 1;
 	if (refresh_on_max)
 		pthread_cond_signal(&refresh_on_max_cond);
@@ -1503,8 +1521,6 @@ int main(int argc, char **argv)
 	sigset_t sigset;
 	int signum =3D SIGALRM;
 	int mode;
-	struct thread_param **parameters;
-	struct thread_stat **statistics;
 	int max_cpus =3D sysconf(_SC_NPROCESSORS_CONF);
 	int i, ret =3D -1;
 	int status;
@@ -1642,6 +1658,7 @@ int main(int argc, char **argv)
=20
 	signal(SIGINT, sighand);
 	signal(SIGTERM, sighand);
+	signal(SIGUSR1, sighand);
=20
 	parameters =3D calloc(num_threads, sizeof(struct thread_param *));
 	if (!parameters)

--Sig_/HFGzyFR0p._0gaGg82UPzAd
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlE+EXcACgkQHyuj/+TTEp02jgCfR1+p1RMiwmquJBC9F1tJkngw
4D4AoKSFhZzVc04v2KNMTXvtrPuYaT1k
=o4y1
-----END PGP SIGNATURE-----

--Sig_/HFGzyFR0p._0gaGg82UPzAd--
