From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 4.1.42-rt50
Date: Fri, 18 Aug 2017 14:11:32 +0200
Message-ID: <20170818121132.4aniecrs54227xcj@linutronix.de>
References: <20170816204228.GE8384@jcartwri.amer.corp.natinst.com>
 <20170817073027.xzkn7sn4cxki3lcr@linutronix.de>
 <20170817185327.GH8384@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
To: Julia Cartwright <julia@ni.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170817185327.GH8384@jcartwri.amer.corp.natinst.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-08-17 13:53:27 [-0500], Julia Cartwright wrote:
> 
> Ah!  Thanks. Indeed.  I did see the upstream-queued version get cc'd to
> linux-rt-users, but didn't see the rcu_irq_{enter,exit}_irqson()
> addition, assuming it to be what landed in rt-devel.
> 
> Will you be fixing this up in 4.11-rt?

Just did so. The patch-queue has the complete patch, here [0] is the
delta patch.

  https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/?h=linux-4.11.y-rt&id=f648e23dac72deef07f25e05fc09dbbc209dbd33

>    Julia

Sebastian
