From: Daniel Walker <dwalker@mvista.com>
Subject: Re: v2.6.23-rc1-rt6-dw1
Date: Mon, 30 Jul 2007 08:59:14 -0700
Message-ID: <1185811154.2636.29.camel@imap.mvista.com>
References: <1185765740.2636.2.camel@imap.mvista.com>
	 <1185772831.2686.6.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:16240 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756726AbXG3QJd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 30 Jul 2007 12:09:33 -0400
In-Reply-To: <1185772831.2686.6.camel@laptopd505.fenrus.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sun, 2007-07-29 at 22:20 -0700, Arjan van de Ven wrote:
> >  
> > +/*
> > + * trigger a reschedule on all other CPUs:
> > + */
> > +extern void smp_send_reschedule_allbutself(void);
> > +
> > +/*
> > + * trigger a reschedule on all other CPUs:
> > + */
> > +extern void smp_send_reschedule_allbutself(void);
> > +
> 
> just to make sure the C compiler doesn't forget it ?
> or maybe the parser is suffering from memory lapse ? ;)

In terms of this whole patch, I should have been a little clearer about
it's meaning .. It represents code getting moved inside the -rt series..
For example the code above was originally in the,
preempt-realtime-core.patch and I moved it to the
preempt-realtime-i386.patch.

So I'm not actually adding any code.. I wasn't trying to put Ingo's code
up for evaluation either, since it's all still in development ..

Daniel
