From: "Fernando Gomes" <fernando.gomes@efacec.com>
Subject: RE: Issue (NOT RELATED TO RT-PATCH) with clock_gettime / clock_nanosleep APIs with high resolution timer on panda board
Date: Wed, 7 Sep 2011 00:00:43 +0100
Message-ID: <BA0FD0EA8282D74CAE2088A5DCB4474B0F7B7438@S005.maia.efacec.pt>
References: <CAFQPvXfaisNL9YN+pUp_cYCRp4YZFCEPt33ZUAZ-Sa6VieAing@mail.gmail.com><alpine.LFD.2.02.1109012121580.2723@ionos><CA+zZMHFhJ81EjM09jRkfyGXtucASf3Ac1KS65TuYw4VDaJ5jFQ@mail.gmail.com><alpine.LFD.2.02.1109020937190.2723@ionos><CA+zZMHGg=Q3rxW9j5iW0CqNNjKbrbSyi6OxQjRe9i1cO5mFRuA@mail.gmail.com><CA+zZMHGndWUm09CT+ogoAPMM61FYcYG453KcAjtxOtjNoSB17A@mail.gmail.com> <CAFQPvXfiyCNwn9Z3ZmVFt5nc1qB-pAP+atPOkOjMqGq=dPPKTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Thomas Gleixner" <tglx@linutronix.de>,
	"linux-rt-users" <linux-rt-users@vger.kernel.org>
To: "Sankara Muthukrishnan" <sankara.m@gmail.com>,
	"Michael Mueller" <ss7box@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail2.efacec.com ([62.28.144.243]:23299 "HELO mail2.efacec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755295Ab1IFXOK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Sep 2011 19:14:10 -0400
Content-class: urn:content-classes:message
In-Reply-To: <CAFQPvXfiyCNwn9Z3ZmVFt5nc1qB-pAP+atPOkOjMqGq=dPPKTA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

We made the test today on our custom board based on a OMAP L138 (ARM9) =
using Linux 3.0 with high resolution timers enabled in the kernel (with=
out RT patch). Our test ran for more than 4 hours without any issue. So=
 it seems that this issue doesn't appear on all the ARM platforms.

Best regards

=46ernando

-----Original Message-----
=46rom: linux-rt-users-owner@vger.kernel.org [mailto:linux-rt-users-own=
er@vger.kernel.org] On Behalf Of Sankara Muthukrishnan
Sent: ter=E7a-feira, 6 de Setembro de 2011 05:08
To: Michael Mueller
Cc: Thomas Gleixner; linux-rt-users
Subject: Re: Issue (NOT RELATED TO RT-PATCH) with clock_gettime / clock=
_nanosleep APIs with high resolution timer on panda board

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


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
