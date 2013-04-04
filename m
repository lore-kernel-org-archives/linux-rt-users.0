From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [RT LATENCY] 249 microsecond latency caused by slub's
 unfreeze_partials() code.
Date: Thu, 4 Apr 2013 09:58:50 +0900
Message-ID: <20130404005850.GC10683@lge.com>
References: <20130327025957.GA17125@lge.com>
 <1364355032.6345.200.camel@gandalf.local.home>
 <20130327061351.GB17125@lge.com>
 <alpine.DEB.2.02.1303281227520.16200@gentwo.org>
 <0000013db20ca149-0064fbb8-2f81-4323-9095-a38f6abb79c5-000000@email.amazonses.com>
 <CAP=VYLr4i=39ywFCrmG-XuvUFmmXpyj6dYgG44JJoUJhpN6uuQ@mail.gmail.com>
 <alpine.DEB.2.02.1304011025550.12690@gentwo.org>
 <0000013dc63b3a87-6ce88b75-d011-407e-8dde-da73c3a7f5fd-000000@email.amazonses.com>
 <20130402004217.GA16699@lge.com>
 <0000013dcc35f310-d338600d-8a5a-4c95-9770-af4b8d81e103-000000@email.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <clark@redhat.com>,
	Pekka Enberg <penberg@kernel.org>
To: Christoph Lameter <cl@linux.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0000013dcc35f310-d338600d-8a5a-4c95-9770-af4b8d81e103-000000@email.amazonses.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello, Christoph.

On Tue, Apr 02, 2013 at 07:25:20PM +0000, Christoph Lameter wrote:
> On Tue, 2 Apr 2013, Joonsoo Kim wrote:
> 
> > We need one more fix for correctness.
> > When available is assigned by put_cpu_partial, it doesn't count cpu slab's objects.
> > Please reference my old patch.
> >
> > https://lkml.org/lkml/2013/1/21/64
> 
> Could you update your patch and submit it again?

Pekka alreay applied it.
Do we need update?

Thanks.

> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
