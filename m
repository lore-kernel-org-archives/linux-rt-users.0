From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 0/8] Linux 3.2.53-rt76-rc1
Date: Thu, 16 Jan 2014 10:09:21 -0500
Message-ID: <20140116100921.6ecbf214@gandalf.local.home>
References: <20140116015824.201732155@goodmis.org>
	<52D7A93C.9090801@pavlinux.ru>
	<20140116091847.0786c8af@gandalf.local.home>
	<52D7EE70.8000509@pavlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: pavel@pavlinux.ru
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52D7EE70.8000509@pavlinux.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 16 Jan 2014 18:36:32 +0400
Pavel Vasilyev <pavel@pavlinux.ru> wrote:

> 16.01.2014 18:18, Steven Rostedt =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Thu, 16 Jan 2014 13:41:16 +0400
> > Pavel Vasilyev <pavel@pavlinux.ru> wrote:
> >=20
> >> 16.01.2014 05:58, Steven Rostedt =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>> Dear RT Folks,
> >>>
> >>> This is the RT stable review cycle of patch 3.2.53-rt76-rc1.
> >>
> >> Yap..., mainline is 3.2.54 !
> >>
> >=20
> > Yeah, but I already had the -rt specific changes merged into 3.2.53
> > before 3.2.54 was released, and then I discovered the cpu hotplug b=
ug.
> > I did not want to release that -rc until it was solved. Now that it=
 is,
> > I can release this one and then move to 3.2.54.
>=20
>=20
> $ xz -cd /tmp/patch-3.2.53-rt75-rt76-rc1.patch.xz | patch -p1 --dry-r=
un
>=20
> checking file arch/arm/kernel/smp_tlb.c
> checking file arch/tile/include/asm/smp.h
> checking file arch/tile/kernel/smp.c
> checking file drivers/net/wireless/orinoco/orinoco_usb.c
> checking file drivers/usb/gadget/f_fs.c
> checking file drivers/usb/gadget/inode.c
> checking file fs/buffer.c
> checking file include/linux/smp.h
> Hunk #1 succeeded at 117 with fuzz 1 (offset 16 lines).
> Hunk #2 FAILED at 147.
> 1 out of 2 hunks FAILED
> checking file include/linux/spinlock_rt.h
> checking file kernel/cpu.c
> checking file kernel/rtmutex.c
> checking file kernel/smp.c
> Hunk #1 FAILED at 712.
> 1 out of 1 hunk FAILED
> checking file kernel/softirq.c
> checking file kernel/timer.c
> checking file localversion-rt
>=20
>=20
> include/linux/smp.h REJECT: #define on_each_cpu_mask() and #define
> on_each_cpu_cond() and same in kernel/smp.c
>=20
>=20

Ouch, thanks for letting me know. I'll give it a try to make sure that
the patch is the same code that I tested.

-- Steve
