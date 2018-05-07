Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from webbox1416.server-home.net ([77.236.96.61]:45094 "EHLO
        webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750732AbeEGGJV (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 7 May 2018 02:09:21 -0400
From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH 1/1] squashfs: Disable "percpu multiple decompressor" on RT
Date: Mon, 07 May 2018 08:09:18 +0200
Message-ID: <4064553.Shs7ScuBS6@ws-stein>
In-Reply-To: <20180503154834.GF967@jcartwri.amer.corp.natinst.com>
References: <20180502131233.17029-1-alexander.stein@systec-electronic.com> <3619069.dCv7WPLmuO@ws-stein> <20180503154834.GF967@jcartwri.amer.corp.natinst.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Julia Cartwright <julia@ni.com>
Cc: linux-rt-users@vger.kernel.org, bigeasy@linutronix.de, tglx@linutronix.de

Hello Julia,

On Thursday, May 3, 2018, 5:48:34 PM CEST Julia Cartwright wrote:
> [...]
> Hrmph.  I was lost in the percpu arithmetic.  Should have built with
> sparse, it clearly tells me I screwed up.  Are you able to give this a
> try?  It's sparse-clean now :)

That does the trick. The max latency stays at 80µs in my test case. Thanks.
Tested-by: Alexander Stein <alexander.stein@systec-electronic.com>

Best regards,
Alexander

> diff --git a/fs/squashfs/decompressor_multi_percpu.c b/fs/squashfs/decompressor_multi_percpu.c
> index 23a9c28ad8ea..6a73c4fa88e7 100644
> --- a/fs/squashfs/decompressor_multi_percpu.c
> +++ b/fs/squashfs/decompressor_multi_percpu.c
> @@ -10,6 +10,7 @@
>  #include <linux/slab.h>
>  #include <linux/percpu.h>
>  #include <linux/buffer_head.h>
> +#include <linux/locallock.h>
>  
>  #include "squashfs_fs.h"
>  #include "squashfs_fs_sb.h"
> @@ -25,6 +26,8 @@ struct squashfs_stream {
>  	void		*stream;
>  };
>  
> +static DEFINE_LOCAL_IRQ_LOCK(stream_lock);
> +
>  void *squashfs_decompressor_create(struct squashfs_sb_info *msblk,
>  						void *comp_opts)
>  {
> @@ -79,10 +82,15 @@ int squashfs_decompress(struct squashfs_sb_info *msblk, struct buffer_head **bh,
>  {
>  	struct squashfs_stream __percpu *percpu =
>  			(struct squashfs_stream __percpu *) msblk->stream;
> -	struct squashfs_stream *stream = get_cpu_ptr(percpu);
> -	int res = msblk->decompressor->decompress(msblk, stream->stream, bh, b,
> -		offset, length, output);
> -	put_cpu_ptr(stream);
> +	struct squashfs_stream *stream;
> +	int res;
> +
> +	stream = get_locked_ptr(stream_lock, percpu);
> +
> +	res = msblk->decompressor->decompress(msblk, stream->stream, bh, b,
> +			offset, length, output);
> +
> +	put_locked_ptr(stream_lock, stream);
>  
>  	if (res < 0)
>  		ERROR("%s decompression failed, data probably corrupt\n",
> diff --git a/include/linux/locallock.h b/include/linux/locallock.h
> index d658c2552601..c3ab5183a6a1 100644
> --- a/include/linux/locallock.h
> +++ b/include/linux/locallock.h
> @@ -222,6 +222,14 @@ static inline int __local_unlock_irqrestore(struct local_irq_lock *lv,
>  
>  #define put_locked_var(lvar, var)	local_unlock(lvar);
>  
> +#define get_locked_ptr(lvar, var)					\
> +	({								\
> +		local_lock(lvar);					\
> +		this_cpu_ptr(var);					\
> +	})
> +
> +#define put_locked_ptr(lvar, var)	local_unlock(lvar);
> +
>  #define local_lock_cpu(lvar)						\
>  	({								\
>  		local_lock(lvar);					\
> 
> 



