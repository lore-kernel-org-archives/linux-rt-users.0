From: Joe Korty <joe.korty@ccur.com>
Subject: network bug in 3.6.11.7
Date: Tue, 20 Aug 2013 13:15:14 -0400
Message-ID: <20130820171514.GA16405@tsunami.ccur.com>
Reply-To: Joe Korty <joe.korty@ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from flusers.ccur.com ([173.221.59.2]:56914 "EHLO gamx.iccur.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751761Ab3HTRPV (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 20 Aug 2013 13:15:21 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Steve,
I get the following warnings when compiling 3.6.11.7-rt39:

  net/core/sock.c:212: warning: excess elements in array initializer
  net/core/sock.c:212: warning: (near initialization for 'af_family_key_strings')
  net/core/sock.c:228: warning: excess elements in array initializer
  net/core/sock.c:228: warning: (near initialization for 'af_family_slock_key_strings')
  net/core/sock.c:244: warning: excess elements in array initializer
  net/core/sock.c:244: warning: (near initialization for 'af_family_clock_key_strings')

I traced it down to the patch
  "net/core/sock.c: add missing VSOCK string in af_family_*_key_strings"

This is really a fixup to a much larger patch (6,000 lines) in mainline
called "VSOCK: Introduce VM Sockets", which was not backport to 3.6.11.7.

It might be best for 3.6.11.7 to to drop the VSOCK fixup patch.

Regards,
Joe
