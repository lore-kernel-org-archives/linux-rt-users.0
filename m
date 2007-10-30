From: Daniel Walker <dwalker@mvista.com>
Subject: Re: CONFIG_CRITICAL_IRQSOFF_TIMING
Date: Tue, 30 Oct 2007 14:05:51 -0700
Message-ID: <1193778351.4673.26.camel@imap.mvista.com>
References: <6252335.1612671193778588591.JavaMail.www@wwinf6102>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: gerritbinnenmars@wanadoo.nl
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:2896 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754605AbXJ3VLj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 30 Oct 2007 17:11:39 -0400
In-Reply-To: <6252335.1612671193778588591.JavaMail.www@wwinf6102>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2007-10-30 at 22:09 +0100, Gerrit Binnenmars wrote:
> > Datum: 30/10/07 10:02 PM
> > Van: "Daniel Walker" 
> > Aan: gerritbinnenmars@wanadoo.nl
> > CC: linux-rt-users@vger.kernel.org
> > Onderwerp : Re: CONFIG_CRITICAL_IRQSOFF_TIMING
> > 
> > On Tue, 2007-10-30 at 21:52 +0100, Gerrit Binnenmars wrote:
> > 
> > > CONFIG_LTT_PROBE_LOCKING=m
> > > # CONFIG_LTT_PROBE_STACK is not set
> > 
> > I wonder which kernel your using? I don't recall LTT being part of real
> > time in the past .. What the architecture too ?
> 
> Hello Daniel,
> I use version 2.6.22.1-rt4, see the following link for LTT compatibility
> http://ltt.polymtl.ca/svn/ltt/branches/poly/doc/developer/lttng-lttv-compatibility.html
> 
> I have used LTT on both i386 an on a PowerPC (MPC8555) architecture.
> It is a great help in understanding real-time behaviour.

Did you add LTT into your kernel on your own?

Daniel
