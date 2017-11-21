From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH PREEMPT RT] rt-mutex: fix deadlock in device mapper
Date: Tue, 21 Nov 2017 18:33:39 +0100
Message-ID: <1511285619.30074.13.camel@gmx.de>
References: <alpine.LRH.2.02.1711131245580.23280@file01.intranet.prod.int.rdu2.redhat.com>
           <20171117145744.t366d2ztxj2qqnco@linutronix.de>
           <1511030230.12841.42.camel@gmx.de>
           <alpine.LRH.2.02.1711201607230.24006@file01.intranet.prod.int.rdu2.redhat.com>
         <1511234430.7672.26.camel@gmx.de>
          <alpine.DEB.2.20.1711210931460.1782@nanos>
         <1511255884.7672.49.camel@gmx.de>
         <alpine.LRH.2.02.1711211107550.12859@file01.intranet.prod.int.rdu2.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 8BIT
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org
To: Mikulas Patocka <mpatocka@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:64849 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751145AbdKURdz (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 21 Nov 2017 12:33:55 -0500
In-Reply-To: <alpine.LRH.2.02.1711211107550.12859@file01.intranet.prod.int.rdu2.redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2017-11-21 at 11:11 -0500, Mikulas Patocka wrote:
> 
> So, drop the spinlock unplugging and leave only mutex unplugging, 
> reproduce the deadlock and send the stacktraces.

Nah, I reproduced it five years ago.  Is any of that relevant today?
 Damned if I know.  Your report was the first I've noticed since.

	-Mike
