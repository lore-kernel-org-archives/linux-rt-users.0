Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:53846 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753052AbeGFJQe (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 6 Jul 2018 05:16:34 -0400
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: tty latency and RT
References: <681500CE65202E47A192754B01DAB4673BE3D87A37@SDE12.beckipc.net>
Date: Fri, 06 Jul 2018 11:16:31 +0200
In-Reply-To: <681500CE65202E47A192754B01DAB4673BE3D87A37@SDE12.beckipc.net>
        (=?utf-8?Q?=22Andr=C3=A9?= Pribil"'s message of "Fri, 6 Jul 2018 10:51:08
 +0200")
Message-ID: <87muv4zpu8.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: =?utf-8?Q?Andr=C3=A9?= Pribil <a.pribil@beck-ipc.com>
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>

Hi,

On 2018-07-06, André Pribil <a.pribil@beck-ipc.com> wrote:
> are there any plans to improve the latency with serial ttys and RT?
>
> I'm seeing very high latencies (up to 100 ms) when a high priority 
> RT thread accesses a serial tty port. I'm working with 4.14.52-rt34 
> on a ARM system.

As you later point out, this is a problem with the tty subsystem
(kworker) and is not RT-specific. This problem needs to be fixed in
mainline.

> The reason for this issue seems to be that a kworker thread with a 
> normal priority is involved here. When the high priority RT 
> thread needs to wait for this kworker thread, it can easily be blocked 
> by other lower priority RT threads running in the system.
>
> I have seen that Steven Walter proposed some change in 2015, where
> this kworker thread in replaced by a kthread with a RT priority if
> the low_latency mode is selected.
> See: https://www.spinics.net/lists/linux-serial/msg17782.html
>
> The follow-up discussion in this thread also proposes a solution that
> allows low_latency ports to directly execute the worker.
> As interrupts are already threaded in PREEMPT_RT, wouldn't that be a 
> solution?

The patches and discussions in that thread provide some good ground work
for a real solution. Someone needs to take more time to work with the
maintainers to get it mainline.

John Ogness
