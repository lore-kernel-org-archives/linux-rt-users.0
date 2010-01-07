From: Carsten Emde <Carsten.Emde@osadl.org>
Subject: Re: [RFC] [rt-tests] change to cyclictest behavior
Date: Thu, 07 Jan 2010 15:54:34 +0100
Message-ID: <4B45F5AA.2020100@osadl.org>
References: <20100106130400.7f30ae55@torg>	<520f0cf11001061139j2af13403qfcbf567647bdfaa8@mail.gmail.com>	<4B4502FD.1000404@osadl.org>	<20100106160434.77efc790@torg>	<4B450D91.7060403@osadl.org>	<20100106162759.1d4d5b57@torg>	<4B458C08.8070209@osadl.org> <20100107084700.0fa053a3@torg>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: John Kacur <jkacur@redhat.com>,
	RT <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:35050 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752342Ab0AGPA0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 7 Jan 2010 10:00:26 -0500
In-Reply-To: <20100107084700.0fa053a3@torg>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 01/07/2010 03:47 PM, Clark Williams wrote:
> On Thu, 07 Jan 2010 08:23:52 +0100
> Carsten Emde <Carsten.Emde@osadl.org> wrote:
>>>> -S      --smp              Standard SMP testing (equals -a -t -n -d0),
>>>>                            same priority on all threads.
>> After having done some tests with a quickly hacked cyclictest version, I
>> have found an issue with including -d0. Apparently, small numbers make
>> life especially difficult for the scheduler; this is why we often used
>> -d1. Specifying -d0 seems a special case where all threads are in sync.
>> Maybe, we may miss some important latency constellations, if we do not
>> let the tasks slightly interfere. In any case, I would like to be able
>> to specify a distance _in addition_ to -S.
>> [..]
> I don't have a problem not having -d in the -S option. I was looking at
> the possibility of synchronous sampling as well so it's probably a good
> idea to keep it separate. 
> The main things we want are implied -t, -a and -n.
Yes, let's do it this way.
