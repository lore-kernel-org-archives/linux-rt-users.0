From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH -rt]
 Updates-from-Jon-Masters-for-hwlat_detector.c.patch
Date: Mon, 2 Nov 2009 16:43:12 +0100 (CET)
Message-ID: <alpine.LFD.2.00.0911021620580.12138@localhost.localdomain>
References: <alpine.LFD.2.00.0910230007030.3737@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, Jon Masters <jcm@redhat.com>,
	linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:44308 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755287AbZKBPnW (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 2 Nov 2009 10:43:22 -0500
In-Reply-To: <alpine.LFD.2.00.0910230007030.3737@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

On Fri, 23 Oct 2009, John Kacur wrote:
> I took Jon Masters' latest hwlat_detector patch for upstream, and grabbed 
> the bits that aren't currently in -rt. The patch is fairly small.
> 
> Please consider it for the next -rt release.

Not really.

> diff --git a/drivers/misc/hwlat_detector.c b/drivers/misc/hwlat_detector.c
> index be6553f..7191e17 100644
> --- a/drivers/misc/hwlat_detector.c
> +++ b/drivers/misc/hwlat_detector.c
> @@ -262,6 +262,8 @@ static int get_sample(void *unused)
>  		/* Keep a running maximum ever recorded hardware latency */
>  		if (sample > data.max_sample)
>  			data.max_sample = sample;
> +
> +		wake_up(&data.wq); /* wake up reader(s) */
>  	}
>  
>  	ret = 0;
> @@ -299,8 +301,6 @@ static int kthread_fn(void *unused)
>  			goto err_out;
>  		}
>  
> -		wake_up(&data.wq); /* wake up reader(s) */
> -

This reverts -rt commit 5fc485f6341c177e9d5f641c6fb9e33ca465aa84. 

CONFIG_DEBUG_SPINLOCK_SLEEP resp. CONFIG_DEBUG_PREEMPT will tell you
why this is a bad idea on -rt :)

Thanks,

	tglx
