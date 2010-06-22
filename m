From: Sven-Thorsten Dietrich <thebigcorporation@gmail.com>
Subject: Re: Linux, RT and virtualisation
Date: Tue, 22 Jun 2010 13:11:40 -0700
Message-ID: <1277237500.20886.4.camel@baracus>
References: <20100622172414.GA13372@hades> <4C20FBC9.8030309@am.sony.com>
	 <20100622184938.GB27741@hades>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Frank Rowand <frank.rowand@am.sony.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Luis Henriques <luis.henrix@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:36893 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752814Ab0FVULp (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 22 Jun 2010 16:11:45 -0400
Received: by pvh11 with SMTP id 11so551471pvh.19
        for <linux-rt-users@vger.kernel.org>; Tue, 22 Jun 2010 13:11:44 -0700 (PDT)
In-Reply-To: <20100622184938.GB27741@hades>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2010-06-22 at 19:49 +0100, Luis Henriques wrote:
> On Tue, Jun 22, 2010 at 11:07:05AM -0700, Frank Rowand wrote:
> > On 06/22/10 10:24, luis.henrix@gmail.com wrote:
> > > Hi,
> > > 
> > 
> > < snip >
> > 
> > > Any experiences/thoughts/links?  Would preemptrt+Xen be able to do this?
> > > preemptrt+kvm? Other options?
> > 
> > Some links:
> > 
> > AlacrityVM hypervisor project
> > 
> >   http://developer.novell.com/wiki/index.php/AlacrityVM
> >   http://lwn.net/Articles/345296/
> > 
> > Towards Linux as a Real-Time Hypervisor
> > Eleventh Real-Time Linux Workshop
> > 
> >   http://www.osadl.org/Abstract-20-Towards-Linux-as-a-Real-Tim.rtlws11-abstract20.0.html
> 
> Great, thanks for the links.  Some interesting stuff here.  I actually
> never used AlacrityVM before but it looks like real-time support is still
> something TBD.  Anyway, something to follow closely.
>  

Alacrity was targeted specifically at low latency.

Sven


