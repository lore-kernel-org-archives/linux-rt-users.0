From: "Mark Knecht" <markknecht@gmail.com>
Subject: Re: 2.6.24-rc7-rt2
Date: Mon, 14 Jan 2008 12:02:21 -0800
Message-ID: <5bdc1c8b0801141202p68dcb452yd2cb55fde9336521@mail.gmail.com>
References: <1200336080.318.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	"Ingo Molnar" <mingo@elte.hu>,
	"Thomas Gleixner" <tglx@linutronix.de>
To: "Steven Rostedt" <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hs-out-0708.google.com ([64.233.178.240]:36950 "EHLO
	hs-out-2122.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752800AbYANUCX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Jan 2008 15:02:23 -0500
Received: by hs-out-2122.google.com with SMTP id 54so2021375hsz.5
        for <linux-rt-users@vger.kernel.org>; Mon, 14 Jan 2008 12:02:22 -0800 (PST)
In-Reply-To: <1200336080.318.8.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Jan 14, 2008 10:41 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> We are pleased to announce the 2.6.24-rc7-rt2 tree, which can be
> downloaded from the location:
>

Up and running here:

mark@lightning ~ $ uname -a
Linux lightning 2.6.24-rc7-rt2 #1 PREEMPT RT Mon Jan 14 11:18:04 PST
2008 x86_64 AMD Athlon(tm) 64 Processor 3000+ AuthenticAMD GNU/Linux
mark@lightning ~ $

I must learn how to use some of the test tools so I can do better
testing for you guys. I see no problems in dmesg but in
/var/log/messages I spotted this:

Jan 14 11:56:54 lightning sshd[5915]: Server listening on :: port 22.
Jan 14 11:56:54 lightning sshd[5915]: error: Bind to port 22 on
0.0.0.0 failed: Address already in use.

Scanning back through /var/log/messages I don't see that in earlier kernels.

- Mark
