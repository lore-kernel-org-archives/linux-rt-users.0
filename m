From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: 3.12.5 CRASH/FREEZE
Date: Fri, 20 Dec 2013 16:05:59 +0100
Message-ID: <52B45CD7.5030404@linutronix.de>
References: <52A9CC77.20904@linaro.org> <52AA1CC0.30307@pavlinux.ru> <20131220141008.GE10249@linutronix.de> <52B45AEB.2060508@pavlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: pavel@pavlinux.ru
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52B45AEB.2060508@pavlinux.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 12/20/2013 03:57 PM, Pavel Vasilyev wrote:
> 
> Same bug if attach to ehci hub.
> 
> ksoftird/0 process of loading the CPU upto 100% Sometimes process
> irq17/0 - ehci_hcd  or xhci_hcd. After taking the camera out of the
> socket, the load does not fall, keyboard and console blocked

Okay, but this problem is unique to your webcam. Keyboard & mice to
work as usual?
Could please provide me the addr2line either for the ehci or xhci? I've
been browsing to the code and I didn't see anything obvious.

Sebastian
