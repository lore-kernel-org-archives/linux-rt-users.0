From: jordan <triplesquarednine@gmail.com>
Subject: Re: kernel 2.6.39
Date: Sun, 22 May 2011 14:09:11 -0400
Message-ID: <BANLkTinAFwEoCkPUV5m1Kf=F1i5AXyi85w@mail.gmail.com>
References: <450FBA9CC12245C59BAF518CF94AC500@e1705>
	<BANLkTi=exhwVt=_uNS8rSsaVx+A8opgUTA@mail.gmail.com>
	<BANLkTi=7HuChAsv2OrsaBsRx2Rtnc4Sn+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: E-Blokos <infos@e-blokos.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Mugunth <mugunthanvnm@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:34832 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768Ab1EVSJN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 22 May 2011 14:09:13 -0400
Received: by eyx24 with SMTP id 24so1613270eyx.19
        for <linux-rt-users@vger.kernel.org>; Sun, 22 May 2011 11:09:11 -0700 (PDT)
In-Reply-To: <BANLkTi=7HuChAsv2OrsaBsRx2Rtnc4Sn+g@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> Hi Jordan,

hi,

> I am new to RT kernel. I am trying to use 2.6.37 kernel with RT. I am=
 unable
> to succeed.

you are unable to succeed, because there is no 2.6.37-rt available.
last i heard the patchset was being worked on, not actually available
-  you must use 2.6.33-rt. that is the last stable release of RT.

> Since you are using 2.6.39 with RT.=A0Are you using any patches which=
 are not
> mainlined in kernel, so that I can also contribute in testing your pa=
tches.

AFAIK, I am not using 2.6.39 with RT - i am using 2.6.39 which
includes one of the main features that RT provided. I have the
forced-interrupt-threading - enabled in my kernel  (using nconfig
before compiling 2.6.39, to customize my kernel how i wanted it).

I am not an RT maintainer, or even contributor. I do not write patches
and am an end-user. (i use RT, specifically for proaudio on the Linux
platform).

I was just answering E-BLOKOS' question, because it seemed as if he
wasn't aware as to why those commits in 2.6.39 would show bits of code
related to and specific to RT.

jordan
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
