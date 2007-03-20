From: Guennadi Liakhovetski <gl@dsa-ac.de>
Subject: Re: [irda-users] [2.6.20-rt8] "Neighbour table overflow."
Date: Tue, 20 Mar 2007 18:02:33 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703201759390.534@pcgl.dsa-ac.de>
References: <mtHxbRRF.1174407786.3649450.samuel@sortiz.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: davem@davemloft.net,
	"irda-users@lists.sourceforge.net" <irda-users@lists.sourceforge.net>,
	"mingo@elte.hu" <mingo@elte.hu>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Samuel Ortiz <samuel@sortiz.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.dsa-ac.de ([62.112.80.99]:49617 "EHLO mail.dsa-ac.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965485AbXCTRCf (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 20 Mar 2007 13:02:35 -0400
In-Reply-To: <mtHxbRRF.1174407786.3649450.samuel@sortiz.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 20 Mar 2007, Samuel Ortiz wrote:

> Well, if you're using IrNET, then those sock_alloc_send_skb() calls
> should come from the IP code (net/ipv4/af_inet.c). Do you have a way to
> verify that ?

The test is running atm. If I've done everything right, I'll have the 
result tomorrow.

> The skb should eventually be freed by the IrDA hardware driver, when the
> frame is actually transmitted. Are you using the pxaficp_ir driver ?

Hardware driver?... hm, interesting. Yes, it's pxaficp_ir.

> P.S.: I propose we remove the -rt people and Mingo from this discussion
> until we know for sure that it's an RT bug. If no one objects, I'll
> remove them from the CC list.

No objections.

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany
