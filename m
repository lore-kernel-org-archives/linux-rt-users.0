From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: 2.6.33.1-rt11 BUG: sleeping function called from invalid context
 at kernel/rtmutex.c:684
Date: Tue, 6 Apr 2010 10:43:18 -0300
Message-ID: <20100406134318.GR4234@uudg.org>
References: <4BB8587F.40307@xs4all.nl>
 <alpine.LFD.2.00.1004061005300.32352@localhost.localdomain>
 <4BBB3865.9070204@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: RT <linux-rt-users@vger.kernel.org>
To: Udo van den Heuvel <udovdh@xs4all.nl>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:41097 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755828Ab0DFNs4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Apr 2010 09:48:56 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1745018qwh.37
        for <linux-rt-users@vger.kernel.org>; Tue, 06 Apr 2010 06:48:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4BBB3865.9070204@xs4all.nl>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Apr 06, 2010 at 03:34:29PM +0200, Udo van den Heuvel wrote:
| Hallo Thomas,
| 
| On 2010-04-06 10:07, Thomas Gleixner wrote:
| > On Sun, 4 Apr 2010, Udo van den Heuvel wrote:
| >> I see a load of these after booting into 2.6.33.1-rt11:
| >>
| >> BUG: sleeping function called from invalid context at kernel/rtmutex.c:684
| >> pcnt: 1 0 in_atomic(): 1, irqs_disabled(): 0, pid: 1507, name: md1_raid5
| >> Pid: 1507, comm: md1_raid5 Not tainted 2.6.33.1-rt11 #1
| >> Call Trace:
| >>  [<ffffffff8138fb8c>] ? rt_spin_lock+0x2c/0x70
| >>  [<ffffffff812becc4>] ? __raid_run_ops+0x304/0xc60
| >>  [<ffffffff812c0ccd>] ? handle_stripe+0x6bd/0x1a70
| >>  [<ffffffff8104b460>] ? mod_timer+0x150/0x200
| >>  [<ffffffff812c23f6>] ? raid5d+0x376/0x4f0
| >>  [<ffffffff8138e5bd>] ? schedule_timeout+0x22d/0x2b0
| >>  [<ffffffff8138fb8c>] ? rt_spin_lock+0x2c/0x70
| >>  [<ffffffff812cd0f3>] ? md_thread+0x53/0x120
| >>  [<ffffffff810573a0>] ? autoremove_wake_function+0x0/0x30
| >>  [<ffffffff812cd0a0>] ? md_thread+0x0/0x120
| >>  [<ffffffff81057016>] ? kthread+0x96/0xa0
| >>  [<ffffffff81037908>] ? finish_task_switch+0x58/0xd0
| >>  [<ffffffff810032d4>] ? kernel_thread_helper+0x4/0x10
| >>  [<ffffffff81056f80>] ? kthread+0x0/0xa0
| >>  [<ffffffff810032d0>] ? kernel_thread_helper+0x0/0x10
| >>
| >> As these appear to be touching my raid array I am quite eager to learn
| >> how I can fix the BUGs.
| >>
| >> Please have a look and explain.
| > 
| > That's caused by the get_cpu()/put_cpu() preempt disabled region. Can
| > you try the following (untested) patch ?
| 
| After applying, compilign and rebooting the BUG-messages appear to be
| gone (after a quick test).
| Thanks!
| 
| Only issue remaining is this message:
| 
| Apr  6 15:25:02 nawdew rtkit-daemon[3484]: Failed to make ourselves RT:
| Operation not permitted
| (repeated a number of times)
| 
| Is this also -rt related?

here's the description of rtkit:

	Summary     : Realtime Policy and Watchdog Daemon
	Description :
	  RealtimeKit is a D-Bus system service that changes the
	  scheduling policy of user processes/threads to SCHED_RR (i.e. realtime
	  scheduling mode) on request. It is intended to be used as a secure
	  mechanism to allow real-time scheduling to be used by normal user
	  processes.

One famous user of rtkit is pulseaudio. In fact, it is the only user of
rtkit on my system. And the message reflects that either your pulseaudio
config is forbidding usage of RT prios or the user running pulseaudio has
no rights to use higher priorities (check with ulimit)

Luis

| 
| Kind regards,
| Udo
| --
| To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
---end quoted text---

-- 
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

