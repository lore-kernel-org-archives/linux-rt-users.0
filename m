From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 3.12.8-rt11
Date: Fri, 31 Jan 2014 23:22:07 +0100
Message-ID: <20140131222207.GH21238@linutronix.de>
References: <20140125134519.GA9845@linutronix.de>
 <52E57D42.60206@pavlinux.ru>
 <52E61C52.6070104@linutronix.de>
 <52E62A05.7080802@pavlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Pavel Vasilyev <pavel@pavlinux.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52E62A05.7080802@pavlinux.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Pavel Vasilyev | 2014-01-27 13:42:29 [+0400]:

>3) 3.10 not works at all, even without -RT patches;

I bootet 3.10.20-rt17 some time ago on an Intel Atom with EG20T chipset
(with those pch driver like pch_udc for usb gadget, pch_uart for serial
and so on). That on _was_ working. I can share the config with you from
back then if you wish.

Sebastian
