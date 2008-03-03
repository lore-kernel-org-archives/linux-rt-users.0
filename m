From: David Brownell <david-b@pacbell.net>
Subject: Re: High resolution timers on AT91SAM926x
Date: Mon, 3 Mar 2008 10:39:57 -0800
Message-ID: <200803031039.57909.david-b@pacbell.net>
References: <200803011457.40857.david-b@pacbell.net> <d6c8ef150803030226m75f68bffvfa20feba9133b247@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: lkml <linux-kernel@vger.kernel.org>,
	linux-rt-users@vger.kernel.org, tglx@linutronix.de
To: "Bosko Radivojevic" <bosko.radivojevic@gmail.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758166AbYCCSkP@vger.kernel.org>
In-Reply-To: <d6c8ef150803030226m75f68bffvfa20feba9133b247@mail.gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Monday 03 March 2008, Bosko Radivojevic wrote:
> thank you for the reply. But, I'm getting pretty strange behavior.

Presumably you got different results when your Kconfig
enabled a HRT/NO_HZ capable clockevent source, instead
of just the PIT?

CONFIG_ATMEL_TCLIB=y
CONFIG_ATMEL_TCB_CLKSRC=y
CONFIG_ATMEL_TCB_CLKSRC_BLOCK=0
