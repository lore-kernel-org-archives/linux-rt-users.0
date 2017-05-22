From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 07/34] cyclictest: update --smp help: -n was removed
Date: Mon, 22 May 2017 18:07:36 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1705221807180.7915@riemann>
References: <20170522082540.15467-1-tommi.t.rantala@nokia.com> <20170522082540.15467-8-tommi.t.rantala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
To: Tommi Rantala <tommi.t.rantala@nokia.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35814 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760303AbdEVQHj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2017 12:07:39 -0400
Received: by mail-wr0-f193.google.com with SMTP id j27so956988wre.2
        for <linux-rt-users@vger.kernel.org>; Mon, 22 May 2017 09:07:38 -0700 (PDT)
In-Reply-To: <20170522082540.15467-8-tommi.t.rantala@nokia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Mon, 22 May 2017, Tommi Rantala wrote:

> Update the --smp help, now that -n has been removed.
> 
> Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
> ---
>  src/cyclictest/cyclictest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 8f7b28c..2630296 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -1347,7 +1347,7 @@ static void display_help(int error)
>  	       "         --secaligned [USEC] align thread wakeups to the next full second\n"
>  	       "                           and apply the optional offset\n"
>  	       "-s       --system          use sys_nanosleep and sys_setitimer\n"
> -	       "-S       --smp             Standard SMP testing: options -a -t -n and\n"
> +	       "-S       --smp             Standard SMP testing: options -a -t and\n"
>  	       "                           same priority of all threads\n"
>  	       "	--spike=<trigger>  record all spikes > trigger\n"
>  	       "	--spike-nodes=[num of nodes]\n"
> -- 

Signed-off-by: John Kacur <jkacur@redhat.com>
