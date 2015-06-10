From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [ANNOUNCE] 4.0.4-rt1
Date: Tue, 09 Jun 2015 20:10:10 -0700
Message-ID: <5577AA92.5070203@localhost>
References: <20150519213923.GA26363@linutronix.de>	<20150526083449.5357059b@sluggy>	<20150526093832.558e2e46@gandalf.local.home>	<20150526084802.2cfd055b@sluggy>	<20150526111924.20836deb@gandalf.local.home> <20150526104343.51fad474@sluggy> <5564CC80.3080101@localhost> <5567C741.5010007@localhost> <55771837.4020007@localhost> <5577633A.2060100@pavlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: pavel@pavlinux.ru,
	Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
	Clark Williams <williams@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp1.stanford.edu ([171.67.219.81]:60537 "EHLO
	smtp.stanford.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932760AbbFJDKd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Jun 2015 23:10:33 -0400
In-Reply-To: <5577633A.2060100@pavlinux.ru>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 06/09/2015 03:05 PM, Pavel Vasilyev wrote:
> 09.06.2015 19:45, Fernando Lopez-Lezcano =D0=BF=D0=B8=D1=88=D0=B5=D1=82=
:
>
>> This is still happening, about once a day. John Dulaney help me set =
up a
>> crash kernel dump (thanks!) so now I have a kernel core dump for thi=
s
>> one,
>
> Asus,Fedora,CGROUPS, iptables,snd_ac97,radeon,raid1,kvm - this realti=
me
> system? :D

:-P

Yup. I have been using rt for many years - and packaging it - for (very=
)=20
low latency sound processing. Linux + rt + jackd + rtirq + threaded irq=
s=20
+ jack clients, everything with the right priorities. Runs very nicely=20
unless you hit an issue like the one I'm asking about[*]. Usually=20
running snd_hdspm with RME hardware when in concert situations (this on=
e=20
with Asus mobo is my - quite old by now - desktop at work, but I'm also=
=20
having the same problem in my Lenovo laptop).

-- Fernando

[*] for example a whole concert for a 24.8 3D sound system with a remot=
e=20
ethernet driven D/A and running all the time with 64 frame x 2 buffers=20
at 48KHz.

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
