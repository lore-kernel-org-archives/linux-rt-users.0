From: Clark Williams <williams@redhat.com>
Subject: RFC: cyclictest notrace option
Date: Wed, 13 Mar 2013 19:46:50 -0500
Message-ID: <20130313194650.45649c1f@riff.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/m6UurMIN7U_ye9iTfiGZTT6"; protocol="application/pgp-signature"
To: John Kacur <jkacur@redhat.com>, RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:23922 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755725Ab3CNAqx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 13 Mar 2013 20:46:53 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r2E0krgT021178
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-rt-users@vger.kernel.org>; Wed, 13 Mar 2013 20:46:53 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/m6UurMIN7U_ye9iTfiGZTT6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

This patch adds the --notrace/-A option to cyclictest. The intent is to
allow use of the -b/--breaktrace option but to have cyclictest do no
actual ftrace operations (i.e. stop when threshold is hit and do
nothing wrt ftrace).  The idea is that you can do more sophisticated
tracing with the trace-cmd script, so do that rather than trying to put
all combinations of tracing into cyclictest.=20

I've push this and the previous patch up to my kernel.org repository in
the work branch:

git://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rt-tests.git

commit 83adb67c7928a73f6434e98cba736717d656ceb4
Author: Clark Williams <clark.williams@gmail.com>
Date:   Wed Mar 13 19:36:29 2013 -0500

    cyclictest: allow break threshold without doing any tracing
   =20
    Add the --notrace/-A option, intended to be used in conjunction
    with the -b option. This will cause cyclictest to exit when a
    threshold is hit, but will not perform any tracing operations,
    allowing more sophisticated tracing to be done externally.
   =20
    Signed-off-by: Clark Williams <clark.williams@gmail.com>

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index a8f9534..7eb4799 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -165,6 +165,7 @@ struct thread_stat {
=20
 static int shutdown;
 static int tracelimit =3D 0;
+static int notrace =3D 0;
 static int ftrace =3D 0;
 static int kernelversion;
 static int verbose =3D 0;
@@ -446,7 +447,7 @@ static int settracer(char *tracer)
=20
 static void setup_tracer(void)
 {
-	if (!tracelimit)
+	if (!tracelimit || notrace)
 		return;
=20
 	if (mount_debugfs(NULL))
@@ -1101,6 +1102,7 @@ static void process_options (int argc, char
*argv[]) */
 		static struct option long_options[] =3D {
 			{"affinity",         optional_argument, NULL,
'a'},
+			{"notrace",          no_argument,       NULL,
'A'}, {"breaktrace",       required_argument, NULL, 'b'},
 			{"preemptirqs",      no_argument,       NULL,
'B'}, {"clock",            required_argument, NULL, 'c'},
@@ -1161,6 +1163,7 @@ static void process_options (int argc, char
*argv[]) setaffinity =3D AFFINITY_USEALL;
 			}
 			break;
+		case 'A': notrace =3D 1; break;
 		case 'b': tracelimit =3D atoi(optarg); break;
 		case 'B': tracetype =3D PREEMPTIRQSOFF; break;
 		case 'c': clocksel =3D atoi(optarg); break;
@@ -1400,7 +1403,7 @@ static void sighand(int sig)
 	shutdown =3D 1;
 	if (refresh_on_max)
 		pthread_cond_signal(&refresh_on_max_cond);
-	if (tracelimit)
+	if (tracelimit && !notrace)
 		tracing(0);
 }
=20
@@ -1921,7 +1924,7 @@ int main(int argc, char **argv)
 	}
  out:
 	/* ensure that the tracer is stopped */
-	if (tracelimit)
+	if (tracelimit && !notrace)
 		tracing(0);
=20
=20
@@ -1937,7 +1940,7 @@ int main(int argc, char **argv)
=20
 	/* turn off the function tracer */
 	fileprefix =3D procfileprefix;
-	if (tracetype)
+	if (tracetype && !notrace)
 		setkernvar("ftrace_enabled", "0");
 	fileprefix =3D get_debugfileprefix();
=20

--Sig_/m6UurMIN7U_ye9iTfiGZTT6
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlFBHfoACgkQHyuj/+TTEp3EVQCgjrZ39sWN0Bp3KnpgB9XXiv5G
tVcAn1juLEFOuwJGm7xHbVrDAwB+hn9W
=KeNv
-----END PGP SIGNATURE-----

--Sig_/m6UurMIN7U_ye9iTfiGZTT6--
