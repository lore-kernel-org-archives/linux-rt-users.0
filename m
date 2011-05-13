From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] rt-tests - minor clean-ups
Date: Fri, 13 May 2011 13:08:52 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1105131304490.21159@localhost6.localdomain6>
References: <alpine.LFD.2.00.1105121251220.21611@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33332 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758339Ab1EMLIz (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 May 2011 07:08:55 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p4DB8tmJ005342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-rt-users@vger.kernel.org>; Fri, 13 May 2011 07:08:55 -0400
In-Reply-To: <alpine.LFD.2.00.1105121251220.21611@localhost6.localdomain6>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Thu, 12 May 2011, John Kacur wrote:

> 
> Hi Clark
> 
> Please pull from
> git://git.kernel.org/pub/scm/linux/kernel/git/jkacur/rt-tests.git
> branch: rt-tests-dev
> 
> I have a few clean-ups in my repo that aren't in yours.
> 1. Spelling clean-ups - makes it look more professional
> 2. A function header style clean-up, and spacing.
> 
> The diff between our trees is shown below.
> 
> Thanks
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 29d0fe5..d13669b 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -313,9 +313,7 @@ void traceopt(char *option)
>  	traceptr[traceopt_count++] = ptr;
>  }
>  
> -
> -static int
> -trace_file_exists(char *name)
> +static int trace_file_exists(char *name)
>  {
>  	struct stat sbuf;
>  	char *tracing_prefix = get_debugfileprefix();
> @@ -1030,7 +1028,7 @@ static void process_options (int argc, char *argv[])
>  			setaffinity = AFFINITY_USEALL;
>  			use_nanosleep = MODE_CLOCK_NANOSLEEP;
>  #else
> -			warn("cyclicteset was not built with the numa option\n");
> +			warn("cyclictest was not built with the numa option\n");
>  			warn("ignoring --numa or -U\n");
>  #endif
>  			break;
> @@ -1187,7 +1185,7 @@ static void print_hist(struct thread_param *par[], int nthreads)
>  	if (histofall && nthreads > 1)
>  		printf(" %09llu", log_entries[nthreads]);
>  	printf("\n");
> -	printf("# Min Latencys:");
> +	printf("# Max Latencies:");
>  	for (j = 0; j < nthreads; j++)
>  		printf(" %05lu", par[j]->stats->min);
>  	printf("\n");
> 

I'm not sure why the git diff was bogus, probably I did something wrong. 
However, my patch is in my repo is correct even if the above hunk as 
reported by git diff is obviously bogus. However, I see I missed the same 
spelling mistake elsewhere. Just to make things easy I am respinning this patch

You can either pull this new branch
repo: pub/scm/linux/kernel/git/jkacur/rt-tests.git
branch rt-tests-dev-new

Or use the respun patch below, thanks.

>From f26dbd8adcc7f9888d06a4963e8fe9e1ca497a15 Mon Sep 17 00:00:00 2001
From: John Kacur <jkacur@redhat.com>
Date: Fri, 13 May 2011 12:52:48 +0200
Subject: [PATCH] Minor Fix-ups
 1. Make the function header style consistent with the rest of cyclictest.
 2. Spelling clean-ups.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 29d0fe5..3227acd 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -313,9 +313,7 @@ void traceopt(char *option)
 	traceptr[traceopt_count++] = ptr;
 }
 
-
-static int
-trace_file_exists(char *name)
+static int trace_file_exists(char *name)
 {
 	struct stat sbuf;
 	char *tracing_prefix = get_debugfileprefix();
@@ -1030,7 +1028,7 @@ static void process_options (int argc, char *argv[])
 			setaffinity = AFFINITY_USEALL;
 			use_nanosleep = MODE_CLOCK_NANOSLEEP;
 #else
-			warn("cyclicteset was not built with the numa option\n");
+			warn("cyclictest was not built with the numa option\n");
 			warn("ignoring --numa or -U\n");
 #endif
 			break;
@@ -1187,11 +1185,11 @@ static void print_hist(struct thread_param *par[], int nthreads)
 	if (histofall && nthreads > 1)
 		printf(" %09llu", log_entries[nthreads]);
 	printf("\n");
-	printf("# Min Latencys:");
+	printf("# Min Latencies:");
 	for (j = 0; j < nthreads; j++)
 		printf(" %05lu", par[j]->stats->min);
 	printf("\n");
-	printf("# Avg Latencys:");
+	printf("# Avg Latencies:");
 	for (j = 0; j < nthreads; j++)
 		printf(" %05lu", par[j]->stats->cycles ?
 		       (long)(par[j]->stats->avg/par[j]->stats->cycles) : 0);
-- 
1.7.2.3

