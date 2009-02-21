From: Frederic Weisbecker <fweisbec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Announce] 2.6.29-rc4-rt2
Date: Sat, 21 Feb 2009 18:19:13 +0100
Message-ID: <20090221171912.GB6807@nowhere>
References: <alpine.LFD.2.00.0902112332370.415@localhost.localdomain> <alpine.LFD.2.00.0902122353050.16972@localhost.localdomain> <1235235862.3350.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>,
	Thomas Gleixner <tglx-kttTfShzVuc@public.gmane.org>,
	LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	rt-users <linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>,
	Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>,
	Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	Carsten Emde <ce-BGmsVP+Gamo@public.gmane.org>,
	Clark Williams <williams-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
	ath5k-devel-xDcbHBWguxEUs3QNXV6qNA@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Meyer <thomas-VsYtu1Qij5c@public.gmane.org>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1235235862.3350.4.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, Feb 21, 2009 at 06:04:22PM +0100, Thomas Meyer wrote:
> Am Donnerstag, den 12.02.2009, 23:56 +0100 schrieb Thomas Gleixner:
> > We are pleased to announce the first update to our new preempt-rt
> > series. It fixes the reported bugs and some more.
> > 
> > Download locations:
> > 
> >    http://rt.et.redhat.com/download/
> >    http://www.kernel.org/pub/linux/kernel/projects/rt/
> >  
> > Information on the RT patch can be found at:
> > 
> >   http://rt.wiki.kernel.org/index.php/Main_Page
> > 
> > to build the 2.6.29-rc4-rt2 tree, the following patches should be
> > applied:
> > 
> >   http://www.kernel.org/pub/linux/kernel/v2.6/testing/linux-2.6.29-rc4.tar.bz2
> >   http://www.kernel.org/pub/linux/kernel/projects/rt/patch-2.6.29-rc4-rt2.bz2
> > 
> > The broken out patches are also available at the same download
> > locations.
> > 
> > Enjoy !
> > 
> >       Thomas, Ingo
> > --
> 
> Hi,
> 
> I got this warning, that i never saw before with a non rt-preempt
> kernel. But maybe it's just coincidence...
> 
> [22652.437889] ------------[ cut here ]------------
> [22652.437898] WARNING: at net/mac80211/rx.c:2234 __ieee80211_rx+0x85/0x53e [mac80211]()
> [22652.437904] Hardware name: MacBookPro1,1
> [22652.437908] Modules linked in: ipt_REJECT nf_conntrack_ipv4 nf_defrag_ipv4 iptable_filter ip_tables nf_conntrack_ftp ip6t_REJECT xt_tcpudp nf_conntrack_ipv6 xt_state nf_conntrack ip6table_filter ip6_tables x_tables ath5k mac80211 cfg80211 video [last unloaded: scsi_wait_scan]
> [22652.437952] Pid: 23, comm: sirq-tasklet/1 Tainted: G        W  2.6.29-rc4-rt2-tip #57
> [22652.437958] Call Trace:
> [22652.437970]  [<c0451e50>] warn_slowpath+0x8a/0xd3
> [22652.437981]  [<c0665165>] ? plist_add+0x73/0x8e
> [22652.437990]  [<c0447d8e>] ? enqueue_pushable_task+0x62/0x79
> [22652.437999]  [<c04480f1>] ? enqueue_task_rt+0x203/0x247
> [22652.438029]  [<f90e78bf>] __ieee80211_rx+0x85/0x53e [mac80211]
> [22652.438039]  [<c09aafaa>] ? __spin_unlock_irq+0x1e/0x44
> [22652.438057]  [<f92e14af>] ath5k_tasklet_rx+0x406/0x457 [ath5k]
> [22652.438067]  [<c045787e>] __tasklet_action+0x8c/0x100
> [22652.438075]  [<c04579d8>] tasklet_action+0x67/0x7f
> [22652.438083]  [<c04575e3>] ksoftirqd+0x12d/0x223
> [22652.438091]  [<c04574b6>] ? ksoftirqd+0x0/0x223
> [22652.438099]  [<c0467022>] kthread+0x4a/0x82
> [22652.438106]  [<c0466fd8>] ? kthread+0x0/0x82
> [22652.438114]  [<c0420b67>] kernel_thread_helper+0x7/0x10
> [22652.438120] ---[ end trace a7919e7f17c0a727 ]---
> 


Hi,

It's an known issue on ath5k (or 80211):
http://patchwork.kernel.org/patch/1169/

So not preempt-rt related. Perhaps it has been fixed in -rc5.

 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
