From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: RFC: THE OFFLINE SCHEDULER
Date: Mon, 31 Aug 2009 17:33:22 +0200
Message-ID: <1251732802.18584.135.camel@twins>
References: <1251282598.3514.20.camel@raz>
	 <alpine.DEB.1.10.0908260943090.9924@gentwo.org>
	 <1251297910.1791.22.camel@maxim-laptop> <1251322663.3882.48.camel@raz>
	 <4A96B997.1070001@nortel.com>
	 <alpine.DEB.1.10.0908271257270.17470@gentwo.org>
	 <alpine.LFD.2.00.0908272242500.2888@localhost.localdomain>
	 <4A97071F.5070804@novell.com> <4A973DAE.4020508@redhat.com>
	 <4A975025.8030500@novell.com> <4A975CC4.1090208@novell.com>
	 <alpine.LFD.2.00.0908281218560.2888@localhost.localdomain>
	 <alpine.DEB.1.10.0908281446520.7317@gentwo.org>
	 <alpine.LFD.2.00.0908282100040.19335@localhost.localdomain>
	 <alpine.DEB.1.10.0908281551450.17784@gentwo.org>
	 <alpine.LFD.2.00.0908282158100.19335@localhost.localdomain>
	 <alpine.DEB.1.10.0908281619520.15573@gentwo.org> <4A995F53.50509@hp.com>
	 <alpine.DEB.1.10.0908311520500.26046@V090114053VZO-1>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: jim owens <jowens@hp.com>, Thomas Gleixner <tglx@linutronix.de>,
	Gregory Haskins <ghaskins@novell.com>,
	Rik van Riel <riel@redhat.com>,
	Chris Friesen <cfriesen@nortel.com>,
	raz ben yehuda <raziebe@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, mingo@elte.hu,
	maximlevitsky@gmail.com, efault@gmx.de, wiseman@macs.biu.ac.il,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Christoph Lameter <cl@linux-foundation.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:37169 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929AbZHaPfo (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 31 Aug 2009 11:35:44 -0400
In-Reply-To: <alpine.DEB.1.10.0908311520500.26046@V090114053VZO-1>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2009-08-31 at 15:22 -0400, Christoph Lameter wrote:
> 
> Stats updates are performed if needed or not. Same with slab expiration.
> Thats why its necessary to Offline the cpu.

Or we fix it to not do anything when not needed.

Come-on Christoph this ain't rocket science.
