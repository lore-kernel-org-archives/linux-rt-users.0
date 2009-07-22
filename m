From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: i915_driver_irq_handler - BUG: NULL pointer dereference
Date: Wed, 22 Jul 2009 15:03:30 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0907221500160.2813@localhost.localdomain>
References: <20090722084424.GA3507@tycho.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <williams@redhat.com>,
	Dave Airlie <airlied@linux.ie>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755012AbZGVNEF@vger.kernel.org>
In-Reply-To: <20090722084424.GA3507@tycho.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



On Wed, 22 Jul 2009, John Kacur wrote:

> Hello Thomas et al
> 
> I'm still seeing this sometimes, in this case during shutdown with the experimental rt kernel
> based off of 2.6.31-rc3
> 
> The system is going down for reboot NOW!
> Disabling monthly Smolt update: [  OK  ]
> Shutting down Avahi daemon: [drm:gm45_get_vblank_counter] *ERROR* trying to get1
> BUG: unable to handle kernel NULL pointer dereference at 0000000000000084
> IP: [<ffffffffa05df8ef>] i915_driver_irq_handler+0x848/0x8e9 [i915]

So it crashes in the i915 interrupt handler. Smells like a
synchronization problem on shutdown which is exposed by the threaded
handler.

Dave, any idea ?

Thanks,

	tglx
