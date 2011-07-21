From: hermann <brummer-@web.de>
Subject: Re: [ANNOUNCE] 3.0-rc7-rt0
Date: Thu, 21 Jul 2011 20:33:22 +0200
Message-ID: <1311273202.2323.13.camel@box>
References: <1311265361.2323.6.camel@box>
	 <alpine.LFD.2.02.1107211932440.2702@ionos>
	 <alpine.LFD.2.02.1107211942420.2702@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fmmailgate01.web.de ([217.72.192.221]:50126 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902Ab1GUSdZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 Jul 2011 14:33:25 -0400
In-Reply-To: <alpine.LFD.2.02.1107211942420.2702@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Am Donnerstag, den 21.07.2011, 19:43 +0200 schrieb Thomas Gleixner:
> On Thu, 21 Jul 2011, Thomas Gleixner wrote:
> > On Thu, 21 Jul 2011, hermann wrote:
> > > I try to build the 3.0-rc7-rt0 but fail with the following message:
> > >  CC [M]  fs/ext3/balloc.o
> > > In file included from include/linux/jbd.h:247:0,
> > >                  from fs/ext3/balloc.c:18:
> > 
> > Find below a patch on top of rt0 which fixes this build failure and
> > some other stuff.

Many Thanks for the quick response, when I try to apply the patch's on a
fresh patched 3.0-rc7-rt0, I receive some Hunks :

 patch -p1<../patch-3.0-rc7-rt0.1.patch
patching file kernel/timer.c
Hunk #1 succeeded at 654 with fuzz 1.
Hunk #2 FAILED at 729.
1 out of 2 hunks FAILED -- saving rejects to file kernel/timer.c.rej
patching file mm/page_alloc.c
Hunk #1 FAILED at 1943.
1 out of 1 hunk FAILED -- saving rejects to file mm/page_alloc.c.rej
patching file include/linux/buffer_head.h
Hunk #1 FAILED at 74.
1 out of 1 hunk FAILED -- saving rejects to file
include/linux/buffer_head.h.rej
patching file include/linux/buffer_head.h
Hunk #1 FAILED at 109.
1 out of 1 hunk FAILED -- saving rejects to file
include/linux/buffer_head.h.rej

So I apply them per hand, (well some offset here and there). 
Build is running now, will report back if all went well for me now. 

kind regards
hermann

