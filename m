From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: trace/latency-hist: Consider new argument when probing the
 sched_switch tracer
Date: Fri, 15 Jan 2016 09:05:38 -0500
Message-ID: <20160115090538.29674790@gandalf.local.home>
References: <568B8B37.9070804@osadl.org>
	<20160113154526.GJ29964@linutronix.de>
	<20160113105135.3334856c@gandalf.local.home>
	<56967681.9070204@linutronix.de>
	<5698D86F.607@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Linux RT Users <linux-rt-users@vger.kernel.org>
To: Carsten Emde <C.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0095.hostedemail.com ([216.40.44.95]:53515 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751874AbcAOOFl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Jan 2016 09:05:41 -0500
In-Reply-To: <5698D86F.607@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 15 Jan 2016 12:30:55 +0100
Carsten Emde <C.Emde@osadl.org> wrote:


> So the question is whether you still encourage me to write the RFC for
> upstream inclusion of the current code after some polishing - maybe, in the
> hope that someone will come up with the framework during RFC discussion -
> or we better wait, since writing an RFC for hopeless code really doesn't
> make sense.

Note, the latency measurement code is basically the last code that is
practically untouched from what was in the original latency-tracer code
from the -rt patch. It's been on my todo list to update it for some
time. There's a few things lacking with it. I want to improve that.

Perhaps this should be done before pushing in a histogram
infrastructure on top of it. I'll move this up on my priority list.

-- Steve

