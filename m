From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: v2.6.19-rt6, yum/rpm
Date: Thu, 07 Dec 2006 12:45:57 -0800
Message-ID: <1165524358.9244.33.camel@cmn3.stanford.edu>
References: <20061205171114.GA25926@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: nando@ccrma.Stanford.EDU, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org, Mike Galbraith <efault@gmx.de>,
	Clark Williams <williams@redhat.com>,
	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Giandomenico De Tullio <ghisha@email.it>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp3.Stanford.EDU ([171.67.20.26]:59894 "EHLO
	smtp3.stanford.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1163324AbWLGUqD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 7 Dec 2006 15:46:03 -0500
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20061205171114.GA25926@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2006-12-05 at 18:11 +0100, Ingo Molnar wrote:
> i have released the 2.6.19-rt6 tree, which can be downloaded from the 
> usual place:
> 
>     http://redhat.com/~mingo/realtime-preempt/
> 
> more info about the -rt patchset can be found on the RT wiki:
> 
>   http://rt.wiki.kernel.org
> 
> this is a fixes-only release. Changes since -rt1:
[MUNCH]

A first non-scientific feedback report. 

Much better performance in terms of xruns with Jackd. Hardly any at all
as it should be. I'm starting to test -rt8 right now. 

Now, I still don't have an smp machine to test so the improvement could
be because I'm just running 64 bit up instead of smp. Or it could have
been the hardware on that other machine that had some problem (either
because it was starting to fail or because the kernel drivers for that
hardware were somehow triggering the xruns). 

Anyway, looks good!
Thanks.
-- Fernando
