From: John Kacur <jkacur@redhat.com>
Subject: Re: Real-time projects that could use userspace RCU
Date: Tue, 11 May 2010 14:32:57 +0200
Message-ID: <AANLkTikLHsvs1LKAnFInWLkZUjHAVlM0evDT18jkb-NU@mail.gmail.com>
References: <20100511122140.GA11000@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: tglx@linutronix.de,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	linux-rt-users@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	Clark Williams <williams@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:52374 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756351Ab0EKMlT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 11 May 2010 08:41:19 -0400
Received: by ey-out-2122.google.com with SMTP id d26so321355eyd.19
        for <linux-rt-users@vger.kernel.org>; Tue, 11 May 2010 05:41:16 -0700 (PDT)
In-Reply-To: <20100511122140.GA11000@Krystal>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, May 11, 2010 at 2:21 PM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> Hi Thomas,
>
> Paul told me you were quite interested in the userspace RCU library when he told
> you about it (http://lttng.org/urcu). Do you have some userspace applications or
> libraries with real-time needs in mind that could use it ? We could help moving
> them to liburcu. The wait-free read-side is, as you certainly know, a
> characteristic of RCU that can be very useful to RT applications.
>
> [CCing linux-rt-users, as it seems appropriate to ask them too.]
>
> Thanks,

Do you have any kind of benchmarks? If you had something appropriate
we could add it to the rt-tests suite (which includes cyclictest). Not
only would this provide an objective measure, but it could also act as
a reference implementation for userspace programmers.

See here.
git clone git://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rt-tests.git

cyclictest is the original program written by Thomas, maintained by
Clark Williams now. Most - but not all, of the additional tests are
modelled after this program, so you might want to have a look at that
if you're not already familiar with it.

Thanks

John
