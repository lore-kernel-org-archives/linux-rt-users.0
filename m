From: Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 2/2] tracing: Use strncpy instead of memcpy for string keys in hist triggers
Date: Mon,  4 Feb 2019 15:07:24 -0600
Message-ID: <50c35ae1267d64eee975b8125e151e600071d4dc.1549309756.git.tom.zanussi@linux.intel.com>
References: <cover.1549309756.git.tom.zanussi@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1549309756.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1549309756.git.tom.zanussi@linux.intel.com>
References: <cover.1549309756.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Because there may be random garbage beyond a string's null terminator,
it's not correct to copy the the complete character array for use as a
hist trigger key.  This results in multiple histogram entries for the
'same' string key.

So, in the case of a string key, use strncpy instead of memcpy to
avoid copying in the extra bytes.

Before, using the gdbus entries in the following hist trigger as an
example:

  # echo 'hist:key=comm' > /sys/kernel/debug/tracing/events/sched/sched_waking/trigger
  # cat /sys/kernel/debug/tracing/events/sched/sched_waking/hist

  ...

  { comm: ImgDecoder #4                      } hitcount:        203
  { comm: gmain                              } hitcount:        213
  { comm: gmain                              } hitcount:        216
  { comm: StreamTrans #73                    } hitcount:        221
  { comm: mozStorage #3                      } hitcount:        230
  { comm: gdbus                              } hitcount:        233
  { comm: StyleThread#5                      } hitcount:        253
  { comm: gdbus                              } hitcount:        256
  { comm: gdbus                              } hitcount:        260
  { comm: StyleThread#4                      } hitcount:        271

  ...

  # cat /sys/kernel/debug/tracing/events/sched/sched_waking/hist | egrep gdbus | wc -l
  51

After:

  # cat /sys/kernel/debug/tracing/events/sched/sched_waking/hist | egrep gdbus | wc -l
  1

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
---
 kernel/trace/trace_events_hist.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index c4a667503bf0..1b349689b897 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -4695,9 +4695,10 @@ static inline void add_to_key(char *compound_key, void *key,
 		/* ensure NULL-termination */
 		if (size > key_field->size - 1)
 			size = key_field->size - 1;
-	}
 
-	memcpy(compound_key + key_field->offset, key, size);
+		strncpy(compound_key + key_field->offset, (char *)key, size);
+	} else
+		memcpy(compound_key + key_field->offset, key, size);
 }
 
 static void
-- 
2.14.1
