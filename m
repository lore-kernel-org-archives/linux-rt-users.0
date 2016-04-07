From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT 4/6] rt/locking: Reenable migration accross schedule
Date: Thu, 7 Apr 2016 18:47:36 +0200
Message-ID: <57068F28.8010409@linutronix.de>
References: <1455318168-7125-1-git-send-email-bigeasy@linutronix.de>
 <1455318168-7125-4-git-send-email-bigeasy@linutronix.de>
 <1458463425.3908.5.camel@gmail.com> <1458814024.23732.35.camel@gmail.com>
 <alpine.DEB.2.11.1603241140510.3978@nanos>
 <1459405903.14336.64.camel@gmail.com> <20160401211105.GE29603@linutronix.de>
 <1459566735.3779.36.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459566735.3779.36.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 04/02/2016 05:12 AM, Mike Galbraith wrote:
>> By the time I improved hotplug I played with this. I had a few ideas but
>> it didn't fly in the end. Today however I ended up with this:
> 
> Yeah, but that fails the duct tape test too.  Mine is below, and is the
> extra sticky variety ;-)  With busted 0299 patch reverted and those two
> applied, my DL980 took a beating for ~36 hours before I aborted it.. ie
> hotplug road seemingly has no more -rt specific potholes.

just to be clear: The patch I attached did _not_ work for you.

> If that lock dies, we can unpin when entering lock slow path and pin
> again post acquisition with no ABBA worries as well, and not only does
> existing hotplug work heaping truckloads better, -rt can perhaps help
> spot trouble as the rewrite proceeds.
> 
> Current state is more broken than ever.. if that's possible.

And the two patches you attached here did?

> 
> 	-Mike

Sebastian
