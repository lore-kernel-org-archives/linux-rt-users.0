From: Christoph Lameter <cl@linux.com>
Subject: Re: [RT LATENCY] 249 microsecond latency caused by slub's
 unfreeze_partials() code.
Date: Wed, 5 Jun 2013 14:06:47 +0000
Message-ID: <0000013f14a94e72-7933a6c6-c0db-40d1-b7ec-dba19e7393b5-000000@email.amazonses.com>
References: <1364010673.6345.156.camel@gandalf.local.home> <0000013da2ace21a-9e87fe8a-75c2-4b7c-b5e1-37ad196ce012-000000@email.amazonses.com> <1364234613.6345.184.camel@gandalf.local.home> <0000013da2ce20f8-0e3a64ef-67ed-4ab4-9f20-b77980c876c3-000000@email.amazonses.com>
 <1364236355.6345.185.camel@gandalf.local.home> <20130327025957.GA17125@lge.com> <1364355032.6345.200.camel@gandalf.local.home> <20130327061351.GB17125@lge.com> <alpine.DEB.2.02.1303281227520.16200@gentwo.org> <0000013db20ca149-0064fbb8-2f81-4323-9095-a38f6abb79c5-000000@email.amazonses.com>
 <1369751967.15552.12.camel@gandalf.local.home> <alpine.DEB.2.02.1305281121420.1627@gentwo.org> <0000013eec62261a-77052f34-f1cb-41b2-ae90-7575a2d0472c-000000@email.amazonses.com> <CAAmzW4M8rX9WGo_FYeyBQ8=Ht-mRnQz1TGhLfbFuKhm3r8grGA@mail.gmail.com>
 <0000013f0b7b993c-35844ed2-81be-4146-ab3c-6c803006576b-000000@email.amazonses.com> <CAAmzW4MakOx_SA6eA=BYP4rq76np4yOS6RANpNObQP6dDDqYQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <clark@redhat.com>,
	Pekka Enberg <penberg@kernel.org>
To: JoonSoo Kim <js1304@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from a9-62.smtp-out.amazonses.com ([54.240.9.62]:58680 "EHLO
	a9-62.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755902Ab3FEOGt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Jun 2013 10:06:49 -0400
In-Reply-To: <CAAmzW4MakOx_SA6eA=BYP4rq76np4yOS6RANpNObQP6dDDqYQg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 5 Jun 2013, JoonSoo Kim wrote:

> I knew that we need the other nodes pages if we consistently allocate
> from there.
> In allocation path, it is reasonable.
> But, in free path, it is not reasonable that we put other nodes' page
> to cpu partial list.

It is reasonable. An "other nodes page" on the cpu partial list will
decrease the synchronization necessary to free other objects to that
page. And multiple objects from a remote node are typically freed in on go.

