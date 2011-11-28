From: Andreas O <andreas2025@gmail.com>
Subject: Linux RT and Jffs2
Date: Mon, 28 Nov 2011 02:45:26 +0000
Message-ID: <CAAVaN8wdd3HjfwzqBeBm0LiMsz93FfJ=ubp6iz2p4gui7sw=EA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59041 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755929Ab1K1Cp1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 27 Nov 2011 21:45:27 -0500
Received: by bke11 with SMTP id 11so7857884bke.19
        for <linux-rt-users@vger.kernel.org>; Sun, 27 Nov 2011 18:45:26 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear List,

I am using a real-time 2.6.33.7 version on ARM and I have noticed some
problems with the NAND. After a power cycle I see messages like
"mtd->read( ) returned ECC Error." It is quite strange.
Example:

mtd->read(0x1fba0 bytes from 0x4e0460) returned ECC error
mtd->read(0x1d520 bytes from 0x4e2ae0) returned ECC error

Initially, I make write to the NAND the jff2 filesystem and when I
boot for first time
there are no ECC errors at all. After the first power cycler, some ECC
errors will appear.
If I do a second power cycle, more may be would appear.
If I repeat again the same procedure, writing again the rootfile
system to the NAND, after a power cycle the ECC errors will come from
the same region (0x4exxxx). I have used different types of NAND, and
the problem is the same.

I think it might have to do with a combination of the RT and jffs2,
Jffs2 garbage collector thread. The GC thread might need priority
change as it takes the lock for performing the scan and may sleep for
longer within the RT world. Therefore writes do not happen that often,
therefore those ECC errors from un-flushed wbuf buffers.

Have you seen similar behaviour before with RT and Jffs2?

Thank you
A
