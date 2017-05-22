From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 12/34] cyclictest: fix off-by-one in clocksel check
Date: Mon, 22 May 2017 18:23:01 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1705221822390.7915@riemann>
References: <20170522082540.15467-1-tommi.t.rantala@nokia.com> <20170522082540.15467-13-tommi.t.rantala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
To: Tommi Rantala <tommi.t.rantala@nokia.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36582 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935737AbdEVQXK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2017 12:23:10 -0400
Received: by mail-wr0-f193.google.com with SMTP id v42so7460554wrc.3
        for <linux-rt-users@vger.kernel.org>; Mon, 22 May 2017 09:23:04 -0700 (PDT)
In-Reply-To: <20170522082540.15467-13-tommi.t.rantala@nokia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Mon, 22 May 2017, Tommi Rantala wrote:

> Fix off-by-one when checking that clocksel is valid index to the array.
> 
> Also fix a compiler warning:
> 
> src/cyclictest/cyclictest.c: In function 'process_options':
> src/cyclictest/cyclictest.c:1828:31: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
>   if (clocksel < 0 || clocksel > ARRAY_SIZE(clocksources))
> 
> Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
> ---
>  src/cyclictest/cyclictest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index f2747e4..d89cb0f 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -1823,7 +1823,7 @@ static void process_options (int argc, char *argv[], int max_cpus)
>  	if (tracelimit)
>  		fileprefix = procfileprefix;
>  
> -	if (clocksel < 0 || clocksel > ARRAY_SIZE(clocksources))
> +	if (clocksel < 0 || clocksel >= (int)ARRAY_SIZE(clocksources))
>  		error = 1;
>  
>  	if (oscope_reduction < 1)
> -- 

Signed-off-by: John Kacur <jkacur@redhat.com>
