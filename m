From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] arm: spear: platsmp: fix lock definition
Date: Mon, 12 Aug 2013 12:04:49 +0200
Message-ID: <20130812100449.GB23040@linutronix.de>
References: <1375365264-10135-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-rt-users@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1375365264-10135-1-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Felipe Balbi | 2013-08-01 16:54:24 [+0300]:
>
>compile tested only, I don't have any spear boards.
>
>But at least solves the argument error compile warnings.

looks very correct :) Applied and folded back into the original patch.

Sebastian
