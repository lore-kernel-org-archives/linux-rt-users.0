Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:41554 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751369AbeECPry (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 3 May 2018 11:47:54 -0400
Date: Thu, 3 May 2018 10:48:34 -0500
From: Julia Cartwright <julia@ni.com>
Subject: Re: [PATCH 1/1] squashfs: Disable "percpu multiple decompressor" on
 RT
Message-ID: <20180503154834.GF967@jcartwri.amer.corp.natinst.com>
References: <20180502131233.17029-1-alexander.stein@systec-electronic.com>
 <20180502143729.GB967@jcartwri.amer.corp.natinst.com>
 <3619069.dCv7WPLmuO@ws-stein>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3619069.dCv7WPLmuO@ws-stein>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-rt-users@vger.kernel.org, bigeasy@linutronix.de, tglx@linutronix.de

Hey Alexander-

On Thu, May 03, 2018 at 08:36:03AM +0200, Alexander Stein wrote:
> On Wednesday, May 2, 2018, 4:37:29 PM CEST Julia Cartwright wrote:
> > [..]
> > > +++ b/fs/squashfs/Kconfig
> > > @@ -86,6 +86,7 @@ config SQUASHFS_DECOMP_MULTI
> > >  
> > >  config SQUASHFS_DECOMP_MULTI_PERCPU
> > >  	bool "Use percpu multiple decompressors for parallel I/O"
> > > +	depends on !PREEMPT_RT_BASE
> > 
> > Hmm, I think we'd like to get out of the business of disabling Kconfig
> > options unless we are absolutely not given any other choice.
> > 
> > Looking at the codepaths involved in this squashfs decompressor, it
> > seems like this is a perfect candidate for the usage of local locks.
> > Can you give the following patch a try instead?
> 
> Sure. See below!

Thanks for giving it a test.

> > --- a/fs/squashfs/decompressor_multi_percpu.c
> > +++ b/fs/squashfs/decompressor_multi_percpu.c
> > @@ -6,6 +6,7 @@
> >   * the COPYING file in the top-level directory.
> >   */
> >  
> > +#include <linux/locallock.h>
> >  #include <linux/types.h>
> >  #include <linux/slab.h>
> >  #include <linux/percpu.h>
>
> <linux/locallock.h> needs to be added after <linux/slab.h>.

That seems broken.

> > [...]
> > @@ -79,10 +82,15 @@ int squashfs_decompress(struct squashfs_sb_info *msblk, struct buffer_head **bh,
> >  {
> >  	struct squashfs_stream __percpu *percpu =
> >  			(struct squashfs_stream __percpu *) msblk->stream;
> > -	struct squashfs_stream *stream = get_cpu_ptr(percpu);
> > -	int res = msblk->decompressor->decompress(msblk, stream->stream, bh, b,
> > -		offset, length, output);
> > -	put_cpu_ptr(stream);
> > +	struct squashfs_stream *stream;
> > +	int res;
> > +
> > +	stream = get_locked_var(stream_lock, percpu);
> > +
> > +	res = msblk->decompressor->decompress(msblk, stream->stream, bh, b,
> > +			offset, length, output);
>           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> This doesn't work. I get a "Unable to handle kernel paging request at virtual address bcf67c1c". addr2line says its this line.

Hrmph.  I was lost in the percpu arithmetic.  Should have built with
sparse, it clearly tells me I screwed up.  Are you able to give this a
try?  It's sparse-clean now :)

   Julia

diff --git a/fs/squashfs/decompressor_multi_percpu.c b/fs/squashfs/decompressor_multi_percpu.c
index 23a9c28ad8ea..6a73c4fa88e7 100644
--- a/fs/squashfs/decompressor_multi_percpu.c
+++ b/fs/squashfs/decompressor_multi_percpu.c
@@ -10,6 +10,7 @@
 #include <linux/slab.h>
 #include <linux/percpu.h>
 #include <linux/buffer_head.h>
+#include <linux/locallock.h>
 
 #include "squashfs_fs.h"
 #include "squashfs_fs_sb.h"
@@ -25,6 +26,8 @@ struct squashfs_stream {
 	void		*stream;
 };
 
+static DEFINE_LOCAL_IRQ_LOCK(stream_lock);
+
 void *squashfs_decompressor_create(struct squashfs_sb_info *msblk,
 						void *comp_opts)
 {
@@ -79,10 +82,15 @@ int squashfs_decompress(struct squashfs_sb_info *msblk, struct buffer_head **bh,
 {
 	struct squashfs_stream __percpu *percpu =
 			(struct squashfs_stream __percpu *) msblk->stream;
-	struct squashfs_stream *stream = get_cpu_ptr(percpu);
-	int res = msblk->decompressor->decompress(msblk, stream->stream, bh, b,
-		offset, length, output);
-	put_cpu_ptr(stream);
+	struct squashfs_stream *stream;
+	int res;
+
+	stream = get_locked_ptr(stream_lock, percpu);
+
+	res = msblk->decompressor->decompress(msblk, stream->stream, bh, b,
+			offset, length, output);
+
+	put_locked_ptr(stream_lock, stream);
 
 	if (res < 0)
 		ERROR("%s decompression failed, data probably corrupt\n",
diff --git a/include/linux/locallock.h b/include/linux/locallock.h
index d658c2552601..c3ab5183a6a1 100644
--- a/include/linux/locallock.h
+++ b/include/linux/locallock.h
@@ -222,6 +222,14 @@ static inline int __local_unlock_irqrestore(struct local_irq_lock *lv,
 
 #define put_locked_var(lvar, var)	local_unlock(lvar);
 
+#define get_locked_ptr(lvar, var)					\
+	({								\
+		local_lock(lvar);					\
+		this_cpu_ptr(var);					\
+	})
+
+#define put_locked_ptr(lvar, var)	local_unlock(lvar);
+
 #define local_lock_cpu(lvar)						\
 	({								\
 		local_lock(lvar);					\
