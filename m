Return-Path: <SRS0=rL3Y=RR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC445C43381
	for <linux-rt-users@archiver.kernel.org>; Thu, 14 Mar 2019 04:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86A3F2184C
	for <linux-rt-users@archiver.kernel.org>; Thu, 14 Mar 2019 04:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552537805;
	bh=VwWdkFvgpbeIVEvL6i1lSaHhTX3+yofQWzD7SD60KD8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=EuMYpACUB2HkyLUhM+FtLsAdeBBEntS/4rEzoRYm//6Uxc/2rMnrkaPMHlAWSsOum
	 s8QuFXziAwjBHOb6397b3admSxzvlRk1mfyc5Pa+lHxkJEf4L3f+8bO0d1eCqXfKVm
	 3Gy2/yijzpozBHPULtkqBEMVPnArQTnLLx8w7uVQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbfCNEaE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 14 Mar 2019 00:30:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:47400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbfCNEaE (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 14 Mar 2019 00:30:04 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E43D2085A;
        Thu, 14 Mar 2019 04:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552537804;
        bh=VwWdkFvgpbeIVEvL6i1lSaHhTX3+yofQWzD7SD60KD8=;
        h=From:To:Cc:Subject:Date:From;
        b=h7TCWIERGyVZg6MqMbGNcy9uKoAyBT/EJaqIiHrjX443XQF/LhuIQY8KdJ4YQ9bDE
         CA6u9IMn5J12p1ZhD2i6WilxsIKDcnCeSwd+24tyeVLxy7YjGE1zM5TnSxYHi8++qX
         1OgT0lJf8tn7o4y9sdIAy5rWvotN0JMcL9H4Bb8c=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [RFC PATCH v2 0/7] tracing: Use common error_log with probe events
Date:   Thu, 14 Mar 2019 13:29:49 +0900
Message-Id: <155253778926.14922.14048967363017104338.stgit@devnote2>
X-Mailer: git-send-email 2.17.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

Here is the 2nd version of using common error_log  with probe events.
Previous version is here.

http://lkml.kernel.org/r/155248005229.10815.334731901778152247.stgit@devnote2

In this version, I've updated some error messages according to
Steve's comment, adjust some error position, and update testcase
to simplify a bit.

 - [4/7]: Update error message according to Steve's comment (Thanks!)
 - [6/7]: Update error message, adjust error positions, and add uprobe errors
 - [7/7]: Specify error position in command string by "^".
          Clear error_log right before writing command.
          Add uprobe syntax error checker

Thank you,

---

Masami Hiramatsu (7):
      tracing/probe: Check maxactive error cases
      tracing/probe: Check event name length correctly
      tracing/probe: Check the size of argument name and body
      tracing/probe: Check event/group naming rule at parsing
      tracing/probe: Verify alloc_trace_*probe() result
      tracing: Use tracing error_log with probe events
      selftests/ftrace: Add error_log testcase for probe errors


 kernel/trace/trace_kprobe.c                        |   90 ++++--
 kernel/trace/trace_probe.c                         |  282 +++++++++++++++-----
 kernel/trace/trace_probe.h                         |   78 +++++-
 kernel/trace/trace_uprobe.c                        |   52 ++--
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |   93 +++++++
 .../ftrace/test.d/kprobe/uprobe_syntax_errors.tc   |   31 ++
 6 files changed, 494 insertions(+), 132 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc

--
Masami Hiramatsu <mhiramat@kernel.org>
