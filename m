From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH rt-tests 2/9] cyclictest: fixup documentation for --priority
 option
Date: Tue, 1 Sep 2015 23:03:08 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1509012301520.19826@riemann>
References: <cover.1441038216.git.joshc@ni.com> <01e06fd455b51323577b0af9bb144e892281ecf8.1441038216.git.joshc@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
To: Josh Cartwright <joshc@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:37169 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755647AbbIAVDT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 1 Sep 2015 17:03:19 -0400
Received: by wicfx3 with SMTP id fx3so25526398wic.0
        for <linux-rt-users@vger.kernel.org>; Tue, 01 Sep 2015 14:03:18 -0700 (PDT)
In-Reply-To: <01e06fd455b51323577b0af9bb144e892281ecf8.1441038216.git.joshc@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Mon, 31 Aug 2015, Josh Cartwright wrote:

> Commit 15c6d81986b6 ("[cyclictest] added priority spreading option
> --priospread") introduced an additional option with the prefix 'prio';
> this means that it is no longer possible for a user to specify '--prio'
> instead of the full '--priority'.  Doing so results in the following
> error:
> 
>   $ cyclictest --prio=4
>   cyclictest: option '--prio=4' is ambiguous; possibilities: '--priority' '--priospread'
> 
> Fix this up by updating the 'help' output.
> 
> Signed-off-by: Josh Cartwright <joshc@ni.com>
> ---
>  src/cyclictest/cyclictest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 9aebe32..4ced67f 100644
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
> 2.5.0

This was already fixed in v0.93
417ddb5db0ab cyclictest: Fix long priority help text option

Thanks> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
