From: Daniel Walker <dwalker@mvista.com>
Subject: Re: v2.6.21-rt2
Date: Wed, 16 May 2007 15:22:58 -0700
Message-ID: <1179354178.20519.43.camel@imap.mvista.com>
References: <20070516180447.GA17922@elte.hu>
	 <1179348842.20519.20.camel@imap.mvista.com>
	 <20070516210104.GA17240@elte.hu>
	 <1179350448.20519.25.camel@imap.mvista.com>
	 <20070516213259.GC19850@elte.hu>
	 <1179352036.20519.36.camel@imap.mvista.com>
	 <20070516220444.GA27081@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:56051 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755591AbXEPWZO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 16 May 2007 18:25:14 -0400
In-Reply-To: <20070516220444.GA27081@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2007-05-17 at 00:04 +0200, Ingo Molnar wrote:
> * Daniel Walker <dwalker@mvista.com> wrote:
> 
> > I don't know. irqs_off_preempt_count() could get used someplace else, 
> > where you would want to flip the preempt_count() check .. It seems 
> > sane to combine your patch with mine ..
> > 
> > irqs_off_preempt_count() (!__get_cpu_var(trace_cpu_idle) && 
> > preempt_count())
> > 
> > You can't call __get_cpu_var() without the a positive preempt_count(), 
> > so the check seems backwards regardless of the other factors ..
> 
> yeah. The whole trace_preempt_enter_idle() thing looks a bit suspect. 
> Why cannot those architectures simply disable/enable preemption and get 
> the same effect? It's not like we ever want to allow the preemption of 
> the idle task.

They disable interrupts it looks like (i386, and x86_64), around the
same area where those trace_preempt_enter_idle calls are placed .. I'm
not up on the details of Steve's fix .. There's also a
preempt_disable/preempt_enable ..

I'm not up on the details of Steve's fix , but stuff looks a little
odd ..

Daniel
