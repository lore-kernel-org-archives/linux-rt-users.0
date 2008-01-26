From: "Jim Beck" <4805455@gmail.com>
Subject: X86 Pentium M platform troubles at low temperatures
Date: Fri, 25 Jan 2008 16:36:38 -0800
Message-ID: <ed6c89dc0801251636i13a020e4s68a14b969003568f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:34406 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754306AbYAZAgk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 25 Jan 2008 19:36:40 -0500
Received: by py-out-1112.google.com with SMTP id u52so1374694pyb.10
        for <linux-rt-users@vger.kernel.org>; Fri, 25 Jan 2008 16:36:38 -0800 (PST)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This may sound strange, but we have a Pentium M system running
2.6.20-rt5 that fails to boot all the way (fails at spawning mingetty
- then various strange behaviors) when the system is at -10 degrees C
or less.  Oddly, it works fine if we used *unpatched* Linux.  My only
guess can be that there is some hard-coded constants with regards to
timers or clocks that somehow comes into play because of  some
oscillator frequency change.  I was wondering if any of the authors
can comment on any magic numbers or such that might be related to
this.

Of course I will let you know if I discover that I am crazy in the
next few days.  I just wanted to run this by you to see if anyone else
had experience with this.
