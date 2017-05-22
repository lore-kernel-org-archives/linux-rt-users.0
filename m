From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 10/34] cyclictest: use %zd for printing size_t in
 rt_numa_numa_alloc_onnode()
Date: Mon, 22 May 2017 17:25:44 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1705221725230.7915@riemann>
References: <20170522082540.15467-1-tommi.t.rantala@nokia.com> <20170522082540.15467-11-tommi.t.rantala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
To: Tommi Rantala <tommi.t.rantala@nokia.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34255 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934647AbdEVPZr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2017 11:25:47 -0400
Received: by mail-wr0-f194.google.com with SMTP id 6so7307156wrb.1
        for <linux-rt-users@vger.kernel.org>; Mon, 22 May 2017 08:25:47 -0700 (PDT)
In-Reply-To: <20170522082540.15467-11-tommi.t.rantala@nokia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Mon, 22 May 2017, Tommi Rantala wrote:

> Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
> ---
>  src/cyclictest/rt_numa.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/cyclictest/rt_numa.h b/src/cyclictest/rt_numa.h
> index ec29943..ee25045 100644
> --- a/src/cyclictest/rt_numa.h
> +++ b/src/cyclictest/rt_numa.h
> @@ -64,7 +64,7 @@ static void *rt_numa_numa_alloc_onnode(size_t size, int node, int cpu)
>  	void *stack;
>  	stack = numa_alloc_onnode(size, node);
>  	if (stack == NULL)
> -		fatal("failed to allocate %d bytes on node %d for cpu %d\n",
> +		fatal("failed to allocate %zd bytes on node %d for cpu %d\n",
>  				size, node, cpu);
>  	return stack;
>  }
> -- 

Signed-off-by: John Kacur <jkacur@redhat.com>
