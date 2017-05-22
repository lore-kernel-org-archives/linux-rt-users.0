From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [patch 2/2] MM: allow per-cpu vmstat_threshold and vmstat_worker
 configuration
Date: Mon, 22 May 2017 18:13:41 -0300
Message-ID: <20170522211337.GA4718@amt.cnet>
References: <20170512154026.GA3556@amt.cnet>
 <alpine.DEB.2.20.1705121103120.22831@east.gentwo.org>
 <20170512161915.GA4185@amt.cnet>
 <alpine.DEB.2.20.1705121154240.23503@east.gentwo.org>
 <20170515191531.GA31483@amt.cnet>
 <alpine.DEB.2.20.1705160825480.32761@east.gentwo.org>
 <20170519143407.GA19282@amt.cnet>
 <alpine.DEB.2.20.1705191205580.19631@east.gentwo.org>
 <20170520082646.GA16139@amt.cnet>
 <alpine.DEB.2.20.1705221137001.12282@east.gentwo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luiz Capitulino <lcapitulino@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Rik van Riel <riel@redhat.com>,
        Linux RT Users <linux-rt-users@vger.kernel.org>, cmetcalf@mellanox.com
To: Christoph Lameter <cl@linux.com>
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1705221137001.12282@east.gentwo.org>
Sender: owner-linux-mm@kvack.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, May 22, 2017 at 11:38:02AM -0500, Christoph Lameter wrote:
> On Sat, 20 May 2017, Marcelo Tosatti wrote:
> 
> > > And you can configure the interval of vmstat updates freely.... Set
> > > the vmstat_interval to 60 seconds instead of 2 for a try? Is that rare
> > > enough?
> >
> > Not rare enough. Never is rare enough.
> 
> Ok what about the other stuff that must be going on if you allow OS
> activity like f.e. the tick, scheduler etc etc.

Yes these are also problems... but we're either getting rid of them or
reducing their impact as much as possible.

vmstat_update is one member of the problematic set.

I'll get you the detailed IPI measures, hold on...

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
