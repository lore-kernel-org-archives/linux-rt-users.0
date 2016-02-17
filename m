From: Jakub Kicinski <moorray3@wp.pl>
Subject: Re: [PATCH] sc16is7xx: switch to threaded irq for fixing RT issues
Date: Wed, 17 Feb 2016 21:54:27 +0000
Message-ID: <20160217215427.0263dbbc@laptop>
References: <1455523133-29895-1-git-send-email-sean.nyekjaer@prevas.dk>
 <20160215220810.11529101@laptop>
 <56C2D1A7.1030908@prevas.dk>
 <20160216210250.34c2f07f@laptop>
 <56C41FA5.4010605@prevas.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <linux-serial@vger.kernel.org>, <kubakici@wp.pl>,
	linux-rt-users@vger.kernel.org
To: Sean =?UTF-8?B?Tnlla2rDpnI=?= <sean.nyekjaer@prevas.dk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx4.wp.pl ([212.77.101.11]:55395 "EHLO mx4.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965392AbcBQWBM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Feb 2016 17:01:12 -0500
In-Reply-To: <56C41FA5.4010605@prevas.dk>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

[CC: linux-rt-users, can you guys help?]

On Wed, 17 Feb 2016 08:22:13 +0100, Sean Nyekj=C3=A6r wrote:
> On 2016-02-16 22:02, Jakub Kici=C5=84ski wrote:
> > On Tue, 16 Feb 2016 08:37:11 +0100, Sean Nyekj=C3=A6r wrote:
> >> On 2016-02-15 23:08, Jakub Kicinski wrote:
> >>> On Mon, 15 Feb 2016 08:58:53 +0100, Sean Nyekjaer wrote:
> >>>> Working with RT patches reveals this driver have some spin_lock =
issues.
> >>>>
> >>>> spin_lock moved from sc16is7xx_reg_proc to protect to call to
> >>>> uart_handle_cts_change as it's the only call that isn't already
> >>>> protected in serial-core.
> >>> Sorry but this does not look fine.  You are removing all async it=
ems
> >>> from the driver.  This works for you because in RT code can sleep=
 with
> >>> spin locks taken but for upstream it's not acceptable.  Did you t=
est
> >>> this patch with upstream kernel and lockdep enabled?
> >> I have a 4.1.y with cherry-pick of the commits from tty-testing
> >> regarding sc16is7xx. (exept the new gpio api)
> >> On our custom board we have 3 sc16is750 on a single SPI channel. I=
'm
> >> using an FTDI chip(connected to a test PC) TX wired to the 3x RX p=
ins on
> >> the sc16is750.
> >> The problem is easy reproducible just by creating data from the PC=
 at
> >> 115200 baud, causes the kernel oops almost immediately.
> >>
> >> I have not seen any issues with a vanilla 4.1.y, only when i'm app=
lying
> >> the RT patch and loading the system.
> > Thanks for providing the details, I think there is a misunderstandi=
ng
> > between us.  Allow me to explain again what I meant ;)
> >
> > I do acknowledge that there may be a problem with the driver on RT
> > kernels and I do trust you that you tested your patch on RT kernel
> > with latest version of the driver cherry-picked from mainline and i=
t
> > works there.
> >
> > However, IIUC you are proposing your patch to be included in mainli=
ne.
> >
> > What I'm trying to say is that in mainline we need the async works
> > which you remove in your patch because we cannot perform SPI/I2C
> > blocking I/O under a spinlock...  If you compile mainline with your
> > patch you will see a slew of "sleeping in atomic context" warnings.
> >
> > So basically the questions are do you want this patch in mainline a=
nd
> > have you tested it on non-RT kernels?  (Please don't be discouraged=
 -
> > there definitely must be a bug somewhere if you're seeing crashes, =
but
> > I'm afraid the proposed solutions is not good enough...)
> >
> > Thanks
> Yeah the first priority must be for the driver to work on the mainlin=
e=20
> kernel :-)
>=20
> I just wanted to flag a problem with the driver with the RT patches=20
> applied. I thought
> RT patch (maybe) revaled that the driver have underlying problem.
>=20
> So maybe this patch should be included in the RT patch?
> No i have not tested this with a non-RT kernel, maybe i should try :-=
)

I've looked at the stack dump you posted in previous email.  It looks
like we deadlock on the on spinlock_irqsave() in queue_kthread_work()
because our interrupt is not threaded!?  I thought all interrupts are
threaded in RT by default.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D [92/1901]
[ INFO: inconsistent lock state ]
4.1.15-rt17-00120-g6a753b6-dirty #10 Not tainted
---------------------------------
inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
mdev/309 [HC1[1]:SC0[0]:HE0:SE1] takes:
  ((&s->kworker)->lock){?.+...}, at: [<80046c50>]=20
queue_kthread_work+0x18/0x54
{HARDIRQ-ON-W} state was registered at:
   [<80500028>] rt_spin_lock+0x74/0x88
   [<80046930>] kthread_worker_fn+0x84/0x198
   [<80046820>] kthread+0xd8/0xec
   [<8000f658>] ret_from_fork+0x14/0x3c
irq event stamp: 1362
hardirqs last  enabled at (1361): [<800bc364>] filemap_map_pages+0x2b0/=
0x424
hardirqs last disabled at (1362): [<800139b4>] __irq_svc+0x34/0x90
softirqs last  enabled at (0): [<80026108>] copy_process.part.2+0x370/0=
x1650
softirqs last disabled at (0): [<  (null)>]   (null)

other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock((&s->kworker)->lock);
   <Interrupt>
     lock((&s->kworker)->lock);

  *** DEADLOCK ***

3 locks held by mdev/309:
  #0:  (&mm->mmap_sem){++++++}, at: [<8001d420>] do_page_fault+0x80/0x3=
68
  #1:  (&mm->page_table_lock){+.+...}, at: [<800e19fc>]=20
handle_mm_fault+0x630/0xcd0
  #2:  (rcu_read_lock){......}, at: [<800bc0b4>] filemap_map_pages+0x0/=
0x424

stack backtrace:
CPU: 0 PID: 309 Comm: mdev Not tainted 4.1.15-rt17-00120-g6a753b6-dirty=
 #10
Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[<80016e58>] (unwind_backtrace) from [<80012e48>] (show_stack+0x10/0x14=
)
[<80012e48>] (show_stack) from [<804fb00c>] (dump_stack+0x7c/0x90)
[<804fb00c>] (dump_stack) from [<804f8c6c>] (print_usage_bug+0x2d8/0x2e=
8)
[<804f8c6c>] (print_usage_bug) from [<800665ec>] (mark_lock+0x214/0x7a0=
)
[<800665ec>] (mark_lock) from [<800678dc>] (__lock_acquire+0x778/0x1dd8=
)
[<800678dc>] (__lock_acquire) from [<800697d4>] (lock_acquire+0x6c/0x8c=
)
[<800697d4>] (lock_acquire) from [<80500028>] (rt_spin_lock+0x74/0x88)
[<80500028>] (rt_spin_lock) from [<80046c50>] (queue_kthread_work+0x18/=
0x54)
[<80046c50>] (queue_kthread_work) from [<7f00b260>]=20
(sc16is7xx_irq+0x10/0x18 [sc16is7xx])
[<7f00b260>] (sc16is7xx_irq [sc16is7xx]) from [<800734c0>]=20
(handle_irq_event_percpu+0x70/0x15c)
[<800734c0>] (handle_irq_event_percpu) from [<800735e8>]=20
(handle_irq_event+0x3c/0x5c)
[<800735e8>] (handle_irq_event) from [<80076890>]=20
(handle_level_irq+0xc4/0x13c)
[<80076890>] (handle_level_irq) from [<80072b2c>]=20
(generic_handle_irq+0x2c/0x3c)
[<80072b2c>] (generic_handle_irq) from [<8025f8e0>]=20
(mxc_gpio_irq_handler+0x3c/0x108)
[<8025f8e0>] (mxc_gpio_irq_handler) from [<8025fa2c>]=20
(mx3_gpio_irq_handler+0x80/0xcc)
[<8025fa2c>] (mx3_gpio_irq_handler) from [<80072b2c>]=20
(generic_handle_irq+0x2c/0x3c)
[<80072b2c>] (generic_handle_irq) from [<80072e1c>]=20
(__handle_domain_irq+0x7c/0xe8)
[<80072e1c>] (__handle_domain_irq) from [<800094dc>]=20
(gic_handle_irq+0x24/0x5c)
[<800094dc>] (gic_handle_irq) from [<800139c4>] (__irq_svc+0x44/0x90)
Exception stack(0xa9ecdda0 to 0xa9ecdde8)
dda0: 00000001 00000110 00000000 a9f40b00 20070113 00000001 aa811eb8=20
80782edf
ddc0: a9ecde84 aaa231a0 aaa232ec aae4b800 00000003 a9ecdde8 80066be0=20
800bc368
dde0: 20070113 ffffffff
[<800139c4>] (__irq_svc) from [<800bc368>] (filemap_map_pages+0x2b4/0x4=
24)
[<800bc368>] (filemap_map_pages) from [<800e1b0c>]=20
(handle_mm_fault+0x740/0xcd0)
[<800e1b0c>] (handle_mm_fault) from [<8001d604>] (do_page_fault+0x264/0=
x368)
[<8001d604>] (do_page_fault) from [<800093b4>] (do_PrefetchAbort+0x34/0=
x9c)
[<800093b4>] (do_PrefetchAbort) from [<80013e9c>]=20
(ret_from_exception+0x0/0x24)
Exception stack(0xa9ecdfb0 to 0xa9ecdff8)
dfa0:                                     003f8008 00001000 00079c84=20
7ed0bf99
dfc0: 000808f0 ffffffff 7ed0bfc3 003f8008 00000000 00000000 000808f0=20
00000001
dfe0: 76e18598 7ed0bc28 00040d1c 76e18598 60070010 ffffffff
random: nonblocking pool is initialized
------------[ cut here ]------------
Kernel BUG at 804fe6d8 [verbose debug info unavailable]
Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
Modules linked in: gpio_sn65hvs885 ti_ads8688 ad5755 sc16is7xx=20
regmap_spi gpio_pca953x
CPU: 0 PID: 215 Comm: kworker/0:2 Not tainted=20
4.1.15-rt17-00120-g6a753b6-dirty #10
Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree) [17/1901]
Workqueue: events flush_to_ldisc
task: aa414d00 ti: a9c0c000 task.ti: a9c0c000
PC is at rt_spin_lock_slowlock+0x2c8/0x2e4
LR is at rt_spin_lock_slowlock+0x54/0x2e4
pc : [<804fe6d8>]    lr : [<804fe464>]    psr: 60070193
sp : a9c0dc20  ip : aa414d01  fp : a9edc0c4
r10: 00000000  r9 : 80046be0  r8 : 80782e40
r7 : aa414d00  r6 : 00000000  r5 : 00000001  r4 : a9c0dc38
r3 : aa414d00  r2 : 00000000  r1 : aa414d00  r0 : 00000000
=46lags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5387d  Table: 39fe804a  DAC: 00000015
Process kworker/0:2 (pid: 215, stack limit =3D 0xa9c0c210)
Stack: (0xa9c0dc20 to 0xa9c0e000)
dc20: a9c0dce0 aac0c000 a9c0dd64 800697d4 00000001 00000080 a9c0dc38=20
800735f4
dc40: 00000000 a9c0dc44 00000000 aad6b868 00000000 00000002 00000001=20
804ff9ac
dc60: aa414d00 a9edc0c4 80046c50 00000067 aad96400 80782e40 80046be0=20
00000000
dc80: c0ac9018 80500038 00000001 00000001 80f8474c 80748984 7f00b250=20
a9edc0c4
dca0: a9edc11c 80046c50 7f00b250 a9efb2c0 00000000 7f00b260 7f00b250=20
800734c0
dcc0: 800777d4 00000004 00060002 aad96400 aad96468 a9efb2c0 aad41610=20
00000001
dce0: 80f8474c 80748984 c0ac9018 800735e8 aad96400 aad96468 00000002=20
80076890
dd00: 800767cc 00000067 00000004 80072b2c 00000004 8025f8e0 d17b30c0=20
00000001
dd20: 8073e500 a9fdc200 00000000 aad41610 80751108 aad95a00 00000000=20
00000001
dd40: a9c0dda0 aac0c000 c0ac9018 8025fa2c 00000063 00000000 00000063=20
80072b2c
dd60: 8073c6d0 80072e1c f400010c 00000056 80748ca0 a9c0dda0 f4000100=20
00000008
dd80: a9fe2000 800094dc 80046be0 60070013 ffffffff a9c0ddd4 ffffffff=20
800139c4
dda0: a9edc0c4 a9edc268 a9edc108 a9edc108 a9edc268 a9edc108 a9edc0c4=20
a9fe38a9
ddc0: ffffffff 00000008 a9fe2000 c0ac9018 a9c0dda8 a9c0dde8 80046c88=20
80046be0
dde0: 60070013 ffffffff a9edc0c4 00000001 00000000 80046c88 aa4f8800=20
a9edc12c
de00: a9fe2000 802a6914 aa414d00 802a75f8 802a7608 c0ac9000 c0ac9000=20
80292ce8
de20: 60070013 a9fe39a1 a9fe38a1 00000008 c0ac9000 00000000 00000008=20
80526d20
de40: 55555556 c0ac9000 00000000 a9fe2124 00000000 a9fe2000 aa5722a0=20
a9ea5cc0
de60: a9fe3800 aa572280 aa57227c 00000000 00000000 80293120 00000001=20
aa572280
de80: a9fe2000 80296374 00000000 80040ee0 aa678d00 aa572280 ab70ce80=20
a9c0dec8
dea0: ab710700 00000001 00000000 80040f60 00000001 00000000 80040ee0=20
800412cc
dec0: 00000000 00000000 80f87484 00000000 00000000 80663790 80782dca=20
ab70ce80
dee0: ab70ced4 a9c0c000 80782dca aa678d18 aa678d00 00000008 ab70ce80=20
80041230
df00: 80742a40 aa414d00 aa678d00 aa655c00 00000000 aa678d00 800411e4=20
00000000
df20: 00000000 00000000 00000000 80046820 a9c0df9c 00000000 aa414d00=20
aa678d00
df40: 00000000 00000000 dead4ead ffffffff ffffffff 80785368 00000000=20
00000000
df60: 8066b7cc a9c0df64 a9c0df64 00000000 00000000 dead4ead ffffffff=20
ffffffff
df80: 80785368 00000000 00000000 8066b7cc a9c0df90 a9c0df90 a9c0dfac=20
aa655c00
dfa0: 80046748 00000000 00000000 8000f658 00000000 00000000 00000000=20
00000000
dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000=20
00000000
dfe0: 00000000 00000000 00000000 00000000 00000013 00000000 3bf5a811=20
3bf5ac11
[<804fe6d8>] (rt_spin_lock_slowlock) from [<80500038>]=20
(rt_spin_lock+0x84/0x88)
[<80500038>] (rt_spin_lock) from [<80046c50>] (queue_kthread_work+0x18/=
0x54)
[<80046c50>] (queue_kthread_work) from [<7f00b260>]=20
(sc16is7xx_irq+0x10/0x18 [sc16is7xx])
[<7f00b260>] (sc16is7xx_irq [sc16is7xx]) from [<800734c0>]=20
(handle_irq_event_percpu+0x70/0x15c)
[<800734c0>] (handle_irq_event_percpu) from [<800735e8>]=20
(handle_irq_event+0x3c/0x5c)
[<800735e8>] (handle_irq_event) from [<80076890>]=20
(handle_level_irq+0xc4/0x13c)
[<80076890>] (handle_level_irq) from [<80072b2c>]=20
(generic_handle_irq+0x2c/0x3c)
[<80072b2c>] (generic_handle_irq) from [<8025f8e0>]=20
(mxc_gpio_irq_handler+0x3c/0x108)
[<8025f8e0>] (mxc_gpio_irq_handler) from [<8025fa2c>]=20
(mx3_gpio_irq_handler+0x80/0xcc)
[<8025fa2c>] (mx3_gpio_irq_handler) from [<80072b2c>]=20
(generic_handle_irq+0x2c/0x3c)
[<80072b2c>] (generic_handle_irq) from [<80072e1c>]=20
(__handle_domain_irq+0x7c/0xe8)
[<80072e1c>] (__handle_domain_irq) from [<800094dc>]=20
(gic_handle_irq+0x24/0x5c)
[<800094dc>] (gic_handle_irq) from [<800139c4>] (__irq_svc+0x44/0x90)
Exception stack(0xa9c0dda0 to 0xa9c0dde8)
dda0: a9edc0c4 a9edc268 a9edc108 a9edc108 a9edc268 a9edc108 a9edc0c4=20
a9fe38a9
ddc0: ffffffff 00000008 a9fe2000 c0ac9018 a9c0dda8 a9c0dde8 80046c88=20
80046be0
dde0: 60070013 ffffffff
[<800139c4>] (__irq_svc) from [<80046be0>] (insert_kthread_work+0x28/0x=
80)
[<80046be0>] (insert_kthread_work) from [<80046c88>]=20
(queue_kthread_work+0x50/0x54)
[<80046c88>] (queue_kthread_work) from [<802a6914>] (__uart_start+0x38/=
0x3c)
[<802a6914>] (__uart_start) from [<802a75f8>] (uart_start+0x24/0x34)
[<802a75f8>] (uart_start) from [<80292ce8>]=20
(n_tty_receive_buf_common+0x55c/0x980)
[<80292ce8>] (n_tty_receive_buf_common) from [<80293120>]=20
(n_tty_receive_buf2+0x14/0x1c)
[<80293120>] (n_tty_receive_buf2) from [<80296374>]=20
(flush_to_ldisc+0xd4/0x188)
[<80296374>] (flush_to_ldisc) from [<80040f60>]=20
(process_one_work+0x1a0/0x424)
[<80040f60>] (process_one_work) from [<80041230>] (worker_thread+0x4c/0=
x4cc)
[<80041230>] (worker_thread) from [<80046820>] (kthread+0xd8/0xec)
[<80046820>] (kthread) from [<8000f658>] (ret_from_fork+0x14/0x3c)
Code: 0a000002 e59d3018 e1530004 0a000000 (e7f001f2)
---[ end trace 0000000000000002 ]---
Kernel panic - not syncing: Fatal exception in interrupt
CPU1: stopping
CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D=20
4.1.15-rt17-00120-g6a753b6-dirty #10
Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[<80016e58>] (unwind_backtrace) from [<80012e48>] (show_stack+0x10/0x14=
)
[<80012e48>] (show_stack) from [<804fb00c>] (dump_stack+0x7c/0x90)
[<804fb00c>] (dump_stack) from [<80015d4c>] (handle_IPI+0x17c/0x190)
[<80015d4c>] (handle_IPI) from [<80009510>] (gic_handle_irq+0x58/0x5c)
[<80009510>] (gic_handle_irq) from [<800139c4>] (__irq_svc+0x44/0x90)
Exception stack(0xaacadf58 to 0xaacadfa0)
df40:                                                       8036afbc=20
aaca2100
df60: 00000001 00000000 ba4c1c99 0000000f d76b24e1 0000000f 00000001=20
ab7197e8
df80: 8073a894 00000001 aacac000 aacadfa0 8036afbc 8036afc0 60000013=20
ffffffff
[<800139c4>] (__irq_svc) from [<8036afc0>] (cpuidle_enter_state+0xbc/0x=
1f4)
[<8036afc0>] (cpuidle_enter_state) from [<80063198>]=20
(cpu_startup_entry+0x23c/0x394)
[<80063198>] (cpu_startup_entry) from [<100095ac>] (0x100095ac)
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
