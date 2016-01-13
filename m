From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: trace/latency-hist: Consider new argument when probing the
 sched_switch tracer
Date: Wed, 13 Jan 2016 10:51:35 -0500
Message-ID: <20160113105135.3334856c@gandalf.local.home>
References: <568B8B37.9070804@osadl.org>
	<20160113154526.GJ29964@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Carsten Emde <C.Emde@osadl.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Linux RT Users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0045.hostedemail.com ([216.40.44.45]:56516 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750779AbcAMPvi (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 13 Jan 2016 10:51:38 -0500
In-Reply-To: <20160113154526.GJ29964@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 13 Jan 2016 16:45:26 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:


> Is it somehow possible to detect this kind of bugs at compile time? Is
> there an easy way to do this?

There should have been a warning. Wasn't there one?

> What is blocking the latency-hist tracer from entering mainline?

Has it been submitted. Like lots of things in -rt, it just takes the
effort of pushing out an RFC for inclusion.

-- Steve
