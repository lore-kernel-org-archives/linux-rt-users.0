Return-Path: <SRS0=4qQz=SU=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E99C10F0E
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Apr 2019 15:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D646217D7
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Apr 2019 15:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555600770;
	bh=3nxiG9CJktiF+Ochp4Znep7VA+0pCcaYOmPVEyqRGXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=ZnYHd8Ja6ErRgbAB4pgKCihoIIxv8+xJkLzsd7cYXTKRISXD+fEFC4MWR+MadOP1U
	 03IvD6nMqpwO38v1lWkWlBBr/8KOmaSl9F7nKheSu62n9/6NdBl9kom2QEb1aFACid
	 MSjasyafc4a5BpBFsokYSgJX588CqLhPfqW5OBFY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389590AbfDRPT2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:19:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389561AbfDRPTV (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 18 Apr 2019 11:19:21 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE5892083D;
        Thu, 18 Apr 2019 15:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555600760;
        bh=3nxiG9CJktiF+Ochp4Znep7VA+0pCcaYOmPVEyqRGXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Ua9DGBmoFbwtBE8/gTuFpZJI27OC9Pxzg3j65Vlm0lVv9Ys2AovF0e+s28cbU9e9o
         /JdwJWvM15SGDfNlqvOcUAGLTtL+NN7q5/9tomJU1bxBdty/gU2064echlwMpkMPgK
         rEV/DWV6fNGSzV9DKZqUoMk9aDLfeefUwtEOqRUQ=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     vincent@bernat.ch, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH 3/3] tracing: Add a check_val() check before updating cond_snapshot() track_val
Date:   Thu, 18 Apr 2019 10:18:52 -0500
Message-Id: <95958351329f129c07504b4d1769c47a97b70d65.1555597045.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1555597045.git.tom.zanussi@linux.intel.com>
References: <cover.1555597045.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1555597045.git.tom.zanussi@linux.intel.com>
References: <cover.1555597045.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Without this check a snapshot is taken whenever a bucket's max is hit,
rather than only when the global max is hit, as it should be.

Before:

  In this example, we do a first run of the workload (cyclictest),
  examine the output, note the max ('triggering value') (347), then do
  a second run and note the max again.

  In this case, the max in the second run (39) is below the max in the
  first run, but since we haven't cleared the histogram, the first max
  is still in the histogram and is higher than any other max, so it
  should still be the max for the snapshot.  It isn't however - the
  value should still be 347 after the second run.

  # echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_waking/trigger
  # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0:onmax($wakeup_lat).save(next_prio,next_comm,prev_pid,prev_prio,prev_comm):onmax($wakeup_lat).snapshot() if next_comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger

  # cyclictest -p 80 -n -s -t 2 -D 2

  # cat /sys/kernel/debug/tracing/events/sched/sched_switch/hist

  { next_pid:       2143 } hitcount:        199
    max:         44  next_prio:        120  next_comm: cyclictest
    prev_pid:          0  prev_prio:        120  prev_comm: swapper/4

  { next_pid:       2145 } hitcount:       1325
    max:         38  next_prio:         19  next_comm: cyclictest
    prev_pid:          0  prev_prio:        120  prev_comm: swapper/2

  { next_pid:       2144 } hitcount:       1982
    max:        347  next_prio:         19  next_comm: cyclictest
    prev_pid:          0  prev_prio:        120  prev_comm: swapper/6

  Snapshot taken (see tracing/snapshot).  Details:
      triggering value { onmax($wakeup_lat) }:        347
      triggered by event with key: { next_pid:       2144 }

  # cyclictest -p 80 -n -s -t 2 -D 2

  # cat /sys/kernel/debug/tracing/events/sched/sched_switch/hist

  { next_pid:       2143 } hitcount:        199
    max:         44  next_prio:        120  next_comm: cyclictest
    prev_pid:          0  prev_prio:        120  prev_comm: swapper/4

  { next_pid:       2148 } hitcount:        199
    max:         16  next_prio:        120  next_comm: cyclictest
    prev_pid:          0  prev_prio:        120  prev_comm: swapper/1

  { next_pid:       2145 } hitcount:       1325
    max:         38  next_prio:         19  next_comm: cyclictest
    prev_pid:          0  prev_prio:        120  prev_comm: swapper/2

  { next_pid:       2150 } hitcount:       1326
    max:         39  next_prio:         19  next_comm: cyclictest
    prev_pid:          0  prev_prio:        120  prev_comm: swapper/4

  { next_pid:       2144 } hitcount:       1982
    max:        347  next_prio:         19  next_comm: cyclictest
    prev_pid:          0  prev_prio:        120  prev_comm: swapper/6

  { next_pid:       2149 } hitcount:       1983
    max:        130  next_prio:         19  next_comm: cyclictest
    prev_pid:          0  prev_prio:        120  prev_comm: swapper/0

  Snapshot taken (see tracing/snapshot).  Details:
    triggering value { onmax($wakeup_lat) }:    39
    triggered by event with key: { next_pid:       2150 }

After:

  In this example, we do a first run of the workload (cyclictest),
  examine the output, note the max ('triggering value') (375), then do
  a second run and note the max again.

  In this case, the max in the second run is still 375, the highest in
  any bucket, as it should be.

  # cyclictest -p 80 -n -s -t 2 -D 2

  # cat /sys/kernel/debug/tracing/events/sched/sched_switch/hist

  { next_pid:       2072 } hitcount:        200
    max:         28  next_prio:        120  next_comm: cyclictest
    prev_pid:          0  prev_prio:        120  prev_comm: swapper/5

  { next_pid:       2074 } hitcount:       1323
    max:        375  next_prio:         19  next_comm: cyclictest
    prev_pid:          0  prev_prio:        120  prev_comm: swapper/2

  { next_pid:       2073 } hitcount:       1980
    max:        153  next_prio:         19  next_comm: cyclictest
    prev_pid:          0  prev_prio:        120  prev_comm: swapper/6

  Snapshot taken (see tracing/snapshot).  Details:
    triggering value { onmax($wakeup_lat) }:        375
    triggered by event with key: { next_pid:       2074 }

  # cyclictest -p 80 -n -s -t 2 -D 2

  # cat /sys/kernel/debug/tracing/events/sched/sched_switch/hist

  { next_pid:       2101 } hitcount:        199
    max:         49  next_prio:        120  next_comm: cyclictest
    prev_pid:          0  prev_prio:        120  prev_comm: swapper/6

  { next_pid:       2072 } hitcount:        200
    max:         28  next_prio:        120  next_comm: cyclictest
    prev_pid:          0  prev_prio:        120  prev_comm: swapper/5

  { next_pid:       2074 } hitcount:       1323
    max:        375  next_prio:         19  next_comm: cyclictest
    prev_pid:          0  prev_prio:        120  prev_comm: swapper/2

  { next_pid:       2103 } hitcount:       1325
    max:         74  next_prio:         19  next_comm: cyclictest
    prev_pid:          0  prev_prio:        120  prev_comm: swapper/4

  { next_pid:       2073 } hitcount:       1980
    max:        153  next_prio:         19  next_comm: cyclictest
    prev_pid:          0  prev_prio:        120  prev_comm: swapper/6

  { next_pid:       2102 } hitcount:       1981
    max:         84  next_prio:         19  next_comm: cyclictest
    prev_pid:         12  prev_prio:        120  prev_comm: kworker/0:1

  Snapshot taken (see tracing/snapshot).  Details:
    triggering value { onmax($wakeup_lat) }:        375
    triggered by event with key: { next_pid:       2074 }

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index cb56c7c456fa..61b58c906489 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -3585,14 +3585,20 @@ static bool cond_snapshot_update(struct trace_array *tr, void *cond_data)
 	struct track_data *track_data = tr->cond_snapshot->cond_data;
 	struct hist_elt_data *elt_data, *track_elt_data;
 	struct snapshot_context *context = cond_data;
+	struct action_data *action;
 	u64 track_val;
 
 	if (!track_data)
 		return false;
 
+	action = track_data->action_data;
+
 	track_val = get_track_val(track_data->hist_data, context->elt,
 				  track_data->action_data);
 
+	if (!action->track_data.check_val(track_data->track_val, track_val))
+		return false;
+
 	track_data->track_val = track_val;
 	memcpy(track_data->key, context->key, track_data->key_len);
 
-- 
2.14.1

