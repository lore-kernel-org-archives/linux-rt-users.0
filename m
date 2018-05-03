Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from webbox1416.server-home.net ([77.236.96.61]:51492 "EHLO
        webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751872AbeECGgH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 3 May 2018 02:36:07 -0400
From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH 1/1] squashfs: Disable "percpu multiple decompressor" on RT
Date: Thu, 03 May 2018 08:36:03 +0200
Message-ID: <3619069.dCv7WPLmuO@ws-stein>
In-Reply-To: <20180502143729.GB967@jcartwri.amer.corp.natinst.com>
References: <20180502131233.17029-1-alexander.stein@systec-electronic.com> <20180502143729.GB967@jcartwri.amer.corp.natinst.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Julia Cartwright <julia@ni.com>
Cc: linux-rt-users@vger.kernel.org, bigeasy@linutronix.de, tglx@linutronix.de

Hello Julia,

On Wednesday, May 2, 2018, 4:37:29 PM CEST Julia Cartwright wrote:
> [..]
> > +++ b/fs/squashfs/Kconfig
> > @@ -86,6 +86,7 @@ config SQUASHFS_DECOMP_MULTI
> >  
> >  config SQUASHFS_DECOMP_MULTI_PERCPU
> >  	bool "Use percpu multiple decompressors for parallel I/O"
> > +	depends on !PREEMPT_RT_BASE
> 
> Hmm, I think we'd like to get out of the business of disabling Kconfig
> options unless we are absolutely not given any other choice.
> 
> Looking at the codepaths involved in this squashfs decompressor, it
> seems like this is a perfect candidate for the usage of local locks.
> Can you give the following patch a try instead?

Sure. See below!

> --- a/fs/squashfs/decompressor_multi_percpu.c
> +++ b/fs/squashfs/decompressor_multi_percpu.c
> @@ -6,6 +6,7 @@
>   * the COPYING file in the top-level directory.
>   */
>  
> +#include <linux/locallock.h>
>  #include <linux/types.h>
>  #include <linux/slab.h>
>  #include <linux/percpu.h>

<linux/locallock.h> needs to be added after <linux/slab.h>.

> [...]
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
> +	stream = get_locked_var(stream_lock, percpu);
> +
> +	res = msblk->decompressor->decompress(msblk, stream->stream, bh, b,
> +			offset, length, output);
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This doesn't work. I get a "Unable to handle kernel paging request at virtual address bcf67c1c". addr2line says its this line.

Best regards,
Alexander



