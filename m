From: Christoph Lameter <cl@linux-foundation.org>
Subject: Re: RFC: THE OFFLINE SCHEDULER
Date: Tue, 1 Sep 2009 14:46:10 -0400 (EDT)
Message-ID: <alpine.DEB.1.10.0909011443100.12112@V090114053VZO-1>
References: <1251282598.3514.20.camel@raz>  <alpine.DEB.1.10.0908260943090.9924@gentwo.org>  <1251297910.1791.22.camel@maxim-laptop> <1251322663.3882.48.camel@raz>  <4A96B997.1070001@nortel.com>  <alpine.DEB.1.10.0908271257270.17470@gentwo.org>
 <alpine.LFD.2.00.0908272242500.2888@localhost.localdomain>  <4A97071F.5070804@novell.com> <4A973DAE.4020508@redhat.com>  <4A975025.8030500@novell.com> <4A975CC4.1090208@novell.com>  <alpine.LFD.2.00.0908281218560.2888@localhost.localdomain>
 <alpine.DEB.1.10.0908281446520.7317@gentwo.org>  <alpine.LFD.2.00.0908282100040.19335@localhost.localdomain>  <alpine.DEB.1.10.0908281551450.17784@gentwo.org>  <alpine.LFD.2.00.0908282158100.19335@localhost.localdomain>  <alpine.DEB.1.10.0908281619520.15573@gentwo.org>
 <4A995F53.50509@hp.com>  <alpine.DEB.1.10.0908311520500.26046@V090114053VZO-1> <1251732802.18584.135.camel@twins>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: jim owens <jowens@hp.com>, Thomas Gleixner <tglx@linutronix.de>,
	Gregory Haskins <ghaskins@novell.com>,
	Rik van Riel <riel@redhat.com>,
	Chris Friesen <cfriesen@nortel.com>,
	raz ben yehuda <raziebe@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, mingo@elte.hu,
	maximlevitsky@gmail.com, efault@gmx.de, wiseman@macs.biu.ac.il,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753937AbZIAPGa@vger.kernel.org>
In-Reply-To: <1251732802.18584.135.camel@twins>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 31 Aug 2009, Peter Zijlstra wrote:

> On Mon, 2009-08-31 at 15:22 -0400, Christoph Lameter wrote:
> >
> > Stats updates are performed if needed or not. Same with slab expiration.
> > Thats why its necessary to Offline the cpu.
>
> Or we fix it to not do anything when not needed.
>
> Come-on Christoph this ain't rocket science.

Well lets try it then. Not sure that I can be too much help as long as we
have issues with UDP weirdness in the network layers. Bugs before feature
work.... Sigh.
