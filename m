From: Guennadi Liakhovetski <gl-o/hVf8ie6tKzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [2.6.20-rt8] "Neighbour table overflow."
Date: Tue, 20 Mar 2007 16:21:34 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703201527340.534@pcgl.dsa-ac.de>
References: <Pine.LNX.4.63.0703161653400.534@pcgl.dsa-ac.de>
	<20070316161653.GC9413@elte.hu>
	<Pine.LNX.4.63.0703161722280.534@pcgl.dsa-ac.de>
	<20070316.121539.78711178.davem@davemloft.net>
	<Pine.LNX.4.63.0703191617250.534@pcgl.dsa-ac.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: irda-users-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, mingo-X9Un+BFzKDI@public.gmane.org,
	linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Return-path: <irda-users-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.63.0703191617250.534-pjC7uWgG1yLsj6RlE8knwQ@public.gmane.org>
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

On Mon, 19 Mar 2007, Guennadi Liakhovetski wrote:

> On Fri, 16 Mar 2007, David Miller wrote:
>>
>> There is an SKB leak somewhere, and that leaked SKB has references to
>> a route, that's what that message usually means.
>
> Do you have an idea how to debug this? I tried just replacing all 
> (dev_)alloc_skb and (dev_)kfree_skb in net/irda and drivers/net/irda, and I 
> get for each skb address more free than alloc calls...

I wrote a small hashing debugger - from __aloc_skb I store the new skb on 
a hash, from __kfree_skb I remove it from it. The first strange thing that 
occurred to me is that __kfree_skb is very often called on already freed 
skbs. Is it normal? It seems strange as trying to free memory that you no 
longer own can free a newly allocated object at that address.

As for the original problem, looks like the packets that get leaked are 
from af_irda.c::irda_sendmsg(). Any ideas where and when these skbs should 
be freed?

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
