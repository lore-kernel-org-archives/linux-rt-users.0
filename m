From: jordan <triplesquarednine@gmail.com>
Subject: Re: kernel 2.6.39
Date: Sat, 21 May 2011 11:08:16 -0400
Message-ID: <BANLkTi=exhwVt=_uNS8rSsaVx+A8opgUTA@mail.gmail.com>
References: <450FBA9CC12245C59BAF518CF94AC500@e1705>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: E-Blokos <infos@e-blokos.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:63351 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752079Ab1EUPIR (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 21 May 2011 11:08:17 -0400
Received: by ewy4 with SMTP id 4so1423250ewy.19
        for <linux-rt-users@vger.kernel.org>; Sat, 21 May 2011 08:08:16 -0700 (PDT)
In-Reply-To: <450FBA9CC12245C59BAF518CF94AC500@e1705>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> does it mean that -RT option is now in the kernel core ?

not exactly. From what i have seen discussed on this list, Jack-dev
list and through googling ~ 2.6.39 contains one of the main parts of
the RT series.  It's called something like
"forced-interruupt-threading" in the kernel config (can't remember the
exact phrase).  So RT is almost upstream. but i think there are still
a few patches/parts to migrate over.

2.6.39 is pretty good, i use RT mostly for music/recording
applications - and am using 2.6.39 over 2.6.33-rt . Mind you, I can't
even use .33 anymore, because it is too outdated and isn't very usable
on my main desktop PC.

It does look like RT will be totally mainline soonish, although 2.6.37
is supposed to have an RT kernel. I guess we will see what happens,
but i for one will be happy when it's all upstream, so that i can
always keep my kernel current, while still being able to use all of my
RT-type apps effectively.

jordan
