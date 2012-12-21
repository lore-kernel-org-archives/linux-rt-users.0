From: Mike Galbraith <bitbucket@online.de>
Subject: Re: [ANNOUNCE] 3.6.11-rt24 (apocalypse release)c
Date: Fri, 21 Dec 2012 19:03:51 +0100
Message-ID: <1356113031.32581.4.camel@marge.simpson.net>
References: <alpine.LFD.2.02.1212211413200.3148@ionos>
	 <1356106865.4547.60.camel@marge.simpson.net>
	 <alpine.LFD.2.02.1212211729240.3148@ionos>
	 <1356107797.4547.61.camel@marge.simpson.net>
	 <1356108846.4547.66.camel@marge.simpson.net>
	 <1356112760.32581.2.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:60096 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318Ab2LUSDy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 21 Dec 2012 13:03:54 -0500
In-Reply-To: <1356112760.32581.2.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2012-12-21 at 18:59 +0100, Mike Galbraith wrote: 
> On Fri, 2012-12-21 at 17:54 +0100, Mike Galbraith wrote: 
> > On Fri, 2012-12-21 at 17:36 +0100, Mike Galbraith wrote: 
> > > On Fri, 2012-12-21 at 17:29 +0100, Thomas Gleixner wrote: 
> > > > On Fri, 21 Dec 2012, Mike Galbraith wrote:
> > > > > Just got this apocalypse day hiccup.
> > > > 
> > > > Can you revert the block chill patch ?
> > > 
> > > Sure, will do, and beat the box up a bit.
> > 
> > Hm, while I was away, box must have had a fit, then boot didn't go well.
> 
> It did that again (chill is reverted), but what it was up to prior to
> reboot was endless soft lockup.

(ie it's crashing while trying to crash dump the lockup.  poo)

