From: Guennadi Liakhovetski <gl@dsa-ac.de>
Subject: Re: [2.6.20-rt8] "Neighbour table overflow."
Date: Fri, 16 Mar 2007 17:26:57 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703161722280.534@pcgl.dsa-ac.de>
References: <Pine.LNX.4.63.0703161653400.534@pcgl.dsa-ac.de>
 <20070316161653.GC9413@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linux-rt-users@vger.kernel.org, irda-users@lists.sourceforge.net
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.dsa-ac.de ([62.112.80.99]:54364 "EHLO mail.dsa-ac.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753570AbXCPQ1A (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 16 Mar 2007 12:27:00 -0400
In-Reply-To: <20070316161653.GC9413@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 16 Mar 2007, Ingo Molnar wrote:

> * Guennadi Liakhovetski <gl@dsa-ac.de> wrote:
>>
>> After fixing the irda spinlock init bug, [...]
>
> could you send the patch for that? Is it upstream already?

It's indeed an IrDA bug (though mainly visible under rt-preempt) and the 
patch has been sent to the maintainer and to stable.

>> user.warn kernel: Neighbour table overflow.
>
> hm, i havent seen this one yet.

it comes from net/ipv4/route.c::rt_intern_hash()... That's all I can say 
so far. Any debug ideas? Could you try on any your rt-test system just a 
loop like

while true; do
 	ifdown eth0
 	ifup eth0
 	ping -c 1 host
done

or similar. Or, better yet with starting / stopping pppd?

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany
