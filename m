From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [patch 2/2] MM: allow per-cpu vmstat_threshold and vmstat_worker
 configuration
Date: Fri, 12 May 2017 09:27:06 -0300
Message-ID: <20170512122704.GA30528@amt.cnet>
References: <20170425135717.375295031@redhat.com>
 <20170425135846.203663532@redhat.com>
 <20170502102836.4a4d34ba@redhat.com>
 <20170502165159.GA5457@amt.cnet>
 <20170502131527.7532fc2e@redhat.com>
 <alpine.DEB.2.20.1705111035560.2894@east.gentwo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luiz Capitulino <lcapitulino@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Rik van Riel <riel@redhat.com>,
        Linux RT Users <linux-rt-users@vger.kernel.org>, cmetcalf@mellanox.com
To: Christoph Lameter <cl@linux.com>
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1705111035560.2894@east.gentwo.org>
Sender: owner-linux-mm@kvack.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, May 11, 2017 at 10:37:07AM -0500, Christoph Lameter wrote:
> On Tue, 2 May 2017, Luiz Capitulino wrote:
> 
> > Ah, OK. Got this now. I'll give this patch a try. But I think we want
> > to hear from Christoph (who worked on reducing the vmstat interruptions
> > in the past).
> 
> A bit confused by this one. The vmstat worker is already disabled if there
> are no updates. Also the patches by Chris Metcalf on data plane mode add a
> prctl to quiet the vmstat workers.
> 
> Why do we need more than this?

If there are vmstat statistic updates on a given CPU, and you don't
want intervention from the vmstat worker, you change the behaviour of
stat data collection to directly write to the global structures (which
disables the performance optimization of collecting data in per-cpu
counters).

This way you can disable vmstat worker (because it causes undesired
latencies), while allowing vmstatistics to function properly.

The prctl from Chris Metcalf patchset allows one to disable vmstat
worker per CPU? If so, they replace the functionality of the patch
"[patch 3/3] MM: allow per-cpu vmstat_worker configuration" 
of the -v2 series of my patchset, and we can use it instead.

Is it integrated already?

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
