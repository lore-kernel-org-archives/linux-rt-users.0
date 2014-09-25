From: Rafael Vega <email.rafa@gmail.com>
Subject: Fwd: CpuFreq Laptop Scaling broken?
Date: Thu, 25 Sep 2014 11:53:18 -0500
Message-ID: <CA+fL4x6q8JcCB4XqKBpoNo0_bP5J76314Ru1+ydQXV9uRX2JGw@mail.gmail.com>
Reply-To: email.rafa@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:45517 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752659AbaIYQxj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 25 Sep 2014 12:53:39 -0400
Received: by mail-pa0-f47.google.com with SMTP id rd3so627267pab.34
        for <linux-rt-users@vger.kernel.org>; Thu, 25 Sep 2014 09:53:39 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,


I'm jumping into this thread as suggested by the folks at
linux-audio-user. I am the poster of the thread that Harry mentioned.
I would like to help resolve this issue but I'm not sure how. Please
advise and I'll try to help as much as I can. Here are some links with
relevant information (I think) regarding this issue:


The same post Harry mentioned:
http://forums.debian.net/viewtopic.php?f=3D5&t=3D117613&p=3D554333#p554=
333


Another Debian user reporting similar problems, he "fixed" it by using
an older kernel:
http://forums.debian.net/viewtopic.php?f=3D5&t=3D116307


The thread I started on linux-audio-user. Another person reports he
has the same issue in Arch=C2=B4s package of the RT kernel.
http://lists.linuxaudio.org/pipermail/linux-audio-user/2014-September/0=
99285.html


An issue I reported on the thermald git repository. I originally
thought the problem had to do with thermald. There are some hopefully
useful syslog messages there.
https://github.com/01org/thermal_daemon/issues/39#issuecomment-56846550


Rafael Vega.

--=20

Rafael Vega
email.rafa@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
