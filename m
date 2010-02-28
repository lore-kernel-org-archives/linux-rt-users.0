From: ulmo@sonic.net
Subject: 2.6.33-rt4 core2duo oopses:  what method to catch
Date: Sun, 28 Feb 2010 03:49:38 -0800
Message-ID: <edada484761252d21f1ea67c507f6e98.squirrel@webmail.sonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: ulmo@sonic.net
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from a.mail.sonic.net ([64.142.16.245]:50296 "EHLO a.mail.sonic.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752410Ab0B1Ltk (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 28 Feb 2010 06:49:40 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I'm getting kernel faults in 2.6.33-rt4 on a core 2 duo.  It takes a
moment to hard-crash, so there's a chance for the output to be diagnosed. 
A few questions regarding that:

Please point me the way to best get the diagnostic data (kernel trace).

There used to be utilities to use System.map to give names to traces (like
sysklogd).  There also used to be a built-in method for System.map so the
kernel could do that.  What's the option?  What are my options?  I
currently use metalog for the syslog daemon.

What's the easiest way to write the oops to disk while in the initrd?  I'm
getting the oopses while it's doing reiserfsck, and I only have a bit of
room in /boot to stick some output.  Is there a way to log to /boot the
oopses, with some small initrd-fitting binary that will cull kernel
logging for those and write them out?  Just a standard logger?

After that I can try to get some output for us to look at.  Thanks.

