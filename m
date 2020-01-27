Return-Path: <SRS0=nqJC=3Q=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1178C2D0DB
	for <linux-rt-users@archiver.kernel.org>; Mon, 27 Jan 2020 13:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E5F4207FD
	for <linux-rt-users@archiver.kernel.org>; Mon, 27 Jan 2020 13:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580132933;
	bh=nHi/YUzGUCuratHwiOmc3Q8G3EswlHxPtofNzsOAzkM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=DgBysjwzkjJCi8oZWwr77Wx4CA89sGtxmrpnu9jUepK1BWvPZbRvSgTGulyXg7D/C
	 t555d7yMW81Z59+jhLtbmDC5BZHUWRDRkd5hq3H31Uu0jiP1YjMXx+cjZhjjP6MU7w
	 cEDbbT1ENzb/vLxz3UVbSe20SlIAcynVx2sgRjyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbgA0Nsx (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 27 Jan 2020 08:48:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:48648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbgA0Nsx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 27 Jan 2020 08:48:53 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA6E420716;
        Mon, 27 Jan 2020 13:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580132932;
        bh=nHi/YUzGUCuratHwiOmc3Q8G3EswlHxPtofNzsOAzkM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kbf9uxSb48wx/B5aCcBDNhei3Zk8UP2/ICpM/fNVWC73DCZJILSFYXnijddbVVVqC
         V+OU7zF4kRLrr6Cf5Mr07yojkH8Z1r919KJpJm6JoFx/8AAA2bRwxVlM9iH9yZlrZ1
         hMnENtPQCYxKHNRs9Ged4naxHPlihhSgBhWnvSAw=
Date:   Mon, 27 Jan 2020 22:48:47 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, artem.bityutskiy@linux.intel.com,
        mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, ndesaulniers@google.com
Subject: Re: [PATCH v3 00/12] tracing: Add support for in-kernel dynamic
 event API
Message-Id: <20200127224847.54ad704c08785b85a63c18a5@kernel.org>
In-Reply-To: <cover.1579904761.git.zanussi@kernel.org>
References: <cover.1579904761.git.zanussi@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Tom,

On Fri, 24 Jan 2020 16:56:11 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> Hi,
> 
> This is v3 of 'tracing: Add support for in-kernel dynamic event API',
> incorporating changes based on suggestions from Masami and Steven.
> 
>   - Rebased to trace/for-next
> 
>   - Regularized the entire API to use synth_event_*, kprobe_event_*,
>     dynevent_*, and added some new macros and functions to make things
>     more consistent
> 
>   - Introduced trace_array_find_get() and used it in
>     trace_array_get_file() as suggested
>   
>   - Removed exports from dynevent_cmd functions that didn't need to be
>     exported
> 
>   - Switched the param order of __kprobe_event_gen_cmd_start() to fix
>     a problem found building with clang.  Apparently varargs and
>     implicit promotion of types like bool don't mix.  Thanks to Nick
>     Desaulniers for pointing that out.
> 
>   - Updated the documentation for all of the above
> 
> Text from the v2 posting:
> 
> This is v2 of the previous 'tracing: Add support for in-kernel
> synthetic event API', and is largely a rewrite based on suggestions
> from Masami to expand the scope to include other types of dynamic
> events such as kprobe events, in addition to the original sythetic
> event focus.

Yeah, v3 basically looks good to me now :)
Please see my comment on [4/12]. Others are good. You can put my
Acked-by to those patches. 

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
except for [04/12].

Thank you!

> 
> The functionality of the original API remains available, though it's
> in a slightly different form due to the use of the new dynevent_cmd
> API it's now based on.  The dynevent_cmd API provides a common dynamic
> event command generation capability that both the synthetic event API
> and the kprobe event API are now based on, and there are now test
> modules demonstrating both the synthetic event and kprobes APIs.
> 
> A couple of the patches are snippets from Masami's 'tracing:
> bootconfig: Boot-time tracing and Extra boot config' series, and the
> patch implementing the dynevent_cmd API includes some of the
> spnprintf() generating code from that patchset.
> 
> Because I used Masami's gen_*_cmd() naming suggestion for generating
> the commands, the previous patchset's generate_*() functions were
> renamed to trace_*() to avoid confusion, and probably is better naming
> anyway.
> 
> An overview of the user-visible changes in comparison to v1:
> 
>   - create_synth_event() using an array of synth_desc_fields remains
>     unchanged and works the same way as previously
> 
>   - gen_synth_cmd() takes a variable-length number of args which
>     represent 'type field;' pairs.  Using this with no field args
>     basically replaces the previous 'create_empty_synth_event()'
> 
>   - The 'add_synth_field()' and 'add_synth_fields()' function from v1
>     are essentially the same except that they now take a dynevent_cmd
>     instead of a synth_event pointer
> 
>   - The finalize_synth_event() from v1 is replaced by
>     create_dynevent() in the new version.
>   
>   - The new v2 API includes some additional functions to initialize
>     the dynevent_cmd - synth_dynevent_cmd() is used to do that.  While
>     it's an extra step, it makes it easier to do error handling.
> 
>   - There's a new trace_synth_event() function that traces a synthetic
>     event using a variable-arg list of values.
> 
>   - The original generate_synth_event() using an array of values is
>     now called trace_synth_event_array().
> 
>   - For piecewise event tracing, the original
>     generate_synth_event_start() and generate_synth_event_end() have
>     now been renamed to trace_synth_event_end().
> 
>   - add_next_synth_val() and add_synth_val() remain the same.
> 
>   - A similar API and test module demonstrating the API has been added
>     for kprobe events
> 
>   - Both the synthetic events and kprobe events API is based on the
>     dynevent_cmd API, newly added
> 
>   - The Documentation for all of the above has been updated
> 
> Text from the orginal v1 posting:
> 
> I've recently had several requests and suggestions from users to add
> support for the creation and generation of synthetic events from
> kernel code such as modules, and not just from the available command
> line commands.
> 
> This patchset adds support for that.  The first three patches add some
> minor preliminary setup, followed by the two main patches that add the
> ability to create and generate synthetic events from the kernel.  The
> next patch adds a test module that demonstrates actual use of the API
> and verifies that it works as intended, followed by Documentation.
> 
> Special thanks to Artem Bityutskiy, who worked with me over several
> iterations of the API, and who had many great suggestions on the
> details of the interface, and pointed out several problems with the
> code itself.
> 
> The following changes since commit 659ded30272d67a04b3692f0bfa12263be20d790:
> 
>   trace/kprobe: Remove unused MAX_KPROBE_CMDLINE_SIZE (2020-01-22 07:07:38 -0500)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/synth-event-gen-v3
> 
> Tom Zanussi (12):
>   tracing: Add trace_array_find/_get() to find instance trace arrays
>   tracing: Add trace_get/put_event_file()
>   tracing: Add synth_event_delete()
>   tracing: Add dynamic event command creation interface
>   tracing: Add synthetic event command generation functions
>   tracing: Change trace_boot to use synth_event interface
>   tracing: Add synth_event_trace() and related functions
>   tracing: Add synth event generation test module
>   tracing: Add kprobe event command generation functions
>   tracing: Change trace_boot to use kprobe_event interface
>   tracing: Add kprobe event command generation test module
>   tracing: Documentation for in-kernel synthetic event API
> 
>  Documentation/trace/events.rst       | 515 ++++++++++++++++++++
>  include/linux/trace_events.h         | 124 +++++
>  kernel/trace/Kconfig                 |  25 +
>  kernel/trace/Makefile                |   2 +
>  kernel/trace/kprobe_event_gen_test.c | 225 +++++++++
>  kernel/trace/synth_event_gen_test.c  | 523 ++++++++++++++++++++
>  kernel/trace/trace.c                 |  43 +-
>  kernel/trace/trace.h                 |  36 ++
>  kernel/trace/trace_boot.c            |  66 ++-
>  kernel/trace/trace_events.c          | 325 +++++++++++++
>  kernel/trace/trace_events_hist.c     | 896 ++++++++++++++++++++++++++++++++++-
>  kernel/trace/trace_kprobe.c          | 160 ++++++-
>  12 files changed, 2868 insertions(+), 72 deletions(-)
>  create mode 100644 kernel/trace/kprobe_event_gen_test.c
>  create mode 100644 kernel/trace/synth_event_gen_test.c
> 
> -- 
> 2.14.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
