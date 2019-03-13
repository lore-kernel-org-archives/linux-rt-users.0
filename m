Return-Path: <SRS0=s/eb=RQ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C89C43381
	for <linux-rt-users@archiver.kernel.org>; Wed, 13 Mar 2019 12:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A982184E
	for <linux-rt-users@archiver.kernel.org>; Wed, 13 Mar 2019 12:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552480124;
	bh=2L+2NwOBiVKMfnRi15N9+tRX3RBC6Mc5xswsS11bNQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=izWylEhbD/UefrKwgFcImNWqGbt6SZWiPw7W/xkcwoQpTHZSYE5oVNk5BN2/sABjH
	 ibP+5w1mSpeF/CH4ZWiqBG4O1DP5083PvpgcoxwkLx30Jcdcb9hu8x6LT+DYzcSaHA
	 T0jjAugobY5LFX3sAA9g0TH5Cebun7tHQKxf1rW4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfCMM2i (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 13 Mar 2019 08:28:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:42126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbfCMM2i (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 13 Mar 2019 08:28:38 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDAB12183F;
        Wed, 13 Mar 2019 12:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552480116;
        bh=2L+2NwOBiVKMfnRi15N9+tRX3RBC6Mc5xswsS11bNQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FpC6bGIVNVbLnqaGJ/qySzgHUeGefCfIAmuCTwHLy1Dy+C62IfJeEpkdIXRtLlWaf
         Ne3S7NM4lstHvdTtfF6QNHZ6T+SKHh4JPdJg2YlN3z0DB0uVZpcpEKh4JEbqoLrvAX
         ZIbdC6judHae39j05/7DZ7HvuXo/cgVoyCg0Ww78=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [RFC PATCH 6/7] tracing: Use tracing error_log with probe events
Date:   Wed, 13 Mar 2019 21:28:31 +0900
Message-Id: <155248011156.10815.12118138888770837748.stgit@devnote2>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <155248005229.10815.334731901778152247.stgit@devnote2>
References: <155248005229.10815.334731901778152247.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Use tracing error_log with probe events for logging error more
precisely. This also makes all parse error returns -EINVAL
(except for -ENOMEM), because user can see better error message
in error_log file now.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c |   77 +++++++-----
 kernel/trace/trace_probe.c  |  272 +++++++++++++++++++++++++++++++------------
 kernel/trace/trace_probe.h  |   75 ++++++++++++
 kernel/trace/trace_uprobe.c |   35 ++++--
 4 files changed, 336 insertions(+), 123 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 56324c231688..b5945e1c3359 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -441,13 +441,8 @@ static int __register_trace_kprobe(struct trace_kprobe *tk)
 	else
 		ret = register_kprobe(&tk->rp.kp);
 
-	if (ret == 0) {
+	if (ret == 0)
 		tk->tp.flags |= TP_FLAG_REGISTERED;
-	} else if (ret == -EILSEQ) {
-		pr_warn("Probing address(0x%p) is not an instruction boundary.\n",
-			tk->rp.kp.addr);
-		ret = -EINVAL;
-	}
 	return ret;
 }
 
@@ -591,7 +586,7 @@ static int trace_kprobe_create(int argc, const char *argv[])
 	 * Type of args:
 	 *  FETCHARG:TYPE : use TYPE instead of unsigned long.
 	 */
-	struct trace_kprobe *tk;
+	struct trace_kprobe *tk = NULL;
 	int i, len, ret = 0;
 	bool is_return = false;
 	char *symbol = NULL, *tmp = NULL;
@@ -615,44 +610,50 @@ static int trace_kprobe_create(int argc, const char *argv[])
 	if (argc < 2)
 		return -ECANCELED;
 
+	trace_probe_log_init("trace_kprobe", argc, argv);
+
 	event = strchr(&argv[0][1], ':');
 	if (event)
 		event++;
 
 	if (isdigit(argv[0][1])) {
 		if (!is_return) {
-			pr_info("Maxactive is not for kprobe");
-			return -EINVAL;
+			trace_probe_log_err(1, MAXACT_NO_KPROBE);
+			goto parse_error;
 		}
 		if (event)
 			len = event - &argv[0][1] - 1;
 		else
 			len = strlen(&argv[0][1]);
-		if (len > MAX_EVENT_NAME_LEN - 1)
-			return -E2BIG;
+		if (len > MAX_EVENT_NAME_LEN - 1) {
+			trace_probe_log_err(1, BAD_MAXACT);
+			goto parse_error;
+		}
 		memcpy(buf, &argv[0][1], len);
 		buf[len] = '\0';
 		ret = kstrtouint(buf, 0, &maxactive);
 		if (ret || !maxactive) {
-			pr_info("Invalid maxactive number\n");
-			return ret;
+			trace_probe_log_err(1, BAD_MAXACT);
+			goto parse_error;
 		}
 		/* kretprobes instances are iterated over via a list. The
 		 * maximum should stay reasonable.
 		 */
 		if (maxactive > KRETPROBE_MAXACTIVE_MAX) {
-			pr_info("Maxactive is too big (%d > %d).\n",
-				maxactive, KRETPROBE_MAXACTIVE_MAX);
-			return -E2BIG;
+			trace_probe_log_err(1, MAXACT_TOO_BIG);
+			goto parse_error;
 		}
 	}
 
 	/* try to parse an address. if that fails, try to read the
 	 * input as a symbol. */
 	if (kstrtoul(argv[1], 0, (unsigned long *)&addr)) {
+		trace_probe_log_set_index(1);
 		/* Check whether uprobe event specified */
-		if (strchr(argv[1], '/') && strchr(argv[1], ':'))
-			return -ECANCELED;
+		if (strchr(argv[1], '/') && strchr(argv[1], ':')) {
+			ret = -ECANCELED;
+			goto error;
+		}
 		/* a symbol specified */
 		symbol = kstrdup(argv[1], GFP_KERNEL);
 		if (!symbol)
@@ -660,23 +661,23 @@ static int trace_kprobe_create(int argc, const char *argv[])
 		/* TODO: support .init module functions */
 		ret = traceprobe_split_symbol_offset(symbol, &offset);
 		if (ret || offset < 0 || offset > UINT_MAX) {
-			pr_info("Failed to parse either an address or a symbol.\n");
-			goto out;
+			trace_probe_log_err(0, BAD_PROBE_ADDR);
+			goto parse_error;
 		}
 		if (kprobe_on_func_entry(NULL, symbol, offset))
 			flags |= TPARG_FL_FENTRY;
 		if (offset && is_return && !(flags & TPARG_FL_FENTRY)) {
-			pr_info("Given offset is not valid for return probe.\n");
-			ret = -EINVAL;
-			goto out;
+			trace_probe_log_err(0, BAD_RETPROBE);
+			goto parse_error;
 		}
 	}
-	argc -= 2; argv += 2;
 
+	trace_probe_log_set_index(0);
 	if (event) {
-		ret = traceprobe_parse_event_name(&event, &group, buf);
+		ret = traceprobe_parse_event_name(&event, &group, buf,
+						  event - argv[0]);
 		if (ret)
-			goto out;
+			goto parse_error;
 	} else {
 		/* Make a new event name */
 		if (symbol)
@@ -691,13 +692,14 @@ static int trace_kprobe_create(int argc, const char *argv[])
 
 	/* setup a probe */
 	tk = alloc_trace_kprobe(group, event, addr, symbol, offset, maxactive,
-			       argc, is_return);
+			       argc - 2, is_return);
 	if (IS_ERR(tk)) {
 		ret = PTR_ERR(tk);
-		/* This must return -ENOMEM otherwise there is a bug */
+		/* This must return -ENOMEM, else there is a bug */
 		WARN_ON_ONCE(ret != -ENOMEM);
-		goto out;
+		goto out;	/* We know tk is not allocated */
 	}
+	argc -= 2; argv += 2;
 
 	/* parse arguments */
 	for (i = 0; i < argc && i < MAX_TRACE_ARGS; i++) {
@@ -707,19 +709,32 @@ static int trace_kprobe_create(int argc, const char *argv[])
 			goto error;
 		}
 
+		trace_probe_log_set_index(i + 2);
 		ret = traceprobe_parse_probe_arg(&tk->tp, i, tmp, flags);
 		kfree(tmp);
 		if (ret)
-			goto error;
+			goto error;	/* This can be -ENOMEM */
 	}
 
 	ret = register_trace_kprobe(tk);
-	if (ret)
+	if (ret) {
+		trace_probe_log_set_index(1);
+		if (ret == -EILSEQ)
+			trace_probe_log_err(0, BAD_INSN_BNDRY);
+		else if (ret == -ENOENT)
+			trace_probe_log_err(0, BAD_PROBE_ADDR);
+		else if (ret != -ENOMEM)
+			trace_probe_log_err(0, FAIL_REG_PROBE);
 		goto error;
+	}
+
 out:
+	trace_probe_log_clear();
 	kfree(symbol);
 	return ret;
 
+parse_error:
+	ret = -EINVAL;
 error:
 	free_trace_kprobe(tk);
 	goto out;
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 1f0cb4030c0b..9c3a16058ac8 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -13,6 +13,11 @@
 
 #include "trace_probe.h"
 
+#undef C
+#define C(a, b)		b
+
+static const char *trace_probe_err_text[] = { ERRORS };
+
 const char *reserved_field_names[] = {
 	"common_type",
 	"common_flags",
@@ -133,6 +138,60 @@ static const struct fetch_type *find_fetch_type(const char *type)
 	return NULL;
 }
 
+static struct trace_probe_log trace_probe_log;
+
+void trace_probe_log_init(const char *subsystem, int argc, const char **argv)
+{
+	trace_probe_log.subsystem = subsystem;
+	trace_probe_log.argc = argc;
+	trace_probe_log.argv = argv;
+	trace_probe_log.index = 0;
+}
+
+void trace_probe_log_clear(void)
+{
+	memset(&trace_probe_log, 0, sizeof(trace_probe_log));
+}
+
+void trace_probe_log_set_index(int index)
+{
+	trace_probe_log.index = index;
+}
+
+void __trace_probe_log_err(int offset, int err_type)
+{
+	char *command, *p;
+	int i, len = 0, pos = 0;
+
+	if (!trace_probe_log.argv)
+		return;
+
+	/* Recalcurate the length and allocate buffer */
+	for (i = 0; i < trace_probe_log.argc; i++) {
+		if (i == trace_probe_log.index)
+			pos = len;
+		len += strlen(trace_probe_log.argv[i]) + 1;
+	}
+	command = kzalloc(len, GFP_KERNEL);
+	if (!command)
+		return;
+
+	/* And make a command string from argv array */
+	p = command;
+	for (i = 0; i < trace_probe_log.argc; i++) {
+		len = strlen(trace_probe_log.argv[i]);
+		strcpy(p, trace_probe_log.argv[i]);
+		p[len] = ' ';
+		p += len + 1;
+	}
+	*(p - 1) = '\0';
+
+	tracing_log_err(trace_probe_log.subsystem, command,
+			trace_probe_err_text, err_type, pos + offset);
+
+	kfree(command);
+}
+
 /* Split symbol and offset. */
 int traceprobe_split_symbol_offset(char *symbol, long *offset)
 {
@@ -156,7 +215,7 @@ int traceprobe_split_symbol_offset(char *symbol, long *offset)
 
 /* @buf must has MAX_EVENT_NAME_LEN size */
 int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
-				char *buf)
+				char *buf, int offset)
 {
 	const char *slash, *event = *pevent;
 	int len;
@@ -164,32 +223,33 @@ int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
 	slash = strchr(event, '/');
 	if (slash) {
 		if (slash == event) {
-			pr_info("Group name is not specified\n");
+			trace_probe_log_err(offset, NO_GROUP_NAME);
 			return -EINVAL;
 		}
 		if (slash - event + 1 > MAX_EVENT_NAME_LEN) {
-			pr_info("Group name is too long\n");
-			return -E2BIG;
+			trace_probe_log_err(offset, GROUP_TOO_LONG);
+			return -EINVAL;
 		}
 		strlcpy(buf, event, slash - event + 1);
 		if (!is_good_name(buf)) {
-			pr_info("Group name must follow the rule of C identifier\n");
+			trace_probe_log_err(offset, BAD_GROUP_NAME);
 			return -EINVAL;
 		}
 		*pgroup = buf;
 		*pevent = slash + 1;
+		offset += slash - event + 1;
 		event = *pevent;
 	}
 	len = strlen(event);
 	if (len == 0) {
-		pr_info("Event name is not specified\n");
+		trace_probe_log_err(offset, NO_EVENT_NAME);
 		return -EINVAL;
 	} else if (len > MAX_EVENT_NAME_LEN) {
-		pr_info("Event name is too long\n");
-		return -E2BIG;
+		trace_probe_log_err(offset, EVENT_TOO_LONG);
+		return -EINVAL;
 	}
 	if (!is_good_name(event)) {
-		pr_info("Event name must follow the rule of C identifier\n");
+		trace_probe_log_err(offset, BAD_EVENT_NAME);
 		return -EINVAL;
 	}
 	return 0;
@@ -198,56 +258,67 @@ int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
 #define PARAM_MAX_STACK (THREAD_SIZE / sizeof(unsigned long))
 
 static int parse_probe_vars(char *arg, const struct fetch_type *t,
-			    struct fetch_insn *code, unsigned int flags)
+			struct fetch_insn *code, unsigned int flags, int offs)
 {
 	unsigned long param;
 	int ret = 0;
 	int len;
 
 	if (strcmp(arg, "retval") == 0) {
-		if (flags & TPARG_FL_RETURN)
+		if (flags & TPARG_FL_RETURN) {
 			code->op = FETCH_OP_RETVAL;
-		else
+		} else {
+			trace_probe_log_err(offs, RETVAL_ON_PROBE);
 			ret = -EINVAL;
+		}
 	} else if ((len = str_has_prefix(arg, "stack"))) {
 		if (arg[len] == '\0') {
 			code->op = FETCH_OP_STACKP;
 		} else if (isdigit(arg[len])) {
 			ret = kstrtoul(arg + len, 10, &param);
-			if (ret || ((flags & TPARG_FL_KERNEL) &&
-				    param > PARAM_MAX_STACK))
+			if (ret) {
+				goto inval_var;
+			} else if ((flags & TPARG_FL_KERNEL) &&
+				    param > PARAM_MAX_STACK) {
+				trace_probe_log_err(offs, BAD_STACK_NUM);
 				ret = -EINVAL;
-			else {
+			} else {
 				code->op = FETCH_OP_STACK;
 				code->param = (unsigned int)param;
 			}
 		} else
-			ret = -EINVAL;
+			goto inval_var;
 	} else if (strcmp(arg, "comm") == 0) {
 		code->op = FETCH_OP_COMM;
 #ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
 	} else if (((flags & TPARG_FL_MASK) ==
 		    (TPARG_FL_KERNEL | TPARG_FL_FENTRY)) &&
 		   (len = str_has_prefix(arg, "arg"))) {
-		if (!isdigit(arg[len]))
-			return -EINVAL;
 		ret = kstrtoul(arg + len, 10, &param);
-		if (ret || !param || param > PARAM_MAX_STACK)
+		if (ret) {
+			goto inval_var;
+		} else if (!param || param > PARAM_MAX_STACK) {
+			trace_probe_log_err(offs, BAD_ARG_NUM);
 			return -EINVAL;
+		}
 		code->op = FETCH_OP_ARG;
 		code->param = (unsigned int)param - 1;
 #endif
 	} else
-		ret = -EINVAL;
+		goto inval_var;
 
 	return ret;
+
+inval_var:
+	trace_probe_log_err(offs, BAD_VAR);
+	return -EINVAL;
 }
 
 /* Recursive argument parser */
 static int
 parse_probe_arg(char *arg, const struct fetch_type *type,
 		struct fetch_insn **pcode, struct fetch_insn *end,
-		unsigned int flags)
+		unsigned int flags, int offs)
 {
 	struct fetch_insn *code = *pcode;
 	unsigned long param;
@@ -257,7 +328,7 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 
 	switch (arg[0]) {
 	case '$':
-		ret = parse_probe_vars(arg + 1, type, code, flags);
+		ret = parse_probe_vars(arg + 1, type, code, flags, offs);
 		break;
 
 	case '%':	/* named register */
@@ -266,47 +337,57 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 			code->op = FETCH_OP_REG;
 			code->param = (unsigned int)ret;
 			ret = 0;
-		}
+		} else
+			trace_probe_log_err(offs, BAD_REG_NAME);
 		break;
 
 	case '@':	/* memory, file-offset or symbol */
 		if (isdigit(arg[1])) {
 			ret = kstrtoul(arg + 1, 0, &param);
-			if (ret)
+			if (ret) {
+				trace_probe_log_err(offs, BAD_MEM_ADDR);
 				break;
+			}
 			/* load address */
 			code->op = FETCH_OP_IMM;
 			code->immediate = param;
 		} else if (arg[1] == '+') {
 			/* kprobes don't support file offsets */
-			if (flags & TPARG_FL_KERNEL)
+			if (flags & TPARG_FL_KERNEL) {
+				trace_probe_log_err(offs, FILE_ON_KPROBE);
 				return -EINVAL;
-
+			}
 			ret = kstrtol(arg + 2, 0, &offset);
-			if (ret)
+			if (ret) {
+				trace_probe_log_err(offs, BAD_FILE_OFFS);
 				break;
+			}
 
 			code->op = FETCH_OP_FOFFS;
 			code->immediate = (unsigned long)offset;  // imm64?
 		} else {
 			/* uprobes don't support symbols */
-			if (!(flags & TPARG_FL_KERNEL))
+			if (!(flags & TPARG_FL_KERNEL)) {
+				trace_probe_log_err(offs, SYM_ON_UPROBE);
 				return -EINVAL;
-
+			}
 			/* Preserve symbol for updating */
 			code->op = FETCH_NOP_SYMBOL;
 			code->data = kstrdup(arg + 1, GFP_KERNEL);
 			if (!code->data)
 				return -ENOMEM;
-			if (++code == end)
-				return -E2BIG;
-
+			if (++code == end) {
+				trace_probe_log_err(offs, TOO_MANY_OPS);
+				return -EINVAL;
+			}
 			code->op = FETCH_OP_IMM;
 			code->immediate = 0;
 		}
 		/* These are fetching from memory */
-		if (++code == end)
-			return -E2BIG;
+		if (++code == end) {
+			trace_probe_log_err(offs, TOO_MANY_OPS);
+			return -EINVAL;
+		}
 		*pcode = code;
 		code->op = FETCH_OP_DEREF;
 		code->offset = offset;
@@ -317,28 +398,37 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 		/* fall through */
 	case '-':
 		tmp = strchr(arg, '(');
-		if (!tmp)
+		if (!tmp) {
+			trace_probe_log_err(offs, DEREF_NEED_BRACE);
 			return -EINVAL;
-
+		}
 		*tmp = '\0';
 		ret = kstrtol(arg, 0, &offset);
-		if (ret)
+		if (ret) {
+			trace_probe_log_err(offs, BAD_DEREF_OFFS);
 			break;
-
+		}
+		offs += (tmp + 1 - arg) + (arg[0] != '-' ? 1 : 0);
 		arg = tmp + 1;
 		tmp = strrchr(arg, ')');
-
-		if (tmp) {
+		if (!tmp) {
+			trace_probe_log_err(offs - 1, DEREF_OPEN_BRACE);
+			return -EINVAL;
+		} else {
 			const struct fetch_type *t2 = find_fetch_type(NULL);
 
 			*tmp = '\0';
-			ret = parse_probe_arg(arg, t2, &code, end, flags);
+			ret = parse_probe_arg(arg, t2, &code, end, flags, offs);
 			if (ret)
 				break;
-			if (code->op == FETCH_OP_COMM)
+			if (code->op == FETCH_OP_COMM) {
+				trace_probe_log_err(offs, COMM_CANT_DEREF);
+				return -EINVAL;
+			}
+			if (++code == end) {
+				trace_probe_log_err(offs, TOO_MANY_OPS);
 				return -EINVAL;
-			if (++code == end)
-				return -E2BIG;
+			}
 			*pcode = code;
 
 			code->op = FETCH_OP_DEREF;
@@ -348,6 +438,7 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 	}
 	if (!ret && code->op == FETCH_OP_NOP) {
 		/* Parsed, but do not find fetch method */
+		trace_probe_log_err(offs, BAD_FETCH_ARG);
 		ret = -EINVAL;
 	}
 	return ret;
@@ -379,7 +470,7 @@ static int __parse_bitfield_probe_arg(const char *bf,
 		return -EINVAL;
 	code++;
 	if (code->op != FETCH_OP_NOP)
-		return -E2BIG;
+		return -EINVAL;
 	*pcode = code;
 
 	code->op = FETCH_OP_MOD_BF;
@@ -392,32 +483,52 @@ static int __parse_bitfield_probe_arg(const char *bf,
 
 /* String length checking wrapper */
 static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
-		struct probe_arg *parg, unsigned int flags)
+		struct probe_arg *parg, unsigned int flags, int offset)
 {
 	struct fetch_insn *code, *scode, *tmp = NULL;
-	char *t, *t2;
+	char *t, *t2, *t3;
 	int ret, len;
 
-	if (strlen(arg) > MAX_ARGSTR_LEN) {
-		pr_info("Argument is too long.: %s\n",  arg);
-		return -ENOSPC;
+	len = strlen(arg);
+	if (len > MAX_ARGSTR_LEN) {
+		trace_probe_log_err(offset, ARG_TOO_LONG);
+		return -EINVAL;
+	} else if (len == 0) {
+		trace_probe_log_err(offset, NO_ARG_BODY);
+		return -EINVAL;
 	}
+
 	parg->comm = kstrdup(arg, GFP_KERNEL);
-	if (!parg->comm) {
-		pr_info("Failed to allocate memory for command '%s'.\n", arg);
+	if (!parg->comm)
 		return -ENOMEM;
-	}
+
 	t = strchr(arg, ':');
 	if (t) {
 		*t = '\0';
 		t2 = strchr(++t, '[');
 		if (t2) {
-			*t2 = '\0';
-			parg->count = simple_strtoul(t2 + 1, &t2, 0);
-			if (strcmp(t2, "]") || parg->count == 0)
+			*t2++ = '\0';
+			t3 = strchr(t2, ']');
+			if (!t3) {
+				trace_probe_log_err(offset + t2 - arg - 1,
+						    ARRAY_NO_CLOSE);
+				return -EINVAL;
+			} else if (t3[1] != '\0') {
+				trace_probe_log_err(offset + t3 + 1 - arg,
+						    BAD_ARRAY_SUFFIX);
+				return -EINVAL;
+			}
+			*t3 = '\0';
+			if (kstrtouint(t2, 0, &parg->count) || !parg->count) {
+				trace_probe_log_err(offset + t2 - arg,
+						    BAD_ARRAY_NUM);
 				return -EINVAL;
-			if (parg->count > MAX_ARRAY_LEN)
-				return -E2BIG;
+			}
+			if (parg->count > MAX_ARRAY_LEN) {
+				trace_probe_log_err(offset + t2 - arg,
+						    ARRAY_TOO_BIG);
+				return -EINVAL;
+			}
 		}
 	}
 	/*
@@ -429,7 +540,7 @@ static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
 	else
 		parg->type = find_fetch_type(t);
 	if (!parg->type) {
-		pr_info("Unsupported type: %s\n", t);
+		trace_probe_log_err(offset + (t ? (t - arg) : 0), BAD_TYPE);
 		return -EINVAL;
 	}
 	parg->offset = *size;
@@ -450,7 +561,7 @@ static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
 	code[FETCH_INSN_MAX - 1].op = FETCH_OP_END;
 
 	ret = parse_probe_arg(arg, parg->type, &code, &code[FETCH_INSN_MAX - 1],
-			      flags);
+			      flags, offset);
 	if (ret)
 		goto fail;
 
@@ -458,7 +569,8 @@ static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
 	if (!strcmp(parg->type->name, "string")) {
 		if (code->op != FETCH_OP_DEREF && code->op != FETCH_OP_IMM &&
 		    code->op != FETCH_OP_COMM) {
-			pr_info("string only accepts memory or address.\n");
+			trace_probe_log_err(offset + (t ? (t - arg) : 0),
+					    BAD_STRING);
 			ret = -EINVAL;
 			goto fail;
 		}
@@ -470,7 +582,8 @@ static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
 			 */
 			code++;
 			if (code->op != FETCH_OP_NOP) {
-				ret = -E2BIG;
+				trace_probe_log_err(offset, TOO_MANY_OPS);
+				ret = -EINVAL;
 				goto fail;
 			}
 		}
@@ -483,7 +596,8 @@ static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
 	} else {
 		code++;
 		if (code->op != FETCH_OP_NOP) {
-			ret = -E2BIG;
+			trace_probe_log_err(offset, TOO_MANY_OPS);
+			ret = -EINVAL;
 			goto fail;
 		}
 		code->op = FETCH_OP_ST_RAW;
@@ -493,20 +607,24 @@ static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
 	/* Modify operation */
 	if (t != NULL) {
 		ret = __parse_bitfield_probe_arg(t, parg->type, &code);
-		if (ret)
+		if (ret) {
+			trace_probe_log_err(offset + t - arg, BAD_BITFIELD);
 			goto fail;
+		}
 	}
 	/* Loop(Array) operation */
 	if (parg->count) {
 		if (scode->op != FETCH_OP_ST_MEM &&
 		    scode->op != FETCH_OP_ST_STRING) {
-			pr_info("array only accepts memory or address\n");
+			trace_probe_log_err(offset + (t ? (t - arg) : 0),
+					    BAD_STRING);
 			ret = -EINVAL;
 			goto fail;
 		}
 		code++;
 		if (code->op != FETCH_OP_NOP) {
-			ret = -E2BIG;
+			trace_probe_log_err(offset, TOO_MANY_OPS);
+			ret = -EINVAL;
 			goto fail;
 		}
 		code->op = FETCH_OP_LP_ARRAY;
@@ -555,15 +673,19 @@ int traceprobe_parse_probe_arg(struct trace_probe *tp, int i, char *arg,
 {
 	struct probe_arg *parg = &tp->args[i];
 	char *body;
-	int ret;
 
 	/* Increment count for freeing args in error case */
 	tp->nr_args++;
 
 	body = strchr(arg, '=');
 	if (body) {
-		if (body - arg > MAX_ARG_NAME_LEN || body == arg)
+		if (body - arg > MAX_ARG_NAME_LEN) {
+			trace_probe_log_err(0, ARG_NAME_TOO_LONG);
+			return -EINVAL;
+		} else if (body == arg) {
+			trace_probe_log_err(0, NO_ARG_NAME);
 			return -EINVAL;
+		}
 		parg->name = kmemdup_nul(arg, body - arg, GFP_KERNEL);
 		body++;
 	} else {
@@ -575,22 +697,16 @@ int traceprobe_parse_probe_arg(struct trace_probe *tp, int i, char *arg,
 		return -ENOMEM;
 
 	if (!is_good_name(parg->name)) {
-		pr_info("Invalid argument[%d] name: %s\n",
-			i, parg->name);
+		trace_probe_log_err(0, BAD_ARG_NAME);
 		return -EINVAL;
 	}
-
 	if (traceprobe_conflict_field_name(parg->name, tp->args, i)) {
-		pr_info("Argument[%d]: '%s' conflicts with another field.\n",
-			i, parg->name);
+		trace_probe_log_err(0, USED_ARG_NAME);
 		return -EINVAL;
 	}
-
 	/* Parse fetch argument */
-	ret = traceprobe_parse_probe_arg_body(body, &tp->size, parg, flags);
-	if (ret)
-		pr_info("Parse error at argument[%d]. (%d)\n", i, ret);
-	return ret;
+	return traceprobe_parse_probe_arg_body(body, &tp->size, parg, flags,
+					       body - arg);
 }
 
 void traceprobe_free_probe_arg(struct probe_arg *arg)
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 2177c206de15..d0a25de18a20 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -280,8 +280,8 @@ extern int traceprobe_update_arg(struct probe_arg *arg);
 extern void traceprobe_free_probe_arg(struct probe_arg *arg);
 
 extern int traceprobe_split_symbol_offset(char *symbol, long *offset);
-extern int traceprobe_parse_event_name(const char **pevent,
-				       const char **pgroup, char *buf);
+int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
+				char *buf, int offset);
 
 extern int traceprobe_set_print_fmt(struct trace_probe *tp, bool is_return);
 
@@ -298,3 +298,74 @@ extern void destroy_local_trace_uprobe(struct trace_event_call *event_call);
 #endif
 extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 					size_t offset, struct trace_probe *tp);
+
+#undef ERRORS
+#define ERRORS	\
+	C(FILE_NOT_FOUND,	"Failed to find the given file"),	\
+	C(NO_REGULAR_FILE,	"Not a regular file"),			\
+	C(BAD_REFCNT,		"Invalid reference counter offset"),	\
+	C(BAD_UPROBE_OFFS,	"Invalid uprobe offset"),		\
+	C(MAXACT_NO_KPROBE,	"Maxactive is not for kprobe"),		\
+	C(BAD_MAXACT,		"Invalid maxactive number"),		\
+	C(MAXACT_TOO_BIG,	"Maxactive is too big"),		\
+	C(BAD_PROBE_ADDR,	"Invalid probed address or symbol"),	\
+	C(BAD_RETPROBE,		"Retprobe address must be an function entry"),\
+	C(NO_GROUP_NAME,	"Group name is not specified"),		\
+	C(GROUP_TOO_LONG,	"Group name is too long"),		\
+	C(BAD_GROUP_NAME,	"Group name must follow the rule of C identifier"), \
+	C(NO_EVENT_NAME,	"Event name is not specified"),		\
+	C(EVENT_TOO_LONG,	"Event name is too long"),		\
+	C(BAD_EVENT_NAME,	"Event name must follow the rule of C identifier"), \
+	C(RETVAL_ON_PROBE,	"$retval is not available on probe"),	\
+	C(BAD_STACK_NUM,	"Invalid stack number"),		\
+	C(BAD_ARG_NUM,		"Invalid argument number"),		\
+	C(BAD_VAR,		"Invalid $-valiable specified"),	\
+	C(BAD_REG_NAME,		"Invalid register name"),		\
+	C(BAD_MEM_ADDR,		"Invalid memory address"),		\
+	C(FILE_ON_KPROBE,	"File offset is not available with kprobe"), \
+	C(BAD_FILE_OFFS,	"Invalid file offset value"),		\
+	C(SYM_ON_UPROBE,	"Symbol is not available with uprobe"),	\
+	C(TOO_MANY_OPS,		"Dereference is too much nested"), 	\
+	C(DEREF_NEED_BRACE,	"Dereference needs a brace"),		\
+	C(BAD_DEREF_OFFS,	"Invalid dereference offset"),		\
+	C(DEREF_OPEN_BRACE,	"Dereference brace is not closed"),	\
+	C(COMM_CANT_DEREF,	"$comm can not be dereferenced"),	\
+	C(BAD_FETCH_ARG,	"Invalid fetch argument"),		\
+	C(ARRAY_NO_CLOSE,	"Array is not closed"),			\
+	C(BAD_ARRAY_SUFFIX,	"Array has wrong suffix"),		\
+	C(BAD_ARRAY_NUM,	"Invalid array size"),			\
+	C(ARRAY_TOO_BIG,	"Array number is too big"),		\
+	C(BAD_TYPE,		"Unknown type is specified"),		\
+	C(BAD_STRING,		"String accepts only memory argument"),	\
+	C(BAD_BITFIELD,		"Invalid bitfield"),			\
+	C(ARG_NAME_TOO_LONG,	"Argument name is too long"),		\
+	C(NO_ARG_NAME,		"Argument name is not specified"),	\
+	C(BAD_ARG_NAME,		"Invalid argument name"),		\
+	C(USED_ARG_NAME,	"This argument name is already used"),	\
+	C(ARG_TOO_LONG,		"Argument expression is too long"),	\
+	C(NO_ARG_BODY,		"No argument expression"),		\
+	C(BAD_INSN_BNDRY,	"Probe point is not an instruction boundary"),\
+	C(FAIL_REG_PROBE,	"Failed to register probe event"),
+
+#undef C
+#define C(a, b)		TP_ERR_##a
+
+/* Define TP_ERR_ */
+enum { ERRORS };
+
+/* Error text is defined in trace_probe.c */
+
+struct trace_probe_log {
+	const char	*subsystem;
+	const char	**argv;
+	int		argc;
+	int		index;
+};
+
+void trace_probe_log_init(const char *subsystem, int argc, const char **argv);
+void trace_probe_log_set_index(int index);
+void trace_probe_log_clear(void);
+void __trace_probe_log_err(int offset, int err);
+
+#define trace_probe_log_err(offs, err)	\
+	__trace_probe_log_err(offs, TP_ERR_##err)
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index b54137ec7810..80141aeb0e48 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -450,13 +450,19 @@ static int trace_uprobe_create(int argc, const char **argv)
 		return -ECANCELED;
 	}
 
+	trace_probe_log_init("trace_uprobe", argc, argv);
+	trace_probe_log_set_index(1);	/* filename is the 2nd argument */
+
 	*arg++ = '\0';
 	ret = kern_path(filename, LOOKUP_FOLLOW, &path);
 	if (ret) {
+		trace_probe_log_err(0, FILE_NOT_FOUND);
 		kfree(filename);
+		trace_probe_log_clear();
 		return ret;
 	}
 	if (!d_is_reg(path.dentry)) {
+		trace_probe_log_err(0, NO_REGULAR_FILE);
 		ret = -EINVAL;
 		goto fail_address_parse;
 	}
@@ -467,7 +473,7 @@ static int trace_uprobe_create(int argc, const char **argv)
 		rctr_end = strchr(rctr, ')');
 		if (rctr > rctr_end || *(rctr_end + 1) != 0) {
 			ret = -EINVAL;
-			pr_info("Invalid reference counter offset.\n");
+			trace_probe_log_err(rctr - filename, BAD_REFCNT);
 			goto fail_address_parse;
 		}
 
@@ -475,22 +481,23 @@ static int trace_uprobe_create(int argc, const char **argv)
 		*rctr_end = '\0';
 		ret = kstrtoul(rctr, 0, &ref_ctr_offset);
 		if (ret) {
-			pr_info("Invalid reference counter offset.\n");
+			trace_probe_log_err(rctr - filename, BAD_REFCNT);
 			goto fail_address_parse;
 		}
 	}
 
 	/* Parse uprobe offset. */
 	ret = kstrtoul(arg, 0, &offset);
-	if (ret)
+	if (ret) {
+		trace_probe_log_err(arg - filename, BAD_UPROBE_OFFS);
 		goto fail_address_parse;
-
-	argc -= 2;
-	argv += 2;
+	}
 
 	/* setup a probe */
+	trace_probe_log_set_index(0);
 	if (event) {
-		ret = traceprobe_parse_event_name(&event, &group, buf);
+		ret = traceprobe_parse_event_name(&event, &group, buf,
+						  event - argv[0]);
 		if (ret)
 			goto fail_address_parse;
 	} else {
@@ -512,6 +519,9 @@ static int trace_uprobe_create(int argc, const char **argv)
 		kfree(tail);
 	}
 
+	argc -= 2;
+	argv += 2;
+
 	tu = alloc_trace_uprobe(group, event, argc, is_return);
 	if (IS_ERR(tu)) {
 		ret = PTR_ERR(tu);
@@ -532,6 +542,7 @@ static int trace_uprobe_create(int argc, const char **argv)
 			goto error;
 		}
 
+		trace_probe_log_set_index(i + 2);
 		ret = traceprobe_parse_probe_arg(&tu->tp, i, tmp,
 					is_return ? TPARG_FL_RETURN : 0);
 		kfree(tmp);
@@ -540,20 +551,20 @@ static int trace_uprobe_create(int argc, const char **argv)
 	}
 
 	ret = register_trace_uprobe(tu);
-	if (ret)
-		goto error;
-	return 0;
+	if (!ret)
+		goto out;
 
 error:
 	free_trace_uprobe(tu);
+out:
+	trace_probe_log_clear();
 	return ret;
 
 fail_address_parse:
+	trace_probe_log_clear();
 	path_put(&path);
 	kfree(filename);
 
-	pr_info("Failed to parse address or file.\n");
-
 	return ret;
 }
 

