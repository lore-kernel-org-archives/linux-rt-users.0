From: Carsten Emde <Carsten.Emde@osadl.org>
Subject: Re: [RFC] [rt-tests] change to cyclictest behavior
Date: Wed, 06 Jan 2010 23:24:17 +0100
Message-ID: <4B450D91.7060403@osadl.org>
References: <20100106130400.7f30ae55@torg>	<520f0cf11001061139j2af13403qfcbf567647bdfaa8@mail.gmail.com>	<4B4502FD.1000404@osadl.org> <20100106160434.77efc790@torg>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: John Kacur <jkacur@redhat.com>,
	RT <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:51940 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932259Ab0AFWZU (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 6 Jan 2010 17:25:20 -0500
In-Reply-To: <20100106160434.77efc790@torg>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Clark,

>> [..]
>> Here is my proposal:
>> Do not change the meaning of existing options. Introduce a new option
>> that is mutual exclusive with the -a, the -t and the -d option. This new
>> option does the same as -a and -t and -d0 and sets the same priority to
>> all threads. How about that?
> Ugh, I truly *hate* adding options. Do you know that cyclictest is
> halfway to having as many options as 'ls'?
Well, yes, we have the choice between two bad things, breaking
compatibility or adding another option. I prefer the latter.
> [..]
> How about if we create the -S/--smp option that takes no arguments and
> causes -a, -t and -d to be ignored (with a warning). This option would
> create one thread per cpu, each thread pinned to it's corresponding
> cpu, all with the same sampling interval (i.e. -d0) and the same
> priority?
Sounds good to me.

May I ask you to also include the -n option which is almost always
needed? This would then give:

-S      --smp              Standard SMP testing (equals -a -t -n -d0),
                           same priority on all threads.

	Carsten.
