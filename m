From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RT] Lockdep warning on boot with 2.6.31-rc5-rt1.1
Date: Fri, 07 Aug 2009 17:09:03 +0200
Message-ID: <1249657743.32113.733.camel@twins>
References: <20090807094608.4b0efea1@torg>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alan Stern <stern@rowland.harvard.edu>,
	"greg@kroah.com" <greg@kroah.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Kay Sievers <kay.sievers@vrfy.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:39605 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932594AbZHGPJh (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 7 Aug 2009 11:09:37 -0400
In-Reply-To: <20090807094608.4b0efea1@torg>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2009-08-07 at 09:46 -0500, Clark Williams wrote:
> Peter,
> 
> I'm getting this warning from lockdep when booting on my T60. 
> 
> The two addresses reported (0xffffffff812664a2 and 0xffffffff812664ae)
> actually bracket one call to mutex_lock() in driver_attach() so I'm not
> sure what the complaint is.
> 
> Clark
> 
> =============================================
> [ INFO: possible recursive locking detected ]
> 2.6.31-rc5-rt1.1 #37
> ---------------------------------------------
> swapper/1 is trying to acquire lock:
>  (&dev->mutex){+.+...}, at: [<ffffffff812664ae>]
> __driver_attach+0x48/0x81
> 
> but task is already holding lock:
>  (&dev->mutex){+.+...}, at: [<ffffffff812664a2>]
> __driver_attach+0x3c/0x81
> 
> other info that might help us debug this:
> 1 lock held by swapper/1:
>  #0:  (&dev->mutex){+.+...}, at: [<ffffffff812664a2>]
> __driver_attach+0x3c/0x81

Oh, that's tglx who's gone wild with sem->mutex conversions.

It used to be that _all_ dev->sem instances were taken on suspend or
something like that, I think that got fixed a long while back.

I'd have to look at what the current locking requirements for dev->sem
are. 

I remember talking to Alan on several occasions about this, and I just
went over some of the old emails, but I must say the precise
requirements stay hidden from me. Also, I'm not sure these emails are
still representative of the current state.

