From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH] release quicklist before free_page
Date: Mon, 23 Jul 2007 11:27:12 -0700
Message-ID: <1185215232.2573.72.camel@imap.mvista.com>
References: <20070723152129.036573829@mvista.com>
	 <1185208378.8197.20.camel@twins> <1185207979.2573.55.camel@imap.mvista.com>
	 <20070723182301.GA27789@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Peter Zijlstra <peterz@infradead.org>, paulmck@linux.vnet.ibm.com,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:33347 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756375AbXGWSid (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 23 Jul 2007 14:38:33 -0400
In-Reply-To: <20070723182301.GA27789@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2007-07-23 at 20:23 +0200, Ingo Molnar wrote:
> 
> how about: "if you've got some time then please also add a few comments, 
> because the code was quite non-obvious to me and I misunderstood it when 
> I tried to fix it. Thanks."

Not exactly what I was thinking of .. More like,

"LOCKING NOTE: This code uses the fact that get_cpu_var disables
preemption to maintain cpu affinity during the call to free_page()
otherwise it might free pages on another cpu."

(btw, your comment above comes off very snide, which I don't appreciate.
I haven't done anything that remotely warrants that.)

Daniel
