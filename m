From: Christoph Lameter <cl@linux.com>
Subject: Re: [patch 2/2] MM: allow per-cpu vmstat_threshold and vmstat_worker
 configuration
Date: Mon, 22 May 2017 11:38:02 -0500 (CDT)
Message-ID: <alpine.DEB.2.20.1705221137001.12282@east.gentwo.org>
References: <20170512122704.GA30528@amt.cnet> <alpine.DEB.2.20.1705121002310.22243@east.gentwo.org> <20170512154026.GA3556@amt.cnet> <alpine.DEB.2.20.1705121103120.22831@east.gentwo.org> <20170512161915.GA4185@amt.cnet> <alpine.DEB.2.20.1705121154240.23503@east.gentwo.org>
 <20170515191531.GA31483@amt.cnet> <alpine.DEB.2.20.1705160825480.32761@east.gentwo.org> <20170519143407.GA19282@amt.cnet> <alpine.DEB.2.20.1705191205580.19631@east.gentwo.org> <20170520082646.GA16139@amt.cnet>
Content-Type: text/plain; charset=US-ASCII
Cc: Luiz Capitulino <lcapitulino@redhat.com>, linux-kernel@vger.kernel.org,
    linux-mm@kvack.org, Rik van Riel <riel@redhat.com>,
    Linux RT Users <linux-rt-users@vger.kernel.org>, cmetcalf@mellanox.com
To: Marcelo Tosatti <mtosatti@redhat.com>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20170520082646.GA16139@amt.cnet>
Sender: owner-linux-mm@kvack.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, 20 May 2017, Marcelo Tosatti wrote:

> > And you can configure the interval of vmstat updates freely.... Set
> > the vmstat_interval to 60 seconds instead of 2 for a try? Is that rare
> > enough?
>
> Not rare enough. Never is rare enough.

Ok what about the other stuff that must be going on if you allow OS
activity like f.e. the tick, scheduler etc etc.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
