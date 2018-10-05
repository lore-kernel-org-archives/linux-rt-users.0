From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT 2/2] watchdog, rt: prevent deferral of watchdogd wakeup
Date: Fri, 5 Oct 2018 18:52:13 +0200
Message-ID: <20181005165213.mbgixd7w4csu3xjh@linutronix.de>
References: <cover.1538089179.git.julia@ni.com>
 <0e02d8327aeca344096c246713033887bc490dd7.1538089180.git.julia@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Tim Sander <tim@krieglstein.org>,
        Guenter Roeck <linux@roeck-us.net>
To: Julia Cartwright <julia@ni.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0e02d8327aeca344096c246713033887bc490dd7.1538089180.git.julia@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-09-28 21:03:51 [+0000], Julia Cartwright wrote:
> When PREEMPT_RT_FULL is enabled, all hrtimer expiry functions are
> deferred for execution into the context of ktimersoftd unless otherwise
> annotated.
…
> Signed-off-by: Julia Cartwright <julia@ni.com>

did s@HRTIMER_MODE_REL@HRTIMER_MODE_REL_HARD@ and then applied.

Thank you Julia.

Sebastian
