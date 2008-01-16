From: "Mark Knecht" <markknecht@gmail.com>
Subject: Re: 2.6.24-rc7-rt3
Date: Wed, 16 Jan 2008 11:44:01 -0800
Message-ID: <5bdc1c8b0801161144x62aa3f9bj868602db94b42570@mail.gmail.com>
References: <1200456773.318.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	"Ingo Molnar" <mingo@elte.hu>,
	"Thomas Gleixner" <tglx@linutronix.de>
To: "Steven Rostedt" <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.231]:7510 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752170AbYAPToG (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 16 Jan 2008 14:44:06 -0500
Received: by wr-out-0506.google.com with SMTP id c49so139350wra.1
        for <linux-rt-users@vger.kernel.org>; Wed, 16 Jan 2008 11:44:03 -0800 (PST)
In-Reply-To: <1200456773.318.14.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Jan 15, 2008 8:12 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> We are pleased to announce the 2.6.24-rc7-rt3 tree

Up and running here:

mark@lightning ~ $ uname -a
Linux lightning 2.6.24-rc7-rt3 #1 PREEMPT RT Wed Jan 16 11:06:11 PST
2008 x86_64 AMD Athlon(tm) 64 Processor 3000+ AuthenticAMD GNU/Linux
mark@lightning ~ $

Nothing of interest in dmesg. The issue I reported earlier about
/var/log/messages has been there for a long time without me noticing
it. I'm in 2.6.23-rt1 and I still see it so it has nothing to do with
the kernel as I'm sure you decided already.

Jan 16 11:12:55 lightning sshd[5915]: Server listening on :: port 22.
Jan 16 11:12:55 lightning sshd[5915]: error: Bind to port 22 on
0.0.0.0 failed: Address already in use.

Will continue testing as I get time.

Cheers,
Mark
