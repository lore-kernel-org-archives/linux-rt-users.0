From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: [PATCH 2/3] cyclictest: Fix  the same priority method of many threads with -h option.
Date: Mon, 29 Jun 2009 04:05:37 -0700
Message-ID: <D432A3F0-C516-43A3-9561-B6DD5F2E6BDA@thebigcorporation.com>
References: <1246030689.2153.32.camel@centos51>
Mime-Version: 1.0 (iPhone Mail 7A341)
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit
Cc: williams <williams@redhat.com>, tglx <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: "leemgs1@gmail.com" <leemgs1@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.229]:8355 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755827AbZF2LFp (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 29 Jun 2009 07:05:45 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1246314rvb.1
        for <linux-rt-users@vger.kernel.org>; Mon, 29 Jun 2009 04:05:48 -0700 (PDT)
In-Reply-To: <1246030689.2153.32.camel@centos51>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Nak.

Sorry for terse, top-post. I'll respond in more detail within 24 hrs.

+ 1 (415) 694 2930

On Jun 26, 2009, at 8:38, GeunSik Lim <leemgs1@gmail.com> wrote:

>
>
>> From 63c01db3e4b2c3a76f0dd5191f46535137e310c8 Mon Sep 17 00:00:00  
>> 2001
> From: GeunSik,Lim <leemgs1@gmail.com>
> Date: Fri, 26 Jun 2009 23:36:45 +0900
> Subject: [PATCH 2/3] cyclictest: Fix priority-- method of many  
> threads with -h.
>
> If we run a many threads with -t option, "priority--" rt priority  
> will assign
> per thread in sequence. But, If we use -h option, all threads is  
> same priority.
> Adjust the same prirotiy method about below two examples for  
> consistency.
> ex) cyclictest -t 5 -p 50        [enter] <-- without -h
> ex) cyclictest -t 5 -p 50 -h 100 [enter] <-- with    -h
>
>        Signed-off-by: GeunSik Lim <geunsik.lim@samsung.com>
> ---
> src/cyclictest/cyclictest.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index ad4c421..3505de5 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -1150,7 +1150,7 @@ int main(int argc, char **argv)
>        }
>
>        par[i].prio = priority;
> -        if (priority && !histogram)
> +        if (priority)
>            priority--;
>                 if      ( policy == 0) par[i].policy = SCHED_OTHER;
>                 else if ( policy == 1) par[i].policy = SCHED_FIFO;
> -- 
> 1.6.3.1
>
>
> -----------------------------------------------
> To unsubscribe from this list: send the line "unsubscribe linux-***"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
> GeunSik Lim ( Samsung Electronics )
> e-Mail  :1) geunsik.lim@samsung.com
>         2) leemgs@gmail.com , leemgs1@gmail.com
> HomePage: http://blog.naver.com/invain/
> -----------------------------------------------
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt- 
> users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
