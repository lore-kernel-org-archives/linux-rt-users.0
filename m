From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: schedule under irqs_disabled in SLUB problem
Date: Mon, 4 Dec 2017 10:59:13 +0100
Message-ID: <20171204095912.GH2255@linutronix.de>
References: <CADF-jezvVP2O++FR2KiRSSSJF7oObjy8LSP3-yj1HCmxyTzB_Q@mail.gmail.com>
 <20171102165009.u7a7ahmmywo2qugd@linutronix.de>
 <CADF-jexLs9vRuiuoRmcA+0L6Mp-XxW75okheWV+ipGf1b_Ua1w@mail.gmail.com>
 <59FC4393.8030005@mcst.ru>
 <5A01812F.7040406@mcst.ru>
 <20171116160837.hfpnq4vb4j2osbuz@linutronix.de>
 <20171117173820.GM872@jcartwri.amer.corp.natinst.com>
 <CAJ9FNxsfHRuc+UZCPKGDJDtk5neApOb3i6thpGTy9c-oP8T4JA@mail.gmail.com>
 <20171124093724.GB2564@linutronix.de>
 <CAJ9FNxtpTqjLevwN1w037=g1eqRPf-Fht+SFqSqJS0jVhFXkLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: linux-rt-users@vger.kernel.org
To: Sam Kappen <skappen@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:57529 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752797AbdLDJ7O (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 4 Dec 2017 04:59:14 -0500
Content-Disposition: inline
In-Reply-To: <CAJ9FNxtpTqjLevwN1w037=g1eqRPf-Fht+SFqSqJS0jVhFXkLg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-11-27 12:16:36 [+0530], Sam Kappen wrote:
> Hi,
Hi,

> 1.)
> I had derived and tried a patch based on the below analysis.
> ( I referred below open source commit, to derive on this patch.
> https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/commit/?h=v4.9.47-rt37-rebase&id=7a347757f027190c95a363a491c18156a926a370
> )
> 
> In some cases pi_lock in rt_spin_lock_slowlock does not retain the
> irqs state while exiting function, this causes
> issue in migrate_disable() + enable as they are not symmetrical in
> regard to the status of interrupts.
> To fix pi_lock & pi_unlock in rt_spin_lock_slowlock, it has been
> modified to retain irq state by using
> raw_spin_lock and raw_spin_unlock and also modified wait_lock in
> rt_spin_lock_slowlock with raw_spin_lock_irqsave & *_restore.

Can you provide more informations on this? Like a stack strace that
shows that this happens and when it happens? It should not happen.

…
> We were testing above patch on multiple targets we could experience
> some stuck issue on some remote target after 2 days. I am not
> sure what really happens there, may be the issue when try for
> scheduling with irq in disabled state.
> The systems I have tested found to be worked 7 days after that I
> stopped the test.

Which patch? The patch I've sent and ask you for testing or the patch
you had in this email?

> 
> 2.) With your patch during the slab allocations irqs will be in enabled state.
> So if we enable irqs in early stage will there be any side effects? I
> am sorry if my question doesn't seem
> to be logical.

You must not enable the interrupts too early. At the time of scheduling
it is okay.

> Regards,
> Sam

Sebastian
