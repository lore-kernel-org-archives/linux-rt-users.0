From: Victor henri <nadaeck@hotmail.com>
Subject: RE: disk thread problem when using RT kernel
Date: Thu, 3 Feb 2011 22:34:07 +0100
Message-ID: <SNT110-W57B8947044119C3574D92BA8E70@phx.gbl>
References: <SNT110-W5817A2D3ADD8DC29980D08A8E70@phx.gbl>,<4D4B17EE.3020309@cygnusx-1.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from snt0-omc1-s19.snt0.hotmail.com ([65.55.90.30]:48458 "EHLO
	snt0-omc1-s19.snt0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753173Ab1BCVeI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 3 Feb 2011 16:34:08 -0500
In-Reply-To: <4D4B17EE.3020309@cygnusx-1.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Hello
=20
So if=A0 i understand well 'soft lock' is what i have described in my p=
ost, and what you were experiencing.
=20
The only solution is to wait then?
=20
Thank you for your answer
=20
Victor
=20

----------------------------------------
> Date: Thu, 3 Feb 2011 13:02:38 -0800
> From: linux-rt-users@cygnusx-1.org
> To: linux-rt-users@vger.kernel.org
> Subject: Re: disk thread problem when using RT-kernel
>
> On 02/03/2011 12:50 PM, Victor henri wrote:
> > Hello
> >
> > I'm back after some testing.... and it is a complete mess; actually=
 there is more than that just problems with linuxsampler.... with every=
 RT kernel greater than 2.6.31.12 (i started seeing it on gentoo), i ha=
ve total system freeze... after a few minutes.... to the point that i h=
ave to force shut down the system without proper shutdown (i hate doing=
 that); i have installed "das-watchdog" and see the pop-up window sayin=
g that das watchdog has disabled real-time for 8 seconds... and this po=
p-up appears every 8 sec... (forever)... everything happen before i hav=
e time to play a single note....
> > This old problem is coming again... and i've open a new subject to =
solve this first
> It sounds like you are running into the same problem I did a while
> back. I never got to the bottom of it. I am waiting for the 2.6.37-rt
> kernel. See my thread below.
>
> http://www.spinics.net/lists/linux-rt-users/msg06248.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
 		 	   		  --
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
