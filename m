From: Josh Cartwright <joshc@ni.com>
Subject: [PATCH rt-tests 3/9] cyclictest: drop unnecessary numa_on_and_available() check
Date: Mon, 31 Aug 2015 11:35:30 -0500
Message-ID: <787515a5a59861a892ac3a44b6c6c502cfc102fd.1441038216.git.joshc@ni.com>
References: <cover.1441038216.git.joshc@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod2.natinst.com ([130.164.80.23]:37410 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753708AbbHaQfk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 31 Aug 2015 12:35:40 -0400
In-Reply-To: <cover.1441038216.git.joshc@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The condition that numa_on_and_available() checks is impossible to hit,
as it's already being checked during process_options().

Removal of numa_on_and_available() also has the side effect of removing
the following warning during build:

src/cyclictest/rt_numa.h:259:15: warning: implicit declaration of funct=
ion =E2=80=98numa_available=E2=80=99 [-Wimplicit-function-declaration]

Signed-off-by: Josh Cartwright <joshc@ni.com>
---
 src/cyclictest/cyclictest.c | 3 ---
 src/cyclictest/rt_numa.h    | 9 ---------
 2 files changed, 12 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 4ced67f..dc754fd 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1816,9 +1816,6 @@ int main(int argc, char **argv)
 	if (verbose)
 		printf("Max CPUs =3D %d\n", max_cpus);
=20
-	/* Checks if numa is on, program exits if numa on but not available *=
/
-	numa_on_and_available();
-
 	/* lock all memory (prevent swapping) */
 	if (lockall)
 		if (mlockall(MCL_CURRENT|MCL_FUTURE) =3D=3D -1) {
diff --git a/src/cyclictest/rt_numa.h b/src/cyclictest/rt_numa.h
index 06c9420..caa80e6 100644
--- a/src/cyclictest/rt_numa.h
+++ b/src/cyclictest/rt_numa.h
@@ -251,15 +251,6 @@ static inline void rt_bitmask_free(struct bitmask =
*mask)
=20
 #endif	/* NUMA */
=20
-/*
- * Any behavioral differences above are transparent to these functions
- */
-static void numa_on_and_available()
-{
-	if (numa && (numa_available() =3D=3D -1))
-		fatal("--numa specified and numa functions not available.\n");
-}
