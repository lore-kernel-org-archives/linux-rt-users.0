From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] cyclictest: touch threadstacks on numa to pre-fault
 them
Date: Mon, 24 Apr 2017 21:56:33 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1704242156020.13237@riemann.fritz.box>
References: <20170424170515.7051-1-williams@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Linux RT Users <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36852 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S977329AbdDXT4n (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 24 Apr 2017 15:56:43 -0400
Received: by mail-wm0-f67.google.com with SMTP id u65so20096360wmu.3
        for <linux-rt-users@vger.kernel.org>; Mon, 24 Apr 2017 12:56:42 -0700 (PDT)
In-Reply-To: <20170424170515.7051-1-williams@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Mon, 24 Apr 2017, Clark Williams wrote:

> On a numa system we allocate a stack from the closest NUMA node
> for each measurement thread. We need to touch those stack pages
> to prevent them faulting when first run. Not a big deal on a
> system with just a few cores, but overhead adds up with 32+ cores.
> 
> Signed-off-by: Clark Williams <williams@redhat.com>
> ---
>  src/cyclictest/cyclictest.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 5e23fc58f602..49a81f168cdb 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -2376,6 +2376,9 @@ int main(int argc, char **argv)
>  			/*  allocate memory for a stack on appropriate node */
>  			stack = rt_numa_numa_alloc_onnode(stksize, node, i);
>  
> +			/* touch the stack pages to pre-fault them in */
> +			memset(stack, 0, stksize);
> +
>  			/* set the thread's stack */
>  			if (pthread_attr_setstack(&attr, stack, stksize))
>  				fatal("failed to set stack addr for thread %d to 0x%x\n",
> -- 
> 2.9.3
> 
> --

Signed-off-by: John Kacur <jkacur@redhat.com>

