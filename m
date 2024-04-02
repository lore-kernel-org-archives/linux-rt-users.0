Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6576315AAAF
	for <linux-rt-users@vger.kernel.org>; Tue,  2 Apr 2024 17:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712080029; cv=none; b=nto0ljO8XUSXE7fmSFuXGCcWLAgl/YEfv5y+zSkfDh5nMtNmELZmtBp4NdagyBL0IFMbYp32OXRbxtkNlto8UJJ8CoZhqo6F/UcR0v1u9LdO3l9e79iu6KYkKmJ2nxbvgRVadDA5GgJWReOUvjzvIZ+yiYd/qPI4JwQq52RxD7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712080029; c=relaxed/simple;
	bh=0ybYNJE2QFC5ao3US6qmvLofAlgvIktYV9OD4iNdCNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sx7qHiwsuUUk8ddIFap0NY0KjJGCo+XpmoceESn9qYsV12tLs4XGNxnKkcqjPFCAVO2y7uk/DuwaUUrgDkVBB2HO9iIF66T+SJnOx/9esFQ/p0RI1jK9+ze/AChxinmPh78ngETIdGay3StSS9XO+gEuP2yG3niO3vgiIszpQQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i6q+pYvs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=No1JTo8y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i6q+pYvs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="No1JTo8y"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712080025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZKkQ7tSPVVjiYXHQ4JHuDSDQ9P5slsEuTsah2qBHlDw=;
	b=i6q+pYvs3/MFsVz0xK3/Yg5W8A5j/60a6L9MaCgogbDU0mop1tSvuAJLnaU7j5vlV67D1b
	QFOIJKBbZSJCmZBSA4/45wpROqzok9zlsNqWSRoraDrGEGKU5v4+TGpp/gwYuT43VfT1MN
	Nv/IbEn0yZDfDL/epQrGa84tcnulPi/2zhGgDtdVLS7Zc8TDVAQdy0hpR2r6W4jOAmoU/o
	QKR4X1Wm14rTPCZcEWc7Vfqt+k8JpdSphVs4XJ/a/c2MrpyecpS3nUGzomqykn/Wmx4y1u
	KV/R8MfC9L8ePl0YvbbjgiksnOZRCvv2yONgR61gd4fWDi/5ULVaI/MeKjtM1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712080025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZKkQ7tSPVVjiYXHQ4JHuDSDQ9P5slsEuTsah2qBHlDw=;
	b=No1JTo8y51ZYMV3smrCdoWknNXHqjamyA0UbLNzE6NvHCKQ0lQyhr9h5fpO9Mr22KabFMX
	fa/dnmaGa7AxiUBw==
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Cc: linux-rt-users@vger.kernel.org,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH] rt-tests: hackbench: drop incorrect and unnecessary usage of optind
Date: Tue,  2 Apr 2024 19:46:59 +0200
Message-Id: <20240402174659.202695-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Variable "optind" is used as the last argument of getopt_long(). This
means it "is set to the index of the long option relative to longopts"
(from man page). NULL check is then performed on argv[optind], which is
not valid, because in this case, optind is not an index to argv[].

There is another "optind" which is a global variable, which actually
holds the index to argv[]. This is likely the actual intention here. By
locally define another "optind", the "real optind" is shadowed in this
scope.

Furthermore, the original optind "is the index of the next element to
be processed in argv" (from man page), not the index to the current
element. So doing NULL-check on argv[optind] with the "original optind"
is also not valid.

There is no reason to do this NULL-check, since argv[optind] is not even
read. Only optarg is read, which is never a NULL pointer in this case.

Delete this incorrect and unnecessary "optind".

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 src/hackbench/hackbench.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/src/hackbench/hackbench.c b/src/hackbench/hackbench.c
index 4430db0..d4924b3 100644
--- a/src/hackbench/hackbench.c
+++ b/src/hackbench/hackbench.c
@@ -405,8 +405,6 @@ static unsigned int group(childinfo_t *child,
 static void process_options(int argc, char *argv[])
 {
 	for(;;) {
-		int optind =3D 0;
-
 		static struct option longopts[] =3D {
 			{"fds",		required_argument,	NULL, 'f'},
 			{"fifo",	no_argument,		NULL, 'F'},
@@ -422,13 +420,13 @@ static void process_options(int argc, char *argv[])
 		};
=20
 		int c =3D getopt_long(argc, argv, "f:Fg:hl:pis:TP",
-				    longopts, &optind);
+				    longopts, NULL);
 		if (c =3D=3D -1) {
 			break;
 		}
 		switch (c) {
 		case 'f':
-			if (!(argv[optind] && (num_fds =3D atoi(optarg)) > 0)) {
+			if ((num_fds =3D atoi(optarg)) <=3D 0) {
 				fprintf(stderr, "%s: --fds|-f requires an integer > 0\n", argv[0]);
 				print_usage_exit(1);
 			}
@@ -437,7 +435,7 @@ static void process_options(int argc, char *argv[])
 			fifo =3D 1;
 			break;
 		case 'g':
-			if (!(argv[optind] && (num_groups =3D atoi(optarg)) > 0)) {
+			if ((num_groups =3D atoi(optarg)) <=3D 0) {
 				fprintf(stderr, "%s: --groups|-g requires an integer > 0\n", argv[0]);
 				print_usage_exit(1);
 			}
@@ -446,7 +444,7 @@ static void process_options(int argc, char *argv[])
 			print_usage_exit(0);
 			break;
 		case 'l':
-			if (!(argv[optind] && (loops =3D atoi(optarg)) > 0)) {
+			if ((loops =3D atoi(optarg)) <=3D 0) {
 				fprintf(stderr, "%s: --loops|-l requires an integer > 0\n", argv[0]);
 				print_usage_exit(1);
 			}
--=20
2.39.2

