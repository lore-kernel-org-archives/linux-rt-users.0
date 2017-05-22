From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 08/34] cyclictest: adjust whitespace in display_help()
 output
Date: Mon, 22 May 2017 18:08:47 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1705221808240.7915@riemann>
References: <20170522082540.15467-1-tommi.t.rantala@nokia.com> <20170522082540.15467-9-tommi.t.rantala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
To: Tommi Rantala <tommi.t.rantala@nokia.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:32789 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932481AbdEVQIu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2017 12:08:50 -0400
Received: by mail-wr0-f195.google.com with SMTP id w50so7427313wrc.0
        for <linux-rt-users@vger.kernel.org>; Mon, 22 May 2017 09:08:49 -0700 (PDT)
In-Reply-To: <20170522082540.15467-9-tommi.t.rantala@nokia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Mon, 22 May 2017, Tommi Rantala wrote:

> Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
> ---
>  src/cyclictest/cyclictest.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 2630296..0a2cd9e 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -1349,8 +1349,8 @@ static void display_help(int error)
>  	       "-s       --system          use sys_nanosleep and sys_setitimer\n"
>  	       "-S       --smp             Standard SMP testing: options -a -t and\n"
>  	       "                           same priority of all threads\n"
> -	       "	--spike=<trigger>  record all spikes > trigger\n"
> -	       "	--spike-nodes=[num of nodes]\n"
> +	       "	 --spike=<trigger> record all spikes > trigger\n"
> +	       "	 --spike-nodes=[num of nodes]\n"
>  	       "			   These are the maximum number of spikes we can record.\n"
>  	       "			   The default is 1024 if not specified\n"
>  #ifdef ARCH_HAS_SMI_COUNTER
> -- 

Signed-off-by: John Kacur <jkacur@redhat.com>
