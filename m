From: John Ogness <john.ogness@linutronix.de>
Subject: Re: Realtime tasks and cgroups (cpu.shares)
Date: Mon, 10 Jul 2017 15:39:14 +0200
Message-ID: <87fue4h0n1.fsf@linutronix.de>
References: <cb8cd411e19f4039b7edf024b7762041@FE-MBX1012.de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: "Koehrer Mathias \(ETAS\/EHE1\)" <mathias.koehrer@etas.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:39348 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754005AbdGJNjR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 10 Jul 2017 09:39:17 -0400
In-Reply-To: <cb8cd411e19f4039b7edf024b7762041@FE-MBX1012.de.bosch.com>
        (Koehrer Mathias's message of "Mon, 10 Jul 2017 12:57:05 +0000")
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Mathias,

On 2017-07-10, Koehrer Mathias (ETAS/EHE1) <mathias.koehrer@etas.com> wrote:
> is it possible to combine real time tasks and cgroups (in particular
> cpu.shares)? The background of the question is the following:
> If a real time task hangs by accident in an endless loop, it blocks
> the complete access to the system.  One idea could be to reserve a
> small percentage of the CPU for non real time stuff to avoid these
> kind of situations.

For your particular situation, that is what the following proc-settings
are for:

   /proc/sys/kernel/sched_rt_period_us
   /proc/sys/kernel/sched_rt_runtime_us

However, be aware that these settings apply collectively to *all*
realtime processes within a period. You need to be certain that a
correctly running system is never in danger of hitting these
deadlines. Otherwise you have crippled your realtime system.

For cgroups, I assume you are referring to CONFIG_CFS_BANDWIDTH. I
expect this would work as well, but personally have no experience using
cgroups in this manner and am not certain that it has no adverse affects
on realtime scheduling.

John Ogness
