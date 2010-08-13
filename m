From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: 2.6.33.6-rt28 kernel oops while stressing network
Date: Fri, 13 Aug 2010 13:17:08 -0700
Message-ID: <4C65A844.1010702@gmail.com>
References: <AANLkTi=NBDyUAL=JpUV4h1-syFS3n=Z9aNxAM+eNoHW6@mail.gmail.com>	<AANLkTi=tPSeXTZkjPPm_MGmmOx2fZhryOkajgssv0EsX@mail.gmail.com>	<AANLkTinOmnq0hxL9TaZAuu0x5LORAOKuGYFUam9fMzzo@mail.gmail.com>	<AANLkTimnHPhLSxgiX3rrFso-1NKsvp++tHxwGCvqO-Cq@mail.gmail.com>	<D61182AC8012EA4EBC531B3AF23BE1099C86D3@tranzeo-mail2.12stewart.tranzeo.com>	<AANLkTikty=V_==0udO9F2MxpVxwuLzyOQZt0ha5=VC3y@mail.gmail.com> <AANLkTimU0pf-9xRzJ8p4-OY=itmfjS3GJX4CKBZ9XorG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: John Culvertson <jculvertson@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:54525 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753345Ab0HMURM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Aug 2010 16:17:12 -0400
Received: by ewy23 with SMTP id 23so1543914ewy.19
        for <linux-rt-users@vger.kernel.org>; Fri, 13 Aug 2010 13:17:11 -0700 (PDT)
In-Reply-To: <AANLkTimU0pf-9xRzJ8p4-OY=itmfjS3GJX4CKBZ9XorG@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  On 08/13/2010 11:07 AM, John Culvertson wrote:
> Thanks for the suggestions.  I have tried the unpatched 2.6.33.7
> kernel, and the problem does not occur.  The hardware is a single
> board industrial computer with the network controllers onboard, so I
> cannot easily try different NICs.  I have not seen the problem occur
> with only one port in use, but I have not tested that long enough to
> be positive.
>
> One thing that may be a little odd about this computer is that both
> Ethernet controllers (Intel 82559) share the same PCI interrupt.
> Interrupt sharing should be OK, but since adjacent PCI slots in normal
> PCs generally use different interrupts, it may not occur often in
> other systems.
>

Does it reproduce when you turn off PREEMPT_RT, but leave all the IRQ 
threading options enabled?


