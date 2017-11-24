From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: schedule under irqs_disabled in SLUB problem
Date: Fri, 24 Nov 2017 10:37:24 +0100
Message-ID: <20171124093724.GB2564@linutronix.de>
References: <CADF-jezvVP2O++FR2KiRSSSJF7oObjy8LSP3-yj1HCmxyTzB_Q@mail.gmail.com>
 <20171102165009.u7a7ahmmywo2qugd@linutronix.de>
 <CADF-jexLs9vRuiuoRmcA+0L6Mp-XxW75okheWV+ipGf1b_Ua1w@mail.gmail.com>
 <59FC4393.8030005@mcst.ru>
 <5A01812F.7040406@mcst.ru>
 <20171116160837.hfpnq4vb4j2osbuz@linutronix.de>
 <20171117173820.GM872@jcartwri.amer.corp.natinst.com>
 <CAJ9FNxsfHRuc+UZCPKGDJDtk5neApOb3i6thpGTy9c-oP8T4JA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Sam Kappen <skappen@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:46431 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752387AbdKXJh0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 24 Nov 2017 04:37:26 -0500
Content-Disposition: inline
In-Reply-To: <CAJ9FNxsfHRuc+UZCPKGDJDtk5neApOb3i6thpGTy9c-oP8T4JA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-11-24 12:09:16 [+0530], Sam Kappen wrote:
> Hi,
Hi,

> I am also faces a similar kind of issue on X86 target, while testing
> 3.10.105-rt119.
> The issue is seen during boot-up when USB/SCSI enumeration starts.
> 
> Below is the log from my console

Can you try if the patch I posted solves that? From the callchain it
looks like the same thing.

Sebastian
