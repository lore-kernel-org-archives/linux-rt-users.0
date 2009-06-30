From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: [PATCH 2/3] cyclictest: Fix  the same priority method of many
 threads with -h option.
Date: Mon, 29 Jun 2009 19:56:04 -0700
Message-ID: <1246330564.8104.37.camel@sven.thebigcorporation.com>
References: <1246030689.2153.32.camel@centos51>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: williams <williams@redhat.com>, tglx <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: leemgs1@gmail.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ey-out-1920.google.com ([74.125.78.148]:16426 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755149AbZF3C4K (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 29 Jun 2009 22:56:10 -0400
Received: by ey-out-1920.google.com with SMTP id 3so544708eyh.36
        for <linux-rt-users@vger.kernel.org>; Mon, 29 Jun 2009 19:56:12 -0700 (PDT)
In-Reply-To: <1246030689.2153.32.camel@centos51>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 2009-06-27 at 00:38 +0900, GeunSik Lim wrote:
> 
> >From 63c01db3e4b2c3a76f0dd5191f46535137e310c8 Mon Sep 17 00:00:00 2001
> From: GeunSik,Lim <leemgs1@gmail.com>
> Date: Fri, 26 Jun 2009 23:36:45 +0900
> Subject: [PATCH 2/3] cyclictest: Fix priority-- method of many threads with -h.
> 
> If we run a many threads with -t option, "priority--" rt priority will assign
> per thread in sequence. But, If we use -h option, all threads is same priority.
> Adjust the same prirotiy method about below two examples for consistency.
> ex) cyclictest -t 5 -p 50        [enter] <-- without -h
> ex) cyclictest -t 5 -p 50 -h 100 [enter] <-- with    -h
> 
>         Signed-off-by: GeunSik Lim <geunsik.lim@samsung.com>
> ---
>  src/cyclictest/cyclictest.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index ad4c421..3505de5 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -1150,7 +1150,7 @@ int main(int argc, char **argv)
>  		}
>  
>  		par[i].prio = priority;
> -		if (priority && !histogram)
> +		if (priority)
>  			priority--;

When generating a histogram on multiple cores, the priority of
cyclictest threads should be the same on each CPU.

This change would make the priority lower on higher CPU ids, resulting
in apparent performance skew in favor of CPU0.

Sven

>                  if      ( policy == 0) par[i].policy = SCHED_OTHER;
>                  else if ( policy == 1) par[i].policy = SCHED_FIFO;

