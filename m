From: Jean-Denis Girard <jd.girard@sysnux.pf>
Subject: Re: Fix preempt-rt on AT91
Date: Thu, 18 Feb 2016 10:16:27 -1000
Message-ID: <na58qs$tmq$1@ger.gmane.org>
References: <1452997394-8554-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452997394-8554-1-git-send-email-alexandre.belloni@free-electrons.com>
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Alexandre,

Le 16/01/2016 16:23, Alexandre Belloni a =C3=A9crit :
> Preemp-rt on at91 has multiple issues:

I'd like to use Linux RT on a Acme Arietta (AT91SAM9G25). I tried
4.4.1-rt6, but it does not boot, I get absolutely no message on the
debug port interface. I'm a complete newbie on Linux RT, so I may well
have done something wrong, but the same kernel config without
CONFIG_PREEMPT_RT runs fine.

I'm a bit confused about what is needed for running 4.4.1-rt6 on this
board: it seems some of your patches got merged, could you please
clarify the situation? Are there some peripherals not supported (I
mainly need ADC and PWM)?


Thanks,
--=20
Jean-Denis Girard

SysNux                Syst=C3=A8mes   Linux   en   Polyn=C3=A9sie   fra=
n=C3=A7aise
http://www.sysnux.pf/ T=C3=A9l: +689 40.50.10.40 / GSM: +689 87.79.75.2=
7
