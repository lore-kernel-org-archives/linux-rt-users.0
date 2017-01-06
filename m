From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [rfc patch-rt] radix-tree: Partially disable memcg accounting
 in radix_tree_node_alloc()
Date: Fri, 06 Jan 2017 13:44:31 +0100
Message-ID: <1483706671.4257.4.camel@gmail.com>
References: <20161223163213.szj43nv7rnelkbty@linutronix.de>
         <1483690403.11478.8.camel@gmx.de> <20170106085548.GD5556@dhcp22.suse.cz>
         <1483699979.11478.21.camel@gmx.de> <1483705233.5727.11.camel@gmail.com>
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
In-Reply-To: <1483705233.5727.11.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2017-01-06 at 13:20 +0100, Mike Galbraith wrote:

> > > madvise06 isn't as deadly to the twiddled PREEMPT kernel as
> it is to PREEMPT_RT_FULL, but a very few runs attracted the oom beast.

The very next run paniced the box... deadly enough for gvt. work :)
