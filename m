From: Clark Williams <williams@redhat.com>
Subject: [RT - hwlat_detector] correctly record max when the "outer" value
 is maximum
Date: Fri, 7 Aug 2015 15:20:37 -0500
Message-ID: <20150807152037.02884401@sluggy>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Cc: Steven Rostedt <srostedt@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Luiz Capitulino <lcapitulino@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Steven,

The hwlat_detector module does not correctly record when the "outer"
calculation is the largest diff seen in consecutive clock reads. This
patch should properly record when outer_sample is the largest value
seen:
>From 8b9c14ea45991fdda2040d45647ca4d5358e8221 Mon Sep 17 00:00:00 2001
From: Clark Williams <williams@redhat.com>
Date: Fri, 7 Aug 2015 15:07:30 -0500
Subject: [PATCH] hwlat_detector: update stats code to record when "outer" interval exceeds threshold

The hwlat_detector polls the system clock (either ktime_get() or trace_clock_local())
source looking for intervals between successive reads which exceed a specified threshold.
There are two intervals examined, the "inner" interval which is between t1 and t2,
and the "outer" interval which is between t2 and t1' (i.e. the "next" t1 value).

This patch updates the detector module to record if the outer interval is the maximum
interval encountered during a run.

Reported-by: Luiz Capitulino <lcapitulino@redhat.com>
Signed-off-by: Clark Williams <williams@redhat.com>
---
 drivers/misc/hwlat_detector.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/hwlat_detector.c b/drivers/misc/hwlat_detector.c
index d2676b867e41..5ca7aa9780e0 100644
--- a/drivers/misc/hwlat_detector.c
+++ b/drivers/misc/hwlat_detector.c
@@ -294,6 +294,8 @@ static int get_sample(void)
 		/* Keep a running maximum ever recorded hardware latency */
 		if (sample > data.max_sample)
 			data.max_sample = sample;
+		if (outer_sample > data.max_sample)
+			data.max_sample = outer_sample;
 	}
 
 out:
-- 
2.4.3
