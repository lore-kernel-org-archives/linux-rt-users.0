From: Carsten Emde <Carsten.Emde@osadl.org>
Subject: Re: [PATCH] cyclictest: Use symbolic names for scheduling policy
Date: Mon, 08 Mar 2010 09:35:45 +0100
Message-ID: <4B94B6E1.2060400@osadl.org>
References: <1268011104-22451-1-git-send-email-jkacur@redhat.com> <1268011104-22451-3-git-send-email-jkacur@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080605000504040906080201"
Cc: Clark Williams <williams@redhat.com>,
	rt-users <linux-rt-users@vger.kernel.org>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:35456 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751319Ab0CHIkY (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Mar 2010 03:40:24 -0500
In-Reply-To: <1268011104-22451-3-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is a multi-part message in MIME format.
--------------080605000504040906080201
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 03/08/2010 02:18 AM, John Kacur wrote:
> - Use symbolic names for scheduling policies, that is, don't assume
> 	SCHED_RR is 2, use SCHED_RR instead, and so on.
> 
> - Fix the logic in handlepolicy(char *polname)
> 	- remove the test with the unreachable line,
> 	- make the default SCHED_FIFO if we don't recognize the
> 	requested policy.
> 
> Signed-off-by: John Kacur <jkacur@redhat.com>
> ---
>  src/cyclictest/cyclictest.c |   15 +++++----------
>  1 files changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index d38c0a7..066ca79 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -826,13 +826,8 @@ static void handlepolicy(char *polname)
>  		policy = SCHED_FIFO;
>  	else if (strncasecmp(polname, "rr", 2) == 0)
>  		policy = SCHED_RR;
> -
> -	if (policy == SCHED_FIFO || policy == SCHED_RR) {
> -		if (policy == 0)
> -			policy = 1;
> -	}
> -	else 
> -		policy = 0;
> +	else	/* default policy if we don't recognize the request */
> +		policy = SCHED_FIFO;
>  }
>  
>  static char *policyname(int policy)
> @@ -1303,9 +1298,9 @@ int main(int argc, char **argv)
>  		par->prio = priority;
>  		if (priority && !histogram && !smp && !numa)
>  			priority--;
> -                if      (priority && policy <= 1) par->policy = SCHED_FIFO;
> -                else if (priority && policy == 2) par->policy = SCHED_RR;
> -                else                              par->policy = SCHED_OTHER;
> +                if (priority && policy == SCHED_FIFO) par->policy = SCHED_FIFO;
> +                else if (priority && policy == SCHED_RR) par->policy = SCHED_RR;
> +                else  par->policy = SCHED_OTHER;
>  		par->clock = clocksources[clocksel];
>  		par->mode = mode;
>  		par->timermode = timermode;
We need to adapt the help message accordingly.

Signed-off-by: Carsten Emde <C.Emde@osadl.org>


--------------080605000504040906080201
Content-Type: text/x-patch;
 name="adapt-policy-help-message-for-cyclictest.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="adapt-policy-help-message-for-cyclictest.patch"

Index: rt-tests/src/cyclictest/cyclictest.c
===================================================================
--- rt-tests.orig/src/cyclictest/cyclictest.c
+++ rt-tests/src/cyclictest/cyclictest.c
@@ -776,8 +776,8 @@ static void display_help(int error)
 	       "                           format: n:c:v n=tasknum c=count v=value in us\n"
                "-w       --wakeup          task wakeup tracing (used with -b)\n"
                "-W       --wakeuprt        rt task wakeup tracing (used with -b)\n"
-               "-y POLI  --policy=POLI     policy of realtime thread (1:FIFO, 2:RR)\n"
-               "                           format: --policy=fifo(default) or --policy=rr\n"
+               "-y POLI  --policy=POLI     policy of realtime thread, POLI may be FIFO (default)\n"
+               "                           or RR\n"
 	       "-S       --smp             Standard SMP testing (equals -a -t -n -m -d0)\n"
                "                           same priority on all threads.\n"
 	       "-U       --numa            Standard NUMA testing (similar to SMP option)\n"

--------------080605000504040906080201--
