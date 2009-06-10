From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: RT-linux on MIPS..
Date: Wed, 10 Jun 2009 18:26:35 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0906101823430.3367@localhost.localdomain>
References: <74848fb40906090018m267594f7u6225cf77388f8b4c@mail.gmail.com> <3424dc900906091453h658c1f7cicfd5893251d13be3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tom Desouza <desouza.tom@gmail.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Tony Godshall <togo@of.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:34456 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755778AbZFJQ0u (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 10 Jun 2009 12:26:50 -0400
In-Reply-To: <3424dc900906091453h658c1f7cicfd5893251d13be3@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 9 Jun 2009, Tony Godshall wrote:
> 3. 2.6.24-rc2-rt1: msg#00081 linux.rt.user
> 
>       "rostedt@gandalf:~/linux-2.6.24-rc2$ tar -xf
> patch-2.6.24-rc2-rt1-broken-out.tar. bz2
> rostedt@gandalf:~/linux-2.6.24-rc2$ quilt push preempt-realtime-mips.
> ..."
>       osdir.com/ml/linux.rt.user/2007-11/msg00081.html

FYI, both 2.6.24-rt and 2.6.26-rt contain working MIPS support.

The current 2.6.29-rt series does not, as we did not come around to
port it forward. That's still on the todo list but probably will be
pushed into the next 2.6.30 based -rt series.

Thanks,

	tglx
