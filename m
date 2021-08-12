Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-24.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF8CC4338F
	for <linux-rt-users@archiver.kernel.org>; Thu, 12 Aug 2021 22:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A03C7610A5
	for <linux-rt-users@archiver.kernel.org>; Thu, 12 Aug 2021 22:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236266AbhHLWn4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 12 Aug 2021 18:43:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:34144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232611AbhHLWnz (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 12 Aug 2021 18:43:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 266A761038;
        Thu, 12 Aug 2021 22:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628808209;
        bh=eCQYMK3oyhE0VsSIY7x+Vq79NySbAtGxolYGnQteUhA=;
        h=From:To:Cc:Subject:Date:From;
        b=rACtgpDe6mzJQO4GH8TZeklldjlBT2QrAqO4Kg5dHg2VKnybz3J6xXlgmm/0JMhbH
         0O1EDz4BIcezQjvXn/coB2fzlT9Y8aLUbV9kl8tmurWrWWvpKCpNaqz3h5zDN6vkNZ
         oN5Y/4ucieR1RSh0eV2nOCWMQY4x7BofolfDzjTH5WP/39KH+V6Iejp3La9DZ2UR5R
         LelbFkVmGmQuMkYOWash1HLxInvQWA47mVtm4VKqMyguSYdWL3y/VB3jWgDWzgNY8U
         /1HFXRu5BE8EOXydgp0nG9F0yni0l3GlVIWiyb7aPtvRW93U9L8Pap61BbC8puT4xG
         +rrNSVRVFeI7Q==
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, bristot@kernel.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH 0/1] tracing: Provide more parseable hist trigger output
Date:   Thu, 12 Aug 2021 17:43:23 -0500
Message-Id: <cover.1628807056.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Steve and Daniel,

Following our discussion last week about more parseable hist trigger
output, I started trying to implement the 'csv' output you had
mentioned, but realized that since it was more than just table output
that was needed, JSON would be a better fit, so implemented that in
this patch instead.

I designed it so that more files/formats could be easily added as
desired, so if you still want the csv output, let me know.  If so,
though, please give me some more detailed idea as to what you think
that should look like.

Here are some examples of the JSON output for various histograms:

A simple straighforward histogram:

  # echo 'hist:key=id.syscall,common_pid.execname:val=hitcount:sort=id,hitcount' >> /sys/kernel/debug/tracing/events/raw_syscalls/sys_enter/trigger

  # cat /sys/kernel/debug/tracing/events/raw_syscalls/sys_enter/hist_json

[
  "hist":{
    "info":{
      "trigger":"hist:keys=id.syscall,common_pid.execname:vals=hitcount:sort=id.syscall,hitcount:size=2048 [active]
"
    },
    "map":{
      "entry":{
        "keys":[
          {
            "id":"sys_read                      [  0]",
          },
          {
            "common_pid":"Xwayland        [      2867]",
          },
        ],
        "vals":[
          {
            "hitcount":"1",
          },
        ],
      },
      "entry":{
        "keys":[
          {
            "id":"sys_read                      [  0]",
          },
          {
            "common_pid":"sh              [      3428]",
          },
        ],
        "vals":[
          {
            "hitcount":"1",
          },
        ],
      },
      "entry":{
  ...
      "entry":{
        "keys":[
          {
            "id":"sys_getrandom                 [318]",
          },
          {
            "common_pid":"update-notifier [      3408]",
          },
        ],
        "vals":[
          {
            "hitcount":"95",
          },
        ],
      },
      "entry":{
        "keys":[
          {
            "id":"sys_getrandom                 [318]",
          },
          {
            "common_pid":"apt-check       [      3416]",
          },
        ],
        "vals":[
          {
            "hitcount":"815",
          },
        ],
      },
    },
    "totals":{
      "hits":"112930",
      "entries":"1390",
      "dropped":"0",
    },
  },
]


A histogram with save() variables and snapshot() info:

  # echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_waking/trigger

  #echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0:onmax($wakeup_lat).save(next_prio,next_comm,prev_pid,prev_prio,prev_comm):onmax($wakeup_lat).snapshot() if next_comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger

  # cat /sys/kernel/debug/tracing/events/sched/sched_switch/hist_json

[
  "hist":{
    "info":{
      "trigger":"hist:keys=next_pid:vals=hitcount:wakeup_lat=common_timestamp.usecs-$ts0:sort=hitcount:size=2048:clock=global:onmax($wakeup_lat).save(next_prio,next_comm,prev_pid,prev_prio,prev_comm):onmax($wakeup_lat).snapshot() if next_comm=="cyclictest" [active]
"
    },
    "map":{
      "entry":{
        "keys":[
          {
            "next_pid":"3419",
          },
        ],
        "vals":[
          {
            "hitcount":"156",
          },
        ],
        "action":{
          "max":"439",
          "next_prio":"120",
          "next_comm":"cyclictest",
          "prev_pid":"0",
          "prev_prio":"120",
          "prev_comm":"swapper/1",
        },
      },
      "entry":{
        "keys":[
          {
            "next_pid":"3420",
          },
        ],
        "vals":[
          {
            "hitcount":"1563",
          },
        ],
        "action":{
          "max":"1667",
          "next_prio":"120",
          "next_comm":"cyclictest",
          "prev_pid":"1991",
          "prev_prio":"120",
          "prev_comm":"FAHClient",
        },
      },
    },
    "snapshot":{
      "handler":"onmax",
      "$wakeup_lat":"1667",
      "keys":[
        {
          "next_pid":"3420",
        },
      ],
    },
    "totals":{
      "hits":"1719",
      "entries":"2",
      "dropped":"0",
    },
  },
]

And finally, just to show that even stacktraces in JSON works ;-)

  # echo 'hist:keys=stacktrace:values=bytes_req,bytes_alloc:sort=bytes_alloc' >> /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger

  # cat /sys/kernel/debug/tracing/events/kmem/kmalloc/hist_json 

    "info":{
      "trigger":"hist:keys=stacktrace:vals=hitcount,bytes_req,bytes_alloc:sort=b
ytes_alloc:size=2048 [active]
"
    },
    "map":{
      "entry":{
        "keys":[
          {
            "stacktrace":"
            acpi_ns_internalize_name+0x4a/0xa3
            acpi_ns_get_node_unlocked+0x70/0xd8
            acpi_ns_get_node+0x40/0x55
            acpi_ns_evaluate+0x4c/0x24e
            acpi_evaluate_object+0x137/0x240
            acpi_battery_get_state+0x95/0x230
            acpi_battery_get_property+0x4c/0x3f0
            power_supply_show_property+0xd2/0x260
            dev_attr_show+0x18/0x50
            sysfs_kf_seq_show+0xa3/0x110
            seq_read_iter+0xdd/0x460
            new_sync_read+0x11b/0x1a0
            vfs_read+0x198/0x1c0
            ksys_read+0xa7/0xe0
            do_syscall_64+0x3a/0xb0
            entry_SYSCALL_64_after_hwframe+0x44/0xae
            "
          },
        ],
        "vals":[
          {
            "hitcount":"1",
          },
          {
            "bytes_req":"8",
          },
          {
            "bytes_alloc":"8",
          },
          },
        ],
      },
      "entry":{
        "keys":[
          {
            "stacktrace":"
            ecryptfs_write_inode_size_to_metadata+0x38/0x190
            truncate_upper.isra.16+0x14e/0x250
            ecryptfs_setattr+0x276/0x2c0
            notify_change+0x392/0x4d0
            do_truncate+0x7c/0xd0
            path_openat+0x8e2/0xa60
            do_filp_open+0xc5/0x140
            do_sys_openat2+0x23e/0x300
            do_sys_open+0x57/0x80
            do_syscall_64+0x3a/0xb0
            entry_SYSCALL_64_after_hwframe+0x44/0xae
            "
          },
        ],
        "vals":[
          {
            "hitcount":"1",
          },
          {
            "bytes_req":"8",
          },
          {
            "bytes_alloc":"8",
          },
        ],
      },
  ...
      "entry":{
        "keys":[
          {
            "stacktrace":"
            ath10k_wmi_tlv_parse_alloc.constprop.30+0x35/0x80 [ath10k_core]
            ath10k_wmi_tlv_op_pull_fw_stats+0x38/0x420 [ath10k_core]
            ath10k_debug_fw_stats_process+0x9c/0x410 [ath10k_core]
            ath10k_wmi_tlv_op_rx+0x1a6/0xf20 [ath10k_core]
            ath10k_htc_rx_completion_handler+0x13c/0x180 [ath10k_core]
            ath10k_pci_process_rx_cb+0x122/0x190 [ath10k_pci]
            ath10k_ce_per_engine_service+0x5d/0x80 [ath10k_core]
            ath10k_ce_per_engine_service_any+0x6a/0xa0 [ath10k_core]
            ath10k_pci_napi_poll+0x44/0x110 [ath10k_pci]
            __napi_poll+0x2d/0x200
            net_rx_action+0xe6/0x210
            __do_softirq+0xce/0x43c
            irq_exit_rcu+0xa4/0xb0
            common_interrupt+0x5c/0xa0
            asm_common_interrupt+0x1e/0x40
            cpuidle_enter_state+0x113/0x4a0
            "
          },
        ],
        "vals":[
          {
            "hitcount":"569",
          },
          {
            "bytes_req":"3149984",
          },
          {
            "bytes_alloc":"4661248",
          },
        ],
      },
    },
    "totals":{
      "hits":"62147",
      "entries":"453",
      "dropped":"0",
    },
  },
]

Tom

The following changes since commit 3dc65994e3c1c999be3d991cdc96705e167cb3b1:

  tools/bootconfig: Use per-group/all enable option in ftrace2bconf script (2021-08-08 19:41:50 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/hist-json-v1

Tom Zanussi (1):
  tracing: Add hist_json event file

 kernel/trace/trace.h             |   1 +
 kernel/trace/trace_events.c      |   2 +
 kernel/trace/trace_events_hist.c | 532 ++++++++++++++++++++++++++-----
 3 files changed, 463 insertions(+), 72 deletions(-)

-- 
2.17.1

