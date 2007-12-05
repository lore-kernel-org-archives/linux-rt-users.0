From: "Gregory Haskins" <ghaskins@novell.com>
Subject: Re: [PATCH 3/3] Subject: SCHED - Use a 2-d bitmap for
	searching lowest-pri CPU
Date: Wed, 05 Dec 2007 08:41:19 -0500
Message-ID: <4756642F.BA47.005A.0@novell.com>
References: <20071205025137.4494.18683.stgit@novell1.haskins.net>
 <20071205025538.4494.52380.stgit@novell1.haskins.net>
 <20071205093412.GA17911@elte.hu> <475634F8.BA47.005A.0@novell.com>
 <20071205114438.GC6143@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Cc: <rostedt@goodmis.org>, <linux-kernel@vger.kernel.org>,
	<linux-rt-users@vger.kernel.org>
To: "Ingo Molnar" <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mcclure-nat.wal.novell.com ([130.57.22.22]:42836 "EHLO
	mcclure.wal.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751968AbXLENq2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Dec 2007 08:46:28 -0500
In-Reply-To: <20071205114438.GC6143@elte.hu>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>>> On Wed, Dec 5, 2007 at  6:44 AM, in message <20071205114438.GC6143@elte.hu>,
Ingo Molnar <mingo@elte.hu> wrote: 

> * Gregory Haskins <ghaskins@novell.com> wrote:
> 
>> However, that said, Steven's testing work on the mainline port of our 
>> series sums it up very nicely, so I will present that in lieu of 
>> digging up my -rt numbers unless you specifically want them too.  Here 
>> they are:
> 
> i'm well aware of Steve's benchmarking efforts, but i dont think he's 
> finished with it and i'll let him present the results once he wants to 
> announce them. I asked about the effects of the "2-d" patch in isolation 
> and i'm not sure the numbers show that individual patch in action.

Ah, sorry if I was not clear.  What I was trying to show was that you can compare "gh" to "cpupri" to see the effects of the 2-d patch in isolation (*) in Steven's tests.  I believe it shows a positive impact on some tests, and a negligible impact on some tests.  As long as we dont have a regression somewhere, I am happy :)

(*) Yes, "cpupri" in this test also has patches 21-22 (root-domain).  However, note that Steven is not configuring cpusets, and therefore the root-domain code is effectively marginalized in this data.  Its not a pure isolation, no.  But the results of my tests with *true* isolation present similar characteristics, so I felt they were representative.

> 
> in any case, you are preaching to the choir, i wrote the first 
> rt-overload code and it's been in -rt forever so it's not like you need 
> to sell me the concept ;-) But upstream quality requirements are 
> different from -rt and we need to examine all aspects of scheduling, not 
> just latency. 

Understood and agree.  I designed the subsystem with the overall system in mind, so hopefully that is reflected in the numbers and the review comments that come out of this. :)

>In any case, i'll wait for the rest of Steve's numbers.

Sounds good.  Ill try to dig up my 4/8-way numbers as well for another data point.

Thanks for taking the time to review all this stuff.  I know you are swamped these days.

-Greg
