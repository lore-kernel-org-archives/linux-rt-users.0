From: Guennadi Liakhovetski <gl-o/hVf8ie6tKzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [2.6.20-rt8] "Neighbour table overflow."
Date: Mon, 19 Mar 2007 16:21:20 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703191617250.534@pcgl.dsa-ac.de>
References: <Pine.LNX.4.63.0703161653400.534@pcgl.dsa-ac.de>
	<20070316161653.GC9413@elte.hu>
	<Pine.LNX.4.63.0703161722280.534@pcgl.dsa-ac.de>
	<20070316.121539.78711178.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: irda-users-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, mingo-X9Un+BFzKDI@public.gmane.org,
	linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Return-path: <irda-users-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20070316.121539.78711178.davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/irda-users>,
	<mailto:irda-users-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=irda-users>
List-Post: <mailto:irda-users-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:irda-users-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/irda-users>,
	<mailto:irda-users-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: irda-users-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: irda-users-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 16 Mar 2007, David Miller wrote:

> From: Guennadi Liakhovetski <gl-o/hVf8ie6tKzQB+pC5nmwQ@public.gmane.org>
> Date: Fri, 16 Mar 2007 17:26:57 +0100 (CET)
>
>> it comes from net/ipv4/route.c::rt_intern_hash()... That's all I can say
>> so far. Any debug ideas? Could you try on any your rt-test system just a
>> loop like
>
> There is an SKB leak somewhere, and that leaked SKB has references to
> a route, that's what that message usually means.

Do you have an idea how to debug this? I tried just replacing all 
(dev_)alloc_skb and (dev_)kfree_skb in net/irda and drivers/net/irda, and 
I get for each skb address more free than alloc calls...

> After you accumulate enough leaked packets with routed attached them,
> the system refuses to create any more of them.

What does this mean - packets with routing attached to them? Are these 
only some specific packets and the rest don't have this? can I detect 
them?

> Probably if you look at /proc/slabinfo you'll see a lot of allocated
> sk_buff and rtinfo objects.

skbuff_head_cache grows

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
