From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: rt patch set and tags on mainline repo
Date: Thu, 6 Oct 2011 09:13:10 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1110060900550.18778@ionos>
References: <4E8CA60F.3080700@cavium.com> <alpine.LFD.2.02.1110052143420.18778@ionos> <4E8D234F.9040803@cavium.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Venkat Subbiah <venkat.subbiah@cavium.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35474 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932485Ab1JFHNN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 6 Oct 2011 03:13:13 -0400
In-Reply-To: <4E8D234F.9040803@cavium.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 5 Oct 2011, Venkat Subbiah wrote:
> On 10/05/2011 12:47 PM, Thomas Gleixner wrote:
> > > not available. Is there a location where I can get the split patch
> > > equivalent
> > > of "patch-2.6.33.9-rt31.gz".
> > Not at the moment.
> Thanks for you reply.
> 
> Once the rt wiki is back would there be one or a split patch hasn't been
> created at all for 2.6.33.9-rt1?
> 
> Is there a split patch for any 2.6.33 version?

No.
 
> > > Q2) I am really looking to patch a 2.6.32 kernel. Are there rt patch sets
> > > available for this version even if they are unofficial?
> > No. Just my 0,01$: Move your BSP to 2.6.33 or 3.0 instead of
> > attempting to backport rt to 33. But it's your decision and your time
> > to waste. :0
> Thanks for you input, but it may not be my decision too!

Good luck!

	tglx
