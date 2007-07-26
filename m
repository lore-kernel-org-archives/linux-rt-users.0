From: Juergen Beisert <juergen127@kreuzholzen.de>
Subject: Re: [Trace how to] Kernel Bug when entering something after login
Date: Thu, 26 Jul 2007 14:45:29 +0200
Message-ID: <200707261445.30391.juergen127@kreuzholzen.de>
References: <200707251900.47704.juergen127@kreuzholzen.de> <200707261000.25465.juergen127@kreuzholzen.de> <f87351060707260534k2f87ff47rdcfd0b787d5a0132@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Pradyumna Sampath" <pradyumna.sampath@gmail.com>,
	linux-rt-users@vger.kernel.org
To: linuxppc-embedded@ozlabs.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from bill.weihenstephan.org ([82.135.35.21]:38331 "EHLO
	bill.weihenstephan.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757692AbXGZMpc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 26 Jul 2007 08:45:32 -0400
In-Reply-To: <f87351060707260534k2f87ff47rdcfd0b787d5a0132@mail.gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thursday 26 July 2007 14:34, Pradyumna Sampath wrote:
> Hi Everyone,
>
> On 7/26/07, Juergen Beisert <juergen127@kreuzholzen.de> wrote:
> > On Wednesday 25 July 2007 21:06, Thomas Gleixner wrote:
> > > Solution below
> >
> > Seems to work now. Thanks.
> >
> > Juergen
> > -
>
> First of all very sorry to cross post.
>
> I discovered the same problem on our MPC5200 and it after patching, it
> now works. But I could somehow not get the call trace and hence could
> not report the bug.
>
> I compiled the kernel with "CONFIG_FUNCTION_TRACE" and then I get
> undefined references on "early_printk". Is there something I am doing
> wrong in the kernel config or was there an additional patch to enable
> this support for MPC5200 ?
>
> I see more bugs when I run "stress" but I cant solve them or even
> report them, because I cant see the trace information.

Activate "General setup" -> "Configure standard kernel features (for small 
systems)" -> "Load all symbols for debugging/ksymoops"

Juergen
