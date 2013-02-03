From: jordan <triplesquarednine@gmail.com>
Subject: Re: rt patch for kernel v3.7.5
Date: Sun, 3 Feb 2013 08:35:44 -0500
Message-ID: <CAOcfFMz+vxm5EoKCGNiDZJuVmDEtkHQ4DX6TTM3ciDOjyPvi=w@mail.gmail.com>
References: <1359861287.43330.YahooMailNeo@web190604.mail.sg3.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Kks Kbase <kks.kbase@yahoo.in>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:43921 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752258Ab3BCNfp (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 3 Feb 2013 08:35:45 -0500
Received: by mail-ob0-f169.google.com with SMTP id ta14so5602811obb.14
        for <linux-rt-users@vger.kernel.org>; Sun, 03 Feb 2013 05:35:45 -0800 (PST)
In-Reply-To: <1359861287.43330.YahooMailNeo@web190604.mail.sg3.yahoo.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> Hi,

Hi ;)

> I noticed there is stable version of latest kernel v3.7.5 and I need rt patch for this kernel version to build kernel.
>
> But I couldn't find it on rt projects patch download page.
>
> Can I have patch for it?

The reason you cannot find an -rt patch for 3.7.5 is because it does
not exist. Linux-rt does not explicitly follow upstream releases of
the linux kernel... Generally, it tends to 'jump' every couple of
upstream releases . For example; we have 3.0-rt, 3.2-rt, 3.4-rt and
3.6-rt... There is no -rt releases in between these.

I'm not an rt-developer, so one of them can correct me if i am wrong,
but i do not believe that there will be an 3.7-rt release...

I can only assume 3.8-rt will be next. (although personally, i am
waiting to see, and hope that it will be based on 3.9 since there is a
feature in there, that i am looking forward to using with -rt patch).

if there happens to be some feature that you need from 3.7.5 - you
will likely need to wait until the next -rt series is released.

cheerz

Jordan
