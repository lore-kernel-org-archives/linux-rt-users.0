From: Remy Bohmer <linux@bohmer.net>
Subject: Re: Hard lockup with 2.6.24.7-rt26 on x86
Date: Tue, 3 Feb 2009 20:20:45 +0100
Message-ID: <3efb10970902031120g21b4586k4e7f2f03bbca6c77@mail.gmail.com>
References: <37144.1233608136@vtxmail.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: m.luescher@vtxmail.ch
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qy0-f11.google.com ([209.85.221.11]:45068 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756481AbZBCTUr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 3 Feb 2009 14:20:47 -0500
Received: by qyk4 with SMTP id 4so2827154qyk.13
        for <linux-rt-users@vger.kernel.org>; Tue, 03 Feb 2009 11:20:45 -0800 (PST)
In-Reply-To: <37144.1233608136@vtxmail.ch>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Matthias,

2009/2/2  <m.luescher@vtxmail.ch>:
> Dear Linux rt users
>
> On two different desktop PC (both Core 2 Duo) and on a notebook (Core Duo) the kernel (2.6.24.7-rt26, CONFIG_X86_32)
> locks up hard under a certain rt load. The failure can be reproduced reliably with the following command:

In noticed some hangups too while using 2.6.24.7-rt26, while
2.6.24.7-rt20 was running fine.
I can reproduce it here on an ARM11 core, when
CONFIG_DEBUG_LOCKING_API_SELFTESTS is set the system hangs during boot
on rt26, while it boots properly on rt20. So, there is a regression
here.
I did not find the time yet to bisect it to the offending RT-patch.

Kind regards,

Remy
