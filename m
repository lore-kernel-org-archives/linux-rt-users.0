From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: 4.8.6-rt5 ftrace function_graph hangs
Date: Tue, 6 Dec 2016 12:07:15 +0100
Message-ID: <20161206110715.3mnfjzflaq3semrd@linutronix.de>
References: <d275a464-c787-6e21-0d3f-bbb3d854176e@windriver.com>
 <20161118113524.43f6ff3c@gandalf.local.home>
 <1785742b-8094-56af-01b9-6bac5c67865f@windriver.com>
 <67df43c6-ac39-dea0-025d-5fce434d2743@windriver.com>
 <20161128143317.oz6n6jzvu227jnz3@linutronix.de>
 <433512e3-cb70-a6dc-395b-4afb827734f9@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: He Zhe <zhe.he@windriver.com>,
        Steven Rostedt <rostedt@goodmis.org>, tglx@linutronix.de,
        linux-rt-users@vger.kernel.org
To: Yang Shi <yang.shi@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:38402 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752263AbcLFLHW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 6 Dec 2016 06:07:22 -0500
Content-Disposition: inline
In-Reply-To: <433512e3-cb70-a6dc-395b-4afb827734f9@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2016-12-02 13:42:06 [-0800], Yang Shi wrote:
> Hi Sebastian,
Hi Yang,

> Thanks for following up. I had been distracted by something else. And, I did
> more testing, then I narrowed it down to ARM and PPC only.
okay.

> In addition, I narrowed it down to CONFIG_DEBUG_PREEMPT. function_graph
> tracer works well with it disabled on ARM and PPC. But, I haven't got time
> to figure out why.

It could be a warning that comes with CONFIG_DEBUG_PREEMPT triggers once
function_graph gets enabled. This warning in turn could cause another
warning or go for another reason recursive.

> Yang
> 
Sebastian
