From: Armin Steinhoff <armin@steinhoff.de>
Subject: Re: preempt rt in commercial use
Date: Tue, 14 Sep 2010 14:16:38 +0200
Message-ID: <4C8F67A6.1030409@steinhoff.de>
References: <AANLkTinUYXDM_pGoJTd3veNNfYzWVu3Obv8v4RAL0urq@mail.gmail.com> <201009141317.13439@zigzag.lvk.cs.msu.su> <AANLkTikCwVw9jsg+L_e-kHnhogSdgE+8rrO8O0gDMB5V@mail.gmail.com> <20100914094411.GB10841@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:65140 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753208Ab0INMOo (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 14 Sep 2010 08:14:44 -0400
In-Reply-To: <20100914094411.GB10841@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  Robert Schwebel wrote:
> On Tue, Sep 14, 2010 at 11:24:21AM +0200, Raz wrote:
>> anyone can say preempt rt is hard real time?
> Hard realtime has something to do with how you define "missing the
> deadline". If somebody cuts the cable of your roboter controller in t=
he
> factory hall, the system misses the deadline. So it is all about
> probabilities: hard realtime systems have a very, very low probabilit=
y
> of missing the deadline. However, in real life systems, it is>  0%.
>
> So yes, if you talk about real world, it is hard realtime.
>
Hm, and what do think about that statement from FSMLabs:

"Linux =93PREEMPT=94 real-time is a continuing experiment aimed at audi=
o
and video playing with unreliable results and a detrimental affect on
=93enterprise=94 performance"

--Armin


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
