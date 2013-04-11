From: Christoph Lameter <cl@linux.com>
Subject: Re: [RT LATENCY] 249 microsecond latency caused by slub's
 unfreeze_partials() code.
Date: Thu, 11 Apr 2013 16:42:09 +0000
Message-ID: <0000013df9f9ca28-9863f810-f95f-4a21-83cd-a7a875af69c8-000000@email.amazonses.com>
References: <1364010673.6345.156.camel@gandalf.local.home> <0000013da1f93be3-c3d42ae8-ff34-4c63-8094-77a83291ea19-000000@email.amazonses.com> <1364227073.6345.182.camel@gandalf.local.home> <1364228039.6345.183.camel@gandalf.local.home>
 <0000013da2ace21a-9e87fe8a-75c2-4b7c-b5e1-37ad196ce012-000000@email.amazonses.com> <1364234613.6345.184.camel@gandalf.local.home> <0000013da2ce20f8-0e3a64ef-67ed-4ab4-9f20-b77980c876c3-000000@email.amazonses.com> <1364236355.6345.185.camel@gandalf.local.home>
 <20130327025957.GA17125@lge.com> <1364355032.6345.200.camel@gandalf.local.home> <20130327061351.GB17125@lge.com> <alpine.DEB.2.02.1303281227520.16200@gentwo.org> <0000013db20ca149-0064fbb8-2f81-4323-9095-a38f6abb79c5-000000@email.amazonses.com>
 <1365696307.9609.36.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <clark@redhat.com>,
	Pekka Enberg <penberg@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1365696307.9609.36.camel@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 11 Apr 2013, Steven Rostedt wrote:

> I was wondering if you made any more forward progress with with patch
> yet. When it goes into mainline, I'd like to backport it to the -rt
> stable trees, and will probably make it enabled by default when
> PREEMPT_RT is enabled.

Sorry I did not get around to it yet. Also waiting for Joonsoo's patch to
be merged first. Which tree may I use Pekka?
