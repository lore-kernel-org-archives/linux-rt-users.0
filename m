From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: Linux, RT and virtualisation
Date: Tue, 22 Jun 2010 20:27:13 +0200
Message-ID: <20100622182713.GA29938@opentech.at>
References: <20100622172414.GA13372@hades> <4C20FBC9.8030309@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "luis.henrix@gmail.com" <luis.henrix@gmail.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Frank Rowand <frank.rowand@am.sony.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hofr.at ([212.69.189.236]:55522 "EHLO mail.hofr.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751419Ab0FVS1Q (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 22 Jun 2010 14:27:16 -0400
Content-Disposition: inline
In-Reply-To: <4C20FBC9.8030309@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 22 Jun 2010, Frank Rowand wrote:

> On 06/22/10 10:24, luis.henrix@gmail.com wrote:
> > Hi,
> > 
> 
> < snip >
> 
> > Any experiences/thoughts/links?  Would preemptrt+Xen be able to do this?
> > preemptrt+kvm? Other options?
> 
> Some links:
> 
> AlacrityVM hypervisor project
> 
>   http://developer.novell.com/wiki/index.php/AlacrityVM
>   http://lwn.net/Articles/345296/
> 
> Towards Linux as a Real-Time Hypervisor
> Eleventh Real-Time Linux Workshop
> 
>   http://www.osadl.org/Abstract-20-Towards-Linux-as-a-Real-Tim.rtlws11-abstract20.0.html
> 
>
there also are other solutions around specifically for legacy management - one might be XtratuM (www.xtratum.org), a further one L4 (http://www.inf.tu-dresden.de). Both of these are open-source solutions and explicidly target RT and legacy-system level "recycling".

hofrat

hofrat 
