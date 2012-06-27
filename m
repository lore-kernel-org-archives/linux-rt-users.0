From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Fwd: BUG: scheduling while atomic: chcpu/6197/0x00000002
Date: Wed, 27 Jun 2012 08:37:02 -0400
Message-ID: <1340800622.16702.1.camel@gandalf.stny.rr.com>
References: <4FDF00CB.7090703@med.uni-frankfurt.de>
	 <4FDF201E.2090408@med.uni-frankfurt.de>
	 <4FE19494.6000303@med.uni-frankfurt.de>
	 <4FE86067.9010408@med.uni-frankfurt.de>
	 <4FEAF165.9090008@med.uni-frankfurt.de>
	 <CAFLxGvzYE=PctjXJkEvfYBqe2sDsiJW_PW0tYMjvXnUJGou9HQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: sattler@med.uni-frankfurt.de, Thomas Gleixner <tglx@linutronix.de>,
	rt-users <linux-rt-users@vger.kernel.org>
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:3227 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753616Ab2F0MhE (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 27 Jun 2012 08:37:04 -0400
In-Reply-To: <CAFLxGvzYE=PctjXJkEvfYBqe2sDsiJW_PW0tYMjvXnUJGou9HQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2012-06-27 at 14:26 +0200, richard -rw- weinberger wrote:

> [  105.585086] BUG: scheduling while atomic: chcpu/2817/0x00000002
> [  105.585090] Modules linked in: loop rfcomm bnep btusb hid_microsoft
> usbhid hid uhci_hcd ehci_hcd 3c59x usbcore e1000e mii usb_common sg
> [  105.585109] Pid: 2817, comm: chcpu Not tainted 3.4.4-rt13 #2
> [  105.585111] Call Trace:
> [  105.585119]  [<c103df4d>] __schedule_bug+0x3d/0x42
> [  105.585124]  [<c1355474>] __schedule+0x68/0x571
> [  105.585130]  [<c1045840>] ? enqueue_entity+0x313/0x3d8
> [  105.585134]  [<c1355a22>] schedule+0x60/0x70
> [  105.585138]  [<c1354a42>] schedule_timeout+0x17/0x160
> [  105.585142]  [<c103ed57>] ? check_preempt_curr+0x29/0x64
> [  105.585146]  [<c135532d>] wait_for_common+0xa3/0xff
> [  105.585150]  [<c10412e2>] ? try_to_wake_up+0x391/0x391
> [  105.585154]  [<c135540a>] wait_for_completion+0x12/0x14
> [  105.585158]  [<c103781c>] kthread_create_on_node+0x71/0xb5
> [  105.585162]  [<c102542c>] ? put_online_cpus+0x44/0x44
> [  105.585167]  [<c1350101>] ? init_amd+0x42f/0x64f
> [  105.585172]  [<c134727f>] _cpu_down+0x106/0x2b4

I believe CPU hotplug is still an issue with -rt, and this is a known
problem.

-- Steve

> [  105.585176]  [<c102542c>] ? put_online_cpus+0x44/0x44
> [  105.585180]  [<c1347452>] cpu_down+0x25/0x34
> [  105.585183]  [<c1348a96>] store_online+0x29/0x70
> [  105.585187]  [<c1348a6d>] ? acpi_processor_start+0xf7/0xf7
> [  105.585192]  [<c127b0ef>] dev_attr_store+0x1b/0x23
> [  105.585197]  [<c10eb73e>] sysfs_write_file+0xae/0xe7
> [  105.585201]  [<c10ab9b6>] vfs_write+0x8c/0x122
> [  105.585205]  [<c10eb690>] ? sysfs_poll+0x77/0x77
> [  105.585209]  [<c10abc07>] sys_write+0x3b/0x60
> [  105.585214]  [<c1357963>] sysenter_do_call+0x12/0x2c
> [  105.585242] BUG: scheduling while atomic: chcpu/2817/0x00000002
> [  105.585244] Modules linked in: loop rfcomm bnep btusb hid_microsoft
> usbhid hid uhci_hcd ehci_hcd 3c59x usbcore e1000e mii usb_common sg


