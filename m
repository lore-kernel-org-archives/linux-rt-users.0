Return-Path: <SRS0=Zbf1=2I=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961E4C2D0BF
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Dec 2019 15:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5888F2467F
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Dec 2019 15:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576682889;
	bh=I5rJItCtVyG3ifmXpdh0BqpQLoPh7lJkZPAAE05a4Go=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=UR9LZ6fnG0uP9esJbHKsiFjhj/TBoPBmSWbgqmvnEOnUw9oVu3+YOucDlyzGpc9i0
	 Eo7GfuGFxBvZ6E/KXEdJ012Y7RgEquQ9+vY8LonUi5aJBB3RDU2p/L4K40lJs4qWLE
	 Wa27PN1FT8qVN40MUVHvyx/k4cPCNuM0qTguqSfc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfLRP2F (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 18 Dec 2019 10:28:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:60116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727297AbfLRP2B (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 18 Dec 2019 10:28:01 -0500
Received: from tzanussi-mobl.hsd1.il.comcast.net (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2960824684;
        Wed, 18 Dec 2019 15:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576682879;
        bh=I5rJItCtVyG3ifmXpdh0BqpQLoPh7lJkZPAAE05a4Go=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=XCADSztVAeCgWdV5flnUpYQdSQcSf48Dnry3WPQOb+YKYQicVxcfAGK+Ix2ylJmKB
         66huqAAFi/NzYh/eaTmtDSzUEfUqhF/TG4rpLOGOj1RxLT+p+pg8nwTq7PWeAUaQHu
         3TwTCmuNFkJlt5ZqP3l+W80e7JoIxk3KCtSmjqHM=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH 7/7] tracing: Documentation for in-kernel synthetic event API
Date:   Wed, 18 Dec 2019 09:27:43 -0600
Message-Id: <62dde4c759cbeda827ddcd110ecf0488d5a8890d.1576679206.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1576679206.git.zanussi@kernel.org>
References: <cover.1576679206.git.zanussi@kernel.org>
In-Reply-To: <cover.1576679206.git.zanussi@kernel.org>
References: <cover.1576679206.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add Documentation for creating and generating synthetic events from
modules.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 Documentation/trace/events.rst | 268 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 268 insertions(+)

diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
index f7e1fcc0953c..084d983df3a2 100644
--- a/Documentation/trace/events.rst
+++ b/Documentation/trace/events.rst
@@ -525,3 +525,271 @@ The following commands are supported:
   event counts (hitcount).
 
   See Documentation/trace/histogram.rst for details and examples.
+
+6.3 In-kernel trace event API
+-----------------------------
+
+In most cases, the command-line interface to trace events is more than
+sufficient.  Sometimes, however, applications might find the need for
+more complex relationships than can be expressed through a simple
+series of linked command-line expressions, or putting together sets of
+commands may be simply too cumbersome.  An example might be an
+application that needs to 'listen' to the trace stream in order to
+maintain an in-kernel state machine detecting, for instance, when an
+illegal kernel state occurs in the scheduler.
+
+The trace event subsystem provides an in-kernel API allowing modules
+or other kernel code to generate user-defined 'synthetic' events at
+will, which can be used to either augment the existing trace stream
+and/or signal that a particular important state has occurred.
+
+The API provided for these purposes is describe below and allows the
+following:
+
+  - dynamically creating synthetic event definitions
+  - generating synthetic events from in-kernel code
+
+6.3.1 Dyamically creating synthetic event definitions
+-----------------------------------------------------
+
+There are a couple ways to create a new synthetic event from a kernel
+module or other kernel code.
+
+The first creates the event in one step, using create_synth_event().
+In this method, the name of the event to create and an array defining
+the fields is supplied to create_synth_event().  If successful, a
+synthetic event with that name and fields will exist following that
+call.  For example, to create a new "schedtest" synthetic event:
+
+  ret = create_synth_event("schedtest", sched_fields,
+                           ARRAY_SIZE(sched_fields), THIS_MODULE);
+
+The sched_fields param in this example points to an array of struct
+synth_field_desc, each of which describes an event field by type and
+name:
+
+  static struct synth_field_desc sched_fields[] = {
+        { .type = "pid_t",              .name = "next_pid_field" },
+        { .type = "char[16]",           .name = "next_comm_field" },
+        { .type = "u64",                .name = "ts_ns" },
+        { .type = "u64",                .name = "ts_ms" },
+        { .type = "unsigned int",       .name = "cpu" },
+        { .type = "char[64]",           .name = "my_string_field" },
+        { .type = "int",                .name = "my_int_field" },
+  };
+
+See synth_field_size() for available types. If field_name contains [n]
+the field is considered to be an array.
+
+If the event is created from within a module, a pointer to the module
+must be passed to create_synth_event().  This will ensure that the
+trace buffer won't contain unreadable events when the module is
+removed.
+
+At this point, the event object is ready to be used for generating new
+events.
+
+In the second method, the event is created in several steps.  This
+allows events to be created dynamically and without the need to create
+and populate an array of fields beforehand.
+
+To use this method, an empty synthetic event should first be created
+using create_empty_synth_event().  The name of the event should be
+supplied to this function.  For example, to create a new "schedtest"
+synthetic event:
+
+  struct synth_event *se = create_empty_synth_event("schedtest", THIS_MODULE);
+
+Once the synthetic event object has been created, it can then be
+populated with fields.  Fields are added one by one using
+add_synth_field(), supplying the new synthetic event object, a field
+type, and a field name.  For example, to add a new int field named
+"intfield", the following call should be made:
+
+  ret = add_synth_field(se, "int", "intfield");
+
+See synth_field_size() for available types. If field_name contains [n]
+the field is considered to be an array.
+
+A group of fields can also be added all at once using an array of
+synth_field_desc with add_synth_fields().  For example, this would add
+just the first four sched_fields:
+
+  ret = add_synth_fields(se, sched_fields, 4);
+
+Once all the fields have been added, the event should be finalized and
+registered by calling the finalize_synth_event() function:
+
+  ret = finalize_synth_event(se);
+
+At this point, the event object is ready to be used for generating new
+events.
+
+6.3.3 Generating synthetic events from in-kernel code
+-----------------------------------------------------
+
+To generate a synthetic event, there are a couple of options.  The
+first option is to generate the event in one call, using
+generate_synth_event() with an array of values to be set.  A second
+option can be used to avoid the need for a pre-formed array of values,
+using generate_synth_event_start() and generate_synth_event_end()
+along with add_next_synth_val() or add_synth_val() to add the values
+piecewise.
+
+6.3.3.1 Generating a synthetic event all at once
+------------------------------------------------
+
+To generate a synthetic event all at once, the generate_synth_event()
+function is used.  It's passed the trace_event_file representing the
+synthetic event (which can be retrieved using get_event_file() using
+the synthetic event name, "synthetic" as the system name, and the
+trace instance name (NULL if using the global trace array)), along
+with an array of u64, one for each synthetic event field.
+
+So, to generate an event corresponding to the synthetic event
+definition above, code like the following could be used:
+
+  u64 vals[7];
+
+  vals[0] = 777;                  /* next_pid_field */
+  vals[1] = (u64)"tiddlywinks";   /* next_comm_field */
+  vals[2] = 1000000;              /* ts_ns */
+  vals[3] = 1000;                 /* ts_ms */
+  vals[4] = smp_processor_id();   /* cpu */
+  vals[5] = (u64)"thneed";        /* my_string_field */
+  vals[6] = 398;                  /* my_int_field */
+
+The 'vals' array is just an array of u64, the number of which must
+match the number of field in the synthetic event, and which must be in
+the same order as the synthetic event fields.
+
+All vals should be cast to u64, and string vals are just pointers to
+strings, cast to u64.  Strings will be copied into space reserved in
+the event for the string, using these pointers.
+
+In order to generate a synthetic event, a pointer to the trace event
+file is needed.  The get_event_file() function can be used to get it -
+it will find the file in the given trace instance (in this case NULL
+since the top trace array is being used) while at the same time
+preventing the instance containing it from going away:
+
+       schedtest_event_file = get_event_file(NULL, "synthetic",
+                                             "schedtest");
+
+Before generating the event, it should be enabled in some way,
+otherwise the synthetic event won't actually show up in the trace
+buffer.
+
+To enable a synthetic event from the kernel, trace_array_set_clr_event()
+can be used (which is not specific to synthetic events, so does need
+the "synthetic" system name to be specified explicitly).
+
+To enable the event, pass 'true' to it:
+
+       trace_array_set_clr_event(schedtest_event_file->tr,
+                                 "synthetic", "schedtest", true);
+
+To disable it pass false:
+
+       trace_array_set_clr_event(schedtest_event_file->tr,
+                                 "synthetic", "schedtest", false);
+
+Finally, generate_synth_event() can be used to actually generate the
+event, which should be visible in the trace buffer afterwards:
+
+       ret = generate_synth_event(schedtest_event_file, vals,
+                                  ARRAY_SIZE(vals));
+
+To remove the synthetic event, the event should be disabled, and the
+trace instance should be 'put' back using put_event_file():
+
+       trace_array_set_clr_event(schedtest_event_file->tr,
+                                 "synthetic", "schedtest", false);
+       put_event_file(schedtest_event_file);
+
+If those have been successful, delete_synth_event() can be called to
+remove the event:
+
+       ret = delete_synth_event("schedtest");
+
+6.3.3.1 Generating a synthetic event piecewise
+----------------------------------------------
+
+To generate a synthetic using the piecewise method described above,
+the generate_synth_event_start() function is used to 'open' the
+synthetic event generation:
+
+       struct synth_gen_state gen_state;
+
+       ret = generate_synth_event_start(schedtest_event_file, &gen_state);
+
+It's passed the trace_event_file representing the synthetic event
+using the same methods as described above, along with a pointer to a
+struct synth_gen_state object, which will be zeroed before use and
+used to maintain state between this and following calls.
+
+Once the event has been opened, which means space for it has been
+reserved in the trace buffer, the individual fields can be set.  There
+are two ways to do that, either one after another for each field in
+the event, which requires no lookups, or by name, which does.  The
+tradeoff is flexibility in doing the assignments vs the cost of a
+lookup per field.
+
+To assign the values one after the other without lookups,
+add_next_synth_val() should be used.  Each call is passed the same
+synth_gen_state object used in the generate_synth_event_start(), along
+with the value to set the next field in the event.  After each field
+is set, the 'cursor' points to the next field, which will be set by
+the subsequent call, continuing until all the fields have been set in
+order.  The same sequence of calls as in the above examples using this
+method would be (without error-handling code):
+
+       /* next_pid_field */
+       ret = add_next_synth_val(777, &gen_state);
+
+       /* next_comm_field */
+       ret = add_next_synth_val((u64)"slinky", &gen_state);
+
+       /* ts_ns */
+       ret = add_next_synth_val(1000000, &gen_state);
+
+       /* ts_ms */
+       ret = add_next_synth_val(1000, &gen_state);
+
+       /* cpu */
+       ret = add_next_synth_val(smp_processor_id(), &gen_state);
+
+       /* my_string_field */
+       ret = add_next_synth_val((u64)"thneed_2.01", &gen_state);
+
+       /* my_int_field */
+       ret = add_next_synth_val(395, &gen_state);
+
+To assign the values in any order, add_synth_val() should be used.
+Each call is passed the same synth_gen_state object used in the
+generate_synth_event_start(), along with the field name of the field
+to set and the value to set it to.  The same sequence of calls as in
+the above examples using this method would be (without error-handling
+code):
+
+       ret = add_synth_val("next_pid_field", 777, &gen_state);
+       ret = add_synth_val("next_comm_field", (u64)"silly putty", &gen_state);
+       ret = add_synth_val("ts_ns", 1000000, &gen_state);
+       ret = add_synth_val("ts_ms", 1000, &gen_state);
+       ret = add_synth_val("cpu", smp_processor_id(), &gen_state);
+       ret = add_synth_val("my_string_field", (u64)"thneed_9", &gen_state);
+       ret = add_synth_val("my_int_field", 3999, &gen_state);
+
+Note that add_next_synth_val() and add_synth_val() are incompatible if
+used within the same generation of an event - either one can be used
+but not both at the same time.
+
+Finally, the event won't be actually generated until it's 'closed',
+which is done using generate_synth_event_end(), which takes only the
+struct synth_gen_state object used in the previous calls:
+
+       ret = generate_synth_event_end(&gen_state);
+
+Note that generate_synth_event_end() must be called at the end
+regardless of whether any of the add calls failed (say due to a bad
+field name being passed in).
-- 
2.14.1

