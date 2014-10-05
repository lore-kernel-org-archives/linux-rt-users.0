From: Armin Steinhoff <armin@steinhoff.de>
Subject: Re: Operation not permitted / pthread_setschedparam
Date: Sun, 05 Oct 2014 13:07:04 +0200
Message-ID: <54312658.1070008@steinhoff.de>
References: <542A88A8.7060800@steinhoff.de> <alpine.DEB.2.11.1410010058160.4455@nanos> <542BACF1.3090405@steinhoff.de> <CAA7pwKPcT_YvQx9_nvSXCq3sFB3aCRZ-mGWTk4GOvLn0k7c3_w@mail.gmail.com> <542D0689.8050602@steinhoff.de> <542FD0BE.10508@osadl.org> <542FE9B4.3060708@steinhoff.de> <alpine.DEB.2.11.1410042312440.4383@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Carsten Emde <C.Emde@osadl.org>,
	Patrik Lundquist <patrik.lundquist@gmail.com>,
	rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:52468 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152AbaJELHQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 5 Oct 2014 07:07:16 -0400
In-Reply-To: <alpine.DEB.2.11.1410042312440.4383@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thomas Gleixner schrieb:
> On Sat, 4 Oct 2014, Armin Steinhoff wrote:
>> 8. And your second suspicion is that the ps utility is broken.
>>    The question about the operation of "ps" was just a formal one .. sorry.
> Well, I'd say it's not formal. Let me cite from your previous mail:
>
>>>> If the app "demo_mn_console" has started its first RT thread, a
>>>> lot of other processes/threads are jumping to the highest RT
>>>> priority 99!!
> Did you ever try to invoke:

Did you try to switch on your brain before you wrote such insulting
nonsense ??

--Armin

>
> # man ps
>
> and try to figure out what the PRI field actually means? Definitely
> not.
>
> My version of "man ps" tells me:
>
>        pri         PRI       priority of the process.  Higher number means
>                              lower priority.
>
> Can you figure out why your problem analysis
>
>>>> If the app "demo_mn_console" has started its first RT thread, a
>>>> lot of other processes/threads are jumping to the highest RT
>>>> priority 99!!
> causes people on this list to assume that you either are
>
>  - a student seeking advise for his first homework assignement
>
> or 
>
>  - someone completely incompetent trying to make a business by
>    abusing a community?
>
> or
>
>  - a person with a severe drug abuse problem which causes reality
>    distortion?
>
> but definitely not a business who claims itself to be
>
>  "the Real-Time, Fieldbus, and GUI Experts" [1]
>
>
> Thanks,
>
> 	tglx
>
> [1] http://steinhoff.de/index.htm
>

