From: Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>
Subject: Re: schedule under irqs_disabled in SLUB problem
Date: Thu, 16 Nov 2017 17:08:37 +0100
Message-ID: <20171116160837.hfpnq4vb4j2osbuz@linutronix.de>
References: <CADF-jezvVP2O++FR2KiRSSSJF7oObjy8LSP3-yj1HCmxyTzB_Q@mail.gmail.com>
 <20171102165009.u7a7ahmmywo2qugd@linutronix.de>
 <CADF-jexLs9vRuiuoRmcA+0L6Mp-XxW75okheWV+ipGf1b_Ua1w@mail.gmail.com>
 <59FC4393.8030005@mcst.ru>
 <5A01812F.7040406@mcst.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org, Julia Cartwright <julia@ni.com>,
        Steven Rostedt <rostedt@goodmis.org>
To: "Pavel V. Panteleev" <panteleev_p@mcst.ru>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:46509 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754765AbdKPQIk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 16 Nov 2017 11:08:40 -0500
Content-Disposition: inline
In-Reply-To: <5A01812F.7040406@mcst.ru>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

+ Steven & Julia

On 2017-11-07 12:47:27 [+0300], Pavel V. Panteleev wrote:
> Thanks, it works.

Okay, good to hear.

Steven + Julia:
We need to decide what are going to do about this stable-wise. The bug
was reported against 3.14.79-rt85 and the devel tree is not affected*.
The thread starts at 
  https://www.spinics.net/lists/linux-rt-users/msg17560.html

[*] probably since v4.11.5-rt1 once
    "sched/core: Enable might_sleep() and smp_processor_id() checks
    early" and its prerequisites appeared in the queue.

Sebastian
