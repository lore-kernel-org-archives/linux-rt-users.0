From: ulmo@sonic.net
Subject: 2.6.29.1-rt4 first stable RT since 2.6.25.8-rt7 on AMD64 sys
Date: Thu, 9 Apr 2009 01:01:25 -0700 (PDT)
Message-ID: <fd55b1a034eac9f0d40d6a8bd575765b.squirrel@webmail.sonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: ulmo@sonic.net
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from b.mail.sonic.net ([64.142.19.5]:39490 "EHLO b.mail.sonic.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753424AbZDIINg (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 9 Apr 2009 04:13:36 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I found out that my Asterisk system works beautifully with Linux RT
patches, but basically not at all (unacceptable) without.  Unfortunately,
all the dozen or so RT patches for kernels between 2.6.25.8-rt7 and
2.6.29.1-rt4 crashed so soon in the boot scripts that I never had a chance
to incrementally find out what programs were causing the crashes; I think
it was deeper than that, anyway, because it happened so fast, and even in
single user mode from what I recall.

I am very happy to report that my Asterisk system is working as expected
with RT settings, in 2.6.29.1-rt4.  Thank you for fixing whatever bug you
found that caused that fix.  I have no idea whether it is a Linux kernel
or RT patch fix.

I must admit that I also recently upgraded my Gentoo packages, as I
usually do periodically.  If this was a libc bug or something causing a
kernel crash, or something to that effect, well, then, I'm happy to have a
temporary reprieve.  I doubt it's that, though.  What makes more sense is
that I did see GCC got upgraded in my system just prior to the new RT
kernel build, so maybe a GCC bug was causing the crashes before, and since
I compiled the new kernel and all modules with the new GCC, that may have
affected it too.  GCC version is now gcc-4.3.2-r3, and I think before it
was gcc-4.1.2.

Sincerely,
Brad Allen

