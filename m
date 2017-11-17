From: Sebastian Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH PREEMPT RT] rt-mutex: fix deadlock in device mapper
Date: Fri, 17 Nov 2017 15:57:44 +0100
Message-ID: <20171117145744.t366d2ztxj2qqnco@linutronix.de>
References: <alpine.LRH.2.02.1711131245580.23280@file01.intranet.prod.int.rdu2.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org
To: Mikulas Patocka <mpatocka@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:51003 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751139AbdKQO5s (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 17 Nov 2017 09:57:48 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.1711131245580.23280@file01.intranet.prod.int.rdu2.redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-11-13 12:56:53 [-0500], Mikulas Patocka wrote:
> Hi
Hi,

> I'm submitting this patch for the CONFIG_PREEMPT_RT patch. It fixes 
> deadlocks in device mapper when real time preemption is used.

applied, thank you.

> Mikulas

Sebastian
