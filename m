From: Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 0/2] A couple hist trigger patches
Date: Mon,  4 Feb 2019 15:07:22 -0600
Message-ID: <cover.1549309756.git.tom.zanussi@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Hi,

Here are a couple miscellaneous hist trigger patches which can be
applied independently of the onchange/snapshot patches.

The first is just an additional use of str_has_prefix() that was
apparently missed in the original str_has_prefix() conversion, with an
update suggested by Joe Perches.

The second fixes a bug I noticed when testing the onchange/snapshot
fixes.

I pulled these out into this separate patchset because they should be
applied regardless of what happens with the onchange/snapshot patchset.

Thanks,

Tom


The following changes since commit 67748dbeaf2b1240c0b87588df4bb0fb9471a751:

  sh: ftrace: Fix missing parenthesis in WARN_ON() (2019-01-08 10:19:02 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/hist-fixes-v1

Tom Zanussi (2):
  tracing: Use str_has_prefix() in synth_event_create()
  tracing: Use strncpy instead of memcpy for string keys in hist
    triggers

 kernel/trace/trace_events_hist.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.14.1
