From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.33-rt4 core2duo oopses: what method to catch
Date: Mon, 1 Mar 2010 14:11:11 +0100 (CET)
Message-ID: <alpine.LFD.2.00.1003011403250.4245@localhost.localdomain>
References: <edada484761252d21f1ea67c507f6e98.squirrel@webmail.sonic.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: rt-users <linux-rt-users@vger.kernel.org>,
	Frederic Weisbecker <fweisbec@gmail.com>
To: ulmo@sonic.net
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:43478 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751316Ab0CANLX (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 1 Mar 2010 08:11:23 -0500
In-Reply-To: <edada484761252d21f1ea67c507f6e98.squirrel@webmail.sonic.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, 28 Feb 2010, ulmo@sonic.net wrote:

> I'm getting kernel faults in 2.6.33-rt4 on a core 2 duo.  It takes a
> moment to hard-crash, so there's a chance for the output to be diagnosed. 

Does the same problem happen with vanilla 2.6.33 ?
 
> Please point me the way to best get the diagnostic data (kernel trace).
> 
> There used to be utilities to use System.map to give names to traces (like
> sysklogd).  There also used to be a built-in method for System.map so the
> kernel could do that.  What's the option?  What are my options?  I
> currently use metalog for the syslog daemon.

CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_EXTRA_PASS=y

CONFIG_DEBUG_BUGVERBOSE=y
 
> What's the easiest way to write the oops to disk while in the initrd?  I'm
> getting the oopses while it's doing reiserfsck, and I only have a bit of
> room in /boot to stick some output.  Is there a way to log to /boot the
> oopses, with some small initrd-fitting binary that will cull kernel
> logging for those and write them out?  Just a standard logger?
> 
> After that I can try to get some output for us to look at.  Thanks.

Either serial console - requires a serial port - or netconsole. For
both you need a second computer to log the output.

Thanks,

	tglx
