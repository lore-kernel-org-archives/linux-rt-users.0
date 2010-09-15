From: jordan <triplesquarednine@gmail.com>
Subject: Re: preempt rt in commercial use
Date: Tue, 14 Sep 2010 23:38:49 -0400
Message-ID: <AANLkTi=v_vgk=QwCZPDZWVp+z57_jaPc5=CCnA0Wfmr_@mail.gmail.com>
References: <AANLkTinUYXDM_pGoJTd3veNNfYzWVu3Obv8v4RAL0urq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Raz <raziebe@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:55897 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752222Ab0IODiv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 14 Sep 2010 23:38:51 -0400
Received: by ewy23 with SMTP id 23so3417529ewy.19
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Sep 2010 20:38:50 -0700 (PDT)
In-Reply-To: <AANLkTinUYXDM_pGoJTd3veNNfYzWVu3Obv8v4RAL0urq@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Raz,

> Hello
> some companies asked me to show that premmpt rt is comercially used.
> are you using it ?

A big one would be the TSE (Tokyo Stock Exchange).  "Arrowhead" is
built on RedHat Enterprise, and is a "hard real-time" system.  I have
a feeling that a lot of the financial sector (in the US/canada/europe)
are using rt-linux.

Next, in the Pro-audio sector, you have Muse Research who make the
"Recepter".  Which is a hardware VST host. It was developed so Artists
could use the same sounds/plugins produced in the studio live.
All of the big names in the music industry use them live, and/or in
the studio. as they are very robust, and reliable.
(you can't have your sound skipping, when your playing in front of
thousands of people).

Then there is "CableCam", which is an Rt-linux based high-flying
Camera. Used in Professional Sports heavily, and equally, if not more
so, by the Film Industry...

Which leads me to my last example. Most people are aware that since
about 1999-2000, Linux has dominated the movie industry. Beginning
with Titanic and even today with say, Avatar.

I would be willing to bet, that all of those wonderful rendering farms
and production suites, are
in fact using rt-linux.

Beyond that, IBM, Intel, Novell, FSMLabs, Oracle, RedHat.....

I hope that helps, there is a lot of info available around the
interweb. Lots of papers, by companies on the subject. and lots of
case examples of usage.

Jordan
