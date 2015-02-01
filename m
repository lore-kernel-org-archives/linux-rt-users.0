From: Dorian VEGARA <dorian.vegara@gmail.com>
Subject: Re: sbin/init error 8 (exists but couldn't execute it)
Date: Sun, 1 Feb 2015 20:56:37 +0100
Message-ID: <CAOQDsMxp6EBnxQNnuieYJ7ubRFGL=TQtSs7qeBHV7gqOzEq=6g@mail.gmail.com>
References: <CAOQDsMw55EW19JHpHxX=+oZHGo79ru6CMf4dcTBEK2XXUf2NoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:40923 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753510AbbBAT4j convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 1 Feb 2015 14:56:39 -0500
Received: by mail-la0-f50.google.com with SMTP id hs14so34832589lab.9
        for <linux-rt-users@vger.kernel.org>; Sun, 01 Feb 2015 11:56:37 -0800 (PST)
In-Reply-To: <CAOQDsMw55EW19JHpHxX=+oZHGo79ru6CMf4dcTBEK2XXUf2NoQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all,


I succeeded in booting RTLinux. The problem was that I configured the
kernel with the command "make i386-config" (thus, the kernel is 32
bit). But the init files are 64 bits ones. So the kernel couldn't read
these inits.

=46inally, I used my openSUSE's .config instead of the .config the "mak=
e
xxx-config" generated.

Thanks a lot to Carsten Emde and Nicholas Mc Guire who greatly helped m=
e !
Best regards,
Dorian

2015-02-01 14:53 GMT+01:00 Dorian VEGARA <dorian.vegara@gmail.com>:
> Hello to everyone,
>
> I want to boot RT Linux 3.14.29-rt26 on my laptop. But I'm
> encountering a problem : the boot stops with this error : "sbin/init
> error 8 (exists but couldn't execute it)".
>
> I don't know why this error is displayed... I succeeded in patching
> the kernel, configuring it, compiling it and making its initrd.
>
> Moreover, when I boot openSUZE (the distribution I use to
> patch/compile/etc. RT Linux), there isn't any problem.
> I tried to remove and setup again and again openSUZE, because I
> thought it would regenerate the init file (which is corrupted
> according to Google - "init error n=C2=B08"). It didn't work.
>
> I don't know how to fix this bug. Could you please help me ?
> You can find two files here :
>
> 1- .config du noyau patch=C3=A9 : http://textup.fr/117717qW
> 2- /boot/grub2/grub.cfg (configuration de GRUB2) : http://textup.fr/1=
17719l2
>
>
> Thank you.
> Best regards,
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
