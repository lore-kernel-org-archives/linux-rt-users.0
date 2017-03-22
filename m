From: Julia Cartwright <julia@ni.com>
Subject: Re: [PATCH v2 7/9] gpio: 104-idi-48: make use of raw_spinlock
 variants
Date: Wed, 22 Mar 2017 11:11:16 -0500
Message-ID: <20170322161116.GI10423@jcartwri.amer.corp.natinst.com>
References: <cover.1490135047.git.julia@ni.com>
 <a9b84439c28b96a9b6a4cbfca85f1e13a457d25d.1490135047.git.julia@ni.com>
 <20170322124414.GA22323@sophia>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:43873 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1758611AbdCVQLc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 22 Mar 2017 12:11:32 -0400
Content-Disposition: inline
In-Reply-To: <20170322124414.GA22323@sophia>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Mar 22, 2017 at 08:44:14AM -0400, William Breathitt Gray wrote:
> On Tue, Mar 21, 2017 at 05:43:07PM -0500, Julia Cartwright wrote:
> >The 104-idi-48 gpio driver currently implements an irq_chip for handling
> >interrupts; due to how irq_chip handling is done, it's necessary for the
> >irq_chip methods to be invoked from hardirq context, even on a a
> >real-time kernel.  Because the spinlock_t type becomes a "sleeping"
> >spinlock w/ RT kernels, it is not suitable to be used with irq_chips.
> >
> >A quick audit of the operations under the lock reveal that they do only
> >minimal, bounded work, and are therefore safe to do under a raw spinlock.
> >
> >Signed-off-by: Julia Cartwright <julia@ni.com>
> 
> Hi Julia,
> 
> This driver also uses a second spinlock_t, called ack_lock, to prevent
> reentrance into the idi_48_irq_handler function. Should ack_lock also be
> implemented as a raw_spinlock_t?

I saw this lock, and I don't even understand it's purpose.

However, I think I convinced myself that it's harmless.  Why?  It's only
ever acquired in a handler registered with request_irq(), which, on RT,
is invoked in a context which can sleep.

Thanks for taking a closer look!

   Julia
