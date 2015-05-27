From: Daniel Wagner <wagi@monom.org>
Subject: Re: Full RT kernel problem on arm
Date: Wed, 27 May 2015 09:10:34 +0200
Message-ID: <55656DEA.4040006@monom.org>
References: <CAOn_9a4vX9ixCJ-ZyhbjTAsghrH4UYW-UzWug3kKaUZvw5WUDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Warter <warter@gmail.com>, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:36214 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751796AbbE0HKi (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 27 May 2015 03:10:38 -0400
Received: by wizk4 with SMTP id k4so100751563wiz.1
        for <linux-rt-users@vger.kernel.org>; Wed, 27 May 2015 00:10:37 -0700 (PDT)
In-Reply-To: <CAOn_9a4vX9ixCJ-ZyhbjTAsghrH4UYW-UzWug3kKaUZvw5WUDA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

On 05/22/2015 02:36 PM, Warter wrote:
> Hello to all,
> 
> I tried to use RT kernel for my streaming server (Music Player Daemon)
> on my Hummingboard (Debian Jessie). If I send some commands
> (stop-start-next track) in row the mpd starts to eat up the resources.
> It freezes and I cannot kill it or reboot/shutdown the board. I have
> to reset the board, no other solution. It works fine if I use Basic
> RT. I tried with several kernel versions (3.14, 3.18, 4.0, 4.1).
> 
> Thanks for any comment regarding issue or better way for bug-report,

Without any logs it is pretty hard to help here. Do yoi happen to have
an serial port for logging? In this case redirect the console output.

HTH,
Daniel
