From: "Remy Bohmer" <l.pinguin@gmail.com>
Subject: [Question] Hooks for scheduler tracing (CFS)
Date: Mon, 16 Jul 2007 21:46:46 +0200
Message-ID: <3efb10970707161246se06ab22i32872cfe6fa4f2f6@mail.gmail.com>
Reply-To: linux@bohmer.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: mathieu.desnoyers@polymtl.ca, "Ingo Molnar" <mingo@elte.hu>
To: LKML <linux-kernel@vger.kernel.org>,
	RT-Users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:38592 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614AbXGPTqs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 Jul 2007 15:46:48 -0400
Received: by py-out-1112.google.com with SMTP id d32so2486563pye
        for <linux-rt-users@vger.kernel.org>; Mon, 16 Jul 2007 12:46:46 -0700 (PDT)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello,

I am looking for some tool/kernel machanism that enables me to track
every schedule change on the CFS scheduler of the RT-kernel for some
period of time.
Thus a tool that gives me an overview after some time which task got
"scheduled in/out" at "which timestamp" and at "which CPU". ( I need
the raw data)

In a far past (on Montavista kernels) I used LTT for this to log for
some time with only the SCHED_CHANGE filter and text output. But, I
cannot find any LTT(ng) support for any RT-kernel, and support for the
new CFS (like in 2.6.22.1-rt4) is even harder.

So I was wondering if anybody knows some tool/kernel mechanism which
can do this?
If not, I will build a kernel extension for it myself (new extension
to 'latency_trace' ?)
In that case can anybody with in depth CFS scheduler knowledge please
point me which hooks are safe to use for this?

I need it to get a detailed insight in my RT-system with its RT and
non-RT applications.
Thus to know when a certain task gets scheduled (and to calculate its
per thread min/max/avg latencies), which task preempts another task,
and to get a complete overview of what the RT system (and scheduler)
is doing during time etc.


Kind Regards,

Remy B=F6hmer
