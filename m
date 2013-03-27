From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RT LATENCY] 249 microsecond latency caused by slub's
 unfreeze_partials() code.
Date: Tue, 26 Mar 2013 23:30:32 -0400
Message-ID: <1364355032.6345.200.camel@gandalf.local.home>
References: <1363906545.6345.81.camel@gandalf.local.home>
	 <0000013d92c37ff3-5fb85400-bec1-4eda-8ba1-332566884c59-000000@email.amazonses.com>
	 <1364010673.6345.156.camel@gandalf.local.home>
	 <0000013da1f93be3-c3d42ae8-ff34-4c63-8094-77a83291ea19-000000@email.amazonses.com>
	 <1364227073.6345.182.camel@gandalf.local.home>
	 <1364228039.6345.183.camel@gandalf.local.home>
	 <0000013da2ace21a-9e87fe8a-75c2-4b7c-b5e1-37ad196ce012-000000@email.amazonses.com>
	 <1364234613.6345.184.camel@gandalf.local.home>
	 <0000013da2ce20f8-0e3a64ef-67ed-4ab4-9f20-b77980c876c3-000000@email.amazonses.com>
	 <1364236355.6345.185.camel@gandalf.local.home>
	 <20130327025957.GA17125@lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Christoph Lameter <cl@linux.com>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <clark@redhat.com>
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130327025957.GA17125@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2013-03-27 at 11:59 +0900, Joonsoo Kim wrote:

> How about using spin_try_lock() in unfreeze_partials() and
> using spin_lock_contented() in get_partial_node() to reduce latency?
> IMHO, this doesn't make code more deterministic, but can maintain
> a benefit of cpu partial page with tolerable latency.

And what do you do when you fail the try lock? Try again, or just break
out?

We can run benchmarks, but I don't like playing games in -rt. It either
is deterministic, or it isn't.

-- Steve
