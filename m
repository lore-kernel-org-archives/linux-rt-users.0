From: Mike Galbraith <efault@gmx.de>
Subject: Re: rcu  stalls running 3.0.1-rt8
Date: Tue, 09 Aug 2011 03:14:28 +0200
Message-ID: <1312852468.5977.10.camel@marge.simson.net>
References: <1312580681.28695.44.camel@twins>
	 <1312811718.5896.29.camel@marge.simson.net>
	 <20110808231039.GP4435@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
To: paulmck@linux.vnet.ibm.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:43405 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750828Ab1HIBPH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Aug 2011 21:15:07 -0400
In-Reply-To: <20110808231039.GP4435@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2011-08-08 at 16:10 -0700, Paul E. McKenney wrote:
> On Mon, Aug 08, 2011 at 03:55:18PM +0200, Mike Galbraith wrote:
> > Greetings,
> > 
> > I've had no time to tinker with this but though I should get it posted,
> > so build latest/greatest to make sure it's still there.  It is.
> > 
> > Box can be idling along, and pow.  If RCU_BOOST is enabled, I get a hung
> > task panic after the stall.  If RCU_BOOST is off, and debugging options
> > are cut to the bone, box will stay up despite periodic gripes.
> 
> Yow!
> 
> Is this new in -rt8?  I wasn't seeing it in earlier versions.  Then
> again, I was running 32 bits.

No, I saw it in earlier releases too.  The only thing I've done since
first seeing it is a quick build to see if it was still alive, or had
died of boredom while waiting for me to come out and play ;-)

	-Mike

