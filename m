From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH PREEMPT RT] rt-mutex: fix deadlock in device mapper
Date: Mon, 20 Nov 2017 14:49:22 +0100
Message-ID: <1511185762.11475.43.camel@gmx.de>
References: <alpine.LRH.2.02.1711131245580.23280@file01.intranet.prod.int.rdu2.redhat.com>
         <20171117145744.t366d2ztxj2qqnco@linutronix.de>
         <1511030230.12841.42.camel@gmx.de>
         <20171120105310.zsd6kotreig6nvik@linutronix.de>
         <1511181834.11475.41.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Mikulas Patocka <mpatocka@redhat.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
To: Sebastian Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:59491 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751086AbdKTNuD (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 20 Nov 2017 08:50:03 -0500
In-Reply-To: <1511181834.11475.41.camel@gmx.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2017-11-20 at 13:43 +0100, Mike Galbraith wrote:

> The problem was converted spinlocks (and added RT locks).

But I suppose lockdep should gripe about that these days...
