From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [4.4-rc6-rt1 PATCH 2/2] kernel/time/timer.c: UP: fix undefined
 reference to `del_timer_sync'
Date: Tue, 12 Jan 2016 17:47:20 +0100
Message-ID: <20160112164720.GA31009@linutronix.de>
References: <1451325611-21678-1-git-send-email-grygorii.strashko@ti.com>
 <1451325611-21678-3-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sekhar Nori <nsekhar@ti.com>
To: Grygorii Strashko <grygorii.strashko@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1451325611-21678-3-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Grygorii Strashko | 2015-12-28 20:00:11 [+0200]:

>This patch fixes below build errors in case SMP=n:

Thank you for the two patches, I've folded them into the original patch.

Sebastian
