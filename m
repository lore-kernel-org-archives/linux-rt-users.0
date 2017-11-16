From: "Pavel V. Panteleev" <panteleev_p@mcst.ru>
Subject: Re: schedule under irqs_disabled in SLUB problem
Date: Thu, 16 Nov 2017 19:39:02 +0300
Message-ID: <5A0DBF26.8090800@mcst.ru>
References: <CADF-jezvVP2O++FR2KiRSSSJF7oObjy8LSP3-yj1HCmxyTzB_Q@mail.gmail.com>
 <20171102165009.u7a7ahmmywo2qugd@linutronix.de>
 <CADF-jexLs9vRuiuoRmcA+0L6Mp-XxW75okheWV+ipGf1b_Ua1w@mail.gmail.com>
 <59FC4393.8030005@mcst.ru> <5A01812F.7040406@mcst.ru>
 <20171116160837.hfpnq4vb4j2osbuz@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, Julia Cartwright <julia@ni.com>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from tretyak2.mcst.ru ([80.84.125.22]:58214 "EHLO tretyak2.mcst.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751029AbdKPQjW (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 16 Nov 2017 11:39:22 -0500
In-Reply-To: <20171116160837.hfpnq4vb4j2osbuz@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 16.11.2017 19:08, Sebastian Andrzej Siewior wrote:
> + Steven & Julia
>
> On 2017-11-07 12:47:27 [+0300], Pavel V. Panteleev wrote:
>> Thanks, it works.
> Okay, good to hear.
>
> Steven + Julia:
> We need to decide what are going to do about this stable-wise. The bug
> was reported against 3.14.79-rt85 and the devel tree is not affected*.
> The thread starts at
>    https://www.spinics.net/lists/linux-rt-users/msg17560.html
>
> [*] probably since v4.11.5-rt1 once
>      "sched/core: Enable might_sleep() and smp_processor_id() checks
>      early" and its prerequisites appeared in the queue.
>
> Sebastian
>
>
kernel 4.9 has the same problem.
