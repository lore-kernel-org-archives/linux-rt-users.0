From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 1/4] cyclictest: tracing(): check for notrace
Date: Tue, 22 Mar 2016 15:37:49 +0100 (CET)
Message-ID: <alpine.LFD.2.20.1603221537240.10687@riemann>
References: <1458239417-31089-1-git-send-email-lcapitulino@redhat.com> <1458239417-31089-2-git-send-email-lcapitulino@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org, williams@redhat.com
To: Luiz Capitulino <lcapitulino@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34813 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757386AbcCVOhv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 22 Mar 2016 10:37:51 -0400
Received: by mail-wm0-f68.google.com with SMTP id p65so30616777wmp.1
        for <linux-rt-users@vger.kernel.org>; Tue, 22 Mar 2016 07:37:51 -0700 (PDT)
In-Reply-To: <1458239417-31089-2-git-send-email-lcapitulino@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Thu, 17 Mar 2016, Luiz Capitulino wrote:

> If you pass -b and --notrace to cyclictest today, it will
> write to tracing_on when -b latency is reached.
> 
> Fix this by making tracing() check notrace.
> 
> Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>
> ---
>  src/cyclictest/cyclictest.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index f5a67dc..6070457 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -479,6 +479,9 @@ static void tracemark(char *fmt, ...)
>  
>  static void tracing(int on)
>  {
> +	if (notrace)
> +		return;
> +
>  	if (on) {
>  		switch (kernelversion) {
>  		case KV_26_LT18: gettimeofday(0,(struct timezone *)1); break;
> @@ -1698,7 +1701,7 @@ static void sighand(int sig)
>  	shutdown = 1;
>  	if (refresh_on_max)
>  		pthread_cond_signal(&refresh_on_max_cond);
> -	if (tracelimit && !notrace)
> +	if (tracelimit)
>  		tracing(0);
>  }
>  
> @@ -2303,7 +2306,7 @@ int main(int argc, char **argv)
>  	}
>   out:
>  	/* ensure that the tracer is stopped */
> -	if (tracelimit && !notrace)
> +	if (tracelimit)
>  		tracing(0);
>  
>  
> -- 
> 2.1.0
> 
> --
Signed-off-by: John Kacur <jkacur@redhat.com>
