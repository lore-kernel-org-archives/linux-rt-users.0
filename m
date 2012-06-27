From: richard -rw- weinberger <richard.weinberger@gmail.com>
Subject: Fwd: BUG: scheduling while atomic: chcpu/6197/0x00000002
Date: Wed, 27 Jun 2012 14:26:35 +0200
Message-ID: <CAFLxGvzYE=PctjXJkEvfYBqe2sDsiJW_PW0tYMjvXnUJGou9HQ@mail.gmail.com>
References: <4FDF00CB.7090703@med.uni-frankfurt.de>
	<4FDF201E.2090408@med.uni-frankfurt.de>
	<4FE19494.6000303@med.uni-frankfurt.de>
	<4FE86067.9010408@med.uni-frankfurt.de>
	<4FEAF165.9090008@med.uni-frankfurt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	rt-users <linux-rt-users@vger.kernel.org>
To: sattler@med.uni-frankfurt.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:46616 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754312Ab2F0M0g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 27 Jun 2012 08:26:36 -0400
Received: by bkcji2 with SMTP id ji2so877775bkc.19
        for <linux-rt-users@vger.kernel.org>; Wed, 27 Jun 2012 05:26:35 -0700 (PDT)
In-Reply-To: <4FEAF165.9090008@med.uni-frankfurt.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

CC'ing the right guys...


---------- Forwarded message ----------
=46rom: Thomas Sattler <sattler@med.uni-frankfurt.de>
Date: Wed, Jun 27, 2012 at 1:41 PM
Subject: Re: BUG: scheduling while atomic: chcpu/6197/0x00000002
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de=
>


Linux dragon 3.4.4-rt13 #2 SMP PREEMPT Tue Jun 26 12:22:23 CEST 2012
i686 Intel(R) Core(TM)2 CPU 6300 @ 1.86GHz GenuineIntel GNU/Linux

still BUG message in dmesg:

[ =A0105.585086] BUG: scheduling while atomic: chcpu/2817/0x00000002
[ =A0105.585090] Modules linked in: loop rfcomm bnep btusb hid_microsof=
t
usbhid hid uhci_hcd ehci_hcd 3c59x usbcore e1000e mii usb_common sg
[ =A0105.585109] Pid: 2817, comm: chcpu Not tainted 3.4.4-rt13 #2
[ =A0105.585111] Call Trace:
[ =A0105.585119] =A0[<c103df4d>] __schedule_bug+0x3d/0x42
[ =A0105.585124] =A0[<c1355474>] __schedule+0x68/0x571
[ =A0105.585130] =A0[<c1045840>] ? enqueue_entity+0x313/0x3d8
[ =A0105.585134] =A0[<c1355a22>] schedule+0x60/0x70
[ =A0105.585138] =A0[<c1354a42>] schedule_timeout+0x17/0x160
[ =A0105.585142] =A0[<c103ed57>] ? check_preempt_curr+0x29/0x64
[ =A0105.585146] =A0[<c135532d>] wait_for_common+0xa3/0xff
[ =A0105.585150] =A0[<c10412e2>] ? try_to_wake_up+0x391/0x391
[ =A0105.585154] =A0[<c135540a>] wait_for_completion+0x12/0x14
[ =A0105.585158] =A0[<c103781c>] kthread_create_on_node+0x71/0xb5
[ =A0105.585162] =A0[<c102542c>] ? put_online_cpus+0x44/0x44
[ =A0105.585167] =A0[<c1350101>] ? init_amd+0x42f/0x64f
[ =A0105.585172] =A0[<c134727f>] _cpu_down+0x106/0x2b4
[ =A0105.585176] =A0[<c102542c>] ? put_online_cpus+0x44/0x44
[ =A0105.585180] =A0[<c1347452>] cpu_down+0x25/0x34
[ =A0105.585183] =A0[<c1348a96>] store_online+0x29/0x70
[ =A0105.585187] =A0[<c1348a6d>] ? acpi_processor_start+0xf7/0xf7
[ =A0105.585192] =A0[<c127b0ef>] dev_attr_store+0x1b/0x23
[ =A0105.585197] =A0[<c10eb73e>] sysfs_write_file+0xae/0xe7
[ =A0105.585201] =A0[<c10ab9b6>] vfs_write+0x8c/0x122
[ =A0105.585205] =A0[<c10eb690>] ? sysfs_poll+0x77/0x77
[ =A0105.585209] =A0[<c10abc07>] sys_write+0x3b/0x60
[ =A0105.585214] =A0[<c1357963>] sysenter_do_call+0x12/0x2c
[ =A0105.585242] BUG: scheduling while atomic: chcpu/2817/0x00000002
[ =A0105.585244] Modules linked in: loop rfcomm bnep btusb hid_microsof=
t
usbhid hid uhci_hcd ehci_hcd 3c59x usbcore e1000e mii usb_common sg
[ =A0105.585260] Pid: 2817, comm: chcpu Not tainted 3.4.4-rt13 #2
[ =A0105.585262] Call Trace:
[ =A0105.585266] =A0[<c103df4d>] __schedule_bug+0x3d/0x42
[ =A0105.585270] =A0[<c1355474>] __schedule+0x68/0x571
[ =A0105.585275] =A0[<c1356ba1>] ? _raw_spin_unlock_irqrestore+0x1a/0x2=
f
[ =A0105.585279] =A0[<c103a992>] ? __hrtimer_start_range_ns+0x2cf/0x2f6
[ =A0105.585283] =A0[<c1355a22>] schedule+0x60/0x70
[ =A0105.585287] =A0[<c1354f2a>] schedule_hrtimeout_range_clock+0xc5/0x=
ec
[ =A0105.585291] =A0[<c103a202>] ? update_rmtp+0x68/0x68
[ =A0105.585295] =A0[<c1354f5b>] schedule_hrtimeout_range+0xa/0xc
[ =A0105.585299] =A0[<c1354f69>] schedule_hrtimeout+0xc/0xe
[ =A0105.585303] =A0[<c103f197>] wait_task_inactive+0xc5/0xd6
[ =A0105.585307] =A0[<c1037773>] kthread_bind+0x13/0x4b
[ =A0105.585312] =A0[<c134729a>] _cpu_down+0x121/0x2b4
[ =A0105.585316] =A0[<c1347452>] cpu_down+0x25/0x34
[ =A0105.585319] =A0[<c1348a96>] store_online+0x29/0x70
[ =A0105.585323] =A0[<c1348a6d>] ? acpi_processor_start+0xf7/0xf7
[ =A0105.585327] =A0[<c127b0ef>] dev_attr_store+0x1b/0x23
[ =A0105.585331] =A0[<c10eb73e>] sysfs_write_file+0xae/0xe7
[ =A0105.585335] =A0[<c10ab9b6>] vfs_write+0x8c/0x122
[ =A0105.585339] =A0[<c10eb690>] ? sysfs_poll+0x77/0x77
[ =A0105.585342] =A0[<c10abc07>] sys_write+0x3b/0x60
[ =A0105.585347] =A0[<c1357963>] sysenter_do_call+0x12/0x2c

[...]
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
Please read the FAQ at =A0http://www.tux.org/lkml/


--=20
Thanks,
//richard
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
