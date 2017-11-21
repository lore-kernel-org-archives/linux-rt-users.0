From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH PREEMPT RT] rt-mutex: fix deadlock in device mapper
Date: Tue, 21 Nov 2017 22:20:51 +0100
Message-ID: <1511299251.30074.72.camel@gmx.de>
References: <alpine.LRH.2.02.1711131245580.23280@file01.intranet.prod.int.rdu2.redhat.com>
            <20171117145744.t366d2ztxj2qqnco@linutronix.de>
            <1511030230.12841.42.camel@gmx.de>
            <alpine.LRH.2.02.1711201607230.24006@file01.intranet.prod.int.rdu2.redhat.com>
         <1511234430.7672.26.camel@gmx.de>
           <alpine.DEB.2.20.1711210931460.1782@nanos>
          <1511255884.7672.49.camel@gmx.de>
          <alpine.LRH.2.02.1711211107550.12859@file01.intranet.prod.int.rdu2.redhat.com>
         <1511285619.30074.13.camel@gmx.de>
         <alpine.LRH.2.02.1711211450410.10766@file01.intranet.prod.int.rdu2.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 8BIT
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org
To: Mikulas Patocka <mpatocka@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LRH.2.02.1711211450410.10766@file01.intranet.prod.int.rdu2.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2017-11-21 at 14:56 -0500, Mikulas Patocka wrote:
> 
> If we don't have any reason why it is needed to unplug block requests when 
> a spinlock is taken - so let's not do this.

That's perfectly fine.  I guess I shouldn't have even mentioned having
encountered unplug at mutex being insufficient.

	-Mike
