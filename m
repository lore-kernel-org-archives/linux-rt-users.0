From: Andreas O <andreas2025@gmail.com>
Subject: clockevents on ARM9
Date: Fri, 4 Nov 2011 22:00:27 +0000
Message-ID: <CAAVaN8zzg1p8F7Q+nD-yfMdEwnJCWJOesE-TWmcLrgXv7dPTxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:65326 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753413Ab1KDWA3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 4 Nov 2011 18:00:29 -0400
Received: by bke11 with SMTP id 11so2386323bke.19
        for <linux-rt-users@vger.kernel.org>; Fri, 04 Nov 2011 15:00:28 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear List,

I have a question, and I hope someone can give me some ideas to see
what is happening.

I am using an ARM926 with the Real-Time Patch for 2.6.33 kernel. And I
observe an interesting behaviour from the clockevents.
HZ is fixed at 100, and Dynamic tick is switched off. I have a small
driver that generates interrupts every 2-4msec. When I don't use the
driver, clockevents (interrupts) are about 100/sec, but when I used
the driver the clockevents will be about 1000/sec.  Is this something
that you would expect to happen with the Real-Time patch?

TIA,
Andreas
