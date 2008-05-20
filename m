From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.25.4-rt2
Date: Mon, 19 May 2008 20:13:11 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0805192012290.4125@gandalf.stny.rr.com>
References: <1211237032.14697.76.camel@localhost.localdomain> <4832105C.4030101@gmx.net>
 <Pine.LNX.4.58.0805191954100.4125@gandalf.stny.rr.com> <4832162F.2010006@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: RT <linux-rt-users@vger.kernel.org>
To: Dragan Noveski <perodog@gmx.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:63943 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758226AbYETANM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 19 May 2008 20:13:12 -0400
In-Reply-To: <4832162F.2010006@gmx.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Tue, 20 May 2008, Dragan Noveski wrote:
>
> ......
>   CC [M]
> /home/nowhiskey/software/nove/alsa/alsa-driver-1.0.16/acore/rtctimer.o
>   CC [M]
> /home/nowhiskey/software/nove/alsa/alsa-driver-1.0.16/acore/timer.o
> /home/nowhiskey/software/nove/alsa/alsa-driver-1.0.16/acore/timer.c: In
> function 'snd_timer_request':
> /home/nowhiskey/software/nove/alsa/alsa-driver-1.0.16/acore/timer.c:155:
> error: wrong type argument to unary exclamation mark
> make[3]: ***
> [/home/nowhiskey/software/nove/alsa/alsa-driver-1.0.16/acore/timer.o]
> Fehler 1
> make[2]: ***
> [/home/nowhiskey/software/nove/alsa/alsa-driver-1.0.16/acore] Fehler 2
> make[1]: ***
> [_module_/home/nowhiskey/software/nove/alsa/alsa-driver-1.0.16] Fehler 2
> make[1]: Leaving directory `/usr/src/linux-2.6.25'
> make: *** [compile] Fehler 2
>
>
> ................
>
> no idea if it is in any kind related, but it happens with both, 25.4-rt1
> and rt2, but alsa drivers just compiling fine with 24.7-rt7 you
> announced just today.
>

Does it compile against kernel.org 2.6.25.4?


-- Steve

