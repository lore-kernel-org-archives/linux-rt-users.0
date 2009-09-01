From: Cliff Brake <cliff.brake@gmail.com>
Subject: Re: RT tests on OMAP3
Date: Mon, 31 Aug 2009 23:18:33 -0400
Message-ID: <f96d234e0908312018j5f36d6e1s95319f4669105d06@mail.gmail.com>
References: <f96d234e0908311350u5d3d7680gfbf46a1c8f9de58f@mail.gmail.com>
	 <f96d234e0908312016v4ffb9765pe06dc53e5e679758@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: rt-users <linux-rt-users@vger.kernel.org>,
	Linux OMAP Users <linux-omap@vger.kernel.org>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <f96d234e0908312016v4ffb9765pe06dc53e5e679758@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, Aug 31, 2009 at 11:16 PM, Cliff Brake<cliff.brake@gmail.com> wr=
ote:

> Applying
>
> http://cgit.openembedded.org/cgit.cgi/openembedded/diff/recipes/linux=
/linux-omap-2.6.29/0001-implement-TIF_RESTORE_SIGMASK-support-and-enabl=
e-the.patch?id=3D1f0d91e152f16fbd40bb2fb3c44a30d774d4dede
>
> Seems to fix or mask the udev problems. =A0But, with preempt-rt, and
> EHCI enabled, I still get messages continually scrolling:

A few more notes, the above patch is not required to make the PXA270
work.  Without EHCI enabled, the system boots and performs fairly
normal (I'm able to log in, etc).

Cliff
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
