From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFD 5/5] tracing: Add trace_irqsoff tracepoints
Date: Thu, 30 Apr 2015 22:54:11 -0400
Message-ID: <20150430225411.37cbb7cc@grimm.local.home>
References: <1430388385-29558-1-git-send-email-daniel.wagner@bmw-carit.de>
	<1430388385-29558-6-git-send-email-daniel.wagner@bmw-carit.de>
	<1430446492.17922.32.camel@picadillo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>,
	Ingo Molnar <mingo@redhat.com>,
	Carsten Emde <C.Emde@osadl.org>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.227]:5119 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751168AbbEACyE (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 30 Apr 2015 22:54:04 -0400
In-Reply-To: <1430446492.17922.32.camel@picadillo>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 30 Apr 2015 21:14:52 -0500
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:


> > 'hist:key=latency.bucket:val=hitcount:sort=latency if cpu==0'
> > 
> > but I haven't got this working. I didn't spend much time figuring out
> > why this doesn't work. Even if the above is working you still
> 
> I think it doesn't work because the tracepoint doesn't actually have a
> 'cpu' field to use in the filter...

Perhaps we should add special fields that don't use the tracepoint
field, but can use generically know fields that are always known when
the tracepoint is triggered. COMM could be one, as well as CPU.

-- Steve
