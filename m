Return-Path: <SRS0=Qnkb=27=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A355C282DD
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Jan 2020 20:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B6E20848
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Jan 2020 20:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578688581;
	bh=hBVe9UwxcBnG9Vz9iVJQcDh/aOLSGU/Rhl+dCkj6M2I=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=UC7Aq4nQZXncpsPCCcVCpCz+oeFM+ASmyK6ffHNLu4ud7I6tVHvssYRHM5NTN/RDZ
	 xE1t+qvS8Jcu56oBzogDfiHRV2IFzZooHJ2Is8rB53auDjG/6LUVOJZWQlL19ELkfL
	 Ozl25zhjYvTLfj/8R1ioUlvuZV0/w8GA3dBMsShM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgAJUf1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 10 Jan 2020 15:35:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:57946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbgAJUf0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 10 Jan 2020 15:35:26 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B66F7205F4;
        Fri, 10 Jan 2020 20:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578688526;
        bh=hBVe9UwxcBnG9Vz9iVJQcDh/aOLSGU/Rhl+dCkj6M2I=;
        h=From:To:Cc:Subject:Date:From;
        b=pQh6KZJaG9pKK6cVCcgnbkh+6uPV99LaT50JLlNw9p+HJy4pEixSCkSHr8ZxHJOLa
         ImzbVj8hS0JKGbB2cpJ6y6shB/0h7WsmdfZRqbAKl3PjVa3qA/PlF6o3q9N4Xv9KcU
         rot2ioL7qna5yvkWI+lRAIyNk95wlA3y9ik7qvS0=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH v2 00/12] tracing: Add support for in-kernel dynamic event API
Date:   Fri, 10 Jan 2020 14:35:06 -0600
Message-Id: <cover.1578688120.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

This is v2 of the previous 'tracing: Add support for in-kernel
synthetic event API', and is largely a rewrite based on suggestions
from Masami to expand the scope to include other types of dynamic
events such as kprobe events, in addition to the original sythetic
event focus.

The functionality of the original API remains available, though it's
in a slightly different form due to the use of the new dynevent_cmd
API it's now based on.  The dynevent_cmd API provides a common dynamic
event command generation capability that both the synthetic event API
and the kprobe event API are now based on, and there are now test
modules demonstrating both the synthetic event and kprobes APIs.

A couple of the patches are snippets from Masami's 'tracing:
bootconfig: Boot-time tracing and Extra boot config' series, and the
patch implementing the dynevent_cmd API includes some of the
spnprintf() generating code from that patchset.

Because I used Masami's gen_*_cmd() naming suggestion for generating
the commands, the previous patchset's generate_*() functions were
renamed to trace_*() to avoid confusion, and probably is better naming
anyway.

An overview of the user-visible changes in comparison to v1:

  - create_synth_event() using an array of synth_desc_fields remains
    unchanged and works the same way as previously

  - gen_synth_cmd() takes a variable-length number of args which
    represent 'type field;' pairs.  Using this with no field args
    basically replaces the previous 'create_empty_synth_event()'

  - The 'add_synth_field()' and 'add_synth_fields()' function from v1
    are essentially the same except that they now take a dynevent_cmd
    instead of a synth_event pointer

  - The finalize_synth_event() from v1 is replaced by
    create_dynevent() in the new version.
  
  - The new v2 API includes some additional functions to initialize
    the dynevent_cmd - synth_dynevent_cmd() is used to do that.  While
    it's an extra step, it makes it easier to do error handling.

  - There's a new trace_synth_event() function that traces a synthetic
    event using a variable-arg list of values.

  - The original generate_synth_event() using an array of values is
    now called trace_synth_event_array().

  - For piecewise event tracing, the original
    generate_synth_event_start() and generate_synth_event_end() have
    now been renamed to trace_synth_event_end().

  - add_next_synth_val() and add_synth_val() remain the same.

  - A similar API and test module demonstrating the API has been added
    for kprobe events

  - Both the synthetic events and kprobe events API is based on the
    dynevent_cmd API, newly added

  - The Documentation for all of the above has been updated

Text from the orginal v1 posting:

I've recently had several requests and suggestions from users to add
support for the creation and generation of synthetic events from
kernel code such as modules, and not just from the available command
line commands.

This patchset adds support for that.  The first three patches add some
minor preliminary setup, followed by the two main patches that add the
ability to create and generate synthetic events from the kernel.  The
next patch adds a test module that demonstrates actual use of the API
and verifies that it works as intended, followed by Documentation.

Special thanks to Artem Bityutskiy, who worked with me over several
iterations of the API, and who had many great suggestions on the
details of the interface, and pointed out several problems with the
code itself.

The following changes since commit d783b3c08c14fccbc4d5ef33a38288ec9b264df7:

  tracing: Have the histogram compare functions convert to u64 first (2019-12-11 15:47:14 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/synth-event-gen-v2

Masami Hiramatsu (2):
  tracing: Add synth_event_run_command()
  tracing: Add trace_kprobe_run_command()

Tom Zanussi (10):
  tracing: Add trace_array_find() to find instance trace arrays
  tracing: Add get/put_event_file()
  tracing: Add delete_synth_event()
  tracing: Add dynamic event command creation interface
  tracing: Add synthetic event command generation functions
  tracing: Add trace_synth_event() and related functions
  tracing: Add synth event generation test module
  tracing: Add kprobe event command generation functions
  tracing: Add kprobe event command generation test module
  tracing: Documentation for in-kernel synthetic event API

 Documentation/trace/events.rst       | 488 ++++++++++++++++++++
 include/linux/trace_events.h         | 134 ++++++
 kernel/trace/Kconfig                 |  25 ++
 kernel/trace/Makefile                |   2 +
 kernel/trace/kprobe_event_gen_test.c | 223 ++++++++++
 kernel/trace/synth_event_gen_test.c  | 519 +++++++++++++++++++++
 kernel/trace/trace.c                 |  30 +-
 kernel/trace/trace.h                 |   1 +
 kernel/trace/trace_events.c          | 304 +++++++++++++
 kernel/trace/trace_events_hist.c     | 842 ++++++++++++++++++++++++++++++++++-
 kernel/trace/trace_kprobe.c          | 162 +++++++
 11 files changed, 2704 insertions(+), 26 deletions(-)
 create mode 100644 kernel/trace/kprobe_event_gen_test.c
 create mode 100644 kernel/trace/synth_event_gen_test.c

-- 
2.14.1

