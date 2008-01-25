From: Daniel Walker <dwalker@mvista.com>
Subject: Re: Use the RT Latency Trace? - LET ME KNOW!
Date: Thu, 24 Jan 2008 18:51:23 -0800
Message-ID: <1201229483.18044.1.camel@imap.mvista.com>
References: <Pine.LNX.4.58.0801241049280.31533@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:62964 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017AbYAYCwV (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 24 Jan 2008 21:52:21 -0500
In-Reply-To: <Pine.LNX.4.58.0801241049280.31533@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Thu, 2008-01-24 at 15:36 -0500, Steven Rostedt wrote:
> Hi all,
> 
> I'm about to gut the RT latency tracer with the version I'm pushing
> upstream. This will be some of the changes:
> 

Do you have all the functionality of the prior tracer ? Specifically the
histogram support .. I can vouch for the fact that it's getting used.. I
would prefer you don't gut the current tracer unless you have the same
level of functionality ..

Daniel
