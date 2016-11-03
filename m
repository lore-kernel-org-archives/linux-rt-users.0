From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] rcu: update: make RCU_EXPEDITE_BOOT default
Date: Thu, 3 Nov 2016 17:33:27 +0100
Message-ID: <20161103163326.jkjbncoz7a5oriy5@linutronix.de>
References: <20161012171553.GA18392@jcartwri.amer.corp.natinst.com>
 <20161012203223.GK29518@linux.vnet.ibm.com>
 <20161013191332-mutt-send-email-mst@kernel.org>
 <20161014092050.GW29518@linux.vnet.ibm.com>
 <20161016044420-mutt-send-email-mst@kernel.org>
 <20161016112846.GR29518@linux.vnet.ibm.com>
 <20161031173852.a3ji7hhgjis5l3u4@linutronix.de>
 <20161031181543.GN3716@linux.vnet.ibm.com>
 <20161102163002.igni3zdnid535nou@linutronix.de>
 <20161103162228.GG3716@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        linux-rt-users@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:36016 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757848AbcKCQdj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 3 Nov 2016 12:33:39 -0400
Content-Disposition: inline
In-Reply-To: <20161103162228.GG3716@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2016-11-03 09:22:28 [-0700], Paul E. McKenney wrote:
> On Wed, Nov 02, 2016 at 05:30:02PM +0100, Sebastian Andrzej Siewior wrote:
> > RCU_EXPEDITE_BOOT should speed up the boot process by enforcing
> > synchronize_rcu_expedited() instead of synchronize_rcu() during the boot
> > process. There should be no reason why one does not want this and there
> > is no need worry about real time latency at this point.
> > Therefore make it default.
> > 
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> Well, it has been awhile since I removed a Kconfig parameter.
> 
> So why could this be a bad thing?
> 
> 1.	Very large systems might see scalability issues with unconditional
> 	expediting at boot.  But if we don't try it, we won't know.

You mean we would make the boot process slower for them instead of
faster?

> 2.	People bringing up new hardware might not want quite so many
> 	IPIs.  But they can just set rcu_normal to prevent that.

I wanted to make things simple and not complicated…

> I am therefore queuing it for testiong and review.  ;-)

Okay thanks.

> 							Thanx, Paul

Sebastian
