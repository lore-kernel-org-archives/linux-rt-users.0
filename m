From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [patch 2/2] MM: allow per-cpu vmstat_threshold and vmstat_worker
 configuration
Date: Fri, 12 May 2017 13:19:16 -0300
Message-ID: <20170512161915.GA4185@amt.cnet>
References: <20170425135717.375295031@redhat.com>
 <20170425135846.203663532@redhat.com>
 <20170502102836.4a4d34ba@redhat.com>
 <20170502165159.GA5457@amt.cnet>
 <20170502131527.7532fc2e@redhat.com>
 <alpine.DEB.2.20.1705111035560.2894@east.gentwo.org>
 <20170512122704.GA30528@amt.cnet>
 <alpine.DEB.2.20.1705121002310.22243@east.gentwo.org>
 <20170512154026.GA3556@amt.cnet>
 <alpine.DEB.2.20.1705121103120.22831@east.gentwo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luiz Capitulino <lcapitulino@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Rik van Riel <riel@redhat.com>,
        Linux RT Users <linux-rt-users@vger.kernel.org>,
        cmetcalf@mellanox.com
To: Christoph Lameter <cl@linux.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1705121103120.22831@east.gentwo.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, May 12, 2017 at 11:07:48AM -0500, Christoph Lameter wrote:
> On Fri, 12 May 2017, Marcelo Tosatti wrote:
> 
> > In our case, vmstat updates are very rare (CPU is dominated by DPDK).
> 
> What is the OS doing on the cores that DPDK runs on? I mean we here can
> clean a processor of all activities and are able to run for a long time
> without any interruptions.
> 
> Why would you still let the OS do things on that processor? If activities
> by the OS are required then the existing NOHZ setup already minimizes
> latency to a short burst (and Chris Metcalf's work improves on that).
> 
> 
> What exactly is the issue you are seeing and want to address? I think we
> have similar aims and as far as I know the current situation is already
> good enough for what you may need. You may just not be aware of how to
> configure this.

I want to disable vmstat worker thread completly from an isolated CPU.
Because it adds overhead to a latency target, target which 
the lower the better.

> I doubt that doing inline updates will do much good compared to what we
> already have and what the dataplan mode can do.

Can the dataplan mode disable vmstat worker thread completly on a given
CPU?
