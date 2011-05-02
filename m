From: dashesy <dashesy@gmail.com>
Subject: Recommended motherboard
Date: Mon, 2 May 2011 12:05:17 -0600
Message-ID: <BANLkTinrbbV=8U8XDA1r+wNpbccVE7MsDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53231 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754344Ab1EBSF1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 2 May 2011 14:05:27 -0400
Received: by bwz15 with SMTP id 15so4844751bwz.19
        for <linux-rt-users@vger.kernel.org>; Mon, 02 May 2011 11:05:25 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I have tested the rt31 patch and everything seems great on my
off-the-shelf high-end Xeon desktop so far. I will continue testing
and let you know if I find any oopses or panics :)

We are in the process of upgrading our embedded system, now based on
an old ADEOS patch.
In the first step we need to substitute our soon to be obsolete
motherboard with a new long life industrial motherboard that works
with -rt (as we all hope it will be all in the mainline).
I know I will be going to a lengthy validation and testing phase to
choose the right motherboard, one that is reliable (for a medical
device), state-of-the-art (at least two cores) and of course -rt
compliant (some indication about thing like SMI or hrtimer issues for
example).

There are few book and plenty of resources out there. "Building
Embedded Linux Systems by Karim Yaghmour, et al" is a nice book, and
linux-rt archives, LWN and LKML have been the ultimate source to keep
up with the past (as much as I could) an learn the new. To find out
what might cause problem or what to avoid when designing the system.

It seems the manufacturers section of the OSADL Realtime QA Farm is a
good starting point to look for motherboards if one is concerned about
the latency plots, however,
That would be great if there was some sort of -rt compliance
certificate or tag, issued by OSADL (one organization that I can think
of). I believe, this might generate some revenue for the project, and
some ease of mind for developers who want to start a fresh design.

I appreciate any comments or suggestion about the motherboard.

Thanks
dashesy
