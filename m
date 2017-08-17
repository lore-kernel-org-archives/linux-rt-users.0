From: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch-rt] hotplug, hrtimer: Migrate expired/deferred timers
 during cpu offline
Date: Thu, 17 Aug 2017 19:37:50 +0200
Message-ID: <1502991470.6840.11.camel@gmx.de>
References: <20170804173823.lzuhnejlnxczr2lj@linutronix.de>
         <1501913583.7917.42.camel@gmx.de> <1501945043.5473.31.camel@gmx.de>
         <20170807073350.nwytftryfp34mrwi@linutronix.de>
         <1502094121.5568.22.camel@gmx.de> <1502186459.8042.31.camel@gmx.de>
         <1502438116.16425.18.camel@gmx.de> <1502439312.16425.19.camel@gmx.de>
         <1502697588.12319.199.camel@gmx.de>
         <20170817165041.3agf2btidfdcspiq@linutronix.de>
         <20170817171720.jz2ok332bpxcjzme@linutronix.de>
         <1502990778.6840.2.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:60936 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753233AbdHQRiK (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 17 Aug 2017 13:38:10 -0400
In-Reply-To: <1502990778.6840.2.camel@gmx.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2017-08-17 at 19:26 +0200, Mike Galbraith wrote:
> On Thu, 2017-08-17 at 19:17 +0200, Sebastian Andrzej Siewior wrote:
> > On 2017-08-17 18:50:42 [+0200], To Mike Galbraith wrote:
> > > __remove_hrtimer() shouldn't be required because it has been done
> > > already. It should be enough to just list_splice() one list to the
> > > other and raise the softirq afterwards.
> > 
> > Mike, can you check this please:
> 
> Yeah, will do.

BTW, with holes stopped up, 8 socket box took a hefty beating for 20
hours.  It was actually 4.12, but it's the same code, just rolled
forward.  This is hotplug code is looking pretty darn durable.

	-Mike
