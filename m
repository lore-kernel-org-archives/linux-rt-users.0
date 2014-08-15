From: John Kacur <jkacur@redhat.com>
Subject: Re: [RFC PATCH] make SMP option only use online cpus (cyclictest)
Date: Fri, 15 Aug 2014 14:54:38 +0200 (CEST)
Message-ID: <alpine.LFD.2.10.1408151446430.25171@riemann>
References: <20140814192929.004ab9d7@alchemy.lu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
To: Joakim Hernberg <jbh@alchemy.lu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:41840 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbaHOMym (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Aug 2014 08:54:42 -0400
Received: by mail-wg0-f49.google.com with SMTP id k14so2334443wgh.32
        for <linux-rt-users@vger.kernel.org>; Fri, 15 Aug 2014 05:54:41 -0700 (PDT)
In-Reply-To: <20140814192929.004ab9d7@alchemy.lu>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Thu, 14 Aug 2014, Joakim Hernberg wrote:

> When I boot my 8 core i7 laptop with the maxcpus=4 kernel boot flag,
> cyclictest -S runs 8 threads.  This patch makes it only use the online
> cpus instead.
> 
> diff --git a/src/cyclictest/cyclictest.c
> b/src/cyclictest/cyclictest.c index 4547831..92fc346 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -1740,7 +1740,7 @@ int main(int argc, char **argv)
>         sigset_t sigset;
>         int signum = SIGALRM;
>         int mode;
> -       int max_cpus = sysconf(_SC_NPROCESSORS_CONF);
> +       int max_cpus = sysconf(_SC_NPROCESSORS_ONLN);
>         int i, ret = -1;
>         int status;
>  
> diff --git a/src/cyclictest/rt_numa.h b/src/cyclictest/rt_numa.h
> index e64c446..c2b3e85 100644
> --- a/src/cyclictest/rt_numa.h
> +++ b/src/cyclictest/rt_numa.h
> @@ -128,7 +128,7 @@ static int rt_numa_numa_node_of_cpu(int cpu)
>         int max_node, max_cpus;
>  
>         max_node = numa_max_node();
> -       max_cpus = sysconf(_SC_NPROCESSORS_CONF);
> +       max_cpus = sysconf(_SC_NPROCESSORS_ONLN);
>  
>         if (cpu > max_cpus) {
>                 errno = EINVAL;
> 
> --

This is fine, in anycase, it's not less robust than what we are currently 
doing. (I suppose we really should be checking the result of sysconf)

I changed the description a little bit.

Clark, I pushed the following version to my repo, please pull

>From 863f1482220034de0a85f8150384931318325953 Mon Sep 17 00:00:00 2001
From: Joakim Hernberg <jbh@alchemy.lu>
Date: Thu, 14 Aug 2014 19:29:29 +0200
Subject: [PATCH] cyclictest: make affinity option only use number of online
 cpus

When I boot my 8 core i7 laptop with the maxcpus=4 kernel boot flag,
cyclictest -S runs 8 threads.  This patch makes it only use the number
of online cpus instead.

Signed-off-by: Joakim Hernberg <jhernberg@alchemy.lu>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c | 2 +-
 src/cyclictest/rt_numa.h    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index a3e7b1d6c377..c727d54364b1 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1763,7 +1763,7 @@ int main(int argc, char **argv)
 	sigset_t sigset;
 	int signum = SIGALRM;
 	int mode;
-	int max_cpus = sysconf(_SC_NPROCESSORS_CONF);
+	int max_cpus = sysconf(_SC_NPROCESSORS_ONLN);
 	int i, ret = -1;
 	int status;
 
diff --git a/src/cyclictest/rt_numa.h b/src/cyclictest/rt_numa.h
index 60a143721da1..06c9420e53cc 100644
--- a/src/cyclictest/rt_numa.h
+++ b/src/cyclictest/rt_numa.h
@@ -128,7 +128,7 @@ static int rt_numa_numa_node_of_cpu(int cpu)
 	int max_node, max_cpus;
 
 	max_node = numa_max_node();
-	max_cpus = sysconf(_SC_NPROCESSORS_CONF);
+	max_cpus = sysconf(_SC_NPROCESSORS_ONLN);
 
 	if (cpu > max_cpus) {
 		errno = EINVAL;
-- 
1.8.1.4

