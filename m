From: "Peter W. Morreale" <pmorreale@novell.com>
Subject: Re: [PATCH [RT] 00/14] RFC - adaptive real-time locks
Date: Thu, 21 Feb 2008 15:42:06 -0700
Message-ID: <1203633726.4232.67.camel@hermosa.morrealenet>
References: <20080221152504.4804.8724.stgit@novell1.haskins.net>
	 <20080221212420.GA20953@elte.hu>
	 <1203631966.4232.62.camel@hermosa.morrealenet>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Gregory Haskins <ghaskins@novell.com>, a.p.zijlstra@chello.nl,
	tglx@linutronix.de, rostedt@goodmis.org,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bill.huey@gmail.com, kevin@hilman.org, cminyard@mvista.com,
	dsingleton@mvista.com, dwalker@mvista.com, npiggin@suse.de,
	dsaxena@plexity.net, ak@suse.de, gregkh@suse.de,
	sdietrich@novell.com, mkohari@novell.com
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:50713 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316AbYBUWmO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 Feb 2008 17:42:14 -0500
In-Reply-To: <1203631966.4232.62.camel@hermosa.morrealenet>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2008-02-21 at 15:12 -0700, Peter W. Morreale wrote:

> True, the ticket spinlock certainly adds to the throughput results we
> have seen.  However, the results without the ticket patch are still very
> significant.   (IIRC, 500-600MB/s instead of the ~730MB/s advertised) We
> can easily re-gen the previous results for an apples-to-apples
> comparison.
> 

I misspoke in the above.  Greg is correct.  Without the ticket lock
patch we see an *improvement* in throughput, not a decrease.  

Sorry for any confusion.

Best,
-PWM
