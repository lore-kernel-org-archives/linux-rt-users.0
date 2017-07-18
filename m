From: Ian Abbott <abbotti@mev.co.uk>
Subject: Re: [BUG] drivers: staging: comedi: do not call blocking ops when
 !TASK_RUNNING; state=1
Date: Tue, 18 Jul 2017 12:17:10 +0100
Message-ID: <57d02406-8ff6-ccd3-a3c0-7e958e48df23@mev.co.uk>
References: <20170717144850.GA1696@piotrpc>
 <710d1c24-a4f2-c0c0-3d20-76e1f0e402a9@mev.co.uk>
 <20170717181439.GB11283@westernst>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sebastian.siewior@linutronix.de, tglx@linutronix.de,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org
To: Piotr Gregor <piotrgregor@rsyncme.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp77.ord1c.emailsrvr.com ([108.166.43.77]:58323 "EHLO
        smtp77.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751379AbdGRLRO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 18 Jul 2017 07:17:14 -0400
Received: from smtp18.relay.ord1c.emailsrvr.com (localhost [127.0.0.1])
        by smtp18.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id 7FC0DE03F0
        for <linux-rt-users@vger.kernel.org>; Tue, 18 Jul 2017 07:17:13 -0400 (EDT)
Received: from smtp69.ord1d.emailsrvr.com (relay.ord1c.rsapps.net [172.28.255.120])
        by smtp18.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTPS id 7B8E1E036E
        for <linux-rt-users@vger.kernel.org>; Tue, 18 Jul 2017 07:17:13 -0400 (EDT)
In-Reply-To: <20170717181439.GB11283@westernst>
Content-Language: en-GB
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

[Top-posting fixed.  Please don't top-post!]
On 17/07/17 19:14, Piotr Gregor wrote:
> On Mon, Jul 17, 2017 at 05:02:45PM +0100, Ian Abbott wrote:
>> On 17/07/17 15:48, Piotr Gregor wrote:
>>> Calling blocking operations from wrong context.
>>> Kernel:
>>>
>>> Linux piotrpc 4.4.70-rt83 #1 SMP PREEMPT RT Thu Jul 13 08:42:02 BST 2017 x86_64 GNU/Linux
>>>
>>> [   80.542018] NOHZ: local_softirq_pending 80
>>> [  125.175471] ------------[ cut here ]------------
>>> [  125.175491] WARNING: CPU: 0 PID: 1497 at kernel/sched/core.c:7833 __might_sleep+0x9f/0xb0()
>>> [  125.175728] do not call blocking ops when !TASK_RUNNING; state=1 set at [<ffffffffc0575741>] comedi_read+0x1a1/0x610 [comedi]
[snip]
>>> [  125.175926] CPU: 0 PID: 1497 Comm: txrx Tainted: G        WC      4.4.70-rt83 #1
>>> [  125.175928] Hardware name: NOVATECH LTD PC-XB04472/H110M-C, BIOS 3019 01/06/2017
>>> [  125.175935]  0000000000000000 ffff8802205b3cb0 ffffffff81387160 ffff8802205b3cf8
>>> [  125.175940]  0000000000000009 ffff8802205b3ce8 ffffffff81089766 ffffffffc057ca60
>>> [  125.175944]  00000000000002dc 0000000000000000 0000000000000001 0000000000000001
>>> [  125.175945] Call Trace:
>>> [  125.175955]  [<ffffffff81387160>] dump_stack+0x85/0xc5
>>> [  125.175963]  [<ffffffff81089766>] warn_slowpath_common+0x86/0xe0
>>> [  125.175971]  [<ffffffff8108980c>] warn_slowpath_fmt+0x4c/0x50
>>> [  125.175980]  [<ffffffff81185577>] ? trace_preempt_on+0x1a7/0x2b0
>>> [  125.175985]  [<ffffffff8168ca95>] ? schedule+0x55/0xe0
>>> [  125.175994]  [<ffffffffc0575741>] ? comedi_read+0x1a1/0x610 [comedi]
>>> [  125.176001]  [<ffffffffc0575741>] ? comedi_read+0x1a1/0x610 [comedi]
>>> [  125.176005]  [<ffffffff810b6d0f>] __might_sleep+0x9f/0xb0
>>> [  125.176012]  [<ffffffff811f54cb>] __might_fault+0x3b/0xb0
>>> [  125.176020]  [<ffffffffc057597f>] comedi_read+0x3df/0x610 [comedi]
>>> [  125.176034]  [<ffffffff810bebf0>] ? wake_up_process+0x20/0x20
>>> [  125.176044]  [<ffffffff812406d8>] __vfs_read+0x28/0xe0
>>> [  125.176053]  [<ffffffff812f1f06>] ? security_file_permission+0xa6/0xc0
>>> [  125.176060]  [<ffffffff81240c53>] ? rw_verify_area+0x53/0xf0
>>> [  125.176066]  [<ffffffff81240d79>] vfs_read+0x89/0x130
>>> [  125.176074]  [<ffffffff81241b79>] SyS_read+0x49/0xb0
>>> [  125.176084]  [<ffffffff81691876>] entry_SYSCALL_64_fastpath+0x16/0x7a
>>> [  125.176095] ---[ end trace 0000000000000003 ]---
>>>
>>>
>>> cheers,
>>> Piotr
>>
>> Thanks for the bug report.  I think comedi_read() in
>> "drivers/staging/comedi/comedi_fops.c" needs a call to
>> set_current_state(TASK_RUNNING) just before the call to copy_to_user(...).
>>
>> Similarly, comedi_write() needs a call to set_current_task(TASK_RUNNING)
>> just before the call to copy_from_user(...), and another call to
>> set_current_task(TASK_RUNNING) before the call to mutex_lock().
>>
>> I'll work on a patch.

 > Hi Ian,
 >
 > I am afraid I have more problems with running Comedi on rt-patched 
kernel than
 > only that. I am still trying to figure out the specific reason - 
hopefully it is
 > my fault and I scrued up my own code, but so far it seems pcie215
 > support doesn't work at least in the same way on rt-patched kernel
 > as it was on non-rt. I will dig it a little bit harder, likely coming 
with another
 > bug reports shoud they be observed.
 >
 > Do you know about other experience other people may have using Comedi
 > for pcie215 on rt-patched kernels, specifically 4.4.70?

Not in particular.  People have used Comedi with RTAI in the past, but 
that's a different animal to the RT patch-set.

 > Has Comedi been tested on rt kernels by yourself?

Not up until now.  Initial testing with the "comedi_test" module 
suggests there may be some issues to be resolved (e.g. it locks up when 
running an asynchronous command), although "comedi_test" isn't a typical 
Comedi driver as it makes heavy use of kernel timers.  I do have a 
pcie215, but haven't tried it on an RT kernel yet.

-- 
-=( Ian Abbott @ MEV Ltd.    E-mail: <abbotti@mev.co.uk> )=-
-=(                          Web: http://www.mev.co.uk/  )=-
