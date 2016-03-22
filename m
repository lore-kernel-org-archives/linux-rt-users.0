From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 2/4] cyclictest: move debugfs init code to its own
 function
Date: Tue, 22 Mar 2016 15:40:27 +0100 (CET)
Message-ID: <alpine.LFD.2.20.1603221540080.10687@riemann>
References: <1458239417-31089-1-git-send-email-lcapitulino@redhat.com> <1458239417-31089-3-git-send-email-lcapitulino@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org, williams@redhat.com
To: Luiz Capitulino <lcapitulino@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35070 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756376AbcCVOka (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 22 Mar 2016 10:40:30 -0400
Received: by mail-wm0-f67.google.com with SMTP id r129so18315318wmr.2
        for <linux-rt-users@vger.kernel.org>; Tue, 22 Mar 2016 07:40:29 -0700 (PDT)
In-Reply-To: <1458239417-31089-3-git-send-email-lcapitulino@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Thu, 17 Mar 2016, Luiz Capitulino wrote:

> A function added by a future commit will want to call
> this code too.
> 
> Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>
> ---
>  src/cyclictest/cyclictest.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 6070457..4e80831 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -514,11 +514,8 @@ static int settracer(char *tracer)
>  	return -1;
>  }
>  
> -static void setup_tracer(void)
> +static void debugfs_prepare(void)
>  {
> -	if (!tracelimit || notrace)
> -		return;
> -
>  	if (mount_debugfs(NULL))
>  		fatal("could not mount debugfs");
>  
> @@ -533,6 +530,14 @@ static void setup_tracer(void)
>  			    "TRACERs not configured?\n", testname);
>  	} else
>  		fileprefix = procfileprefix;
> +}
> +
> +static void setup_tracer(void)
> +{
> +	if (!tracelimit || notrace)
> +		return;
> +
> +	debugfs_prepare();
>  
>  	if (kernelversion >= KV_26_33) {
>  		int ret;
> -- 
> 2.1.0
> 
> --

Signed-off-by: John Kacur <jkacur@redhat.com>
