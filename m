From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Filesystem lockup with CONFIG_PREEMPT_RT
Date: Mon, 7 Jul 2014 15:00:37 +0200 (CEST)
Message-ID: <alpine.DEB.2.10.1407071458330.22031@nanos>
References: <CAA85NCgJPczdQ0mhH3n6cwuZ0kTT-ZFayn3RAjpGAJOB3AM47g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Jan de Kruyf <jan.de.kruyf@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:47577 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752857AbaGGNAk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 7 Jul 2014 09:00:40 -0400
In-Reply-To: <CAA85NCgJPczdQ0mhH3n6cwuZ0kTT-ZFayn3RAjpGAJOB3AM47g@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 7 Jul 2014, Jan de Kruyf wrote:

> Hope I do not kick in an open door, but
> 
> Linux JanDell 3.2.0-0.bpo.3-rt-686-pae #1 SMP PREEMPT RT Thu Aug 23
> 09:55:27 UTC 2012 i686 GNU/Linux
> and
> Linux jan 3.2.0-4-rt-amd64 #1 SMP PREEMPT RT Debian 3.2.57-3+deb7u2
> x86_64 GNU/Linux
> 
> does not give the same problem that I experienced with XFS.
> So there is a hickup between version 3.2-rt and 3.10-rt I would say.

There is no hickup. Just stuff changes over time and makes certain
problems more likely/obvious.

The workqueue issue has been there since we had to deal with the
workqueue wakeup from the guts of the scheduler.

Thanks,

	tglx
