From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] cyclictest: cannot stop running with '-M' option
Date: Thu, 4 May 2017 14:43:33 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1705041442420.11096@riemann>
References: <1493413329-115349-1-git-send-email-jianxun.zhang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Jianxun Zhang <jianxun.zhang@linux.intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35415 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751023AbdEDMnx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 4 May 2017 08:43:53 -0400
Received: by mail-wr0-f193.google.com with SMTP id g12so1311552wrg.2
        for <linux-rt-users@vger.kernel.org>; Thu, 04 May 2017 05:43:52 -0700 (PDT)
In-Reply-To: <1493413329-115349-1-git-send-email-jianxun.zhang@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Fri, 28 Apr 2017, Jianxun Zhang wrote:

> Most of time having '-M' option causes cyclictest  won't exit after
> a duration ('-D') expires, like this quick  command on my machines:
> 
> sudo cyclictest  -S -M -D2 -d0
> 
> This is because the main thread is blocked on waiting for the next
> update of MAX, but the timer thread doesn't signal the main thread
> before it quits.
> 
> Signed-off-by: Jianxun Zhang <jianxun.zhang@linux.intel.com>
> ---
> 
> The issue may not happen every time, depending on your machine or other parameters fed to cyclictest, but it does quite often on my setup.
> 
>  src/cyclictest/cyclictest.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 3f1bef1..36259ea 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -1241,6 +1241,17 @@ static void *timerthread(void *param)
>  	}
>  
>  out:
> +	if (refresh_on_max) {
> +		pthread_mutex_lock(&refresh_on_max_lock);
> +		/* We could reach here with both shutdown and allstopped unset (0).
> +		 * Set shutdown with synchronization to notify the main
> +		 * thread not to be blocked when it should exit.
> +		 */
> +		shutdown++;
> +		pthread_cond_signal(&refresh_on_max_cond);
> +		pthread_mutex_unlock(&refresh_on_max_lock);
> +	}
> +
>  	if (par->mode == MODE_CYCLIC)
>  		timer_delete(timer);
>  
> @@ -2512,8 +2523,9 @@ int main(int argc, char **argv)
>  
>  		if (refresh_on_max) {
>  			pthread_mutex_lock(&refresh_on_max_lock);
> -			pthread_cond_wait(&refresh_on_max_cond,
> -					  &refresh_on_max_lock);
> +			if (!shutdown)
> +				pthread_cond_wait(&refresh_on_max_cond,
> +						&refresh_on_max_lock);
>  			pthread_mutex_unlock(&refresh_on_max_lock);
>  		}
>  	}
> @@ -2523,6 +2535,9 @@ int main(int argc, char **argv)
>  	shutdown = 1;
>  	usleep(50000);
>  
> +	if (!verbose && !quiet && refresh_on_max)
> +		printf("\033[%dB", num_threads + 2);
> +
>  	if (quiet)
>  		quiet = 2;
>  	for (i = 0; i < num_threads; i++) {
> -- 
> 2.7.4
> 
> --

Signed-off-by: jkacur@redhat.com
> 
