From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Lockdep splat + hardlock on 4.1.10-rt9
Date: Sat, 17 Oct 2015 12:00:28 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1510171148560.4212@nanos>
References: <20151016225231.GL4265@uudg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux RT Users <linux-rt-users@vger.kernel.org>
To: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:40346 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347AbbJQKBM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 17 Oct 2015 06:01:12 -0400
In-Reply-To: <20151016225231.GL4265@uudg.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 16 Oct 2015, Luis Claudio R. Goncalves wrote:
> [  688.417603]  [<ffffffff81115672>] del_timer_sync+0x52/0x190
> [  688.417604]  [<ffffffff81115625>] ? del_timer_sync+0x5/0x190
> [  688.417606]  [<ffffffff8182c7f5>] ? _raw_spin_unlock+0x35/0x70
> [  688.417610]  [<ffffffff8182a828>] ? rt_spin_lock_slowunlock+0x68/0x70
> [  688.417613]  [<ffffffff8173aa8e>] inet_csk_reqsk_queue_drop+0xbe/0x210
> [  688.417614]  [<ffffffff8173acc7>] reqsk_timer_handler+0xe7/0x2d0
> [  688.417616]  [<ffffffff8173abe0>] ? inet_csk_reqsk_queue_drop+0x210/0x210
> [  688.417618]  [<ffffffff81115962>] call_timer_fn+0xe2/0x570

That's an upstream bug. Fixed with

83fccfc3940c inet: fix potential deadlock in reqsk_queue_unlink()

Thanks,

	tglx
