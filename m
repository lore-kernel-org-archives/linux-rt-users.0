From: John Culvertson <jculvertson@gmail.com>
Subject: Re: 2.6.33.6-rt28 kernel oops while stressing network
Date: Fri, 13 Aug 2010 13:37:33 -0400
Message-ID: <AANLkTimnHPhLSxgiX3rrFso-1NKsvp++tHxwGCvqO-Cq@mail.gmail.com>
References: <AANLkTi=NBDyUAL=JpUV4h1-syFS3n=Z9aNxAM+eNoHW6@mail.gmail.com>
	<AANLkTi=tPSeXTZkjPPm_MGmmOx2fZhryOkajgssv0EsX@mail.gmail.com>
	<AANLkTinOmnq0hxL9TaZAuu0x5LORAOKuGYFUam9fMzzo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:54508 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761879Ab0HMRhd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Aug 2010 13:37:33 -0400
Received: by pvg2 with SMTP id 2so889280pvg.19
        for <linux-rt-users@vger.kernel.org>; Fri, 13 Aug 2010 10:37:33 -0700 (PDT)
In-Reply-To: <AANLkTinOmnq0hxL9TaZAuu0x5LORAOKuGYFUam9fMzzo@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Since it was my understanding that x86 was the most mature and stable
architecture for preempt-rt, I was surprised when I immediately
encountered problems.  Is this typical when trying the patches on a
new platform?  Like I mentioned before, I am a newbie with preempt-rt.

On Wed, Aug 11, 2010 at 12:53 PM, John Culvertson <jculvertson@gmail.com> wrote:
> I updated to 2.6.33.7-rt29, and I am seeing similar symptoms.
>
> [ 2120.781166] BUG: unable to handle kernel paging request at c11cd497
> [ 2120.784018] IP: [<c11d5ce2>] tcp_set_skb_tso_segs+0x33/0x85
> [ 2120.784018] *pde = 1d7f6063 *pte = 011cd161
> [ 2120.784018] Oops: 0003 [#1] PREEMPT
