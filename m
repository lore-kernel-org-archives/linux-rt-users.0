From: Pradyumna Sampath <pradysam@gmail.com>
Subject: Re: preempt rt in commercial use
Date: Tue, 14 Sep 2010 16:44:43 +0200
Message-ID: <AANLkTimq7RGABRJk=2YQasav_Xd8zC-Qzf63tJRCY12J@mail.gmail.com>
References: <AANLkTinUYXDM_pGoJTd3veNNfYzWVu3Obv8v4RAL0urq@mail.gmail.com>
	<201009141317.13439@zigzag.lvk.cs.msu.su>
	<AANLkTikCwVw9jsg+L_e-kHnhogSdgE+8rrO8O0gDMB5V@mail.gmail.com>
	<20100914094411.GB10841@pengutronix.de>
	<4C8F8500.5070002@theptrgroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robert Schwebel <r.schwebel@pengutronix.de>,
	Raz <raziebe@gmail.com>,
	"Nikita V. Youshchenko" <yoush@cs.msu.su>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Jeff Angielski <jeff@theptrgroup.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49183 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754298Ab0INOoo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 14 Sep 2010 10:44:44 -0400
Received: by bwz11 with SMTP id 11so5551973bwz.19
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Sep 2010 07:44:43 -0700 (PDT)
In-Reply-To: <4C8F8500.5070002@theptrgroup.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

On Tue, Sep 14, 2010 at 4:21 PM, Jeff Angielski <jeff@theptrgroup.com> =
wrote:
> No. =A0Preempt rt it's not hard realtime.
>
> But most people/companies who think they need hard realtime really do=
n't.
> =A0They can live with soft realtime and have a really low probability=
 of
> missing deadlines and having long latencies. =A0For these people, the=
 preempt
> rt is adequate.

I agree. Hard, soft ... far too qualitative for a discussion like
this. Numbers, test cases and applications determine different
meanings of these words.

Top copy a phrase from one of the presentations from dresden.
Real-time need not always be real fast.

hard Real-time =3D Speed + Determinism

So hard real time is a moving target. Would I use RT_PREEMPT to run
servo loops at 60 microseconds on a 160 Mhz powerpc ? Surely not ! Or
not yet.

my 2 cents.

regards
/prady

--=20
http://www.prady.in
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
