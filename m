From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: Lockdep splat + hardlock on 4.1.10-rt9
Date: Sun, 18 Oct 2015 23:48:03 -0200
Message-ID: <20151019014803.GN4265@uudg.org>
References: <20151016225231.GL4265@uudg.org>
 <alpine.DEB.2.11.1510171148560.4212@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux RT Users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:36355 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752576AbbJSBsI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 18 Oct 2015 21:48:08 -0400
Received: by qgad10 with SMTP id d10so52312824qga.3
        for <linux-rt-users@vger.kernel.org>; Sun, 18 Oct 2015 18:48:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1510171148560.4212@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, Oct 17, 2015 at 12:00:28PM +0200, Thomas Gleixner wrote:
| On Fri, 16 Oct 2015, Luis Claudio R. Goncalves wrote:
| > [  688.417603]  [<ffffffff81115672>] del_timer_sync+0x52/0x190
| > [  688.417604]  [<ffffffff81115625>] ? del_timer_sync+0x5/0x190
| > [  688.417606]  [<ffffffff8182c7f5>] ? _raw_spin_unlock+0x35/0x70
| > [  688.417610]  [<ffffffff8182a828>] ? rt_spin_lock_slowunlock+0x68/0x70
| > [  688.417613]  [<ffffffff8173aa8e>] inet_csk_reqsk_queue_drop+0xbe/0x210
| > [  688.417614]  [<ffffffff8173acc7>] reqsk_timer_handler+0xe7/0x2d0
| > [  688.417616]  [<ffffffff8173abe0>] ? inet_csk_reqsk_queue_drop+0x210/0x210
| > [  688.417618]  [<ffffffff81115962>] call_timer_fn+0xe2/0x570
| 
| That's an upstream bug. Fixed with
| 
| 83fccfc3940c inet: fix potential deadlock in reqsk_queue_unlink()

Thanks! I somehow missed this commit while looking for fixes.

Luis
