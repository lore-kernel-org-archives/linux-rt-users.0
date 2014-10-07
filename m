From: Armin Steinhoff <armin@steinhoff.de>
Subject: Re: Operation not permitted / pthread_setschedparam
Date: Tue, 07 Oct 2014 09:57:50 +0200
Message-ID: <54339CFE.2050205@steinhoff.de>
References: <542A88A8.7060800@steinhoff.de> <alpine.DEB.2.11.1410010058160.4455@nanos> <542BACF1.3090405@steinhoff.de> <CAA7pwKPcT_YvQx9_nvSXCq3sFB3aCRZ-mGWTk4GOvLn0k7c3_w@mail.gmail.com> <542D0689.8050602@steinhoff.de> <542FD0BE.10508@osadl.org> <542FE9B4.3060708@steinhoff.de> <alpine.DEB.2.11.1410042312440.4383@nanos> <54312C88.8060609@steinhoff.de> <alpine.DEB.2.11.1410051453590.4383@nanos> <54329A4B.7080706@steinhoff.de> <alpine.DEB.2.11.1410070237190.4383@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:52566 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214AbaJGH6A (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 7 Oct 2014 03:58:00 -0400
In-Reply-To: <alpine.DEB.2.11.1410070237190.4383@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thomas Gleixner schrieb:
> On Mon, 6 Oct 2014, Armin Steinhoff wrote:
>
>> Sorry ... I got now time to read your test code and results in detail.
>> Your test shows only the absence of failures in your "test" scenario.
> Correct. So that proves that the kernel behaviour is correct, right?

There is a complete bug report now in the alternet tree -> rt:   85681

--Armin


