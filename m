From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch -rt 1/2] KVM: use simple waitqueue for vcpu->wq
Date: Thu, 05 Mar 2015 08:42:40 +0100
Message-ID: <54F808F0.50006@linutronix.de>
References: <20150114171251.882318257@redhat.com> <20150114171459.593877145@redhat.com> <20150116114846.4e7b718d@gandalf.local.home> <20150119144100.GA10794@amt.cnet> <20150120054653.GA6473@iris.ozlabs.ibm.com> <20150120131613.009903a0@gandalf.local.home> <20150121150716.GD11596@twins.programming.kicks-ass.net> <20150217174419.GY26177@linutronix.de> <20150227002357.GA11577@amt.cnet> <20150305010920.GB10924@amt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Luiz Capitulino <lcapitulino@redhat.com>,
	Rik van Riel <riel@redhat.com>,
	Steven Rostedt <srostedt@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>
To: Marcelo Tosatti <mtosatti@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:48098 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754442AbbCEHmo (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 5 Mar 2015 02:42:44 -0500
In-Reply-To: <20150305010920.GB10924@amt.cnet>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 03/05/2015 02:09 AM, Marcelo Tosatti wrote:
>> Can you please include the series?
>>
>> Thanks
> 
> Sebastian?

I will pick it up, don't worry. I think I do my -RT day tomorrow.

Sebastian
