From: "Jaggi, Manish" <Manish.Jaggi@caviumnetworks.com>
Subject: Re: [ANNOUNCE] 4.4-rc6-rt1 (arm64)
Date: Thu, 14 Jan 2016 11:50:14 +0000
Message-ID: <CY1PR0701MB1600F7E957009EB7D990A537E1CC0@CY1PR0701MB1600.namprd07.prod.outlook.com>
References: <20151223225755.GA21121@linutronix.de>
 <20151231102441.581ce1e1@sluggy.hsv.redhat.com>
 <1451632781.9800.22.camel@gmail.com> <568CF08F.3070001@caviumnetworks.com>
 <CY1PR0701MB16008257A000E21747214FEBE1CB0@CY1PR0701MB1600.namprd07.prod.outlook.com>,<20160113134500.GF29964@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Mike Galbraith <umgwanakikbuti@gmail.com>,
	Clark Williams <williams@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160113134500.GF29964@linutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Sebastian ,

One quick point, I disabled the hr timer from kernel config and I was able to boot kernel. 

Regards,
Manish Jaggi

________________________________________
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Sent: Wednesday, January 13, 2016 7:15 PM
To: Jaggi, Manish
Cc: Mike Galbraith; Clark Williams; Thomas Gleixner; LKML; linux-rt-users; Steven Rostedt
Subject: Re: [ANNOUNCE] 4.4-rc6-rt1 (arm64)

* Jaggi, Manish | 2016-01-13 11:45:54 [+0000]:

>Hi All,
>
>I am trying to boot linux kernel 4.4.rc7 with the 4.4-rc6-rt1 patch on Cavium thunderX arm64 platform
>Below is the bootlog with errors.

This and your previous email look the same to me.
Did v4.1-RT work here?
Can you enable some debuging in order to figure out what triggers "RT
throttling activated"? lockdep, sleeping while atomic, the usual stuff
:)
>

Sebastian
