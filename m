From: Manikandan Ramachandran <crmanik@gmail.com>
Subject: Re: BKL & latency
Date: Wed, 29 Sep 2010 18:47:49 -0700
Message-ID: <AANLkTikVqUtvtH7wSKTnyebrumU-_WrsRTeca3sBxWwt@mail.gmail.com>
References: <AANLkTimikhQEFSALtgH7+wRqHCHNv1RzdYW6YHi92BPf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Tony Poppleton <tony.poppleton@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57001 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169Ab0I3Bru convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 29 Sep 2010 21:47:50 -0400
Received: by wyb28 with SMTP id 28so1402790wyb.19
        for <linux-rt-users@vger.kernel.org>; Wed, 29 Sep 2010 18:47:49 -0700 (PDT)
In-Reply-To: <AANLkTimikhQEFSALtgH7+wRqHCHNv1RzdYW6YHi92BPf@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Yeap RT has made BKL preemptible. In RT BKL is mutex[sort of counting
mutex] instead of spinlock.

See my inline response to your query.

On Wed, Sep 29, 2010 at 8:11 AM, Tony Poppleton
<tony.poppleton@gmail.com> wrote:
> Hi,
>
> I have read that with each new kernel release, the Big Kernel Lock
> (BKL) is gradually being removed from the core kernel code.
>
> Just out of interest, I was wondering if this has an impact on the RT=
 patch?
>
> In particular,
> =A0- does the RT patch have any connection with the BKL?
[MANI:Yes]
> =A0- presumably the BKL removal will reduce the average latency of th=
e
> unpatched kernel?
[MANI: I don't think it is that straight forward. You can avoid BKL in
some cases. For eg, you can use unlocked_ioctl instead of ioctl]
> =A0- is the BKL currently a source of considerable latency?
[MANI: Yes, but I dont have any stats to prove it though]
> =A0- will the BKL removal make the RT patch coniderably smaller/simpl=
er?
[MANI: Like I said RT just made BKL a mutex]
> =A0- has the RT patch effectively been removing the BKL since day 1, =
or
> does it just make the BKL a pre-emptible lock?
>
> Many thanks,
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Thanks,
Manik

Think twice about a tree before you take a printout
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
