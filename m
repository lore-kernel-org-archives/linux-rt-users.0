From: Daniel Bristot de Oliveira <daniel@bristot.me>
Subject: Re: [RFC][PATCH 0/4] tracing: Add new hwlat_detector tracer
Date: Thu, 23 Apr 2015 17:43:43 -0300
Message-ID: <5539597F.1060805@bristot.me>
References: <20150423190825.714359844@goodmis.org> <alpine.DEB.2.11.1504232148520.13914@nanos> <20150423160925.7d108eaa@gandalf.local.home> <alpine.DEB.2.11.1504232211540.13914@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Carsten Emde <C.Emde@osadl.org>,
	Daniel Wagner <wagi@monom.org>, Jon Masters <jcm@redhat.com>,
	Clark Williams <williams@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtpi82.kinghost.net ([189.38.86.82]:44862 "EHLO
	smtpi82.kinghost.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030581AbbDWUn6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 23 Apr 2015 16:43:58 -0400
In-Reply-To: <alpine.DEB.2.11.1504232211540.13914@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 04/23/2015 05:21 PM, Thomas Gleixner wrote:
> I know of a SMI event counter which is available on newer CPUs and
> Intel promised to add a SMI cycle counter as well. I have no idea
> whether that one ever materialized. PeterZ should know.

The turbostat shows how many SMIs happened during a period. To do it, it
reads the 'MSR_SMI_COUNT' counter. The code's comment says this counter
is there since Nehalem.
