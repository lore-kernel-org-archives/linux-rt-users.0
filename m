From: David Miller <davem@davemloft.net>
Subject: Re: [2.6.20-rt8] "Neighbour table overflow."
Date: Fri, 16 Mar 2007 12:15:39 -0700 (PDT)
Message-ID: <20070316.121539.78711178.davem@davemloft.net>
References: <Pine.LNX.4.63.0703161653400.534@pcgl.dsa-ac.de>
	<20070316161653.GC9413@elte.hu>
	<Pine.LNX.4.63.0703161722280.534@pcgl.dsa-ac.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: mingo@elte.hu, linux-rt-users@vger.kernel.org,
	irda-users@lists.sourceforge.net
To: gl@dsa-ac.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:49941
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S965881AbXCPTPl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 16 Mar 2007 15:15:41 -0400
In-Reply-To: <Pine.LNX.4.63.0703161722280.534@pcgl.dsa-ac.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Guennadi Liakhovetski <gl@dsa-ac.de>
Date: Fri, 16 Mar 2007 17:26:57 +0100 (CET)

> it comes from net/ipv4/route.c::rt_intern_hash()... That's all I can say 
> so far. Any debug ideas? Could you try on any your rt-test system just a 
> loop like

There is an SKB leak somewhere, and that leaked SKB has references to
a route, that's what that message usually means.

After you accumulate enough leaked packets with routed attached them,
the system refuses to create any more of them.

Probably if you look at /proc/slabinfo you'll see a lot of allocated
sk_buff and rtinfo objects.
