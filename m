From: Sankara Muthukrishnan <sankara.m@gmail.com>
Subject: Re: Issue (NOT RELATED TO RT-PATCH) with clock_gettime /
 clock_nanosleep APIs with high resolution timer on panda board
Date: Mon, 5 Sep 2011 23:08:27 -0500
Message-ID: <CAFQPvXfiyCNwn9Z3ZmVFt5nc1qB-pAP+atPOkOjMqGq=dPPKTA@mail.gmail.com>
References: <CAFQPvXfaisNL9YN+pUp_cYCRp4YZFCEPt33ZUAZ-Sa6VieAing@mail.gmail.com>
	<alpine.LFD.2.02.1109012121580.2723@ionos>
	<CA+zZMHFhJ81EjM09jRkfyGXtucASf3Ac1KS65TuYw4VDaJ5jFQ@mail.gmail.com>
	<alpine.LFD.2.02.1109020937190.2723@ionos>
	<CA+zZMHGg=Q3rxW9j5iW0CqNNjKbrbSyi6OxQjRe9i1cO5mFRuA@mail.gmail.com>
	<CA+zZMHGndWUm09CT+ogoAPMM61FYcYG453KcAjtxOtjNoSB17A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Michael Mueller <ss7box@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48533 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746Ab1IFEI2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Sep 2011 00:08:28 -0400
Received: by vws1 with SMTP id 1so4430536vws.19
        for <linux-rt-users@vger.kernel.org>; Mon, 05 Sep 2011 21:08:27 -0700 (PDT)
In-Reply-To: <CA+zZMHGndWUm09CT+ogoAPMM61FYcYG453KcAjtxOtjNoSB17A@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>On Fri, Sep 2, 2011 at 6:29 AM, Michael Mueller <ss7box@gmail.com> wro=
te:
>
> >> > >
> >> > > =A0 =A0 =A0 =A0clock_gettime(CLOCK_MONOTONIC, &prev);
> >> > > =A0 =A0 =A0 =A0while (1) {
> >> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0clock_gettime(CLOCK_MONOTONIC, &cur=
r);
> >> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0if (curr < prev) /* Use a proper co=
mpare function for
> >> > > timespec! */
> >> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf(.....);
> >> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0prev =3D curr;
> >> > > =A0 =A0 =A0 =A0}

I have tried this on 2 panda boards. Both of them fail this simple
test with vanilla (both single core and SMP) kernels (2.6.39-rc4
mainline with high-resolution timer patch, 3.0.1 mainline with
high-resolution timer patch, 3.1-rc2 OMAP git tree without any patch
but with high-resolution timer enabled) within a few seconds to an
hour. Time goes backwards from as low as 234 nsec to 53 usec. The
problem does not reproduce without high resolution timer (i.e by
enabling 32 KHz timer in kernel config) for several hours of testing.

Everyone, could you please try this test on any other ARM boards (and
x86 machines?) with high resolution timer support?
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
