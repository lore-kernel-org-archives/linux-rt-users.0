From: Clark Williams <williams@redhat.com>
Subject: RFC: patch to trigger thread stats output from cyclictest with
 SIGHUP
Date: Mon, 11 Mar 2013 11:16:07 -0500
Message-ID: <20130311111607.587cda32@riff.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/N_3SlkjpmDYXGLdDUvQMu_z"; protocol="application/pgp-signature"
Cc: Steven Rostedt <rostedt@goodmis.org>,
	RT <linux-rt-users@vger.kernel.org>,
	David Sommerseth <davids@redhat.com>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59305 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751526Ab3CKQQN (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 11 Mar 2013 12:16:13 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/N_3SlkjpmDYXGLdDUvQMu_z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

John,

Steven suggested a feature for cyclictest that I'd actually been
whining about (internally anyway). During long rteval runs there's
really no feedback available if you want to know how the run is
progressing. Steven suggested sending SIGHUP and dumping the current
state. Below is a patch that seems to work for cyclictest; just
wanted to get some feedback on whether this would be acceptable
behaviour.=20

Of course if we get this going then we need to figure out how to wire
it into rteval as well :).

Clark


diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 0a15dcb..51b97cf 100644
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
+	if (sig =3D=3D SIGHUP) {
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
+	signal(SIGHUP, sighand);
=20
 	parameters =3D calloc(num_threads, sizeof(struct thread_param *));
 	if (!parameters)

--Sig_/N_3SlkjpmDYXGLdDUvQMu_z
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlE+A0cACgkQHyuj/+TTEp0EKACg4FZ/HU30t8anJox4dlBJO2Xw
8LIAn0LAW8Cl4FityiDvMZUuusEsrdiM
=8LIy
-----END PGP SIGNATURE-----

--Sig_/N_3SlkjpmDYXGLdDUvQMu_z--
