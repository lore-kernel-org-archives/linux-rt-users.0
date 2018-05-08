From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2] serial: sh-sci: Use spin_{try}lock_irqsave instead of
 open coding version
Date: Tue, 8 May 2018 09:40:14 +0200
Message-ID: <20180508074013.w3lzbwzrym76li2e@linutronix.de>
References: <20180504163041.28726-1-wagi@monom.org>
 <20180507125146.75crpaj2scav7mql@linutronix.de>
 <d37e074d-5e8c-84e8-5833-7ff595e6348c@monom.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-rt-users@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-sh@vger.kernel.org, gregkh@linuxfoundation.org,
        Daniel Wagner <daniel.wagner@siemens.com>
To: Daniel Wagner <wagi@monom.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d37e074d-5e8c-84e8-5833-7ff595e6348c@monom.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-05-08 09:18:44 [+0200], Daniel Wagner wrote:
> Hi Sebastian,
Hi,

> Should 'echo t > /proc/sysrq' trigger the splat? At least I was so naive
> that think it would be enough.

No, this is a different interface. The thing is you send the BREAK
command and then, the next character (within a timeout) that comes over
the UART is the MAGIC request. While that character is being received
the sysrq request is answered and output is written to the console which
is probably the UART and so you can't acquire the lock again.

So you can't acquire the lock. I added a try_lock once to at least try
to acquire the lock because this may race against a printk() from
another CPU. But then someone complained about a failed try_lock on UP
(this can't happen on UP unless in a scenario like this where the lock
is already acquired) so this change to the 8250 was reverted.

So the whole situation of the console interface is not perfect and this
is the duct tape we have. It would good to have the same duct tape in
all drivers or come up with a different interface to cover corner cases
:)

To reproduce the sysrq code path: You need to the UART as a console and
send a BREAK (CTRL-A F in minicom) followed by `t' to match your
example.

> Thanks,
> Daniel

Sebastian
