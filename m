From: bhargavb <bhargavaramudu@gmail.com>
Subject: Uprobe not getting enabled (kprobe disabled in 'General Setup' in
 config file)
Date: Tue, 5 Dec 2017 19:04:11 +0530
Message-ID: <CA+bpL9+2AedpqA9bCAOt0D=8vEY50EQWBnrCe0wysh1Xit6szg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
To: linux-rt-users@vger.kernel.org, linux-perf-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:38276 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752499AbdLENeN (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 5 Dec 2017 08:34:13 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I have disabled some options in kernel config file and rebuilt in an
effort to reduce scheduler latency in my real time (preempt_rt
patched) kernel.
Disabled kprobes in general setup too.

After this, I am not able to enable uprobe. I was facing no issue
earlier, with default kernel config file with preempt_rt patch in
tracing functions using uprobe.

objdump file excerpt:
-------------------------------

0000000000408e8c <func>:
  408e8c:       55                      push   %rbp
  xxxxx
  xxxxx
  40dd1d:       e8 23 79 ff ff          callq  405645 <timeElapsed>
  xxxxx

terminal commands :
-------------------------------
root@brt:/home/brt/xxxxxxxx/out# echo 'p:func_entry test:0x40dd1d' >
/sys/kernel/debug/tracing/uprobe_events
root@brt:/home/brt/xxxxxxxx/out# cat /sys/kernel/debug/tracing/events/enable
0
root@brt:/home/brt/xxxxxxxx/out# echo 1 >
/sys/kernel/debug/tracing/events/uprobes/enable
root@brt:/home/brt/xxxxxxxx/out# cat
/sys/kernel/debug/tracing/events/uprobes/enable
0


Relevant config options:
-------------------------------
CONFIG_UPROBES=y
CONFIG_UPROBE_EVENT=y
CONFIG_PROBE_EVENTS=y

# CONFIG_KPROBES is not set


Does uprobe has any other dependency or config option that needs to be
setup? Even if there is any issue in uprobe string or text, the
tracing/events/uprobes/enable value should be able to be set once the
uprobe is added to the file.

Thank you,
Bhargav
