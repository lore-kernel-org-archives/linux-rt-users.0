From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT]  hwlat-detector: Don't ignore threshold module
 parameter
Date: Thu, 12 Sep 2013 14:23:04 -0400
Message-ID: <20130912142304.48e3bcf0@gandalf.local.home>
References: <20130819213324.405942342@goodmis.org>
	<1377842245.5422.7.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>
To: Mike Galbraith <bitbucket@online.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1377842245.5422.7.camel@marge.simpson.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Don't be afraid to Cc LKML with rt kernel patches. linux-rt-users is
for users not kernel developers. People like Peter Zijlstra will never
see this patch.

On Fri, 30 Aug 2013 07:57:25 +0200
Mike Galbraith <bitbucket@online.de> wrote:

> If the user specified a threshold at module load time, use it.

This could use a little better change log.

Other than that,

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve

> 
> Signed-off-by: Mike Galbraith <bitbucket@online.de>
> 
> --- a/drivers/misc/hwlat_detector.c	2013-08-30 07:16:05.387959392 +0200
> +++ b/drivers/misc/hwlat_detector.c	2013-08-30 07:10:52.958670183 +0200
> @@ -413,7 +413,7 @@ static int init_stats(void)
>  		goto out;
>  
>  	__reset_stats();
> -	data.threshold = DEFAULT_LAT_THRESHOLD;	    /* threshold us */
> +	data.threshold = threshold ?: DEFAULT_LAT_THRESHOLD;	    /* threshold us */
>  	data.sample_window = DEFAULT_SAMPLE_WINDOW; /* window us */
>  	data.sample_width = DEFAULT_SAMPLE_WIDTH;   /* width us */
>  
> 
