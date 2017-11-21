From: Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PATCH PREEMPT RT] rt-mutex: fix deadlock in device mapper
Date: Tue, 21 Nov 2017 14:56:43 -0500 (EST)
Message-ID: <alpine.LRH.2.02.1711211450410.10766@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1711131245580.23280@file01.intranet.prod.int.rdu2.redhat.com>    <20171117145744.t366d2ztxj2qqnco@linutronix.de>    <1511030230.12841.42.camel@gmx.de>    <alpine.LRH.2.02.1711201607230.24006@file01.intranet.prod.int.rdu2.redhat.com>
  <1511234430.7672.26.camel@gmx.de>   <alpine.DEB.2.20.1711210931460.1782@nanos>  <1511255884.7672.49.camel@gmx.de>  <alpine.LRH.2.02.1711211107550.12859@file01.intranet.prod.int.rdu2.redhat.com> <1511285619.30074.13.camel@gmx.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="185206533-1773938741-1511294028=:10766"
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1511285619.30074.13.camel@gmx.de>
Content-ID: <alpine.LRH.2.02.1711211454120.10766@file01.intranet.prod.int.rdu2.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--185206533-1773938741-1511294028=:10766
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LRH.2.02.1711211454121.10766@file01.intranet.prod.int.rdu2.redhat.com>



On Tue, 21 Nov 2017, Mike Galbraith wrote:

> On Tue, 2017-11-21 at 11:11 -0500, Mikulas Patocka wrote:
> > 
> > So, drop the spinlock unplugging and leave only mutex unplugging, 
> > reproduce the deadlock and send the stacktraces.
> 
> Nah, I reproduced it five years ago.  Is any of that relevant today?
>  Damned if I know.  Your report was the first I've noticed since.
> 
> 	-Mike

If we don't have any reason why it is needed to unplug block requests when 
a spinlock is taken - so let's not do this.

If you add code to the spinlock path and you don't know why, it is cargo 
cult programming.

Mikulas
--185206533-1773938741-1511294028=:10766--
