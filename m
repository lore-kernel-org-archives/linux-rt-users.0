From: Guennadi Liakhovetski <gl@dsa-ac.de>
Subject: Re: [irda-users] [2.6.20-rt8] "Neighbour table overflow."
Date: Tue, 20 Mar 2007 16:30:46 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703201628590.534@pcgl.dsa-ac.de>
References: <Pine.LNX.4.63.0703161653400.534@pcgl.dsa-ac.de>
 <20070316161653.GC9413@elte.hu> <Pine.LNX.4.63.0703161722280.534@pcgl.dsa-ac.de>
 <20070316.121539.78711178.davem@davemloft.net> <Pine.LNX.4.63.0703191617250.534@pcgl.dsa-ac.de>
 <Pine.LNX.4.63.0703201527340.534@pcgl.dsa-ac.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: irda-users@lists.sourceforge.net, mingo@elte.hu,
	linux-rt-users@vger.kernel.org
To: David Miller <davem@davemloft.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.dsa-ac.de ([62.112.80.99]:48707 "EHLO mail.dsa-ac.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933834AbXCTPas (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 20 Mar 2007 11:30:48 -0400
In-Reply-To: <Pine.LNX.4.63.0703201527340.534@pcgl.dsa-ac.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 20 Mar 2007, Guennadi Liakhovetski wrote:

> As for the original problem, looks like the packets that get leaked are
> from af_irda.c::irda_sendmsg(). Any ideas where and when these skbs should
> be freed?

No, I actually only see that they are created in sock_alloc_send_skb(), 
so, I assumed it was the call in af_irda.c::irda_sendmsg(), which, 
however, seems to be not the case now.

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany
