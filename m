From: Borislav Petkov <bp@amd64.org>
Subject: Re: IRQ "nobody cared...Disabling" errors on linux-3.0.10-rt27 on
 SMP AMD64 system
Date: Tue, 6 Dec 2011 20:42:02 +0100
Message-ID: <20111206194201.GE20445@aftab>
References: <1322691017.24563.9.camel@frodo>
 <4ED9EEB2.6070401@ripples.dyndns.org>
 <alpine.LFD.2.02.1112031726370.2735@ionos>
 <4EDAAEFD.9060209@ripples.dyndns.org>
 <alpine.LFD.2.02.1112041428560.2735@ionos>
 <4EDCC978.3060401@cedwards.geek.nz>
 <alpine.LFD.2.02.1112051740510.2735@ionos>
 <20111205181450.GK7834@aftab>
 <alpine.LFD.2.02.1112052200190.2735@ionos>
 <4EDD8314.3060904@cedwards.geek.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@amd64.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Chris Edwards <cedwards.linux@cedwards.geek.nz>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from s15228384.onlinehome-server.info ([87.106.30.177]:45012 "EHLO
	mail.x86-64.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753394Ab1LFTmI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Dec 2011 14:42:08 -0500
Content-Disposition: inline
In-Reply-To: <4EDD8314.3060904@cedwards.geek.nz>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Dec 06, 2011 at 03:51:00PM +1300, Chris Edwards wrote:
> On 06/12/11 10:02, Thomas Gleixner wrote:
> >On Mon, 5 Dec 2011, Borislav Petkov wrote:
> >>On Mon, Dec 05, 2011 at 05:56:01PM +0100, Thomas Gleixner wrote:
> >>
> >>>You could try the following patch. Be aware that it might not work at
> >>>all, but I don't expect that you need a fire extinguisher :)
> 
> No smoke or flames noted. :)  And that appears to have solved the
> problem.  Firewire audio works, and even after running NetPIPE a
> couple of times over that Ethernet interface, there's only a handful
> of interrupts on the Firewire IRQ (as seems to be normal):

Btw,

can you send me

lspci -nn -vvvv

output from the box?

Thanks.

-- 
Regards/Gruss,
Boris.

Advanced Micro Devices GmbH
Einsteinring 24, 85609 Dornach
GM: Alberto Bozzo
Reg: Dornach, Landkreis Muenchen
HRB Nr. 43632 WEEE Registernr: 129 19551
