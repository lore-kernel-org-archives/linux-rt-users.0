From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch -rt 1/2] KVM: use simple waitqueue for vcpu->wq
Date: Fri, 7 Aug 2015 13:14:15 +0200
Message-ID: <20150807111415.GC18673@twins.programming.kicks-ass.net>
References: <20150114171459.593877145@redhat.com>
 <20150116114846.4e7b718d@gandalf.local.home>
 <20150119144100.GA10794@amt.cnet>
 <20150120054653.GA6473@iris.ozlabs.ibm.com>
 <20150120131613.009903a0@gandalf.local.home>
 <20150121150716.GD11596@twins.programming.kicks-ass.net>
 <20150217174419.GY26177@linutronix.de>
 <20150218140320.GY5029@twins.programming.kicks-ass.net>
 <20150225210250.GA25858@linutronix.de>
 <20150807105738.GF16853@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Paul Mackerras <paulus@samba.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Luiz Capitulino <lcapitulino@redhat.com>,
	Rik van Riel <riel@redhat.com>,
	Steven Rostedt <srostedt@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:33121 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589AbbHGLOU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 7 Aug 2015 07:14:20 -0400
Content-Disposition: inline
In-Reply-To: <20150807105738.GF16853@twins.programming.kicks-ass.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Aug 07, 2015 at 12:57:38PM +0200, Peter Zijlstra wrote:

> > >+void __finish_swait(struct swait_queue_head *q, struct swait_queu=
e *wait)

> > this one has no users the __ suggests that it is locked edition. Ma=
ybe
> > it is for the completions=E2=80=A6
>=20
> Yeah, who knows, I certainly do not anymore ;-)

On that, we cannot convert completions to swait. Because swait wake_all
must not happen from IRQ context, and complete_all() typically is used
from just that.
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
