From: "emin ak" <eminak71@gmail.com>
Subject: Re: v2.6.21-rt3
Date: Fri, 18 May 2007 11:10:05 +0300
Message-ID: <2cf1ee820705180110y740de989ma48553d4b2188845@mail.gmail.com>
References: <20070517194143.GA25394@elte.hu>
	 <2cf1ee820705180039l1d72005fq2169f8fa36e12377@mail.gmail.com>
	 <1179474804.12981.57.camel@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Ingo Molnar" <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: "Thomas Gleixner" <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.227]:6000 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754795AbXERIKG (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 18 May 2007 04:10:06 -0400
Received: by wr-out-0506.google.com with SMTP id 76so916942wra
        for <linux-rt-users@vger.kernel.org>; Fri, 18 May 2007 01:10:06 -0700 (PDT)
In-Reply-To: <1179474804.12981.57.camel@chaos>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Yes, 2.6.21 was compiled and boot successfully for ppc, Is 85xx family
supported for powerpc arch?
Thanks.

2007/5/18, Thomas Gleixner <tglx@linutronix.de>:
> On Fri, 2007-05-18 at 10:39 +0300, emin ak wrote:
> > Hi,
> > I have tried to compile -rt3 patch for ppc (mpc8540ads) and it failed
> > with undefined referance errors on ppc/kernel/asm-offsets.c. Here is
> > the compiler outputs:
>
> arch/ppc is known to be broken. Does it even compile on 2.6.21 vanilla ?
>
>         tglx
>
>
>
