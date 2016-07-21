From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] cyclictest: Fix a maybe-uninitialized warn on duration
 option
Date: Thu, 21 Jul 2016 15:35:44 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1607211533190.5970@riemann.fritz.box>
References: <1469062088-3608-1-git-send-email-bristot@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-1463806030-991391548-1469108151=:5970"
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>
To: Daniel Bristot de Oliveira <bristot@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33251 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752485AbcGUNfy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 Jul 2016 09:35:54 -0400
Received: by mail-lf0-f67.google.com with SMTP id f93so5528186lfi.0
        for <linux-rt-users@vger.kernel.org>; Thu, 21 Jul 2016 06:35:53 -0700 (PDT)
In-Reply-To: <1469062088-3608-1-git-send-email-bristot@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463806030-991391548-1469108151=:5970
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Wed, 20 Jul 2016, Daniel Bristot de Oliveira wrote:

> I am having the following warning while compiling cyclictest on
> Federa 24 (GCC 6.1.1 20160621):
> 
> --------------------------%<--------------------------------------------
> [root@f24desk rt-tests]# make
> cc -D VERSION=1.1 -c src/cyclictest/cyclictest.c -Wall -Wno-nonnull -O2 -DNUMA -DHAVE_PARSE_CPUSTRING_ALL -D_GNU_SOURCE -Isrc/include -o bld/cyclictest.o
> src/cyclictest/cyclictest.c: In function ‘timerthread’:
> src/cyclictest/cyclictest.c:427:30: warning: ‘*((void *)&stop+8)’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>   diff += ((int) t1.tv_nsec - (int) t2.tv_nsec) / 1000;
>                               ^~~~~~~~~~~~~~~~
> src/cyclictest/cyclictest.c:980:39: note: ‘*((void *)&stop+8)’ was declared here
>   struct timespec now, next, interval, stop;
>                                        ^~~~
> src/cyclictest/cyclictest.c:426:54: warning: ‘stop.tv_sec’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>   diff = USEC_PER_SEC * (long long)((int) t1.tv_sec - (int) t2.tv_sec);
>                                                       ^~~~~~~~~~~~~~~
> src/cyclictest/cyclictest.c:980:39: note: ‘stop.tv_sec’ was declared here
>   struct timespec now, next, interval, stop;
>                                        ^~~~
> -------------------------->%--------------------------------------------
> 
> This is a false positive, but rather than workaround it using GCC pragma
> option, I think it is better to use stop variable itself to define
> whether it should be used of not.
> 
> Cc: John Kacur <jkacur@redhat.com>
> Cc: Clark Williams <williams@redhat.com>
> Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> ---
>  src/cyclictest/cyclictest.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 5e23fc5..ad11b1b 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -977,7 +977,8 @@ static void *timerthread(void *param)
>  	struct sigevent sigev;
>  	sigset_t sigset;
>  	timer_t timer;
> -	struct timespec now, next, interval, stop;
> +	struct timespec now, next, interval;
> +	struct timespec *stop = NULL;
>  	struct itimerval itimer;
>  	struct itimerspec tspec;
>  	struct thread_stat *stat = par->stats;
> @@ -1066,9 +1067,11 @@ static void *timerthread(void *param)
>  	tsnorm(&next);
>  
>  	if (duration) {
> -		memset(&stop, 0, sizeof(stop)); /* grrr */
> -		stop = now;
> -		stop.tv_sec += duration;
> +		stop = malloc(sizeof(struct timespec));
> +		if (!stop)
> +			fatal("error allocating space for duration option\n");
> +		stop->tv_sec = now.tv_sec + duration;
> +		stop->tv_nsec = now.tv_nsec;
>  	}
>  	if (par->mode == MODE_CYCLIC) {
>  		if (par->timermode == TIMER_ABSTIME)
> @@ -1185,7 +1188,7 @@ static void *timerthread(void *param)
>  		}
>  
>  
> -		if (duration && (calcdiff(now, stop) >= 0))
> +		if (stop && (calcdiff(now, *stop) >= 0))
>  			shutdown++;
>  
>  		if (!stopped && tracelimit && (diff > tracelimit)) {
> -- 
> 2.7.4
> 

I'm not sure about this one. Do we really need to change our code for a 
false positive, that is really a compiler regression? And then we're 
adding a malloc to a rt program for that? I'd rather ignore the warning if 
we can't do this in a simpler manner.

Thanks

John
---1463806030-991391548-1469108151=:5970--
