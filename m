From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [patch 2/2] MM: allow per-cpu vmstat_threshold and vmstat_worker
 configuration
Date: Tue, 25 Apr 2017 16:36:21 -0300
Message-ID: <20170425193619.GA8403@amt.cnet>
References: <20170425135717.375295031@redhat.com>
 <20170425135846.203663532@redhat.com>
 <1493148546.31102.1.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Linux RT Users <linux-rt-users@vger.kernel.org>
To: Rik van Riel <riel@redhat.com>
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <1493148546.31102.1.camel@redhat.com>
Sender: owner-linux-mm@kvack.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Apr 25, 2017 at 03:29:06PM -0400, Rik van Riel wrote:
> On Tue, 2017-04-25 at 10:57 -0300, Marcelo Tosatti wrote:
> > The per-CPU vmstat worker is a problem on -RT workloads (because
> > ideally the CPU is entirely reserved for the -RT app, without
> > interference). The worker transfers accumulated per-CPU 
> > vmstat counters to global counters.
> > 
> > To resolve the problem, create two tunables:
> > 
> > * Userspace configurable per-CPU vmstat threshold: by default the 
> > VM code calculates the size of the per-CPU vmstat arrays. This 
> > tunable allows userspace to configure the values.
> > 
> > * Userspace configurable per-CPU vmstat worker: allow disabling
> > the per-CPU vmstat worker.
> > 
> > The patch below contains documentation which describes the tunables
> > in more detail.
> 
> The documentation says what the tunables do, but
> not how you should set them in different scenarios,
> or why.
> 
> That could be a little more helpful to sysadmins.

OK i'll update the document to be more verbose.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
