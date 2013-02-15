From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH rt-tests] cyclictest: finish removal of 1 second first
 loops
Date: Fri, 15 Feb 2013 15:26:15 +0100 (CET)
Message-ID: <alpine.LFD.2.03.1302151525440.13838@tycho>
References: <1360880594-20779-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org,
	Jim Somerville <Jim.Somerville@windriver.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:53643 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755257Ab3BOO02 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Feb 2013 09:26:28 -0500
Received: by mail-wi0-f182.google.com with SMTP id hi18so1229015wib.3
        for <linux-rt-users@vger.kernel.org>; Fri, 15 Feb 2013 06:26:27 -0800 (PST)
In-Reply-To: <1360880594-20779-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Thu, 14 Feb 2013, Paul Gortmaker wrote:

> From: Jim Somerville <Jim.Somerville@windriver.com>
> 
> Huge latencies are observed (close to 1 second) when certain
> options are used in cyclictest.
> 
> The problem was 1st introduced at commit da4956cbcaf7945554f
> ("use interval on first loop instead of 1 second").  It removed
> the 1 second first timing loop out of the main path in cyclictest
> but left it in two other paths, namely the ones triggered by
> these two options:
> 
>     -r   --relative    use relative timer instead of absolute
>     -s   --system      use sys_nanosleep and sys_setitimer
> 
> which in turn causes the huge latencies of close to 1 second to
> be reported by cyclictest with certain uses of those two options.
> 
> Here we extend the original commit to remove the 1 second
> hardcoded timer values from the RELTIME and ITIMER options, by
> simply using the actual interval provided instead.
> 
> Signed-off-by: Jim Somerville <Jim.Somerville@windriver.com>
> Cc: Clark Williams <williams@redhat.com>
> Cc: John Kacur <jkacur@redhat.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index abf3e8b..8c93ccb 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -775,17 +775,15 @@ void *timerthread(void *param)
>  		if (par->timermode == TIMER_ABSTIME)
>  			tspec.it_value = next;
>  		else {
> -			tspec.it_value.tv_nsec = 0;
> -			tspec.it_value.tv_sec = 1;
> +			tspec.it_value = interval;
>  		}
>  		timer_settime(timer, par->timermode, &tspec, NULL);
>  	}
>  
>  	if (par->mode == MODE_SYS_ITIMER) {
> -		itimer.it_value.tv_sec = 1;
> -		itimer.it_value.tv_usec = 0;
>  		itimer.it_interval.tv_sec = interval.tv_sec;
>  		itimer.it_interval.tv_usec = interval.tv_nsec / 1000;
> +		itimer.it_value = itimer.it_interval;
>  		setitimer (ITIMER_REAL, &itimer, NULL);
>  	}
>  
> -- 

Thanks Jim and Paul, I've added it to my queue for the next build.

John
