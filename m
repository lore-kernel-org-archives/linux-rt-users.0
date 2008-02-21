From: "Bill Huey (hui)" <bill.huey@gmail.com>
Subject: Re: [PATCH [RT] 00/14] RFC - adaptive real-time locks
Date: Thu, 21 Feb 2008 14:53:56 -0800
Message-ID: <9810cff90802211453l3f62200ey52edfeb9d84d7@mail.gmail.com>
References: <20080221152504.4804.8724.stgit@novell1.haskins.net>
	 <20080221212420.GA20953@elte.hu>
	 <9810cff90802211333k3d19ca2exf28c18ae5a2b86a@mail.gmail.com>
	 <20080221214219.GA27209@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Gregory Haskins" <ghaskins@novell.com>, a.p.zijlstra@chello.nl,
	tglx@linutronix.de, rostedt@goodmis.org,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	kevin@hilman.org, cminyard@mvista.com, dsingleton@mvista.com,
	dwalker@mvista.com, npiggin@suse.de, dsaxena@plexity.net,
	ak@suse.de, gregkh@suse.de, sdietrich@novell.com,
	pmorreale@novell.com, mkohari@novell.com
To: "Ingo Molnar" <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.182]:2246 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935476AbYBUWx6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 Feb 2008 17:53:58 -0500
Received: by el-out-1112.google.com with SMTP id v27so200882ele.23
        for <linux-rt-users@vger.kernel.org>; Thu, 21 Feb 2008 14:53:57 -0800 (PST)
In-Reply-To: <20080221214219.GA27209@elte.hu>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Feb 21, 2008 at 1:42 PM, Ingo Molnar <mingo@elte.hu> wrote:
>  I'd not exclude them fundamentally though, it's really the numbers that
>  matter. The code is certainly simple enough (albeit the .config and
>  sysctl controls are quite ugly and unacceptable - adaptive mutexes
>  should really be ... adaptive, with no magic constants in .configs or
>  else).
>
>  But ... i'm somewhat sceptic, after having played with spin-a-bit
>  mutexes before.

Yeah, it's yet another reason to get better instrumentation in -rt for
this purpose and why it's important to only log things in the slow
path so that the front end of the rtmutex doesn't see instrumentation
artifacts in the measurement. If I get a chance tonight, I'll extend
lockdep/lockstat for this purpose if peterz doesn't beat me to it. I
won't have access to the test harness to replicate this though.

bill
