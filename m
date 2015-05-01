From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [RFD 5/5] tracing: Add trace_irqsoff tracepoints
Date: Thu, 30 Apr 2015 21:14:52 -0500
Message-ID: <1430446492.17922.32.camel@picadillo>
References: <1430388385-29558-1-git-send-email-daniel.wagner@bmw-carit.de>
	 <1430388385-29558-6-git-send-email-daniel.wagner@bmw-carit.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Carsten Emde <C.Emde@osadl.org>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Daniel Wagner <daniel.wagner@bmw-carit.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:56826 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751211AbbEACPL (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 30 Apr 2015 22:15:11 -0400
In-Reply-To: <1430388385-29558-6-git-send-email-daniel.wagner@bmw-carit.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2015-04-30 at 12:06 +0200, Daniel Wagner wrote:
> Finally we place a few tracepoint at the end of critical section. With
> the hist trigger in place we can generate the plots.
> 
> There are a few drawbacks compared to the latency_hist.patch [1]
> 
> The latency plots contain the values from all CPUs. In theory you
> can also filter with something like
> 
> 'hist:key=latency.bucket:val=hitcount:sort=latency if cpu==0'
> 
> but I haven't got this working. I didn't spend much time figuring out
> why this doesn't work. Even if the above is working you still

I think it doesn't work because the tracepoint doesn't actually have a
'cpu' field to use in the filter...

Tom

