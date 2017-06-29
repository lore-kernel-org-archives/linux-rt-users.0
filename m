From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] v4.11.7-rt3
Date: Thu, 29 Jun 2017 09:50:00 +0200
Message-ID: <20170629075000.haum2aiv25pj2xpg@linutronix.de>
References: <20170627135750.dezrobqd4twryeeb@linutronix.de>
 <79973421-cb21-aa5c-29f7-d05dd57283cc@manjaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Bernhard Landauer <oberon@manjaro.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:55239 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751855AbdF2HuF (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 29 Jun 2017 03:50:05 -0400
Content-Disposition: inline
In-Reply-To: <79973421-cb21-aa5c-29f7-d05dd57283cc@manjaro.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-06-29 02:30:12 [+0200], Bernhard Landauer wrote:
> I'm unable to compile the ndiswrapper extramodule against 4.11.7-rt3

I am surprised that this is still needed.

> I get lots of errors of the kind
> 
> 'struct task_struct' has no member named 'cpus_allowed'; did you mean
> 'nr_cpus_allowed'?
> 
> What can I do?

You should only need a read copy and ->cpus_ptr is for that.

> kind regards
> Bernhard

Sebastian
