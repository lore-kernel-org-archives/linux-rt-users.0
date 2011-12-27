From: Mike Galbraith <efault@gmx.de>
Subject: Re: 3.0.14-rt31 + 64 cores = very bad jitter == highly
 synchronized tick?
Date: Tue, 27 Dec 2011 07:40:44 +0100
Message-ID: <1324968044.5217.103.camel@marge.simson.net>
References: <1324717569.5025.73.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Ingo Molnar <mingo@elte.hu>
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:33729 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751429Ab1L0Gkt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 27 Dec 2011 01:40:49 -0500
In-Reply-To: <1324717569.5025.73.camel@marge.simson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 2011-12-24 at 10:06 +0100, Mike Galbraith wrote:

> Has anything been done between 33 and 3.0 that would account for this?

Um, like af5ab277d for instance.

Arjan is right that this contention trouble doesn't happen with nohz..
but low jitter doesn't happen with nohz either.

	-Mike

