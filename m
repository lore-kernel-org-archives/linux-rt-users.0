Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBC4C2EB
	for <linux-rt-users@vger.kernel.org>; Mon,  2 Oct 2023 10:05:49 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35559F
	for <linux-rt-users@vger.kernel.org>; Mon,  2 Oct 2023 03:05:47 -0700 (PDT)
Date: Mon, 2 Oct 2023 12:05:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1696241146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lPQ5aA+Lpufnq1IbyrhKlO/eJ72BtsOSFQMiekPp+VU=;
	b=IrNACFGxPnNr6fb08j57xmH0dtxKA1g0jS5XWYGTsRJXykhaRLX0PI1fCitRNIFBCJsiRx
	itqe9TVRPTUOZHu78BkRAjt6un6qbl4N9J7XI/XnqI6EctgANz7SO9bUwdTlh218lHMa5N
	950gmm9rdWC0cVlnsfBpsIwd0AmzjZ9aVnpcCoR1Dcf50NdLUJdRSPspHvc4lDAJFsN73E
	mdLKBvqlZX20VD6jdJOoDLIIChS30EG6DFDa4ZuEmJTHgQdwWuOdZBW2vhBXCis0XO3+Fh
	DS2hOsJO+8WhV2ZqazWIDcQd8nT076kG/WWZt6DKLdCt9r0nU0NH1hUtZyD+ag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1696241146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lPQ5aA+Lpufnq1IbyrhKlO/eJ72BtsOSFQMiekPp+VU=;
	b=SHr5wkO/BwO15fZ7/ceEGWA50awipd15Q7nMU3dClIDTisITUhI6J5zV/UmzBL8Vn3Ex0z
	swNuJF0zq2sidWAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Mike Galbraith <efault@gmx.de>
Cc: Clark Williams <williams@redhat.com>, "g.medini" <g.medini@eurosoft.it>,
	RT <linux-rt-users@vger.kernel.org>
Subject: Re: High latency of a system based on 5.19 rt
Message-ID: <20231002100542.59fbxJ0f@linutronix.de>
References: <S1JV78$805284328FE38E68AC9E7D23F35846D8@eurosoft.it>
 <f9fd60d19937c4e22407738f2d78b3ca4a7887d8.camel@gmx.de>
 <CAMLffL8=zW0Bv47R=r3=Lh9==OjDrM=FTJZgmm6PYGOyTedeBA@mail.gmail.com>
 <8eb75f2118086edf828ac059999fd52b64382576.camel@gmx.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8eb75f2118086edf828ac059999fd52b64382576.camel@gmx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-09-26 15:15:46 [+0200], Mike Galbraith wrote:
> On Tue, 2023-09-26 at 12:30 +0000, Clark Williams wrote:
> > On Tue, Sep 26, 2023 at 7:05=E2=80=AFAM Mike Galbraith <efault@gmx.de> =
wrote:
> > > On Mon, 2023-09-25 at 18:30 +0200, g.medini@eurosoft.it wrote:
> > > > # tracer: wakeup_rt
> > > > #
> > > > # wakeup_rt latency trace v1.1.5 on 5.19.0-rt10
> > > > # -----------------------------------------------------------------=
---
> > > > # latency: 357 us, #401/401, CPU#0 | (M:preempt_rt VP:0, KP:0, SP:0=
 HP:0 #P:2)
> > > > #=C2=A0=C2=A0=C2=A0 -----------------
> > > > #=C2=A0=C2=A0=C2=A0 | task: ktimers/0-15 (uid:0 nice:0 policy:1 rt_=
prio:1)
> > > > #=C2=A0=C2=A0=C2=A0 -----------------
> > >
> > > The first thing that pokes me in the eye is that priority. I'd bump
> > > that a lot.=C2=A0 As it sits, anything high priority ktimers may wake=
 when
> > > it finally gets the CPU gets to enjoy all the latency ktimers is eati=
ng
> > > in this trace due to it having been deemed relatively unimportant.
> >
> > Hmmm, IRQs are running at FIFO:50 by default. Do we want the ktimer
> > running above the IRQ service thread?=C2=A0
>=20
> I think so yeah, quick like bunny wakeup resource should punch through.

Why not perform all wakes from hardirq then? If SCHED_OTHER is so
important=E2=80=A6

> 	-Mike

Sebastian
