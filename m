From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: interrupt priority
Date: Wed, 29 Nov 2017 17:35:21 +0100
Message-ID: <20171129163521.GB7707@linutronix.de>
References: <CAJ2oMhJ-jnjTV3JbBSyV8iewsJD3mqfMjCpM71z22WvJYRnUVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Ran Shalit <ranshalit@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:40449 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753210AbdK2QfW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 29 Nov 2017 11:35:22 -0500
Content-Disposition: inline
In-Reply-To: <CAJ2oMhJ-jnjTV3JbBSyV8iewsJD3mqfMjCpM71z22WvJYRnUVA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-11-28 21:51:32 [+0200], Ran Shalit wrote:
> Hello,
Hi,

> I've tried to understand the priority between different interrupts,
> but did not find any information on this matter. Are there priorities
> for interrupts ? Is timer priority highest ?

`ps' has an option to show the priority of the interrupt thread and 50
is the default value. The timer interrupts does not run as a thread.

> Regards,
> Ran

Sebastian
