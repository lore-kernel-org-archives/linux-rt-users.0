From: Armin Steinhoff <armin@steinhoff.de>
Subject: Re: Operation not permitted / pthread_setschedparam
Date: Sat, 04 Oct 2014 14:50:26 +0200
Message-ID: <542FED12.6040603@steinhoff.de>
References: <542A88A8.7060800@steinhoff.de>	<alpine.DEB.2.11.1410010058160.4455@nanos>	<542BACF1.3090405@steinhoff.de> <CAA7pwKPcT_YvQx9_nvSXCq3sFB3aCRZ-mGWTk4GOvLn0k7c3_w@mail.gmail.com> <542D0689.8050602@steinhoff.de> <542FD0BE.10508@osadl.org> <542FE9B4.3060708@steinhoff.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Carsten Emde <C.Emde@osadl.org>,
	Patrik Lundquist <patrik.lundquist@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:57934 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbaJDMu2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 4 Oct 2014 08:50:28 -0400
In-Reply-To: <542FE9B4.3060708@steinhoff.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Hi,

some RT threads of the openPOWERLINK threads (2.0.1) are running CPU
affine on selected cores.
Is this important ?

--Armin



Armin Steinhoff schrieb:
> Carsten Emde schrieb:
> [ clip]
> Doesn't come another suspicion to mind?
> Why should I have one? The same code works correctly under then non-RT
> version of the kernel ... at least from the Linux point of view.
>
> --Armin
>


