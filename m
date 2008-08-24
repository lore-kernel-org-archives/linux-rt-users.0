From: "John Kacur" <jkacur@gmail.com>
Subject: 2.6.26.3-rt3 bug report
Date: Mon, 25 Aug 2008 00:51:11 +0200
Message-ID: <520f0cf10808241551x2fe64e9esadf66634b3790c54@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Thomas Gleixner" <tglx@linutronix.de>,
	"Ingo Molnar" <mingo@elte.hu>
To: "Steven Rostedt" <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:40376 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756243AbYHXWvN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 24 Aug 2008 18:51:13 -0400
Received: by ey-out-2122.google.com with SMTP id 6so138456eyi.37
        for <linux-rt-users@vger.kernel.org>; Sun, 24 Aug 2008 15:51:11 -0700 (PDT)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I haven't seen this one before.

Bad page state in process 'firefox-bin'
page:ffffe20001011f00 flags:0x0100000000000000
mapping:ffffe20001011f18 mapcount:0 count:0
Trying to fix it up, but a reboot is needed
Backtrace:
Pid: 4180, comm: firefox-bin Tainted: G        W 2.6.26.3-rt3 #3

Call Trace:
 [<ffffffff80287a72>] bad_page+0x6f/0x9d
 [<ffffffff8029184c>] ? inc_zone_page_state+0x5f/0x6b
 [<ffffffff80289046>] free_hot_cold_page+0x88/0x1e6
 [<ffffffff8028920b>] free_hot_page+0x10/0x12
 [<ffffffff8028922a>] __free_pages+0x1d/0x26
 [<ffffffff80294b95>] __pte_alloc+0x8e/0x99
 [<ffffffff80294cff>] handle_mm_fault+0x15f/0x766
 [<ffffffff8045f2d6>] ? rt_mutex_down_read_trylock+0x1ee/0x1f9
 [<ffffffff804629d9>] do_page_fault+0x51d/0x92c
 [<ffffffff8021251c>] ? native_sched_clock+0x2a/0x72
 [<ffffffff8027c930>] ? ftrace_now+0x9/0xb
 [<ffffffff80281548>] ? tracing_hist_preempt_start+0xf1/0x10d
 [<ffffffff8021251c>] ? native_sched_clock+0x2a/0x72
 [<ffffffff8027c930>] ? ftrace_now+0x9/0xb
 [<ffffffff804602f9>] error_exit+0x0/0x56

---------------------------
| preempt count: 00000000 ]
| 0-level deep critical section nesting:
----------------------------------------
