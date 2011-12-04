From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: IRQ "nobody cared...Disabling" errors on linux-3.0.10-rt27 on
 SMP AMD64 system
Date: Sun, 4 Dec 2011 14:32:39 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1112041428560.2735@ionos>
References: <4ECCE979.5080109@cedwards.geek.nz>  <1322056363.20742.45.camel@frodo>  <4ECD7DCC.3000505@ripples.dyndns.org> <1322691017.24563.9.camel@frodo> <4ED9EEB2.6070401@ripples.dyndns.org> <alpine.LFD.2.02.1112031726370.2735@ionos>
 <4EDAAEFD.9060209@ripples.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Chris Edwards <cedwards@ripples.dyndns.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52208 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752928Ab1LDNco (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 4 Dec 2011 08:32:44 -0500
In-Reply-To: <4EDAAEFD.9060209@ripples.dyndns.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, 4 Dec 2011, Chris Edwards wrote:
> On 04/12/11 05:29, Thomas Gleixner wrote:
> > Ok, that tells us something. So there is something unhappy in your
> > system about the way how the threaded irq handling works. Can you
> > please provide the output of lspci -vvv and a full boot log (any
> > 3.0/3.2 kernel you have handy)?
> 
> Attached. :)

Could you disable the e1000 for a test? Just boot up and bring the
interface down.

Does that change the situation?

Thanks,

	tglx
