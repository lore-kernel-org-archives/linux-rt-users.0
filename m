From: "Samuel Ortiz" <samuel@sortiz.org>
Subject: Re: [irda-users] [2.6.20-rt8] "Neighbour table overflow."
Date: 20 Mar 2007 16:23:06 -0000
Message-ID: <mtHxbRRF.1174407786.3649450.samuel@sortiz.org>
References: <Pine.LNX.4.63.0703201628590.534@pcgl.dsa-ac.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "irda-users@lists.sourceforge.net" <irda-users@lists.sourceforge.net>,
	"mingo@elte.hu" <mingo@elte.hu>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: gl@dsa-ac.de, davem@davemloft.net
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 25.mail-out.ovh.net ([213.186.37.103]:54734 "HELO
	25.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750951AbXCTQXT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 20 Mar 2007 12:23:19 -0400
In-Reply-To: <Pine.LNX.4.63.0703201628590.534@pcgl.dsa-ac.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


On 3/20/2007, "Guennadi Liakhovetski" <gl@dsa-ac.de> wrote:

>On Tue, 20 Mar 2007, Guennadi Liakhovetski wrote:
>
>> As for the original problem, looks like the packets that get leaked are
>> from af_irda.c::irda_sendmsg(). Any ideas where and when these skbs should
>> be freed?
>
>No, I actually only see that they are created in sock_alloc_send_skb(),
>so, I assumed it was the call in af_irda.c::irda_sendmsg(), which,
>however, seems to be not the case now.
Well, if you're using IrNET, then those sock_alloc_send_skb() calls
should come from the IP code (net/ipv4/af_inet.c). Do you have a way to
verify that ?
The skb should eventually be freed by the IrDA hardware driver, when the
frame is actually transmitted. Are you using the pxaficp_ir driver ?

Cheers,
Samuel.

P.S.: I propose we remove the -rt people and Mingo from this discussion
until we know for sure that it's an RT bug. If no one objects, I'll
remove them from the CC list.


>Thanks
>Guennadi
>---------------------------------
>Guennadi Liakhovetski, Ph.D.
>DSA Daten- und Systemtechnik GmbH
>Pascalstr. 28
>D-52076 Aachen
>Germany
>
>-------------------------------------------------------------------------
>Take Surveys. Earn Cash. Influence the Future of IT
>Join SourceForge.net's Techsay panel and you'll get the chance to share your
>opinions on IT & business topics through brief surveys-and earn cash
>http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
>_______________________________________________
>irda-users mailing list
>irda-users@lists.sourceforge.net
>http://lists.sourceforge.net/lists/listinfo/irda-users
