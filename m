From: "Jens Wirth" <jewirth@googlemail.com>
Subject: Re: cyclictest - trouble explaning results
Date: Mon, 16 Jun 2008 11:22:12 +0200
Message-ID: <f944af2a0806160222j5aa226e0l44baf15147069dfa@mail.gmail.com>
References: <20080611151437.234900@gmx.net>
	 <loom.20080613T114833-789@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: galimov@gmx.de
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.246]:19224 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756864AbYFPJWO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 Jun 2008 05:22:14 -0400
Received: by an-out-0708.google.com with SMTP id d40so1175830and.103
        for <linux-rt-users@vger.kernel.org>; Mon, 16 Jun 2008 02:22:13 -0700 (PDT)
In-Reply-To: <loom.20080613T114833-789@post.gmane.org>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Jun 13, 2008 at 2:31 PM, Jens Wirth <jewirth@gmail.com> wrote:
> Oleg Galimov <Galimov <at> gmx.de> writes:
>
>> I have a dual-core cpu. When I run cyclictest on both cores and then start a
> time hog (like cp /dev/zero
>> /dev/null), then the average latency on the core where it runs goes down
> significantly (on my machine it is
>> like 30us before and 10us after, when using rt-patch). It returns to the
> original values, when I kill the cp process.
>
> I made a similar observation while measuring the jitter in
> the time of execution of usleep(). The more load the machine
> has the less becomes the average jitter. Of course, there is
> a point of inflection when the system is fully stretched.
>
> I observed this behavior on a ppc405 based embedded system
> (no SMP) with and without CONFIG_PREEMPT_RT. Interestingly
> enough, I was unable to reproduce your observation with the
> cyclictest tool on this system.

I have to correct myself: When running multiple threads I get the
same behavior as you described. Remarkably, this is a single core
system with a fixed cpu frequency.

Jens
