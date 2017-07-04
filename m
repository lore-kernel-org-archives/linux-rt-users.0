From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] v4.11.7-rt3
Date: Tue, 4 Jul 2017 18:17:35 +0200
Message-ID: <20170704161735.25czmbpjzk4vw27t@linutronix.de>
References: <20170627135750.dezrobqd4twryeeb@linutronix.de>
 <79973421-cb21-aa5c-29f7-d05dd57283cc@manjaro.org>
 <20170629075000.haum2aiv25pj2xpg@linutronix.de>
 <7a940c90-206d-05cd-a73d-c5456a60bbfe@manjaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Bernhard Landauer <oberon@manjaro.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:49316 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751645AbdGDQRh (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 4 Jul 2017 12:17:37 -0400
Content-Disposition: inline
In-Reply-To: <7a940c90-206d-05cd-a73d-c5456a60bbfe@manjaro.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-06-29 11:56:59 [+0200], Bernhard Landauer wrote:
> > You should only need a read copy and ->cpus_ptr is for that.
> ntoskernel.h has this:
> 
>   #define tsk_cpus_allowed(tsk) (&(tsk)->cpus_allowed)
> 
> so should it become:
> 
>   #define tsk_cpus_allowed(tsk) ((tsk)->cpus_ptr)
> 
> ?

That is the obvious thing to do (and I hope it uses it read-only).

Sebastian
