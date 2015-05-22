From: Warter <warter@gmail.com>
Subject: Full RT kernel problem on arm
Date: Fri, 22 May 2015 14:36:35 +0200
Message-ID: <CAOn_9a4vX9ixCJ-ZyhbjTAsghrH4UYW-UzWug3kKaUZvw5WUDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:35161 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757118AbbEVMgg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 May 2015 08:36:36 -0400
Received: by wicmx19 with SMTP id mx19so46004244wic.0
        for <linux-rt-users@vger.kernel.org>; Fri, 22 May 2015 05:36:35 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello to all,

I tried to use RT kernel for my streaming server (Music Player Daemon)
on my Hummingboard (Debian Jessie). If I send some commands
(stop-start-next track) in row the mpd starts to eat up the resources.
It freezes and I cannot kill it or reboot/shutdown the board. I have
to reset the board, no other solution. It works fine if I use Basic
RT. I tried with several kernel versions (3.14, 3.18, 4.0, 4.1).

Thanks for any comment regarding issue or better way for bug-report,
Warter
