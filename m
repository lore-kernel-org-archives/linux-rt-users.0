From: Yong Zhang <yong.zhang0@gmail.com>
Subject: Re: pca953x - warning on irq
Date: Tue, 27 Dec 2011 14:02:23 +0800
Message-ID: <CAM2zO=DdGSJm0J2RNaWQ4ROx2-sK8_qT9QBbT5po9uW=SHR8ng@mail.gmail.com>
References: <201112251740.11066.m.gruber@unverspurt.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Manfred Gruber <m.gruber@unverspurt.at>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:39949 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784Ab1L0GCY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 27 Dec 2011 01:02:24 -0500
Received: by werm1 with SMTP id m1so5186619wer.19
        for <linux-rt-users@vger.kernel.org>; Mon, 26 Dec 2011 22:02:23 -0800 (PST)
In-Reply-To: <201112251740.11066.m.gruber@unverspurt.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Dec 26, 2011 at 12:40 AM, Manfred Gruber <m.gruber@unverspurt.a=
t> wrote:
> Hello RT developers!
>
> Great work on Preempt RT!
>
> I get a warning at 3.0.9-rt25+ in a i2c pca953x chip when using IRQs =
at the
> gpio lines. It appears only once when the first irq happens, after th=
at the
> warning is away. On 3.2.0-rc7 the warning does not happen.
>
> I do not know how to remove/solve the warning, has someone an idea wh=
at I do
> wrong?

Could you please try upstream commit [6dd599f8: gpio/pca953x: Fix warni=
ng
of enabled interrupts in handler] ?

BTW, I think that commit should go to -stable.

Thanks,
Yong


>
>
>
> [ =C2=A0 28.616000] sd 1:0:0:0: [sdb] Attached SCSI removable disk
> [ =C2=A0 45.240000] ------------[ cut here ]------------
> [ =C2=A0 45.240000] WARNING: at kernel/irq/handle.c:130
> handle_irq_event_percpu+0x68/0x168()
> [ =C2=A0 45.240000] irq 130 handler irq_default_primary_handler+0x0/0=
x8 enabled
> interrupts
> [ =C2=A0 45.242000] Modules linked in:
> [ =C2=A0 45.242000] [<c0039cd8>] (unwind_backtrace+0x0/0xec) from [<c=
00473d4>]
> (warn_slowpath_common+0x4c/)
> [ =C2=A0 45.242000] [<c00473d4>] (warn_slowpath_common+0x4c/0x64) fro=
m [<c0047480>]
> (warn_slowpath_fmt+0x3)
> [ =C2=A0 45.242000] [<c0047480>] (warn_slowpath_fmt+0x30/0x40) from [=
<c0078264>]
> (handle_irq_event_percpu+)
> [ =C2=A0 45.242000] [<c0078264>] (handle_irq_event_percpu+0x68/0x168)=
 from
> [<c00783b8>] (handle_irq_event+)
> [ =C2=A0 45.242000] [<c00783b8>] (handle_irq_event+0x54/0x78) from [<=
c007a828>]
> (handle_simple_irq+0x84/0x)
> [ =C2=A0 45.242000] [<c007a828>] (handle_simple_irq+0x84/0xac) from [=
<c0077eb0>]
> (generic_handle_irq+0x30/)
> [ =C2=A0 45.242000] [<c0077eb0>] (generic_handle_irq+0x30/0x48) from =
[<c0168508>]
> (pca953x_irq_handler+0x9)
> [ =C2=A0 45.242000] [<c0168508>] (pca953x_irq_handler+0x98/0xac) from=
 [<c0078930>]
> (irq_thread_fn+0x1c/0x3)
> [ =C2=A0 45.242000] [<c0078930>] (irq_thread_fn+0x1c/0x38) from [<c00=
787ec>]
> (irq_thread+0xc8/0x1f0)
> [ =C2=A0 45.242000] [<c00787ec>] (irq_thread+0xc8/0x1f0) from [<c0060=
82c>]
> (kthread+0x7c/0x84)
> [ =C2=A0 45.242000] [<c006082c>] (kthread+0x7c/0x84) from [<c00358dc>=
]
> (kernel_thread_exit+0x0/0x8)
> [ =C2=A0 45.242000] ---[ end trace 0000000000000002 ]---
>
> # cat /proc/interrupts
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CPU0
> =C2=A01: =C2=A0 =C2=A0 =C2=A0 8340 =C2=A0 =C2=A0 =C2=A0 AIC =C2=A0tty=
S0
> =C2=A07: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02 =C2=A0 =C2=A0 =C2=A0 AIC=
 =C2=A0ttyS2
> =C2=A09: =C2=A0 =C2=A0 =C2=A0 =C2=A0327 =C2=A0 =C2=A0 =C2=A0 AIC =C2=A0=
mmc0
> =C2=A012: =C2=A0 =C2=A0 =C2=A022381 =C2=A0 =C2=A0 =C2=A0 AIC =C2=A0at=
mel_spi.0
> =C2=A013: =C2=A0 =C2=A0 =C2=A074311 =C2=A0 =C2=A0 =C2=A0 AIC =C2=A0at=
mel_spi.1
> =C2=A019: =C2=A0 =C2=A0 245940 =C2=A0 =C2=A0 =C2=A0 AIC =C2=A0tc_clke=
vt
> =C2=A020: =C2=A0 =C2=A0 =C2=A0 =C2=A0541 =C2=A0 =C2=A0 =C2=A0 AIC =C2=
=A0ohci_hcd:usb1
> =C2=A021: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02 =C2=A0 =C2=A0 =C2=A0 AI=
C =C2=A0eth0
> 103: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A05 =C2=A0 =C2=A0 =C2=A0GPIO =C2=
=A00-0070
> 128: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 pca953x =C2=A0gpiolib
> 129: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 pca953x =C2=A0gpiolib
> 130: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02 =C2=A0 pca953x =C2=A0gpiolib
> 131: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 pca953x =C2=A0gpiolib
> 132: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 pca953x =C2=A0gpiolib
>
> thx, regards manfred gruber
>
> --
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml



--=20
Only stand for myself
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
