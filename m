From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Linux stable vs RT stable and RT dev
Date: Fri, 9 Feb 2018 18:39:21 +0100
Message-ID: <20180209173921.mtz55hgs5idj4vhk@linutronix.de>
References: <8155aea247374c058bd7c797124c3d28@ti.com>
 <20180202214611.GD868@jcartwri.amer.corp.natinst.com>
 <1c47b7e6-86d0-cbb0-9b72-7b7d63e46ddc@ti.com>
 <6eecb69a-e60f-f837-bc2c-a627e2660027@ti.com>
 <20180206143426.fdzs6hnvmakqdwiu@linutronix.de>
 <8e201971-d626-7ef6-addd-bbbc32f63770@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: William Mills <wmills@ti.com>, Julia Cartwright <julia@ni.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "Nori, Sekhar" <nsekhar@ti.com>, rostedt@goodmis.org,
        "Hernandez, Carlos" <ceh@ti.com>,
        "Strashko, Grygorii" <grygorii.strashko@ti.com>
To: Dan Murphy <dmurphy@ti.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:34872 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751091AbeBIRj1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 9 Feb 2018 12:39:27 -0500
Content-Disposition: inline
In-Reply-To: <8e201971-d626-7ef6-addd-bbbc32f63770@ti.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2018-02-06 09:47:15 [-0600], Dan Murphy wrote:
> Sebastian
Hi Dan,

> Agreed sorry for that.  I sent the issues before I got the mail list information.

You complained about two warnings. For number one I cherry-picked
15f7b41f70dd ("brd: remove unused brd_mutex"). 

The other thing was a warning in
pl011_console_write::drivers/tty/serial/amba-pl011.c the flags member. I
have here:

    CC      drivers/tty/serial/amba-pl011.o

with gcc version 7.3.0 (Debian 7.3.0-1). Looking at the code, flags is
not be initialized in the uap->port.sysrq case but it is also not used.
So it is a compiler thing and not a bug. There is the same pattern in
the 8250 UART or the omap-serial driver. If you care enough to get this
one fixed, please send a patch.

Sebastian
