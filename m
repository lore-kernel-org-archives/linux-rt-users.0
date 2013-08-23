From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 3.10.9-rt5
Date: Fri, 23 Aug 2013 19:56:28 +0200
Message-ID: <20130823175628.GA9130@linutronix.de>
References: <20130822182127.GA7606@linutronix.de>
 <5216F81A.4050203@localhost>
 <52170A6F.6040009@linutronix.de>
 <52179950.6010601@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52179950.6010601@localhost>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Fernando Lopez-Lezcano | 2013-08-23 10:18:08 [-0700]:

>Please post a patch when/if you have it so I can retry the build...
>Thanks for taking a look at this!

Does this fix your trobule?

diff --git a/drivers/misc/hwlat_detector.c b/drivers/misc/hwlat_detector.c
index 0bfa40d..6f61d5f 100644
--- a/drivers/misc/hwlat_detector.c
+++ b/drivers/misc/hwlat_detector.c
@@ -220,7 +220,7 @@ static struct sample *buffer_get_sample(struct sample *sample)
 #else
 #define time_type	u64
 #define time_get()	trace_clock_local()
-#define time_to_us(x)	((x) / 1000)
+#define time_to_us(x)	div_u64(x, 1000)
 #define time_sub(a, b)	((a) - (b))
 #define init_time(a, b)	a = b
 #define time_u64(a)	a

>-- Fernando

Sebastian
