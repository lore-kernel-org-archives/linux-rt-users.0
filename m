From: Rik van Riel <riel@redhat.com>
Subject: Re: [patch -rt 2/2] KVM: lapic: mark LAPIC timer handler as irqsafe
Date: Wed, 14 Jan 2015 13:23:54 -0500
Message-ID: <54B6B43A.9070506@redhat.com>
References: <20150114171251.882318257@redhat.com> <20150114171459.694888126@redhat.com>
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
Received: from mx1.redhat.com ([209.132.183.28]:50173 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751343AbbANSX7 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 14 Jan 2015 13:23:59 -0500
In-Reply-To: <20150114171459.694888126@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 01/14/2015 12:12 PM, Marcelo Tosatti wrote:
> Since lapic timer handler only wakes up a simple waitqueue,
> it can be executed from hardirq context.
> 
> Reduces average cyclictest latency by 3us.
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Acked-by: Rik van Riel <riel@redhat.com>

