From: Martin Shepherd <mcs@astro.caltech.edu>
Subject: Re: Debugging a hard lockup with no symptoms
Date: Thu, 15 Apr 2010 12:19:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1004151209490.24951@haggis.caltech.edu>
References: <Pine.LNX.4.64.1004132345050.14952@haggis.caltech.edu>
 <alpine.LFD.2.00.1004151455230.3625@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from phobos.caltech.edu ([131.215.193.100]:59570 "EHLO
	phobos.caltech.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756047Ab0DOTUA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 15 Apr 2010 15:20:00 -0400
In-Reply-To: <alpine.LFD.2.00.1004151455230.3625@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Thu, 15 Apr 2010, Thomas Gleixner wrote:
> Did you ever run with lockdep enabled
> (CONFIG_PROVE_LOCKING=y) ?

I have now recompiled the kernel with the above option turned
on. However now I get a hard lockup, without any error messages, as
soon as I run my code, instead of after a few hours. Then when I
reboot, most of the object and executable files of my application have
been replaced by empty files. These files had just been compiled
before running the application. So presumably they didn't get flushed
to disk before the crash.

Any ideas? I have tried both with and without nmi_watchdog=1, and the
result was the same; no messages on the serial console or in the
log. Just an immediate hard lockup on running my code.

Martin
