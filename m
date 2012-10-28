From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Preempt-rt on 3.2.23 raspberry pi kernel
Date: Sun, 28 Oct 2012 11:44:14 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1210281128410.2756@ionos>
References: <op.wh4l2os2k9j7wf@soja-mo> <op.wh75q4qvk9j7wf@soja-mo> <op.wh75zuz8k9j7wf@soja-mo> <2362932D-3DC3-460A-8F3C-C471A8577FBA@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: jan.sommer@s2008.tu-chemnitz.de,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Nick Lott <nick.lott@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:40255 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751Ab2J1KoR (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 28 Oct 2012 06:44:17 -0400
In-Reply-To: <2362932D-3DC3-460A-8F3C-C471A8577FBA@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 30 Jul 2012, Nick Lott wrote:

> I have a complete kernel log of the same problem but on 3.16 with rt27.
> 
> http://www.raspberrypi.org/phpBB3/viewtopic.php?f=29&t=9311
> 
> I've not had time to go any further with this or update and test
> with a newer kerenel.

Unfortunately verbose debug info is off, but it looks like you are
running into a recursive locking problem. You don't see it when you
switch back to !RT because the spinlocks become noops as this is an UP
machine.

Of course this proves, that nobody ever cared to boot a kernel with
DEBUG_SPINLOCK or even LOCKDEP enabled. That would have exposed such
problems. Hint: Documentation/SubmitChecklist and
Documentation/development-process/4.Coding exist for very good
reasons.

Thanks,

	tglx
