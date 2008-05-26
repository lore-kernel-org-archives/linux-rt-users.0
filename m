From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH RT] remove user_trace_stop
Date: Mon, 26 May 2008 11:01:22 +0200
Message-ID: <20080526090122.GD13529@elte.hu>
References: <Pine.LNX.4.58.0805240217130.1841@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Clark Williams <clark.williams@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:38808 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751112AbYEZJBg (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 26 May 2008 05:01:36 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0805240217130.1841@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


* Steven Rostedt <rostedt@goodmis.org> wrote:

> [ Doing a full config compile I came up with this ]
> 
> Remove user_trace_stop that was more of a hack to debug xrun 
> latencies.

btw., would be nice to have an ftrace/xrun or ftrace/audio plugin which 
would be for the targeted tracing of sound latencies.

	Ingo
