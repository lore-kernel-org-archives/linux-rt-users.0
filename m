Return-Path: <SRS0=MKa8=2J=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9884C43603
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Dec 2019 17:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D52222C2
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Dec 2019 17:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfLSRrX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 19 Dec 2019 12:47:23 -0500
Received: from mail.softplc.com ([206.126.248.66]:44423 "EHLO mail.softplc.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbfLSRrX (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 19 Dec 2019 12:47:23 -0500
Received: from [192.100.100.3] ([::ffff:107.174.231.239])
  (AUTH: PLAIN dick@softplc.com, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by mail.softplc.com with ESMTPSA; Thu, 19 Dec 2019 12:47:22 -0500
  id 00000000001E0003.000000005DFBB7AA.000017B8
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
From:   Dick Hollenbeck <dick@softplc.com>
Subject: 8250: set_ier(), clear_ier() and the concept of atomic console writes
Message-ID: <6e0f459a-d3dc-73cb-679f-6e86008048e1@softplc.com>
Date:   Thu, 19 Dec 2019 11:47:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Let's talk serially:

When using serial port debug printing, I have always dedicated a serial port for that.  In
contrast, I have never tried to dovetail debug messages with actual other use of the
serial port.  I don't understand the use case for changing to polled mode on the fly and
then changing back.  I could not disconnect the normal use (interrupt driven) serial cable
and then rapidly attach another serial cable intended for capturing debug messages in time
to see a polled debug message interleaved with normal port usage.  So I think the use case
contemplated by the current code is rare if non-existent.  And the result is that the code
is super ugly.

In fact the serial port code is getting uglier by the month. Its gotten too complex and
bulkier for weird apparent requirements.  When those corner case requirements are met such
that concurrent use is mandated, the solution is always more complex than if requirements
can be considered mutually exclusive.  (e.g. Who prints debug statements onto a serial
cable that is already in use for a MODBUS driver?  How would you see those print
statements easily?)

But for now, I drill down to a specific complaint.

I am looking at branch linux-5.2.y-rt-rebase, file:
  drivers/tty/serial/8250/8250_core.c
  commit 82dfc28946eacceae by John Ogness.


Here is a belated partial patch review, and would be some of the  reasons I could not
accept this patch if I was in charge of mainline:


1) The mutual exclusion used in set_eir() clear_ier() feels like the big kernel lock all
over again.  All ports using the same lock....

2) Those functions are in an 8250 specific area but do not have 8250 specific names, and
they are public.

3) The lock used in set_eir() & clear_eir() puts the CPU into atomic mode and then calls
serial_port_out().  This assumes that we know everything there will ever be to know about
serial_port_out(), even though it is an abstraction, with multiple implementations now and
more in the future.

In fact, the future is now.  I have expanded serial_port_out() to use a spinlock because
my UART is in an FPGA, along with other peripherals which share a common FPGA interface.
The spinlock gets remapped to rt_mutex.  When there is a collision on that mutex somebody
must get suspended, and then I see the kernel report of:

BUG: scheduling while atomic: irq/56-ttyS5/592/0x00000002
[ 4180.382267] Modules linked in: brcmfmac brcmutil cfg80211 rfkill uio_pdrv_genirq
[ 4180.382284] Preemption disabled at:
[ 4180.382285] [<ffff0000108baa94>] __prb_trylock+0x1c/0xf0
[ 4180.382307] CPU: 1 PID: 592 Comm: irq/56-ttyS5 Not tainted 5.2.21-rt15+ #41
[ 4180.382315] Hardware name: FriendlyARM NanoPi NEO Plus2 (DT)
[ 4180.382320] Call trace:
[ 4180.382322]  dump_backtrace+0x0/0x140
[ 4180.382334]  show_stack+0x14/0x20
[ 4180.382338]  dump_stack+0x98/0xbc
[ 4180.382346]  __schedule_bug+0x70/0xc0
[ 4180.382354]  __schedule+0x3a0/0x478
[ 4180.382362]  schedule+0x38/0xd0
[ 4180.382367]  rt_spin_lock_slowlock_locked+0xf8/0x2a0
[ 4180.382374]  rt_spin_lock_slowlock+0x5c/0x90
[ 4180.382380]  rt_spin_lock+0x58/0x68
[ 4180.382386]  fpga_write+0x2c/0x50
[ 4180.382394]  fpga_out+0x18/0x20
[ 4180.382402]  set_ier+0x5c/0x98
[ 4180.382408]  serial8250_tx_chars+0x1f4/0x248
[ 4180.382414]  serial8250_handle_irq.part.9+0xcc/0xe8
[ 4180.382421]  serial8250_default_handle_irq+0x3c/0x48
[ 4180.382427]  serial8250_interrupt+0x74/0xc0
[ 4180.382434]  irq_forced_thread_fn+0x38/0x98
[ 4180.382440]  irq_thread+0x114/0x1c0
[ 4180.382445]  kthread+0x124/0x128
[ 4180.382452]  ret_from_fork+0x10/0x18


fpga_write() is where the rt_mutex is, aka spinlock in true source representation.  I can
run a couple million bytes through that function for UARTs and other peripherals, but you
know RT, if can go wrong it will, and it eventually does.

The atomic mode was entered in the common (shared_by_all_ports) serial lock in
console_atomic_lock().  This is because the author was trying to provide mutual exclusion
between debug messages and actual normal serial port use.  I think that is fool's gold.  I
have no problem with serial port debug messages, but I don't share a port when I am using
them.

So the next question is, do I go to a raw spin lock in my fpga_write(), or do I try and
fix the usage of console_atomic_lock() in set_eir() and clear_eir()?

TIA for your thoughts,

Dick






