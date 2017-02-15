From: Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>
Subject: Re: syscall from userspace thread
Date: Wed, 15 Feb 2017 18:09:28 +0100
Message-ID: <20170215170928.fparkvwa6xbctyfr@linutronix.de>
References: <CAJ2oMh+=AfyLd3XEP-dBVn9f20BLNU=y9382xDLxd0UyRv5uRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Ran Shalit <ranshalit@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:48046 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbdBORJa (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 15 Feb 2017 12:09:30 -0500
Content-Disposition: inline
In-Reply-To: <CAJ2oMh+=AfyLd3XEP-dBVn9f20BLNU=y9382xDLxd0UyRv5uRA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-02-05 00:06:13 [+0200], Ran Shalit wrote:
> Hello,
Hi,

> I made reading on RT PREEMPT, but didn't find some rules/methods, to
> make sure that a real time thread keeps its deadline.
> For example:
>  Can I use in the userspace thread any syscall , or will it results in
> thread preemption ?

You can use any syscall. The less you use the less of the system will
interfere. Since the RT task runs at elevated priority it will be
preferred over other tasks and it will boost everything in order to get
the locks it needs to perform its job.
If you invoke syscalls which can be slow, like write(), it might block
your RT task until the job (writing to disk) is done and the interrupt
is delivered. This gets worse if you also have an application which does
intensive disk-IO. The IO requests from the RT applications don't have a
VIP sticker and will be handled like everything else.

This is one of reason why the cyclictest application has one non-RT
thread which displays the statistics while another does the `RT' work.

> Regards,
> Ran

Sebastian
