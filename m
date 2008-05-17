From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.24.7-rt5
Date: Sat, 17 May 2008 00:25:52 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0805170023270.28686@gandalf.stny.rr.com>
References: <1210985943.14697.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
To: Gregory Haskins <ghaskins@novell.com>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:37898 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbYEQE0F (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 17 May 2008 00:26:05 -0400
In-Reply-To: <1210985943.14697.10.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Greg,

Your patch "sched: push rt tasks only if newly activated tasks have been
added" has caused rt-migrate-test to fail. So I just released 2.6.24.7-rt6
without that patch.

-- Steve

