From: Rik van Riel <riel@redhat.com>
Subject: Re: [patch -rt 1/2] KVM: use simple waitqueue for vcpu->wq
Date: Wed, 14 Jan 2015 13:22:43 -0500
Message-ID: <54B6B3F3.2000908@redhat.com>
References: <20150114171251.882318257@redhat.com> <20150114171459.593877145@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Luiz Capitulino <lcapitulino@redhat.com>,
	Steven Rostedt <srostedt@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>
To: Marcelo Tosatti <mtosatti@redhat.com>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41777 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750965AbbANSWt (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 14 Jan 2015 13:22:49 -0500
In-Reply-To: <20150114171459.593877145@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 01/14/2015 12:12 PM, Marcelo Tosatti wrote:
> The problem:
> 
> On -RT, an emulated LAPIC timer instances has the following path:
> 
> 1) hard interrupt
> 2) ksoftirqd is scheduled
> 3) ksoftirqd wakes up vcpu thread
> 4) vcpu thread is scheduled
> 
> This extra context switch introduces unnecessary latency in the 
> LAPIC path for a KVM guest.

> This patch reduces the average latency in my tests from 14us to 11us.
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Acked-by: Rik van Riel <riel@redhat.com>

