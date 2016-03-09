From: Jean-Denis Girard <jd.girard@sysnux.pf>
Subject: Re: [ANNOUNCE] v4.4.4-rt11
Date: Wed, 9 Mar 2016 10:31:06 -1000
Message-ID: <nbq16a$7li$1@ger.gmane.org>
References: <20160309135142.GF10517@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160309135142.GF10517@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

Le 09/03/2016 03:51, Sebastian Andrzej Siewior a =C3=A9crit :
> - AT91 got a little better. A larger patch series by Boris Brezillon =
has
>   been merged. That means SAMA5 boots now. There is one warning left
>   about invoking free_irq() twice. I would be glad about some feedbac=
k
>   from pre-SAMA5 SoC. Those which share UART and timer interrupt. It
>   seems that that one I have here does not do this anymore.
>=20
> - A patch on top the AT91 series to avoid two warning while switching
>   from period to oneshow mode.

I got this warning when booting my arietta G25:

clocksource: pit: mask: 0xfffffff max_cycles: 0xfffffff, max_idle_ns:
14334453866 ns
------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at kernel/irq/manage.c:1541 __free_irq+0xb0/0x2b=
0()
Trying to free already-free IRQ 16
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 4.4.4-rt11 #1
Hardware name: Atmel AT91SAM9
[<c000ecb8>] (unwind_backtrace) from [<c000cefc>] (show_stack+0x10/0x14=
)
[<c000cefc>] (show_stack) from [<c00165ac>] (warn_slowpath_common+0x80/=
0xa8)
[<c00165ac>] (warn_slowpath_common) from [<c0016600>]
(warn_slowpath_fmt+0x2c/0x3c)
[<c0016600>] (warn_slowpath_fmt) from [<c00409d4>] (__free_irq+0xb0/0x2=
b0)
[<c00409d4>] (__free_irq) from [<c0040c60>] (free_irq+0x40/0x50)
[<c0040c60>] (free_irq) from [<c03056fc>] (pit_clkevt_shutdown+0x24/0x2=
c)
[<c03056fc>] (pit_clkevt_shutdown) from [<c0058e94>]
(clockevents_switch_state+0xe8)
[<c0058e94>] (clockevents_switch_state) from [<c0058ee4>]
(clockevents_shutdown+0x1)
[<c0058ee4>] (clockevents_shutdown) from [<c00597dc>]
(tick_check_new_device+0x54/0)
[<c00597dc>] (tick_check_new_device) from [<c0058950>]
(clockevents_register_device)
[<c0058950>] (clockevents_register_device) from [<c051e22c>]
(clocksource_probe+0x4)
[<c051e22c>] (clocksource_probe) from [<c050aafc>]
(start_kernel+0x248/0x35c)
[<c050aafc>] (start_kernel) from [<20008048>] (0x20008048)
---[ end trace 0000000000000001 ]---

Nevertheless it does boot, and seems to work fine.


Thanks,
--=20
Jean-Denis Girard

SysNux                Syst=C3=A8mes   Linux   en   Polyn=C3=A9sie   fra=
n=C3=A7aise
http://www.sysnux.pf/ T=C3=A9l: +689 40.50.10.40 / GSM: +689 87.79.75.2=
7
