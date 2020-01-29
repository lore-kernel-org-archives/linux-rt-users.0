Return-Path: <SRS0=QF8V=3S=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D2FC33CB7
	for <linux-rt-users@archiver.kernel.org>; Wed, 29 Jan 2020 19:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B785F20720
	for <linux-rt-users@archiver.kernel.org>; Wed, 29 Jan 2020 19:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580324470;
	bh=qpyzBOI9PxcNjKYNateB76k50kAXk+J6ADkXmUZOGnE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=FnnwQxguqEP+GuTcip2fl/e83QOMrbAv0/gnkxa/LnVeYQ/5bOp41RAEqgCtXRoPS
	 5kk0cwxq32UPhHJarrTJKOjClICnndk0+QS2LQcv+kRqVAsuUmuWBxgBZ2txc3zzRK
	 vYHy6IQ67ZCLT9CIAWxwY42LMHyDDYgs7J3Aetw0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbgA2S7k (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 29 Jan 2020 13:59:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:53910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727763AbgA2S7k (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 29 Jan 2020 13:59:40 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4B8C2071E;
        Wed, 29 Jan 2020 18:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580324379;
        bh=qpyzBOI9PxcNjKYNateB76k50kAXk+J6ADkXmUZOGnE=;
        h=From:To:Cc:Subject:Date:From;
        b=nokTUUXcATMmg3k9c7Q10PabNMCLXOrqsOLDwM9cvjzhUt/PPQqxgC47KECiKC9SX
         ctbi7kqhbZFGJkdlA2UTY/Mpmnj3NRPocLNKfcgCT7aKIWFeUMZ0GwsU8EyCnPO3SZ
         ogjANNmpf0KU81shBHL5vALtsFMEFwTvbtCzksg0=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH v4 00/12] tracing: Add support for in-kernel dynamic event API
Date:   Wed, 29 Jan 2020 12:59:20 -0600
Message-Id: <cover.1580323897.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

This is v4 of 'tracing: Add support for in-kernel dynamic event API',
incorporating changes based on suggestions from Masami.

This patchset is the same as the v3 version but add Masami's acks for
all but '[PATCH 04/12] tracing: Add dynamic event command creation
interface', which moves the dynevent command interface code to
trace_dynevent.{c,.h}.

Thanks,

Tom


Text from the v3 posting:

This is v3 of 'tracing: Add support for in-kernel dynamic event API',
incorporating changes based on suggestions from Masami and Steven.

  - Rebased to trace/for-next

  - Regularized the entire API to use synth_event_*, kprobe_event_*,
    dynevent_*, and added some new macros and functions to make things
    more consistent

  - Introduced trace_array_find_get() and used it in
    trace_array_get_file() as suggested
  
  - Removed exports from dynevent_cmd functions that didn't need to be
    exported

  - Switched the param order of __kprobe_event_gen_cmd_start() to fix
    a problem found building with clang.  Apparently varargs and
    implicit promotion of types like bool don't mix.  Thanks to Nick
    Desaulniers for pointing that out.

  - Updated the documentation for all of the above

Text from the v2 posting:

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

The following changes since commit 34f71a4a2de84dde52ccfcb96ce25240ea7981a8:

  tracing: Add new testcases for hist trigger parsing errors (2020-01-28 23:17:31 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/synth-event-gen-v4

Tom Zanussi (12):
  tracing: Add trace_array_find/_get() to find instance trace arrays
  tracing: Add trace_get/put_event_file()
  tracing: Add synth_event_delete()
  tracing: Add dynamic event command creation interface
  tracing: Add synthetic event command generation functions
  tracing: Change trace_boot to use synth_event interface
  tracing: Add synth_event_trace() and related functions
  tracing: Add synth event generation test module
  tracing: Add kprobe event command generation functions
  tracing: Change trace_boot to use kprobe_event interface
  tracing: Add kprobe event command generation test module
  tracing: Documentation for in-kernel synthetic event API

 Documentation/trace/events.rst       | 515 ++++++++++++++++++++
 include/linux/trace_events.h         | 124 +++++
 kernel/trace/Kconfig                 |  25 +
 kernel/trace/Makefile                |   2 +
 kernel/trace/kprobe_event_gen_test.c | 225 +++++++++
 kernel/trace/synth_event_gen_test.c  | 523 ++++++++++++++++++++
 kernel/trace/trace.c                 |  43 +-
 kernel/trace/trace.h                 |   2 +
 kernel/trace/trace_boot.c            |  66 ++-
 kernel/trace/trace_dynevent.c        | 240 ++++++++++
 kernel/trace/trace_dynevent.h        |  33 ++
 kernel/trace/trace_events.c          |  85 ++++
 kernel/trace/trace_events_hist.c     | 896 ++++++++++++++++++++++++++++++++++-
 kernel/trace/trace_kprobe.c          | 160 ++++++-
 14 files changed, 2867 insertions(+), 72 deletions(-)
 create mode 100644 kernel/trace/kprobe_event_gen_test.c
 create mode 100644 kernel/trace/synth_event_gen_test.c

-- 
2.14.1

