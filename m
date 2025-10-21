Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D2F3321DC
	for <linux-rt-users@vger.kernel.org>; Tue, 21 Oct 2025 15:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062097; cv=none; b=fYEuhh1wIVPYzsKaE8zfq0MQ7FQA4sa2Rqjcc8rAZEHT70mor+7sOGDDaEOWJvS0ba+fDXBsQpwyQlpbaDj3BcXWi0sM9rEjXWkXpe4bd9vzHlBjVnQV5S49uUSXVfqQki2PSmp9Eb/H6U4SMPgDarwQys4rj3Ax9D2dknlzJXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062097; c=relaxed/simple;
	bh=jM17+hHjpK8fegZw3NXO46fL1MbIqQQvZjXS8esiHOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FabkMqErnP9F05cVmt8OMiqC2u+BinxLwdL5i0AWvXXTM86vRLfxS2MZVi+SNzmSQ1aTAXeLl3swFBERLLk+nxk7Eow12Z1HHBc9r3R7bKwfvSJD88wz4Hy7AO/EhIFJrxEkoXvr0VqZLRXCUvTBgvSV6WfcHKmmSWMIiIa8cmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SJLAJ0NO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SJLAJ0NO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761062094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3TAAs9Z69DE2PcCMwkI1n6tGXwgQM7sOeuXP6m4XzKM=;
	b=SJLAJ0NOmKrKCc0MhrOD6pqqn0/7Ap22WaRm3lF43GgFa46G+ZZ3dK3NM1Z5mYWdX+BkEL
	zFpGB5KGYos/ubYj4UeYQE0fBdfp09JT6iO+vgHobgBHiQVF0z+Y1JlWE4iTdWYw/Iour8
	ZfbUBuCNRG0XgWJJi5fOgjtrVLIJ6PI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-nsW9s35JMq2nl-sl1h8M_Q-1; Tue,
 21 Oct 2025 11:54:50 -0400
X-MC-Unique: nsW9s35JMq2nl-sl1h8M_Q-1
X-Mimecast-MFC-AGG-ID: nsW9s35JMq2nl-sl1h8M_Q_1761062089
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 25CF419560B6;
	Tue, 21 Oct 2025 15:54:49 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.80.189])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 86D843000221;
	Tue, 21 Oct 2025 15:54:44 +0000 (UTC)
Date: Tue, 21 Oct 2025 12:54:42 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <clrkwllms@kernel.org>
Cc: linux-rt-users@vger.kernel.org, Clark Williams <williams@redhat.com>, 
	Derek Barbosa <debarbos@redhat.com>, marco.chiappero@suse.com, chris.friesen@windriver.com, 
	luochunsheng@ustc.edu
Subject: Re: [PATCH 01/12] sched_debug: Unify parsing methods for task_info
Message-ID: <vv7cmoftbrn3ubivne72pfvyaolw63jvxnk63qpz3hkv77cszj@qnqdrhokk62n>
References: <20251017022444.118802-1-clrkwllms@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017022444.118802-1-clrkwllms@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Oct 16, 2025 at 09:24:33PM -0500, Clark Williams wrote:
> From: Clark Williams <williams@redhat.com>
> 
> In the sched_debug backend code, there are two logical paths for parsing
> the sched_debug file's task_info "running tasks". These are currently
> divided into "OLD" and "NEW" parsing functions, each with their own
> logic.
> 
> Unify these branching code paths by creating a line-based "word" parser
> that stores the word-offset of the neccessary fields in a struct.
> Accomodate "legacy" behavior where needed using an enumerated type.
> 
> parse_task_lines() now can parse multiple formats of output from the
> debugfs file which on modern systems is located at
> /sys/kernel/debug/sched/debug, and on 3.X "legacy" systems, is located
> at /proc/sched_debug.
> 
> The detect_task_format() function records field offsets which are used
> by parse_task_lines to pull fields out of the "running tasks:" section.
> 
> Signed-off-by: Clark Williams <clrkwllms@kernel.org>
> Signed-off-by: Derek Barbosa <debarbos@redhat.com>
> Signed-off-by: Clark Williams <williams@redhat.com>
> ---
>  src/sched_debug.c | 405 +++++++++++++++++++++-------------------------
>  src/sched_debug.h |  65 +++++++-
>  2 files changed, 244 insertions(+), 226 deletions(-)
> 
> diff --git a/src/sched_debug.c b/src/sched_debug.c
> index fa2f74bf36ed..180932ca7aa3 100644
> --- a/src/sched_debug.c
> +++ b/src/sched_debug.c
> @@ -24,6 +24,9 @@
>   */
>  static int config_task_format;
>  
> +static struct task_format_offsets
> +    config_task_format_offsets  = { 0, 0, 0, 0 };
> +
>  /*
>   * Read the contents of sched_debug into the input buffer.
>   */
> @@ -88,8 +91,12 @@ static char *get_next_cpu_info_start(char *start)
>  {
>  	const char *next_cpu = "cpu#";
>  
> -	/* Skip the current CPU definition. */
> -	start += 10;
> +        /*
> +         * Skip the current CPU definition.
> +         * We want to move our "cursor" past the current "cpu#" definition.
> +         * This number is arbitrary. It is purely to assist strstr().
> +         */
> +        start += 10;
>  
>  	return strstr(start, next_cpu);
>  }
> @@ -143,9 +150,13 @@ static inline char *skipchars(char *str)
>  	return str;
>  }
>  
> +/*
> + * Note, for our purposes newline is *not* a space
> + * and we want to stop when we hit it
> + */
>  static inline char *skipspaces(char *str)
>  {
> -	while (*str && isspace(*str))
> +	while (*str && isspace(*str) && (*str != '\n'))
>  		str++;
>  	return str;
>  }
> @@ -156,6 +167,20 @@ static inline char *nextline(char *str)
>  	return ptr ? ptr+1 : NULL;
>  }
>  
> +/*
> + * skip a specified number of words on a task line
> + */
> +
> +static inline char *skipwords(char *ptr, int nwords)
> +{
> +	int i;
> +	for (i=0; i < nwords; i++) {
> +		ptr = skipspaces(ptr);
> +		ptr = skipchars(ptr);
> +	}
> +	return ptr;
> +}
> +
>  /*
>   * Read sched_debug and figure out if it's old or new format
>   * done once so if we fail just exit the program.
> @@ -173,6 +198,7 @@ static int detect_task_format(void)
>  	char *ptr;
>  	int status;
>  	int fd;
> +	int i, count=0;
>  
>  	bufsiz = bufincrement = BUFFER_PAGES * page_size;
>  
> @@ -204,122 +230,63 @@ static int detect_task_format(void)
>  
>  	ptr = strstr(buffer, TASK_MARKER);
>  	if (ptr == NULL) {
> -		fprintf(stderr, "unable to find 'runnable tasks' in buffer, invalid input\n");
> +		die("unable to find 'runnable tasks' in buffer, invalid input\n");
>  		exit(-1);
>  	}
>  
> -	ptr += strlen(TASK_MARKER) + 1;
> -	ptr = skipspaces(ptr);
> +	ptr = nextline(ptr);
> +	i = 0;
>  
> -	if (strncmp(ptr, "task", 4) == 0) {
> -		retval = OLD_TASK_FORMAT;
> -		log_msg("detected old task format\n");
> -	} else if (strncmp(ptr, "S", 1) == 0) {
> +	/*
> +	 * Determine the TASK_FORMAT from the first "word" in the header
> +	 * line.
> +	 */
> +	ptr = skipspaces(ptr);
> +	if (strncmp(ptr, "S", strlen("S")) == 0) {
> +		log_msg("detect_task_format: NEW_TASK_FORMAT detected\n");
>  		retval = NEW_TASK_FORMAT;
> -		log_msg("detected new task format\n");
>  	}
> -
> -	free(buffer);
> -	return retval;
> -}
> -
> -/*
> - * Parse the new sched_debug format.
> - *
> - * Example:
> - * ' S           task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep'
> - * '-----------------------------------------------------------------------------------------------------------'
> - * ' I         rcu_gp     3        13.973264         2   100         0.000000         0.004469         0.000000 0 0 /
> - */
> -static int parse_new_task_format(char *buffer, struct task_info *task_info, int nr_entries)
> -{
> -	char *R, *X, *start = buffer;
> -	struct task_info *task;
> -	int tasks = 0;
> -	int comm_size;
> -	char *end;
> +	else {
> +		log_msg("detect_task_format: OLD_TASK_FORMAT detected\n");
> +		retval = OLD_TASK_FORMAT;
> +	}
>  
>  	/*
> -	 * If we have less than two tasks on the CPU there is no
> -	 * possibility of a stall.
> +	 * Look for our header keywords and store their offset
> +	 * we'll use the offsets when we actually parse the task
> +	 * line data
>  	 */
> -	if (nr_entries < 2)
> -		return 0;
> -
> -	while (tasks < nr_entries) {
> -		task = &task_info[tasks];
> -
> -		/*
> -		 * Runnable tasks.
> -		 */
> -		R = strstr(start, "\n R");
> -
> -		/*
> -		 * Dying tasks.
> -		 */
> -		X = strstr(start, "\n X");
> -
> -		/*
> -		 * Get the first one, the only one, or break.
> -		 */
> -		if (X && R) {
> -			start = R < X ? R : X;
> -		} else if (X || R) {
> -			start = R ? R : X;
> -		} else {
> -			break;
> +	while (*ptr != '\n') {
> +		ptr = skipspaces(ptr);
> +		if (strncmp(ptr, "task", strlen("task")) == 0) {
> +			config_task_format_offsets.task = i;
> +			count++;
> +			log_msg("detect_task_format: found 'task' at word %d\n", i);
>  		}
> -
> -		/* Skip '\n R' || '\n X'. */
> -		start = &start[3];
> -
> -		/* Skip the spaces. */
> -		start = skipspaces(start);
> -
> -		/* Find the end of the string. */
> -		end = skipchars(start);
> -
> -		comm_size = end - start;
> -
> -		if (comm_size >= COMM_SIZE) {
> -			warn("comm_size is too large: %d\n", comm_size);
> -			comm_size = COMM_SIZE - 1;
> +		else if (strncmp(ptr, "PID", strlen("PID")) == 0) {
> +			config_task_format_offsets.pid = i;
> +			count++;
> +			log_msg("detect_task_format: found 'PID' at word %d\n", i);
>  		}
> -
> -		strncpy(task->comm, start, comm_size);
> -
> -		task->comm[comm_size] = '\0';
> -
> -		/* Go to the end of the task comm. */
> -		start=end;
> -
> -		task->pid = strtol(start, &end, 10);
> -
> -		/* Get the id of the thread group leader. */
> -		task->tgid = get_tgid(task->pid);
> -
> -		/* Go to the end of the pid. */
> -		start=end;
> -
> -		/* Skip the tree-key. */
> -		start = skipspaces(start);
> -		start = skipchars(start);
> -
> -		task->ctxsw = strtol(start, &end, 10);
> -
> -		start = end;
> -
> -		task->prio = strtol(start, &end, 10);
> -
> -		task->since = time(NULL);
> -
> -		/* Go to the end and try to find the next occurrence. */
> -		start = end;
> -
> -		tasks++;
> +		else if (strncmp(ptr, "switches", strlen("switches")) == 0) {
> +			config_task_format_offsets.switches = i;
> +			count++;
> +			log_msg("detect_task_format: found 'switches' at word %d\n", i);
> +		}
> +		else if (strncmp(ptr, "prio", strlen("prio")) == 0) {
> +			config_task_format_offsets.prio = i;
> +			count++;
> +			log_msg("detect_task_format: found 'prio' at word %d\n", i);
> +		}
> +		ptr = skipchars(ptr);
> +		i++;
>  	}
>  
> -	return tasks;
> +	if (count != 4)
> +		die("detect_task_format: did not detect all task line fields we need\n");
> +
> +	free(buffer);
> +	return retval;
>  }
>  
>  /*
> @@ -387,104 +354,80 @@ static int is_runnable(int pid)
>  	return runnable;
>  }
>  
> -static int count_task_lines(char *buffer)
> -{
> -	int lines = 0;
> -	char *ptr;
> -	int len;
> -
> -	len = strlen(buffer);
> -
> -	/* Find the runnable tasks: header. */
> -	ptr = strstr(buffer, TASK_MARKER);
> -	if (ptr == NULL)
> -		return 0;
> -
> -	/* Skip to the end of the dashed line separator. */
> -	ptr = strstr(ptr, "-\n");
> -	if (ptr == NULL)
> -		return 0;
> -
> -	ptr += 2;
> -	while(*ptr && ptr < (buffer+len)) {
> -		lines++;
> -		ptr = strchr(ptr, '\n');
> -		if (ptr == NULL)
> -			break;
> -		ptr++;
> -	}
> -	return lines;
> -}
> -
> -/*
> - * Parse the old sched debug format:
> - *
> - * Example:
> - * '            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep
> - * ' ----------------------------------------------------------------------------------------------------------
> - * '     watchdog/35   296       -11.731402      4081     0         0.000000        44.052473         0.000000 /
> - */
> -static int parse_old_task_format(char *buffer, struct task_info *task_info, int nr_entries)
> +static int parse_task_lines(char *buffer, struct task_info *task_info, int nr_entries)
>  {
>  	int pid, ctxsw, prio, comm_size;
> -	char *start, *end, *buffer_end;
> +	char *ptr, *line, *end;
>  	struct task_info *task;
>  	char comm[COMM_SIZE];
> -	int waiting_tasks = 0;
> -
> -	start = buffer;
> -	start = strstr(start, TASK_MARKER);
> -	start = strstr(start, "-\n");
> -	start++;
> +	int tasks = 0;
>  
> -	buffer_end = buffer + strlen(buffer);
> +	if ((ptr = strstr(buffer, TASK_MARKER)) == NULL)
> +		die ("no runnable task section found!\n");
>  
>  	/*
> -	 * We can't short-circuit using nr_entries, we have to scan the
> -	 * entire list of processes that is on this CPU.
> +	 * If we have less than two tasks on the CPU there is no
> +	 * possibility of a stall.
>  	 */
> -	while (*start && start < buffer_end) {
> -		task = &task_info[waiting_tasks];
> +	if (nr_entries < 2)
> +		return 0;
> +	line = ptr;
> +
> +	/* skip header and divider */
> +	line = nextline(line);
> +	line = nextline(line);
> +	
> +	/* now loop over the task info */
> +	while (tasks < nr_entries) {
> +		task = &task_info[tasks];
>  
> -		/* Only care about tasks that are not R (running on a CPU). */
> -		if (start[0] == 'R') {
> +		/*
> +		 * In 3.X kernels, only the singular RUNNING task receives
> +		 * a "running state" label. Therefore, only care about
> +		 * tasks that are not R (running on a CPU).
> +		 */
> +		if ((config_task_format == OLD_TASK_FORMAT) &&
> +			(*ptr == 'R')) {
>  			/* Go to the end of the line and ignore this task. */
> -			start = strchr(start, '\n');
> -			start++;
> +			ptr = strchr(ptr, '\n');
> +			ptr++;
>  			continue;
>  		}
>  
> -		/* Pick up the comm field. */
> -		start = skipspaces(start);
> -		end = skipchars(start);
> -		comm_size = end - start;
> +		/* get the task field */
> +		ptr = skipwords(line, config_task_format_offsets.task);
> +
> +		/* Find the end of the task field */
> +		end = skipchars(ptr);
> +		comm_size = end - ptr;
> +
> +		/* make sure we don't overflow the comm array */
>  		if (comm_size >= COMM_SIZE) {
>  			warn("comm_size is too large: %d\n", comm_size);
>  			comm_size = COMM_SIZE - 1;
>  		}
> -		strncpy(comm, start, comm_size);
> -		comm[comm_size] = 0;
> -
> -		/* Go to the end of the task comm. */
> -		start=end;
> -
> -		/* Now pick up the pid. */
> -		pid = strtol(start, &end, 10);
> -
> -		/* Go to the end of the pid. */
> -		start=end;
> -
> -		/* Skip the tree-key. */
> -		start = skipspaces(start);
> -		start = skipchars(start);
> -
> -		/* Pick up the context switch count. */
> -		ctxsw = strtol(start, &end, 10);
> -		start = end;
> -
> -		/* Get the priority. */
> -		prio = strtol(start, &end, 10);
> -		if (is_runnable(pid)) {
> +		strncpy(comm, ptr, comm_size);
> +		comm[comm_size] = '\0';
> +		ptr = end;
> +
> +		/* get the PID field */
> +		ptr = skipwords(line, config_task_format_offsets.pid);
> +		pid = strtol(ptr, NULL, 10);
> +
> +		/* get the context switches field */
> +		ptr = skipwords(line, config_task_format_offsets.switches);
> +		ctxsw = strtol(ptr, NULL, 10);
> +
> +		/* get the prio field */
> +		ptr = skipwords(line, config_task_format_offsets.prio);
> +		prio = strtol(ptr, NULL, 10);
> +
> +                /*
> +                 * In older formats, we must check to
> +                 * see if the process is runnable prior to storing header
> +                 * fields and incrementing task processing
> +                 */
> +                if ((config_task_format == NEW_TASK_FORMAT) || (is_runnable(pid))) {
>  			strncpy(task->comm, comm, comm_size);
>  			task->comm[comm_size] = 0;
>  			task->pid = pid;
> @@ -492,18 +435,44 @@ static int parse_old_task_format(char *buffer, struct task_info *task_info, int
>  			task->ctxsw = ctxsw;
>  			task->prio = prio;
>  			task->since = time(NULL);
> -			waiting_tasks++;
> +			/* increment the count of tasks processed */
> +			tasks++;
> +		} else {
> +			continue;
>  		}
>  
> -		if ((start = nextline(start)) == NULL)
> -			break;
> +	}
> +	return tasks;
> +}
>  
> -		if (waiting_tasks >= nr_entries) {
> +
> +static int count_task_lines(char *buffer)
> +{
> +	int lines = 0;
> +	char *ptr;
> +	int len;
> +
> +	len = strlen(buffer);
> +
> +	/* Find the runnable tasks: header. */
> +	ptr = strstr(buffer, TASK_MARKER);
> +	if (ptr == NULL)
> +		return 0;
> +
> +	/* Skip to the end of the dashed line separator. */
> +	ptr = strstr(ptr, "-\n");
> +	if (ptr == NULL)
> +		return 0;
> +
> +	ptr += 2;
> +	while(*ptr && ptr < (buffer+len)) {
> +		lines++;
> +		ptr = strchr(ptr, '\n');
> +		if (ptr == NULL)
>  			break;
> -		}
> +		ptr++;
>  	}
> -
> -	return waiting_tasks;
> +	return lines;
>  }
>  
>  static int fill_waiting_task(char *buffer, struct cpu_info *cpu_info)
> @@ -515,36 +484,23 @@ static int fill_waiting_task(char *buffer, struct cpu_info *cpu_info)
>  		warn("NULL cpu_info pointer!\n");
>  		return 0;
>  	}
> -	nr_entries = cpu_info->nr_running;
> -
> -	switch (config_task_format) {
> -	case NEW_TASK_FORMAT:
> -		cpu_info->starving = malloc(sizeof(struct task_info) * nr_entries);
> -		if (cpu_info->starving == NULL) {
> -			warn("failed to malloc %d task_info structs", nr_entries);
> -			return 0;
> -		}
> -		nr_waiting = parse_new_task_format(buffer, cpu_info->starving, nr_entries);
> -		break;
> -	case OLD_TASK_FORMAT:
> -		/*
> -		 * The old task format does not output a correct value for
> -		 * nr_running (the initializer for nr_entries) so count the
> -		 * task lines for this CPU data and use that instead.
> -		 */
> +
> +	if (config_task_format == OLD_TASK_FORMAT)
>  		nr_entries = count_task_lines(buffer);
> -		if (nr_entries <= 0)
> -			return 0;
> -		cpu_info->starving = malloc(sizeof(struct task_info) * nr_entries);
> -		if (cpu_info->starving == NULL) {
> -			warn("failed to malloc %d task_info structs", nr_entries);
> -			return 0;
> -		}
> -		nr_waiting = parse_old_task_format(buffer, cpu_info->starving, nr_entries);
> -		break;
> -	default:
> -		die("invalid value for config_task_format: %d\n", config_task_format);
> +	else
> +		nr_entries = cpu_info->nr_running;
> +
> +	if (nr_entries <= 0)
> +		return 0;
> +
> +	cpu_info->starving = malloc(sizeof(struct task_info) * nr_entries);
> +	if (cpu_info->starving == NULL) {
> +		warn("failed to malloc %d task_info structs", nr_entries);
> +		return 0;
>  	}
> +
> +	nr_waiting = parse_task_lines(buffer, cpu_info->starving, nr_entries);
> +
>  	return nr_waiting;
>  }
>  
> @@ -574,7 +530,7 @@ static int sched_debug_parse(struct cpu_info *cpu_info, char *buffer, size_t buf
>  	}
>  
>  	/*
> -	 * The NEW_TASK_FORMAT produces useful output values for nr_running and
> +	 * NEW_TASK_FORMAT and produces useful output values for nr_running and
>  	 * rt_nr_running, so in this case use them. For the old format just leave
>  	 * them initialized to zero.
>  	 */
> @@ -613,7 +569,8 @@ static int sched_debug_has_starving_task(struct cpu_info *cpu)
>  static int sched_debug_init(void)
>  {
>  	find_sched_debug_path();
> -	config_task_format = detect_task_format();
> +	if ((config_task_format = detect_task_format()) == TASK_FORMAT_UNKNOWN)
> +		die("Can't handle task format!\n");
>  	return 0;
>  }
>  
> diff --git a/src/sched_debug.h b/src/sched_debug.h
> index 21f9da27866e..4b12c39bf7fe 100644
> --- a/src/sched_debug.h
> +++ b/src/sched_debug.h
> @@ -1,6 +1,67 @@
>  /* SPDX-License-Identifier: GPL-2.0-or-later */
> -#define OLD_TASK_FORMAT  1
> -#define NEW_TASK_FORMAT  2
>  #define TASK_MARKER	"runnable tasks:"
> +#define TASK_DIVIDER	"-\n"
> +
> +/*
> + * Over time, the various 'runnable task' output in SCHED_DEBUG has
> + * changed significantly.
> + *
> + * Depending on the version of the running kernel, the task formats can
> + * differ greatly.
> + *
> + * For example, in 3.X kernels, the sched_debug running tasks format denotes the current
> + * running task on the current CPU with a singular state label, 'R'. Other tasks do not
> + * receive a state label.
> + *
> + * example:
> + * '          task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep'
> + * ' ----------------------------------------------------------------------------------------------------------'
> + * '      watchdog/5    33        -8.984472       151     0         0.000000         0.535614         0.000000 0 /'
> + * ' R          less  9542      2382.087644        56   120         0.000000        16.444493         0.000000 0 /'
> + *
> + * In 4.18+ kernels, the sched_debug format running tasks format included an additional 'S'
> + * state field to denote the state of the running tasks on said CPU.
> + *
> + * example:
> + * ' S           task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep'
> + * '-----------------------------------------------------------------------------------------------------------'
> + * ' I         rcu_gp     3        13.973264         2   100         0.000000         0.004469         0.000000 0 0 /'
> + *
> + * Introduced in 6.12+, 2cab4bd024d2 sched/debug: Fix the runnable tasks
> + * output, the sched_debug running tasks format was changed to include
> + * four new EEVDF fields.
> + *
> + * Example:
> + *  'S            task   PID       vruntime   eligible    deadline             slice          sum-exec      switches  prio         wait-time        sum-sleep       sum-block  node   group-id  group-path'
> + *  '-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'
> + *  ' I kworker/R-rcu_g     4        -1.048576   E          -1.040501           0.700000         0.000000         2     100         0.000000         0.000000         0.000000   0      0        /'
> + *
> + * As there are considerable differences in the location of the fields
> + * needed to boost task prioriy, handle the logical code differences with
> + * an enumerated type.
> + */
> +enum task_format {
> +	TASK_FORMAT_UNKNOWN =0,
> +	OLD_TASK_FORMAT,	// 3.10 kernel
> +	NEW_TASK_FORMAT,	// 4.18+ kernel
> +	TASK_FORMAT_LIMIT
> +};
> +
> +
> +/*
> + * set of offsets in a task format line based on offsets
> + * discovered by discover_task_format
> + *
> + * Note: These are *NOT* character offsets, these are "word" offsets.
> + * Requiring consumers of this struct to parse through the individual
> + * lines.
> + */
> +struct task_format_offsets {
> +	int task;
> +	int pid;
> +	int switches;
> +	int prio;
> +	int wait_time;
> +};

I wonder if it is possible to simplify the code using sscanf. For
example:

int detect_task_format(void)
{
    ...
    nextline(ptr);
    skipspaces(ptr);
    return *ptr == 'S' ? NEW_TASK_FORMAT : OLD_TASK_FORMAT;
}

...

void parse_task(void)
{
    ...
    switch (detect_task_format())
    {
        case NEW_TASK_FORMAT:
            sscanf(...);
            break;
        case OLD_TASK_FORMAT:
            sscanf(...);
            break;
        default:
            die();
    }
}

For an example of what I mean, see[1].

[1] https://git.kernel.org/pub/scm/utils/stalld/stalld.git/commit/?h=main&id=f9fe90f6c0b867be0c3fd245d6dd8b99686bb4ae

>  
>  extern struct stalld_backend sched_debug_backend;
> -- 
> 2.51.0
> 

