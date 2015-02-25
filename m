From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 3.18.7-rt1
Date: Wed, 25 Feb 2015 14:55:01 +0100
Message-ID: <20150225135501.GA6823@linutronix.de>
References: <20150216111822.GA21649@linutronix.de>
 <54E2FDD8.8090008@monom.org>
 <20150219103601.7e40d0af@tor.valhalla.alchemy.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Wagner <wagi@monom.org>, John Kacur <jkacur@redhat.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org
To: Joakim Hernberg <jhernberg@alchemy.lu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150219103601.7e40d0af@tor.valhalla.alchemy.lu>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Joakim Hernberg | 2015-02-19 10:36:01 [+0100]:

>On Tue, 17 Feb 2015 09:37:44 +0100
>Daniel Wagner <wagi@monom.org> wrote:
>
>> I needed the patch below to get it running stable under load on my
>> shiny box.
>
>FWIW, this patch makes 3.18-rt survive thermal events on my laptop.

Okay. I applied a slightly modified version of it. That init() is
invoked before the callback function is assigned.
On module exit there is one piece missing: After the callback is
removed we should flush the swork queue to ensure that one callback
is neither pending nor executing. But this won't work now becuase the
swait API lacks that feature so it has to be postponed.

Sebastian
