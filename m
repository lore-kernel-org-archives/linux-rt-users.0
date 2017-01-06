From: Mike Galbraith <efault@gmx.de>
Subject: Re: [rfc patch-rt] radix-tree: Partially disable memcg accounting
 in radix_tree_node_alloc()
Date: Fri, 06 Jan 2017 11:52:59 +0100
Message-ID: <1483699979.11478.21.camel@gmx.de>
References: <20161223163213.szj43nv7rnelkbty@linutronix.de>
         <1483690403.11478.8.camel@gmx.de> <20170106085548.GD5556@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Michal Hocko <mhocko@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170106085548.GD5556@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2017-01-06 at 09:55 +0100, Michal Hocko wrote:
> On Fri 06-01-17 09:13:23, Mike Galbraith wrote:
> > radix-tree: Partially disable memcg accounting in radix_tree_node_alloc()
> > 
> > Having no preload, which turns accounting off for non-rt kernels, trying to
> > allocate coming from shmem_fault() when memcg is full sends us scurrying off
> > to pagefault_out_of_memory(), with dramatic (usually terminal) consequences.
> > LTP's madvise06 testcase triggers this quite well, and per gitk, the below
> > was the beginning of RT memcg woes.
> > 
> > 58e698af4c63 radix-tree: account radix_tree_node to memory cgroup
> > 
> > Turn memcg accounting off for RT in the problematic path.
> 
> I am really wondering why this is RT specific and the non RT kernels
> doesn't have any problem.

For all I know, there may be a scenario for non-RT to explode, but the
madvise06 testcase that thoroughly nails RT ain't it.

	-Mike
