From: Julia Cartwright <julia@ni.com>
Subject: [PATCH RT 2/2] watchdog, rt: prevent deferral of watchdogd wakeup
Date: Fri, 28 Sep 2018 21:03:51 +0000
Message-ID: <0e02d8327aeca344096c246713033887bc490dd7.1538089180.git.julia@ni.com>
References: <cover.1538089179.git.julia@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Tim Sander <tim@krieglstein.org>,
        Guenter Roeck <linux@roeck-us.net>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1538089179.git.julia@ni.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

When PREEMPT_RT_FULL is enabled, all hrtimer expiry functions are
deferred for execution into the context of ktimersoftd unless otherwise
annotated.

Deferring the expiry of the hrtimer used by the watchdog core, however,
is a waste, as the callback does nothing but queue a kthread work item
and wakeup watchdogd.

It's worst then that, too: the deferral through ktimersoftd also means
that for correct behavior a user must adjust the scheduling parameters
of both watchdogd _and_ ktimersoftd, which is unnecessary and has other
side effects (like causing unrelated expiry functions to execute at
potentially elevated priority).

Instead, mark the hrtimer used by the watchdog core as being _HARD to
allow it's execution directly from hardirq context.  The work done in
this expiry function is well-bounded and minimal.

A user still must adjust the scheduling parameters of the watchdogd
to be correct w.r.t. their application needs.

Cc: Guenter Roeck <linux@roeck-us.net>
Reported-and-tested-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Reported-by: Tim Sander <tim@krieglstein.org>
Signed-off-by: Julia Cartwright <julia@ni.com>
---
 drivers/watchdog/watchdog_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_de=
v.c
index ffbdc4642ea5..9c2b3e5cebdc 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -945,7 +945,7 @@ static int watchdog_cdev_register(struct watchdog_devic=
e *wdd, dev_t devno)
 		return -ENODEV;
=20
 	kthread_init_work(&wd_data->work, watchdog_ping_work);
-	hrtimer_init(&wd_data->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(&wd_data->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	wd_data->timer.function =3D watchdog_timer_expired;
=20
 	if (wdd->id =3D=3D 0) {
--=20
2.18.0
