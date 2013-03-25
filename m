From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RT LATENCY] 249 microsecond latency caused by slub's
 unfreeze_partials() code.
Date: Mon, 25 Mar 2013 14:32:35 -0400
Message-ID: <1364236355.6345.185.camel@gandalf.local.home>
References: <1363906545.6345.81.camel@gandalf.local.home>
	 <0000013d92c37ff3-5fb85400-bec1-4eda-8ba1-332566884c59-000000@email.amazonses.com>
	 <1364010673.6345.156.camel@gandalf.local.home>
	 <0000013da1f93be3-c3d42ae8-ff34-4c63-8094-77a83291ea19-000000@email.amazonses.com>
	 <1364227073.6345.182.camel@gandalf.local.home>
	 <1364228039.6345.183.camel@gandalf.local.home>
	 <0000013da2ace21a-9e87fe8a-75c2-4b7c-b5e1-37ad196ce012-000000@email.amazonses.com>
	 <1364234613.6345.184.camel@gandalf.local.home>
	 <0000013da2ce20f8-0e3a64ef-67ed-4ab4-9f20-b77980c876c3-000000@email.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <clark@redhat.com>
To: Christoph Lameter <cl@linux.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0000013da2ce20f8-0e3a64ef-67ed-4ab4-9f20-b77980c876c3-000000@email.amazonses.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2013-03-25 at 18:27 +0000, Christoph Lameter wrote:
> On Mon, 25 Mar 2013, Steven Rostedt wrote:
> 
> > If this makes it more deterministic, and lower worse case latencies,
> > then it's definitely worth the price.
> 
> Yes that would make it more deterministic. Maybe I should add an option
> to be able to compile the allocator without cpu partial page support?

I agree that would be useful.

-- Steve
