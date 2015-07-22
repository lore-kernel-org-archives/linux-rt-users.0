From: Clark Williams <williams@redhat.com>
Subject: Re: [PATCH 1/1] cyclictest: Fix long priority help text option
Date: Wed, 22 Jul 2015 10:21:27 -0500
Message-ID: <20150722102127.12ee911e@sluggy>
References: <1437569099-2965-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
To: Alexander Stein <alexander.stein@systec-electronic.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33301 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934059AbbGVPVf (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 22 Jul 2015 11:21:35 -0400
In-Reply-To: <1437569099-2965-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 22 Jul 2015 14:44:59 +0200
Alexander Stein <alexander.stein@systec-electronic.com> wrote:

> The help text shows prio as the long option name for the process priority.
> But it is actually priority.
> 
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> ---
>  src/cyclictest/cyclictest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 34053c5..c178a74 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -1062,7 +1062,7 @@ static void display_help(int error)
>  	       "-N       --nsecs           print results in ns instead of us (default us)\n"
>  	       "-o RED   --oscope=RED      oscilloscope mode, reduce verbose output by RED\n"
>  	       "-O TOPT  --traceopt=TOPT   trace option\n"
> -	       "-p PRIO  --prio=PRIO       priority of highest prio thread\n"
> +	       "-p PRIO  --priority=PRIO   priority of highest prio thread\n"
>  	       "-P       --preemptoff      Preempt off tracing (used with -b)\n"
>  	       "-q       --quiet           print only a summary on exit\n"
>  	       "	 --priospread       spread priority levels starting at specified value\n"
> -- 
> 2.3.6

Thanks, I've pulled this into my tree for the next release.

Clark
