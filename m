From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 4.4-rc6-rt1 (arm64)
Date: Wed, 13 Jan 2016 14:45:00 +0100
Message-ID: <20160113134500.GF29964@linutronix.de>
References: <20151223225755.GA21121@linutronix.de>
 <20151231102441.581ce1e1@sluggy.hsv.redhat.com>
 <1451632781.9800.22.camel@gmail.com>
 <568CF08F.3070001@caviumnetworks.com>
 <CY1PR0701MB16008257A000E21747214FEBE1CB0@CY1PR0701MB1600.namprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Galbraith <umgwanakikbuti@gmail.com>,
	Clark Williams <williams@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: "Jaggi, Manish" <Manish.Jaggi@caviumnetworks.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CY1PR0701MB16008257A000E21747214FEBE1CB0@CY1PR0701MB1600.namprd07.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Jaggi, Manish | 2016-01-13 11:45:54 [+0000]:

>Hi All,
>
>I am trying to boot linux kernel 4.4.rc7 with the 4.4-rc6-rt1 patch on=
 Cavium thunderX arm64 platform
>Below is the bootlog with errors. =C2=A0

This and your previous email look the same to me.
Did v4.1-RT work here?
Can you enable some debuging in order to figure out what triggers "RT
throttling activated"? lockdep, sleeping while atomic, the usual stuff
:)
>

Sebastian
