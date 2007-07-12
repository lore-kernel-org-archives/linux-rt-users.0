From: Sven-Thorsten Dietrich <sdietrich@novell.com>
Subject: Re: Forward port of latest RT patch (2.6.21.5-rt20) to 2.6.22
	available
Date: Thu, 12 Jul 2007 13:21:40 -0700
Message-ID: <1184271700.24942.175.camel@sx.thebigcorporation.com>
References: <46961E080200005A000276AE@mcclure.wal.novell.com>
	 <20070712163341.GA9622@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Gregory Haskins <ghaskins@novell.com>, jim.houston@ccur.com,
	joe.korty@ccur.com, rostedt@goodmis.org, tglx@linutronix.de,
	dwalker@mvista.com, David Bahi <DBahi@novell.com>,
	Moiz Kohari <MKohari@novell.com>, dsaxena@plexity.net,
	williams@redhat.com, abogani@texware.it,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:52480 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756505AbXGLUoa (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Jul 2007 16:44:30 -0400
In-Reply-To: <20070712163341.GA9622@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2007-07-12 at 18:33 +0200, Ingo Molnar wrote:
> * Gregory Haskins <ghaskins@novell.com> wrote:
> 

> 
> ok. Make sure you check rt2 as well - and note that it's not fully 
> bisectable with PREEMPT_RT enabled (but should probably be fully 
> bisectable with PREEMPT_RT disabled). So check out first whether the 
> problem still persists with PREEMPT_RT disabled.
> 

There is also a regression on my Dell 690 dual-quadcore

rt2 hangs like a brick at boot. rt1 comes up fine.

I am configured at max 8 CPUs so it doesn't seem to be an out of memory
situation.

I'll look at the interdiffs and see what I can find.

Regards,

Sven

> 	Ingo
-- 
Sven-Thorsten Dietrich
+1 415 694-2930
( www.novell.com/linux )
