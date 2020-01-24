Return-Path: <SRS0=keAW=3N=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E250EC2D0CE
	for <linux-rt-users@archiver.kernel.org>; Fri, 24 Jan 2020 22:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 961A822522
	for <linux-rt-users@archiver.kernel.org>; Fri, 24 Jan 2020 22:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579906611;
	bh=v9MxRnjiEL4ixP4mPPptaQ/swH5aF1i0+H6WI3xxk/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=N4XgZ04XQxPCjCZ+mqZyIeeFXOaXfC4o0N5nCWbqFhP9lIIVG8muC2ooARsWh0jQm
	 lzjayCuieplqOpidFhul3+3wf209Tu7iNeSvIswH831NZB2C/zCpf2dDVCEWnE1B+v
	 /kldM2rsKxTbgr7j6ZlouHJuFGxms5wSf5meBsYc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387417AbgAXW4u (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 24 Jan 2020 17:56:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:39866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729521AbgAXW4t (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 24 Jan 2020 17:56:49 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F57C22527;
        Fri, 24 Jan 2020 22:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579906607;
        bh=v9MxRnjiEL4ixP4mPPptaQ/swH5aF1i0+H6WI3xxk/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=i3qGlJlevPtkTT83bo2eAuv6wk+k2sdkhRS2M1PAarA/GX3s9H7fM9UCc8b01DWFN
         DSNuhtg+j0o4oNIXu0hkzwQ416LrWIzsIUGkzkj5ird2O0upVy/K6o9RgA4XSJFMvo
         ueJZxT6AAj6sBSLU67deUOuMzXKJoSiiTK/yV3UE=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        ndesaulniers@google.com
Subject: [PATCH v3 12/12] tracing: Documentation for in-kernel synthetic event API
Date:   Fri, 24 Jan 2020 16:56:23 -0600
Message-Id: <36337ecc10c7066684c7b6953ecae09da0121ea2.1579904761.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1579904761.git.zanussi@kernel.org>
References: <cover.1579904761.git.zanussi@kernel.org>
In-Reply-To: <cover.1579904761.git.zanussi@kernel.org>
References: <cover.1579904761.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add Documentation for creating and generating synthetic events from
modules.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 Documentation/trace/events.rst | 515 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 515 insertions(+)

diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
index f7e1fcc0953c..ed79b220bd07 100644
--- a/Documentation/trace/events.rst
+++ b/Documentation/trace/events.rst
@@ -525,3 +525,518 @@ The following commands are supported:
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
+A similar in-kernel API is also available for creating kprobe and
+kretprobe events.
+
+Both the synthetic event and k/ret/probe event APIs are built on top
+of a lower-level "dynevent_cmd" event command API, which is also
+available for more specialized applications, or as the basis of other
+higher-level trace event APIs.
+
+The API provided for these purposes is describe below and allows the
+following:
+
+  - dynamically creating synthetic event definitions
+  - dynamically creating kprobe and kretprobe event definitions
+  - tracing synthetic events from in-kernel code
+  - the low-level "dynevent_cmd" API
+
+6.3.1 Dyamically creating synthetic event definitions
+-----------------------------------------------------
+
+There are a couple ways to create a new synthetic event from a kernel
+module or other kernel code.
+
+The first creates the event in one step, using synth_event_create().
+In this method, the name of the event to create and an array defining
+the fields is supplied to synth_event_create().  If successful, a
+synthetic event with that name and fields will exist following that
+call.  For example, to create a new "schedtest" synthetic event:
+
+  ret = synth_event_create("schedtest", sched_fields,
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
+must be passed to synth_event_create().  This will ensure that the
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
+To use this method, an empty or partially empty synthetic event should
+first be created using synth_event_gen_cmd_start() or
+synth_event_gen_cmd_array_start().  For synth_event_gen_cmd_start(),
+the name of the event along with one or more pairs of args each pair
+representing a 'type field_name;' field specification should be
+supplied.  For synth_event_gen_cmd_array_start(), the name of the
+event along with an array of struct synth_field_desc should be
+supplied. Before calling synth_event_gen_cmd_start() or
+synth_event_gen_cmd_array_start(), the user should create and
+initialize a dynevent_cmd object using synth_event_cmd_init().
+
+For example, to create a new "schedtest" synthetic event with two
+fields:
+
+  struct dynevent_cmd cmd;
+  char *buf;
+
+  /* Create a buffer to hold the generated command */
+  buf = kzalloc(MAX_DYNEVENT_CMD_LEN, GFP_KERNEL);
+
+  /* Before generating the command, initialize the cmd object */
+  synth_event_cmd_init(&cmd, buf, MAX_DYNEVENT_CMD_LEN);
+
+  ret = synth_event_gen_cmd_start(&cmd, "schedtest", THIS_MODULE,
+                                  "pid_t", "next_pid_field",
+                                  "u64", "ts_ns");
+
+Alternatively, using an array of struct synth_field_desc fields
+containing the same information:
+
+  ret = synth_event_gen_cmd_array_start(&cmd, "schedtest", THIS_MODULE,
+                                        fields, n_fields);
+
+Once the synthetic event object has been created, it can then be
+populated with more fields.  Fields are added one by one using
+synth_event_add_field(), supplying the dynevent_cmd object, a field
+type, and a field name.  For example, to add a new int field named
+"intfield", the following call should be made:
+
+  ret = synth_event_add_field(&cmd, "int", "intfield");
+
+See synth_field_size() for available types. If field_name contains [n]
+the field is considered to be an array.
+
+A group of fields can also be added all at once using an array of
+synth_field_desc with add_synth_fields().  For example, this would add
+just the first four sched_fields:
+
+  ret = synth_event_add_fields(&cmd, sched_fields, 4);
+
+If you already have a string of the form 'type field_name',
+synth_event_add_field_str() can be used to add it as-is; it will
+also automatically append a ';' to the string.
+
+Once all the fields have been added, the event should be finalized and
+registered by calling the synth_event_gen_cmd_end() function:
+
+  ret = synth_event_gen_cmd_end(&cmd);
+
+At this point, the event object is ready to be used for tracing new
+events.
+
+6.3.3 Tracing synthetic events from in-kernel code
+--------------------------------------------------
+
+To trace a synthetic event, there are several options.  The first
+option is to trace the event in one call, using synth_event_trace()
+with a variable number of values, or synth_event_trace_array() with an
+array of values to be set.  A second option can be used to avoid the
+need for a pre-formed array of values or list of arguments, via
+synth_event_trace_start() and synth_event_trace_end() along with
+synth_event_add_next_val() or synth_event_add_val() to add the values
+piecewise.
+
+6.3.3.1 Tracing a synthetic event all at once
+---------------------------------------------
+
+To trace a synthetic event all at once, the synth_event_trace() or
+synth_event_trace_array() functions can be used.
+
+The synth_event_trace() function is passed the trace_event_file
+representing the synthetic event (which can be retrieved using
+trace_get_event_file() using the synthetic event name, "synthetic" as
+the system name, and the trace instance name (NULL if using the global
+trace array)), along with an variable number of u64 args, one for each
+synthetic event field, and the number of values being passed.
+
+So, to trace an event corresponding to the synthetic event definition
+above, code like the following could be used:
+
+  ret = synth_event_trace(create_synth_test, 7, /* number of values */
+                          444,             /* next_pid_field */
+                          (u64)"clackers", /* next_comm_field */
+                          1000000,         /* ts_ns */
+                          1000,            /* ts_ms */
+                          smp_processor_id(),/* cpu */
+                          (u64)"Thneed",   /* my_string_field */
+                          999);            /* my_int_field */
+
+All vals should be cast to u64, and string vals are just pointers to
+strings, cast to u64.  Strings will be copied into space reserved in
+the event for the string, using these pointers.
+
+Alternatively, the synth_event_trace_array() function can be used to
+accomplish the same thing.  It is passed the trace_event_file
+representing the synthetic event (which can be retrieved using
+trace_get_event_file() using the synthetic event name, "synthetic" as
+the system name, and the trace instance name (NULL if using the global
+trace array)), along with an array of u64, one for each synthetic
+event field.
+
+To trace an event corresponding to the synthetic event definition
+above, code like the following could be used:
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
+In order to trace a synthetic event, a pointer to the trace event file
+is needed.  The trace_get_event_file() function can be used to get
+it - it will find the file in the given trace instance (in this case
+NULL since the top trace array is being used) while at the same time
+preventing the instance containing it from going away:
+
+       schedtest_event_file = trace_get_event_file(NULL, "synthetic",
+                                                   "schedtest");
+
+Before tracing the event, it should be enabled in some way, otherwise
+the synthetic event won't actually show up in the trace buffer.
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
+Finally, synth_event_trace_array() can be used to actually trace the
+event, which should be visible in the trace buffer afterwards:
+
+       ret = synth_event_trace_array(schedtest_event_file, vals,
+                                     ARRAY_SIZE(vals));
+
+To remove the synthetic event, the event should be disabled, and the
+trace instance should be 'put' back using trace_put_event_file():
+
+       trace_array_set_clr_event(schedtest_event_file->tr,
+                                 "synthetic", "schedtest", false);
+       trace_put_event_file(schedtest_event_file);
+
+If those have been successful, synth_event_delete() can be called to
+remove the event:
+
+       ret = synth_event_delete("schedtest");
+
+6.3.3.1 Tracing a synthetic event piecewise
+-------------------------------------------
+
+To trace a synthetic using the piecewise method described above, the
+synth_event_trace_start() function is used to 'open' the synthetic
+event trace:
+
+       struct synth_trace_state trace_state;
+
+       ret = synth_event_trace_start(schedtest_event_file, &trace_state);
+
+It's passed the trace_event_file representing the synthetic event
+using the same methods as described above, along with a pointer to a
+struct synth_trace_state object, which will be zeroed before use and
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
+synth_event_add_next_val() should be used.  Each call is passed the
+same synth_trace_state object used in the synth_event_trace_start(),
+along with the value to set the next field in the event.  After each
+field is set, the 'cursor' points to the next field, which will be set
+by the subsequent call, continuing until all the fields have been set
+in order.  The same sequence of calls as in the above examples using
+this method would be (without error-handling code):
+
+       /* next_pid_field */
+       ret = synth_event_add_next_val(777, &trace_state);
+
+       /* next_comm_field */
+       ret = synth_event_add_next_val((u64)"slinky", &trace_state);
+
+       /* ts_ns */
+       ret = synth_event_add_next_val(1000000, &trace_state);
+
+       /* ts_ms */
+       ret = synth_event_add_next_val(1000, &trace_state);
+
+       /* cpu */
+       ret = synth_event_add_next_val(smp_processor_id(), &trace_state);
+
+       /* my_string_field */
+       ret = synth_event_add_next_val((u64)"thneed_2.01", &trace_state);
+
+       /* my_int_field */
+       ret = synth_event_add_next_val(395, &trace_state);
+
+To assign the values in any order, synth_event_add_val() should be
+used.  Each call is passed the same synth_trace_state object used in
+the synth_event_trace_start(), along with the field name of the field
+to set and the value to set it to.  The same sequence of calls as in
+the above examples using this method would be (without error-handling
+code):
+
+       ret = synth_event_add_val("next_pid_field", 777, &trace_state);
+       ret = synth_event_add_val("next_comm_field", (u64)"silly putty",
+                                 &trace_state);
+       ret = synth_event_add_val("ts_ns", 1000000, &trace_state);
+       ret = synth_event_add_val("ts_ms", 1000, &trace_state);
+       ret = synth_event_add_val("cpu", smp_processor_id(), &trace_state);
+       ret = synth_event_add_val("my_string_field", (u64)"thneed_9",
+                                 &trace_state);
+       ret = synth_event_add_val("my_int_field", 3999, &trace_state);
+
+Note that synth_event_add_next_val() and synth_event_add_val() are
+incompatible if used within the same trace of an event - either one
+can be used but not both at the same time.
+
+Finally, the event won't be actually traced until it's 'closed',
+which is done using synth_event_trace_end(), which takes only the
+struct synth_trace_state object used in the previous calls:
+
+       ret = synth_event_trace_end(&trace_state);
+
+Note that synth_event_trace_end() must be called at the end regardless
+of whether any of the add calls failed (say due to a bad field name
+being passed in).
+
+6.3.4 Dyamically creating kprobe and kretprobe event definitions
+----------------------------------------------------------------
+
+To create a kprobe or kretprobe trace event from kernel code, the
+kprobe_event_gen_cmd_start() or kretprobe_event_gen_cmd_start()
+functions can be used.
+
+To create a kprobe event, an empty or partially empty kprobe event
+should first be created using kprobe_event_gen_cmd_start().  The name
+of the event and the probe location should be specfied along with one
+or args each representing a probe field should be supplied to this
+function.  Before calling kprobe_event_gen_cmd_start(), the user
+should create and initialize a dynevent_cmd object using
+kprobe_event_cmd_init().
+
+For example, to create a new "schedtest" kprobe event with two fields:
+
+  struct dynevent_cmd cmd;
+  char *buf;
+
+  /* Create a buffer to hold the generated command */
+  buf = kzalloc(MAX_DYNEVENT_CMD_LEN, GFP_KERNEL);
+
+  /* Before generating the command, initialize the cmd object */
+  kprobe_event_cmd_init(&cmd, buf, MAX_DYNEVENT_CMD_LEN);
+
+  /*
+   * Define the gen_kprobe_test event with the first 2 kprobe
+   * fields.
+   */
+  ret = kprobe_event_gen_cmd_start(&cmd, "gen_kprobe_test", "do_sys_open",
+                                   "dfd=%ax", "filename=%dx");
+
+Once the kprobe event object has been created, it can then be
+populated with more fields.  Fields can be added using
+kprobe_event_add_fields(), supplying the dynevent_cmd object along
+with a variable arg list of probe fields.  For example, to add a
+couple additional fields, the following call could be made:
+
+  ret = kprobe_event_add_fields(&cmd, "flags=%cx", "mode=+4($stack)");
+
+Once all the fields have been added, the event should be finalized and
+registered by calling the kprobe_event_gen_cmd_end() or
+kretprobe_event_gen_cmd_end() functions, depending on whether a kprobe
+or kretprobe command was started:
+
+  ret = kprobe_event_gen_cmd_end(&cmd);
+
+or
+
+  ret = kretprobe_event_gen_cmd_end(&cmd);
+
+At this point, the event object is ready to be used for tracing new
+events.
+
+Similarly, a kretprobe event can be created using
+kretprobe_event_gen_cmd_start() with a probe name and location and
+additional params such as $retval:
+
+  ret = kretprobe_event_gen_cmd_start(&cmd, "gen_kretprobe_test",
+                                      "do_sys_open", "$retval");
+
+Similar to the synthetic event case, code like the following can be
+used to enable the newly created kprobe event:
+
+  gen_kprobe_test = trace_get_event_file(NULL, "kprobes", "gen_kprobe_test");
+
+  ret = trace_array_set_clr_event(gen_kprobe_test->tr,
+                                  "kprobes", "gen_kprobe_test", true);
+
+Finally, also similar to synthetic events, the following code can be
+used to give the kprobe event file back and delete the event:
+
+  trace_put_event_file(gen_kprobe_test);
+
+  ret = kprobe_event_delete("gen_kprobe_test");
+
+6.3.4 The "dynevent_cmd" low-level API
+--------------------------------------
+
+Both the in-kernel synthetic event and kprobe interfaces are built on
+top of a lower-level "dynevent_cmd" interface.  This interface is
+meant to provide the basis for higher-level interfaces such as the
+synthetic and kprobe interfaces, which can be used as examples.
+
+The basic idea is simple and amounts to providing a general-purpose
+layer that can be used to generate trace event commands.  The
+generated command strings can then be passed to the command-parsing
+and event creation code that already exists in the trace event
+subystem for creating the corresponding trace events.
+
+In a nutshell, the way it works is that the higher-level interface
+code creates a struct dynevent_cmd object, then uses a couple
+functions, dynevent_arg_add() and dynevent_arg_pair_add() to build up
+a command string, which finally causes the command to be executed
+using the dynevent_create() function.  The details of the interface
+are described below.
+
+The first step in building a new command string is to create and
+initialize an instance of a dynevent_cmd.  Here, for instance, we
+create a dynevent_cmd on the stack and initialize it:
+
+  struct dynevent_cmd cmd;
+  char *buf;
+  int ret;
+
+  buf = kzalloc(MAX_DYNEVENT_CMD_LEN, GFP_KERNEL);
+
+  dynevent_cmd_init(cmd, buf, maxlen, DYNEVENT_TYPE_FOO,
+                    foo_event_run_command);
+
+The dynevent_cmd initialization needs to be given a user-specified
+buffer and the length of the buffer (MAX_DYNEVENT_CMD_LEN can be used
+for this purpose - at 2k it's generally too big to be comfortably put
+on the stack, so is dynamically allocated), a dynevent type id, which
+is meant to be used to check that further API calls are for the
+correct command type, and a pointer to an event-specific run_command()
+callback that will be called to actually execute the event-specific
+command function.
+
+Once that's done, the command string can by built up by successive
+calls to argument-adding functions.
+
+To add a single argument, define and initialize a struct dynevent_arg
+or struct dynevent_arg_pair object.  Here's an example of the simplest
+possible arg addition, which is simply to append the given string as
+a whitespace-separated argument to the command:
+
+  struct dynevent_arg arg;
+
+  dynevent_arg_init(&arg, NULL, 0);
+
+  arg.str = name;
+
+  ret = dynevent_arg_add(cmd, &arg);
+
+The arg object is first initialized using dynevent_arg_init() and in
+this case the parameters are NULL or 0, which means there's no
+optional sanity-checking function or separator appended to the end of
+the arg.
+
+Here's another more complicated example using an 'arg pair', which is
+used to create an argument that consists of a couple components added
+together as a unit, for example, a 'type field_name;' arg or a simple
+expression arg e.g. 'flags=%cx':
+
+  struct dynevent_arg_pair arg_pair;
+
+  dynevent_arg_pair_init(&arg_pair, dynevent_foo_check_arg_fn, 0, ';');
+
+  arg_pair.lhs = type;
+  arg_pair.rhs = name;
+
+  ret = dynevent_arg_pair_add(cmd, &arg_pair);
+
+Again, the arg_pair is first initialized, in this case with a callback
+function used to check the sanity of the args (for example, that
+neither part of the pair is NULL), along with a character to be used
+to add an operator between the pair (here none) and a separator to be
+appended onto the end of the arg pair (here ';').
+
+There's also a dynevent_str_add() function that can be used to simply
+add a string as-is, with no spaces, delimeters, or arg check.
+
+Any number of dynevent_*_add() calls can be made to build up the string
+(until its length surpasses cmd->maxlen).  When all the arguments have
+been added and the command string is complete, the only thing left to
+do is run the command, which happens by simply calling
+dynevent_create():
+
+  ret = dynevent_create(&cmd);
+
+At that point, if the return value is 0, the dynamic event has been
+created and is ready to use.
+
+See the dynevent_cmd function definitions themselves for the details
+of the API.
-- 
2.14.1

