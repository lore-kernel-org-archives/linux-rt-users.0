Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640492106
	for <linux-rt-users@vger.kernel.org>; Mon,  2 Oct 2023 14:16:14 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255B9B7
	for <linux-rt-users@vger.kernel.org>; Mon,  2 Oct 2023 07:16:13 -0700 (PDT)
Date: Mon, 2 Oct 2023 16:16:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1696256171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YH8HLLDDD0bnVjUytmpHyaUWwvPTWeEJatiz066/y8g=;
	b=oDVGag0WKJFIbttxT+aaa7SLKcREz5S2JZVoM4yPvlMq11LloQfCxU+cUdOx+OE0ECdekP
	qRS6fUGJU15mBstgFtkogyWBBCI6h+KKnXzs7hEoduDAaVW9lsynTlKUViKkWa9imQyKNn
	fx0mWx3ngKV+DuKS8fXGYB8qRWvhKLfeqc0yQDuIEwL/bR0LxrETi7q9J2Z0VxA8DusH1v
	LK8iI/LBJieJHcmOAPlex/TpHZyYos6gkLBJqFf3Chkji9uU+nOxT++ktoKlfN1RVhbezV
	3R3+fQzPEpOGJIddr5sFMr1zVkvtF83H6DFPF2WkkqZ29KfkRrKKSCI57biWmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1696256171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YH8HLLDDD0bnVjUytmpHyaUWwvPTWeEJatiz066/y8g=;
	b=Jw4A4IIB/wu/Wroi4I5mB2Pvhz6fJkr/3vFe6uRVT/aOuWApIiIw8PgspF5+Uv1qVVY5uZ
	hKs7sD5GKK0F6kCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Mike Galbraith <efault@gmx.de>
Cc: Clark Williams <williams@redhat.com>, "g.medini" <g.medini@eurosoft.it>,
	RT <linux-rt-users@vger.kernel.org>
Subject: Re: High latency of a system based on 5.19 rt
Message-ID: <20231002141611.f1H8qyiR@linutronix.de>
References: <S1JV78$805284328FE38E68AC9E7D23F35846D8@eurosoft.it>
 <f9fd60d19937c4e22407738f2d78b3ca4a7887d8.camel@gmx.de>
 <CAMLffL8=zW0Bv47R=r3=Lh9==OjDrM=FTJZgmm6PYGOyTedeBA@mail.gmail.com>
 <8eb75f2118086edf828ac059999fd52b64382576.camel@gmx.de>
 <20231002100542.59fbxJ0f@linutronix.de>
 <8586b9812dccc6248e0518efaf973c4467324b70.camel@gmx.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8586b9812dccc6248e0518efaf973c4467324b70.camel@gmx.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-10-02 13:58:57 [+0200], Mike Galbraith wrote:
> > Why not perform all wakes from hardirq then?
> 
> Sounds good to me iff we're talking about a dinky irq width delta.
> 
> Threads bundling up what are otherwise irq context cycles is loaded
> with goodness, but static priority leaves you holding a bill and paying
> context switch fees on top.  Pick your poison carefully applies I
> suppose.  A tiny swig of hemlock can't do _too_ much harm, right ;-)

A swarm of wake-ups for SCHED_OTHER at prio 50+ will delay your threaded
interrupt handler and everything else that runs 50 and lower.
Since SCHED_OTHER is less important than any RT task, the delay is
usually of lower concern.

> 	-Mike

Sebastian
