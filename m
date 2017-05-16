From: Christoph Lameter <cl@linux.com>
Subject: Re: [patch 2/2] MM: allow per-cpu vmstat_threshold and vmstat_worker
 configuration
Date: Tue, 16 May 2017 08:37:11 -0500 (CDT)
Message-ID: <alpine.DEB.2.20.1705160825480.32761@east.gentwo.org>
References: <20170502102836.4a4d34ba@redhat.com> <20170502165159.GA5457@amt.cnet> <20170502131527.7532fc2e@redhat.com> <alpine.DEB.2.20.1705111035560.2894@east.gentwo.org> <20170512122704.GA30528@amt.cnet> <alpine.DEB.2.20.1705121002310.22243@east.gentwo.org>
 <20170512154026.GA3556@amt.cnet> <alpine.DEB.2.20.1705121103120.22831@east.gentwo.org> <20170512161915.GA4185@amt.cnet> <alpine.DEB.2.20.1705121154240.23503@east.gentwo.org> <20170515191531.GA31483@amt.cnet>
Content-Type: text/plain; charset=US-ASCII
Cc: Luiz Capitulino <lcapitulino@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Rik van Riel <riel@redhat.com>,
        Linux RT Users <linux-rt-users@vger.kernel.org>,
        cmetcalf@mellanox.com
To: Marcelo Tosatti <mtosatti@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from resqmta-ch2-04v.sys.comcast.net ([69.252.207.36]:45844 "EHLO
        resqmta-ch2-04v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752507AbdEPNhN (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 May 2017 09:37:13 -0400
In-Reply-To: <20170515191531.GA31483@amt.cnet>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 15 May 2017, Marcelo Tosatti wrote:

> > NOHZ already does that. I wanted to know what your problem is that you
> > see. The latency issue has already been solved as far as I can tell .
> > Please tell me why the existing solutions are not sufficient for you.
>
> We don't want vmstat_worker to execute on a given CPU, even if the local
> CPU updates vm-statistics.

Instead of responding you repeat describing what you want.

> Because:
>
>     vmstat_worker increases latency of the application
>        (i can measure it if you want on a given CPU,
>         how many ns's the following takes:

That still is no use case. Just a measurement of vmstat_worker. Pointless.

If you move the latency from the vmstat worker into the code thats
updating the counters then you will require increased use of atomics
which will increase contention which in turn will significantly
increase the overall latency.

> Why the existing solutions are not sufficient:
>
> 1) task-isolation patchset seems too heavy for our usecase (we do
> want IPIs, signals, etc).

Ok then minor delays from remote random events are tolerable?
Then you can also have a vmstat update.

> So this seems a little heavy for our usecase.

Sorry all of this does not make sense to me. Maybe get some numbers of of
an app with intensive OS access running with atomics vs vmstat worker?

NOHZ currently disables the vmstat worker when no updates occur. This is
applicable to DPDK and will provide a quiet vmstat worker free environment
if no statistics activity is occurring.

