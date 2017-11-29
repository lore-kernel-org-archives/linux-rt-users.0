From: bhargavb <bhargavaramudu@gmail.com>
Subject: uprobes enable condition (user space) - sysfs interface
Date: Thu, 30 Nov 2017 00:04:23 +0530
Message-ID: <CA+bpL9+McSzeKW+eXHfMJMFRm-EenC9_0pGZkGpSdFzOVozKiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
To: linux-rt-users@vger.kernel.org, linux-perf-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:39857 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751111AbdK2SeZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 29 Nov 2017 13:34:25 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I am trying to understand user space profiling using linux inbuilt
mechanism. (Trying with perf also but could not get complete clear
documentation and could not proceed, so retained linux-perf-users in
to list as the underlying interface used is same for both).

I observed below behaviour when I tried as per directions using URL:
https://opensource.com/article/17/7/dynamic-tracing-linux-user-and-kernel-space#comment-136366
:


echo 'p:<func_entry> ./test:0x420' >
/sys/kernel/debug/tracing/uprobe_events              (for creating
uprobe)
echo 1 > /sys/kernel/debug/tracing/events/enable
                                (enabling uproble)
There is another enable parameter:
/sys/kernel/debug/tracing/events/uprobes/enable

I understand unless enabled both events/enable and
events/uprobes/enable, the /sys/kernel/debug/tracing/trace is not
complete. I do not understand the relevance of
.....events/uprobes/enable as I could not get any trace data in trace
log for 'func_entry' the user space function being added for tracing.
Irrespective of the probe function added, the trace log shows complete
system trace log during the period of execution of the user
application being traced.

Can this be clearly mentioned as to when to use one of them, role of
both and and also, I could not see uprobe function in particular at
all but generic trace in /sys/kernel/debug/tracing/trace. Kindly guide
me in understanding uprobe enable logic in user space in detail.

Regards,
Bhargav
