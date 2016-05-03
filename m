From: Clark Williams <williams@redhat.com>
Subject: [PATCH] cyclictest: stop any tracing after hitting a breaktrace
 threshold
Date: Tue, 3 May 2016 12:59:53 -0500
Message-ID: <20160503125953.1987bedd@sluggy.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/fdysh.t4S_mGJ5nzgZ/Ro4="; protocol="application/pgp-signature"
Cc: RT <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

--Sig_/fdysh.t4S_mGJ5nzgZ/Ro4=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

John,

This patch is against the devel/v0.98 branch. It turns off tracing in the t=
racemark() so that we don't lose information about what was going on when w=
e hit the latency:


The current logic of using --tracemark and --notrace works for running
cyclictest with trace-cmd, but even if we are not doing any trace
manipulation in cyclictest, we still need to stop tracing when we hit a
breaktrace threshold (i.e. -b <n>).

Modify startup logic to hold open file descriptors for the tracemark file
*and* the tracing_on file. When we hit a threshold and call the tracemark()
function, write the marker to the trace buffers and then write a "0\n" to
the tracing_on file to turn off tracing, otherwise we lose the information
immediately prior to the point where we hit the latency.

Signed-off-by: Clark Williams <williams@redhat.com>
---
 src/cyclictest/cyclictest.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 902167010416..00e5f3d59a5b 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -489,7 +489,12 @@ static void tracemark(char *fmt, ...)
 	va_start(ap, fmt);
 	len =3D vsnprintf(tracebuf, TRACEBUFSIZ, fmt, ap);
 	va_end(ap);
+
+	/* write the tracemark message */
 	write(tracemark_fd, tracebuf, len);
+
+	/* now stop any trace */
+	write(trace_fd, "0\n", 2);
 }
=20
=20
@@ -535,13 +540,28 @@ static void open_tracemark_fd(void)
 {
 	char path[MAX_PATH];
=20
-	if (tracemark_fd >=3D 0)
-		return;
+	/*
+	 * open the tracemark file if it's not already open
+	 */
+	if (tracemark_fd < 0) {
+		sprintf(path, "%s/%s", fileprefix, "trace_marker");
+		tracemark_fd =3D open(path, O_WRONLY);
+		if (tracemark_fd < 0) {
+			warn("unable to open trace_marker file: %s\n", path);
+			return;
+		}
+	}
=20
-	sprintf(path, "%s/%s", fileprefix, "trace_marker");
-	tracemark_fd =3D open(path, O_WRONLY);
-	if (tracemark_fd < 0)
-		warn("unable to open trace_marker file: %s\n", path);
+	/*
+	 * if we're not tracing and the tracing_on fd is not open,
+	 * open the tracing_on file so that we can stop the trace
+	 * if we hit a breaktrace threshold
+	 */
+	if (notrace && trace_fd < 0) {
+		sprintf(path, "%s/%s", fileprefix, "tracing_on");
+		if ((trace_fd =3D open(path, O_WRONLY)) < 0)
+			warn("unable to open tracing_on file: %s\n", path);
+	}
 }
=20
 static void debugfs_prepare(void)
--=20
2.5.5


--Sig_/fdysh.t4S_mGJ5nzgZ/Ro4=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJXKOcZAAoJEOI5asVwYXLrzNcP/jbh2SDvN+DH+6VMgWOCtkSJ
fJR4XMd6gfYmtIAVAAd95CaIUoyKsThUeeXnmSY6Saz54SjAuKoOVvG+56BcA8XH
fAAdY6goy+P7N5+EMnlw95w8yWVohyiobcdwDRfWA8djePq9u2p5GkN5Bf3XKZVf
W2mhFqrv4Cz2/P3OGPPHXaCs+rp8JvCl4h9ZgwJI2rsbuBdRwYfHeLiND4EtZQLy
z2phxpGi7HhYXWbf5j6PzXUmv61JsKa6TUKvc0vFdmSTS70iq8K+nmwBz7GoDmEf
7802v12MyRUaEqIjbN7wAtvxup/P1SjnAAVabtdHqJXcfMbClbY9syo3O5hJEb0d
LZJDx1G06jEC6B87x+rl+DugOvO+9bJpmaFMXi5+GDr/ey7w+E6aL+1JxU7aMaKW
2CXTO31dnF3ylYdidVza6cX1TDHpYCJZzbKTczoF++QMq/egH1bf4oFNdfd4dWXK
NAe7DMTIHO3xMvDIujTjKrRuagMt2QDTT5ysj8KLFjympUDfxgz/jSfFDNlPQxOO
EF17XokK6ECCYn97DJ7jR6qkGm76mNNZpArwff3THeVtpyevMKgwKxVU/cMdUbad
lrDDi2oHr8WsaWew0E8mMk/6QTCCwCwU2obYNizj1x3tLJ7zQH/E7o3vzVN7l4RK
rdPpuJWW3IAuB3QV7p48
=exPC
-----END PGP SIGNATURE-----

--Sig_/fdysh.t4S_mGJ5nzgZ/Ro4=--
