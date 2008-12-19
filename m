From: "=?ISO-8859-1?Q?Fr=E9d=E9ric_Weisbecker?=" <fweisbec@gmail.com>
Subject: Re: [patch 1/7] ftrace: fix task state printout
Date: Fri, 19 Dec 2008 17:25:05 +0100
Message-ID: <c62985530812190825k4e4f5a7apa37e1ab4bc35753a@mail.gmail.com>
References: <20081219155504.735865178@linutronix.de>
	 <20081219155555.919550408@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>, "Ingo Molnar" <mingo@elte.hu>,
	"Steven Rostedt" <rostedt@goodmis.org>,
	"Peter Zijlstra" <peterz@infradead.org>,
	"Clark Williams" <clark.williams@gmail.com>,
	"Gregory Haskins" <ghaskins@novell.com>,
	Linux-rt <linux-rt-users@vger.kernel.org>
To: "Thomas Gleixner" <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:48339 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337AbYLSQZH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 19 Dec 2008 11:25:07 -0500
In-Reply-To: <20081219155555.919550408@linutronix.de>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Thomas,

2008/12/19 Thomas Gleixner <tglx@linutronix.de>:
> Impact: tracer task state decoding is wrong, size check is buggy
>
> The tracing code has interesting varieties of printing out task state.
> Unfortunalely only one of the instances is correct as it copies the
> code from sched.c:sched_show_task(). The others are plain wrong as
> they treatthe bitfield as an integer offset into the character
> array. Also the size check of the character array is wrong as it
> includes the trailing \0.
>
> Use a common state decoder inline which does the Right Thing.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


You've already sent it out. It has been applied on -tip :-)
