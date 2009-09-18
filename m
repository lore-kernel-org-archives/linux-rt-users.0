From: Georg Mill <info@georgmill.de>
Subject: Re: xjadeo
Date: Fri, 18 Sep 2009 09:14:48 +0200
Message-ID: <20090918091448.44ab4081.info@georgmill.de>
References: <20090917151902.f6676667.info@georgmill.de>
	<alpine.LFD.2.00.0909172328260.2889@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from csmtp1.one.com ([195.47.247.21]:35812 "EHLO csmtp1.one.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754096AbZIRHOr (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 18 Sep 2009 03:14:47 -0400
In-Reply-To: <alpine.LFD.2.00.0909172328260.2889@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Thomas,

you were right. Changing the nvidia driver to the xserver-xorg-video-nv driver the problem disappeared.
I used the original NVIDIA-Linux-x86_64-185.18.36-pkg2.run installer with the 2.6.31-rt nvidia patches from Jan Engelhard on 64-bit.

Thanks for your help
Georg Mill


On Thu, 17 Sep 2009 23:34:46 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Thu, 17 Sep 2009, Georg Mill wrote:
> 
> > Hi,
> > 
> > I found the following bug on a machine with 4 cpu's. I tried to synchronize sound and video with xjadeo and ardour and jackd and got the following error.
> > This error appears also within the other cpu's. I used the last svn-sources (svn co https://xjadeo.svn.sourceforge.net/svnroot/xjadeo xjadeo). With kernel 2.6.29.6-rt23 that problem didn't appear.
> > 
> > ---snip---
> > 
> > kernel: [  199.899987] BUG: scheduling while atomic: xjadeo/0x1000020b/5117, CPU#3
> 
> Hmm, that's pretty weird. The preempt count is 0x1000020b, which means
> 11 nested preempt disables and 2 bh disables.
> 
> I cannot decode from the stack traces where this should happen. Can
> you reproduce that w/o the binary nvidia driver ?
> 
> Thanks,
> 
> 	tglx
