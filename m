From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH rt-tests 3/9] cyclictest: drop unnecessary numa_on_and_available()
 check
Date: Tue, 15 Sep 2015 23:50:16 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1509152347280.13077@riemann.fritz.box>
References: <cover.1441038216.git.joshc@ni.com> <787515a5a59861a892ac3a44b6c6c502cfc102fd.1441038216.git.joshc@ni.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-1463804494-1085366445-1442353817=:13077"
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
To: Josh Cartwright <joshc@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:37653 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688AbbIOVuU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 Sep 2015 17:50:20 -0400
Received: by wicfx3 with SMTP id fx3so45452663wic.0
        for <linux-rt-users@vger.kernel.org>; Tue, 15 Sep 2015 14:50:18 -0700 (PDT)
In-Reply-To: <787515a5a59861a892ac3a44b6c6c502cfc102fd.1441038216.git.joshc@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463804494-1085366445-1442353817=:13077
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 31 Aug 2015, Josh Cartwright wrote:

> The condition that numa_on_and_available() checks is impossible to hit,
> as it's already being checked during process_options().
> 
> Removal of numa_on_and_available() also has the side effect of removing
> the following warning during build:
> 
> src/cyclictest/rt_numa.h:259:15: warning: implicit declaration of function ‘numa_available’ [-Wimplicit-function-declaration]
> 
> Signed-off-by: Josh Cartwright <joshc@ni.com>
> ---
>  src/cyclictest/cyclictest.c | 3 ---
>  src/cyclictest/rt_numa.h    | 9 ---------
>  2 files changed, 12 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 4ced67f..dc754fd 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -1816,9 +1816,6 @@ int main(int argc, char **argv)
>  	if (verbose)
>  		printf("Max CPUs = %d\n", max_cpus);
>  
> -	/* Checks if numa is on, program exits if numa on but not available */
> -	numa_on_and_available();
> -
>  	/* lock all memory (prevent swapping) */
>  	if (lockall)
>  		if (mlockall(MCL_CURRENT|MCL_FUTURE) == -1) {
> diff --git a/src/cyclictest/rt_numa.h b/src/cyclictest/rt_numa.h
> index 06c9420..caa80e6 100644
> --- a/src/cyclictest/rt_numa.h
> +++ b/src/cyclictest/rt_numa.h
> @@ -251,15 +251,6 @@ static inline void rt_bitmask_free(struct bitmask *mask)
>  
>  #endif	/* NUMA */
>  
> -/*
> - * Any behavioral differences above are transparent to these functions
> - */
> -static void numa_on_and_available()
> -{
> -	if (numa && (numa_available() == -1))
> -		fatal("--numa specified and numa functions not available.\n");
> -}
> -
>  /** Returns number of bits set in mask. */
>  static inline unsigned int rt_numa_bitmask_count(const struct bitmask *mask)
>  {
> -- 
> 2.5.0
> 
> --

I would prefer not to drop this function, since I think it cleanly 
documents a necessary initialization for using numa, althought here is 
something to be said for how cleanly your patch changes it. Proposing the 
following patch for now instead. Further clean-ups are possible.

>From c74b5d3d0e8a4a298dd0480f832e43ac886fdca0 Mon Sep 17 00:00:00 2001
From: John Kacur <jkacur@redhat.com>
Date: Tue, 15 Sep 2015 23:37:12 +0200
Subject: [PATCH] numa_on_and_available: Remove from main in cyclictest

We don't support building without numa libs anymore, although we of
course support running on machines without numa. Never-the-less I
created two versions of numa_on_and_available, one for if you build with
the unsupported NUMA=0 and one for if you build with NUMA=1, which is
the default.

I would prefer not to drop this function, since I think it cleanly
documents the fact that numa_available must be called before any other
numa library functions are defined.

As Josh Cartwright reported though, there was no need to call it from
main() since it was already tested in process_options(), so I tested it
there.

Tested by building with NUMA=0, NUMA=1 and with the non-standard
-Wimplicit-function-declaration

Reported-by: Signed-off-by: Josh Cartwright <joshc@ni.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c |  7 ++-----
 src/cyclictest/rt_numa.h    | 18 +++++++++++++-----
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 213c527fd714..b3abfcc67407 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1451,12 +1451,11 @@ static void process_options (int argc, char *argv[], int max_cpus)
 			setvbuf(stdout, NULL, _IONBF, 0); break;
 		case 'U':
 		case OPT_NUMA: /* NUMA testing */
+			numa = 1;	/* Turn numa on */
 			if (smp)
 				fatal("numa and smp options are mutually exclusive\n");
+			numa_on_and_available();
 #ifdef NUMA
-			if (numa_available() == -1)
-				fatal("NUMA functionality not available!");
-			numa = 1;
 			num_threads = max_cpus;
 			setaffinity = AFFINITY_USEALL;
 			use_nanosleep = MODE_CLOCK_NANOSLEEP;
@@ -1816,8 +1815,6 @@ int main(int argc, char **argv)
 	if (verbose)
 		printf("Max CPUs = %d\n", max_cpus);
 
-	/* Checks if numa is on, program exits if numa on but not available */
-	numa_on_and_available();
 
 	/* lock all memory (prevent swapping) */
 	if (lockall)
diff --git a/src/cyclictest/rt_numa.h b/src/cyclictest/rt_numa.h
index 06c9420e53cc..c1b3f942762d 100644
--- a/src/cyclictest/rt_numa.h
+++ b/src/cyclictest/rt_numa.h
@@ -192,6 +192,12 @@ static inline void rt_bitmask_free(struct bitmask *mask)
 
 #endif	/* LIBNUMA_API_VERSION */
 
+static void numa_on_and_available()
+{
+	if (numa && (numa_available() == -1))
+		fatal("--numa specified and numa functions not available.\n");
+}
+
 #else /* ! NUMA */
 
 struct bitmask {
@@ -249,17 +255,19 @@ static inline void rt_bitmask_free(struct bitmask *mask)
 	free(mask);
 }
 
-#endif	/* NUMA */
 
-/*
- * Any behavioral differences above are transparent to these functions
- */
 static void numa_on_and_available()
 {
-	if (numa && (numa_available() == -1))
+	if (numa) /* NUMA is not defined here */
 		fatal("--numa specified and numa functions not available.\n");
 }
 
+#endif	/* NUMA */
+
+/*
+ * Any behavioral differences above are transparent to these functions
+ */
+
 /** Returns number of bits set in mask. */
 static inline unsigned int rt_numa_bitmask_count(const struct bitmask *mask)
 {
-- 
2.4.3

---1463804494-1085366445-1442353817=:13077--
