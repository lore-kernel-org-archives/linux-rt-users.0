From: John Ogness <john.ogness@linutronix.de>
Subject: Re: timer_create affinity
Date: Fri, 26 May 2017 09:13:35 +0200
Message-ID: <87r2zcay5c.fsf@linutronix.de>
References: <CAKP5S=3NMzfEDdLsd6_FCNTH6o7_Qz2D6qFwx1WOdc-x2Xi0rA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
To: Nicolae Rosia <nicolae.rosia.oss@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:39798 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1947105AbdEZHNj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 26 May 2017 03:13:39 -0400
In-Reply-To: <CAKP5S=3NMzfEDdLsd6_FCNTH6o7_Qz2D6qFwx1WOdc-x2Xi0rA@mail.gmail.com>
        (Nicolae Rosia's message of "Thu, 25 May 2017 17:57:03 +0300")
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-05-25, Nicolae Rosia <nicolae.rosia.oss@gmail.com> wrote:
> I'm working on a real-time application using POSIX timers running on a
> QorIQ PowerPC platform with a 4.1 PREEMPT RT kernel and I'm trying to
> understand whether the following can happen:
>
> 1. A thread with a core affinity #0 creates a timer which will invoke
> a callback.
> 2. The kernel will setup the timer using a local timer running on a
> different core, core #1
> 3. The ISR will fire, and could be dispatched by core #2
> 4. The scheduler will run the callback on core #3.
>
> Is there a way to make sure this whole chain will be executed on a
> single core, the core of the caller?

Avoid POSIX timers if you can. POSIX timers not only have the issue that
you mentioned, but also are generally bad for realtime applications.

The realtime wiki has an example[0] of running a cyclic task. With that
simple example you have complete control over the context of your
task. This is necessary to avoid things like priority inversion and
page-faults, and gives you control over things like affinity or cgroups.

John Ogness

[0] https://wiki.linuxfoundation.org/realtime/documentation/howto/applications/cyclic
