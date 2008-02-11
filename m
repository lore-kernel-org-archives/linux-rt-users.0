From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: Soft lockup when running large iterations of gtod
Date: Mon, 11 Feb 2008 17:52:41 -0200
Message-ID: <20080211195241.GY3522@unix.sh>
References: <20080207104409.GA15048@in.ibm.com> <20080211152651.GB7663@in.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="HlL+5n6rz5pIUxbD"
To: Ankita Garg <ankita@in.ibm.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	John Stultz <johnstul@us.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from sr05-02.mta.terra.com.br ([200.154.152.61]:56945 "EHLO
	sr05-02.mta.terra.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757136AbYBKTwu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 11 Feb 2008 14:52:50 -0500
Content-Disposition: inline
In-Reply-To: <20080211152651.GB7663@in.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 11, 2008 at 08:56:51PM +0530, Ankita Garg wrote:
| Hi,
| 
| On Thu, Feb 07, 2008 at 04:14:09PM +0530, Ankita Garg wrote:
| > Hi,
| > 
| > I observed a softlockup when running large number of iterations of the
| > gtod_latency testcase. This testcase measure the time between several
| > pairs of calls to gettimeofday(). 
| > 
| > Kernel: 2.6.24-rt1
| > This was on AMD Opteron dual dual-core box.
| > 
| > The test output is :
| > 
| > ----------------------
| > Gettimeofday() Latency
| > ----------------------
| > Iterations: 100000000
| >
| 
| I can reproduce the issue even with smaller number of iterations of the
| gtod_latency test case.

I have observed the same symptoms in my system but realized that:

- System is a Core2Duo (2 CPUs, 1 proc) 2GB RAM 
- The test runs at rtprio 99 and SCHED_FIFO
- It writes a huge amount of data when # of iterations = 100000000
- It uses 1.5GB+ of RAM for the above # of iterations
- The disk IRQ runs at rtrpio 95 (in my system) and could easily starve
- All my backtraces involve ext3 handling functions

In short, with no memory and lots of data to write, disk IRQ starve. With
the attached patch, that changes schedule to SCHED_OTHER, I am able to run
the test with no errors.

Btw, after running the test, I have these files written to disk:

-rw-rw-r-- 1 lclaudio lclaudio  139 2008-02-11 17:31 hist.dat
-rw-rw-r-- 1 lclaudio lclaudio  174 2008-02-11 17:31 hist.plt
-rw-rw-r-- 1 lclaudio lclaudio 1.1G 2008-02-11 17:31 scatter.dat
-rw-rw-r-- 1 lclaudio lclaudio  191 2008-02-11 17:31 scatter.plt

Regards,
Luis
 
| > Min: 1 us
| > Max: 670971 us
| > Avg: 0.4021 us
| > StdDev: 164.3269 us
| > 
| > Soft lockup
| > 
| > BUG: soft lockup - CPU#2 stuck for 11s! [gtod_latency:18573]
| > CPU 2:
| > Modules linked in: dock rtc_cmos rtc_core rtc_lib bnx2 shpchp serio_raw
| > lp
| > parport_pc parport ac battery button i2c_core sbs sbshc dm_multipath
| > dm_mirror
| > dm_mod sunrpc rfcomm hidp l2cap bluetooth autofs4 ipv6 sg pcspkr k8temp
| > hwmon
| > mptsas mptscsih mptbase scsi_transport_sas sd_mod scsi_mod ext3 jbd
| > ehci_hcd
| > ohci_hcd uhci_hcd
| > Pid: 18573, comm: gtod_latency Not tainted 2.6.24-rt1-autotest #1
| > RIP: 0033:[<ffffffffff600188>]  [<ffffffffff600188>] vread_hpet+0x8/0xf
| > RSP: 002b:00007fffce199860  EFLAGS: 00000282
| > RAX: 00000000eaef6171 RBX: 00007fffce199890 RCX: 0000000000000002
| > RDX: 00000000041291f4 RSI: 0000000000000000 RDI: 00007fffce199910
| > RBP: 0000000000000000 R08: 000000001175d794 R09: 0000000000000016
| > R10: 0000000000001181 R11: 0000003b0b487160 R12: 0000000000000000
| > R13: 0000000000000000 R14: 00007fffce199900 R15: 00007fffce199910
| > FS:  00002b7ddc9266b0(0000) GS:ffff81022fc057c0(0000)
| > knlGS:00000000f7f9e6c0
| > CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
| > CR2: 0000003b0b487160 CR3: 000000022c4b7000 CR4: 00000000000006e0
| > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
| > DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
| > 
| > 
| > BUG: soft lockup - CPU#2 stuck for 11s! [gtod_latency:18573]
| > CPU 2:
| > Modules linked in: dock rtc_cmos rtc_core rtc_lib bnx2 shpchp serio_raw
| > lp
| > parport_pc parport ac battery button i2c_core sbs sbshc dm_multipath
| > dm_mirror
| > dm_mod sunrpc rfcomm hidp l2cap bluetooth autofs4 ipv6 sg pcspkr k8temp
| > hwmon
| > mptsas mptscsih mptbase scsi_transport_sas sd_mod scsi_mod ext3 jbd
| > ehci_hcd
| > ohci_hcd uhci_hcd
| > Pid: 18573, comm: gtod_latency Not tainted 2.6.24-rt1-autotest #1
| > RIP: 0010:[<ffffffff8803014f>]  [<ffffffff8803014f>]
| > :ext3:ext3_writepage_trans_blocks+0x4b/0x9b
| > RSP: 0018:ffff810103a8bae8  EFLAGS: 00000246
| > RAX: 0000000000010820 RBX: ffff810103a8baf8 RCX: 0000000000000001
| > RDX: 0000000000000003 RSI: ffff810105240358 RDI: ffff8101052401c0
| > RBP: ffffffff80636140 R08: 0000000000000000 R09: ffff810103a8bc60
| > R10: ffff810103a8bed8 R11: 0000000000000001 R12: ffffffff8067ffe0
| > R13: ffff81022df05000 R14: ffff810182dc62b8 R15: ffff81022df05000
| > FS:  00002b7ddc9266b0(0000) GS:ffff81022fc057c0(0000)
| > knlGS:00000000f7f9e6c0
| > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
| > CR2: 00002b7e3bf0a000 CR3: 000000022c4b7000 CR4: 00000000000006e0
| > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
| > DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
| > 
| > Call Trace:
| >  [<ffffffff88030115>] :ext3:ext3_writepage_trans_blocks+0x11/0x9b
| >  [<ffffffff88032178>] :ext3:ext3_write_begin+0x32/0x19e
| >  [<ffffffff8027370e>] generic_file_buffered_write+0x151/0x611
| >  [<ffffffff8023d245>] current_fs_time+0x22/0x29
| >  [<ffffffff802ab1c2>] file_update_time+0x30/0xad
| >  [<ffffffff80273f27>] __generic_file_aio_write_nolock+0x359/0x3c3
| >  [<ffffffff802922ae>] kmem_cache_free+0x63/0x70
| >  [<ffffffff80273ff5>] generic_file_aio_write+0x64/0xc0
| >  [<ffffffff8802e2ae>] :ext3:ext3_file_write+0x1e/0x9e
| >  [<ffffffff80296b1f>] do_sync_write+0xe2/0x126
| >  [<ffffffff80288736>] page_add_new_anon_rmap+0x20/0x22
| >  [<ffffffff8024c860>] autoremove_wake_function+0x0/0x38
| >  [<ffffffff80267bf1>] audit_syscall_entry+0x148/0x17e
| >  [<ffffffff8029731b>] vfs_write+0xc7/0x150
| >  [<ffffffff802978c6>] sys_write+0x4a/0x76
| >  [<ffffffff8020c30e>] tracesys+0xdc/0xe1
| > 
| > The last working kernel I had tried this on was 2.6.21.4-rt10. I notice that 
| > the vsyscall support for hpet went in sometime around 2.6.22. Any
| > thoughts on what could be going wrong here?
| > 
| 
| -- 
| Regards,
| Ankita Garg (ankita@in.ibm.com)
| Linux Technology Center
| IBM India Systems & Technology Labs, 
| Bangalore, India   
| -
| To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
---end quoted text---

-- 
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="gtod_latency_change.patch"

diff --git a/gtod_latency.c b/gtod_latency.c
index a58bc88..aa4ce67 100644
--- a/gtod_latency.c
+++ b/gtod_latency.c
@@ -219,8 +219,8 @@ int main(int argc, char *argv[])
 	}
 		
 	/* switch to SCHED_FIFO 99 */
-	param.sched_priority = sched_get_priority_max(SCHED_FIFO);
-	err = sched_setscheduler(0, SCHED_FIFO, &param);
+	param.sched_priority = sched_get_priority_max(SCHED_OTHER);
+	err = sched_setscheduler(0, SCHED_OTHER, &param);
 
 	/* Check that the user has the appropriate privileges */
 	if (err) {

--HlL+5n6rz5pIUxbD--
