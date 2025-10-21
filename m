Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB677946A
	for <linux-rt-users@vger.kernel.org>; Tue, 21 Oct 2025 15:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062329; cv=none; b=I6vbplqPGuo1dAPggfFoOd51q2IW2Drg8CJWN09L78a3Gy6EUtz+AZz/hSLf52rd0TfxkCkcJioDIz+EqW1XwcoMT82nO3800t+1EF/Xf5aH3d5AowtusPjo47j3q+ARFAf7AUORkAPYPV7+Dd08Ku/IfTOYb3KJ5QEC6ulB0+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062329; c=relaxed/simple;
	bh=m8xqjoTysh/zu5tvP+lNCH4Cz8dlXWLxwnSWxCPRpUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bpaXCFP5JaD+hB09IkXy5TtltS27Q7kLnOMo9mR+5XiPgZZcoSnKyQZUb2iv4kGNk7byc7fBCVookeG6T4JJQ4D6lwNJEVQsFsnA9oOJZUbf0CIotOHjxitltRu3bW8/fAOf98dwLKe73vY800ezRyFq4Yl9vg6Sn0BedRlATBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OtepXBPq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OtepXBPq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761062325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bk0Zu9LUPySsGkMbyyD502gRpIn7R1Cgj/cxA4uLhqk=;
	b=OtepXBPq1viaxGampgnTaLRQPtn62KdvxF4CpqXQesIKE3jPKsa0e5Trcw0rLTIkeS6l/Q
	ptDqRYg9bdQVR34KqtNkeyWP6zEhNAiXGhi+HTYN1JjKNZg/XRl9z6QRlqHXFwyHsyOunA
	fF5K/QVNQj7ks8KmQStQ/6TC4jqrSQs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-QI3CyodINVKSnyQBZ11jvQ-1; Tue,
 21 Oct 2025 11:58:42 -0400
X-MC-Unique: QI3CyodINVKSnyQBZ11jvQ-1
X-Mimecast-MFC-AGG-ID: QI3CyodINVKSnyQBZ11jvQ_1761062321
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 209A119560B2;
	Tue, 21 Oct 2025 15:58:41 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.80.189])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id EFD423000221;
	Tue, 21 Oct 2025 15:58:36 +0000 (UTC)
Date: Tue, 21 Oct 2025 12:58:35 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <clrkwllms@kernel.org>
Cc: linux-rt-users@vger.kernel.org, Clark Williams <williams@redhat.com>, 
	Claude <noreply@anthropic.com>, debarbos@redhat.com, marco.chiappero@suse.com, 
	chris.friesen@windriver.com, luochunsheng@ustc.edu
Subject: Re: [PATCH 02/12] sched_debug: Fix runqueue task parsing logic and
 state filtering
Message-ID: <uno4su4dzqzm2p6kn6m6hu4xme63cpov3abgymcdlvjls2jvjg@vh5lc7ftq3ls>
References: <20251017022444.118802-1-clrkwllms@kernel.org>
 <20251017022444.118802-2-clrkwllms@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017022444.118802-2-clrkwllms@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Oct 16, 2025 at 09:24:34PM -0500, Clark Williams wrote:
> From: Clark Williams <williams@redhat.com>
> 
> Refactor parse_task_lines() to correctly parse runnable tasks from
> sched_debug output with improved state filtering and iteration.
> 
> Key fixes:
> - Rename skipwords() to skip2word() and fix logic to position pointer
>   at the start of the target word (not after whitespace)
> - Fix NEW_TASK_FORMAT detection to account for 'S' column offset in
>   task field positions
> - Add proper state filtering for NEW_TASK_FORMAT: skip '>R' (running),
>   non-'R', and non-'X' states
> - Fix loop termination: iterate to (nr_entries-1) since running task
>   is excluded
> - Fix buffer allocation size to include null terminator (+1)
> - Add comprehensive comments explaining parsing state machine
> - Initialize ptr=NULL to prevent uninitialized use warnings
> 
> This resolves task parsing failures where stalld was incorrectly
> reading task fields or missing runnable tasks on newer kernels.
> 
> ???? Generated with [Claude Code](https://claude.com/claude-code)
> 
> Co-Authored-By: Claude <noreply@anthropic.com>
> Signed-off-by: Clark Williams <clrkwllms@kernel.org>
> Signed-off-by: Clark Williams <williams@redhat.com>
> ---
>  src/sched_debug.c | 89 +++++++++++++++++++++++++++++++++++------------
>  1 file changed, 66 insertions(+), 23 deletions(-)
> 
> diff --git a/src/sched_debug.c b/src/sched_debug.c
> index 180932ca7aa3..04a12ef2a7c2 100644
> --- a/src/sched_debug.c
> +++ b/src/sched_debug.c
> @@ -122,7 +122,8 @@ static char *alloc_and_fill_cpu_buffer(int cpu, char *sched_dbg, int sched_dbg_s
>  	if (!next_cpu_start)
>  		next_cpu_start = sched_dbg + sched_dbg_size;
>  
> -	size = next_cpu_start - cpu_start;
> +	/* add one for the null terminator */
> +	size = next_cpu_start - cpu_start + 1;
>  
>  	if (size <= 0)
>  		return NULL;
> @@ -171,12 +172,13 @@ static inline char *nextline(char *str)
>   * skip a specified number of words on a task line
>   */
>  
> -static inline char *skipwords(char *ptr, int nwords)
> +static inline char *skip2word(char *ptr, int nwords)
>  {
>  	int i;
> -	for (i=0; i < nwords; i++) {
> -		ptr = skipspaces(ptr);
> +	ptr = skipspaces(ptr);
> +	for (i=1; i < nwords; i++) {
>  		ptr = skipchars(ptr);
> +		ptr = skipspaces(ptr);
>  	}
>  	return ptr;
>  }
> @@ -228,12 +230,14 @@ static int detect_task_format(void)
>  	config_buffer_size = bufsiz;
>  	log_msg("initial config_buffer_size set to %zu\n", config_buffer_size);
>  
> +	/* find the delimiter for task information */
>  	ptr = strstr(buffer, TASK_MARKER);
>  	if (ptr == NULL) {
>  		die("unable to find 'runnable tasks' in buffer, invalid input\n");
>  		exit(-1);
>  	}
>  
> +	/* move to the column header line */
>  	ptr = nextline(ptr);
>  	i = 0;
>  
> @@ -245,6 +249,8 @@ static int detect_task_format(void)
>  	if (strncmp(ptr, "S", strlen("S")) == 0) {
>  		log_msg("detect_task_format: NEW_TASK_FORMAT detected\n");
>  		retval = NEW_TASK_FORMAT;
> +		/* move the word offset by one */
> +		i++;
>  	}
>  	else {
>  		log_msg("detect_task_format: OLD_TASK_FORMAT detected\n");
> @@ -357,45 +363,81 @@ static int is_runnable(int pid)
>  static int parse_task_lines(char *buffer, struct task_info *task_info, int nr_entries)
>  {
>  	int pid, ctxsw, prio, comm_size;
> -	char *ptr, *line, *end;
> +	char *ptr=NULL, *line = buffer, *end;
> +	char *buffer_end = buffer + strlen(buffer);
>  	struct task_info *task;
>  	char comm[COMM_SIZE];
>  	int tasks = 0;
>  
> -	if ((ptr = strstr(buffer, TASK_MARKER)) == NULL)
> -		die ("no runnable task section found!\n");
> -
>  	/*
>  	 * If we have less than two tasks on the CPU there is no
>  	 * possibility of a stall.
> -	 */
> + 	 */
>  	if (nr_entries < 2)
>  		return 0;
> +
> +
> +	/* search for the task marker header */
> +	ptr = strstr(buffer, TASK_MARKER);
> +	if (ptr == NULL)
> +		die ("no runnable task section found!\n");
> +
>  	line = ptr;
>  
> -	/* skip header and divider */
> +	/* skip "runnable tasks:" */
> + 	line = nextline(line);
> +
> +	/* skip header lines */
>  	line = nextline(line);
> +
> +	/* skip divider line */
>  	line = nextline(line);
> -	
> -	/* now loop over the task info */
> -	while (tasks < nr_entries) {
> +	/* at this point, line should point to the start of a task line */
> +
> +	/* now loop over the task info
> +	 * note that we always discount the task that's on the cpu, so the
> +	 * number of waiting tasks will always be at least one less than
> +	 * nr_entries.
> +	 */
> +	while ((line < buffer_end) && tasks < (nr_entries-1)) {
>  		task = &task_info[tasks];
>  
> +		/* move ptr to the first word of the line */
> +		ptr = skipspaces(line);
> +
>  		/*
>  		 * In 3.X kernels, only the singular RUNNING task receives
>  		 * a "running state" label. Therefore, only care about
> -		 * tasks that are not R (running on a CPU).
> +		 * tasks that are not R (runnable on a CPU).
>  		 */
>  		if ((config_task_format == OLD_TASK_FORMAT) &&
>  			(*ptr == 'R')) {
>  			/* Go to the end of the line and ignore this task. */
> -			ptr = strchr(ptr, '\n');
> -			ptr++;
> +			line = nextline(line);
>  			continue;
>  		}
>  
> +		/*
> +		 * in newer kernels (>=4.x) every task info line has a state
> +		 * but the actual running tasks has a '>R' to denote it.
> +		 * since we don't care about the currently running tasks
> +		 * skip it.
> +		 * Also, we don't care about any states other than 'R' (runnable)
> +		 * and 'X' (dying)
> +		 */
> +		if (config_task_format == NEW_TASK_FORMAT) {
> +			if (*ptr == '>' || (*ptr != 'R' && *ptr != 'X')) {
> +				line = nextline(line);
> +				continue;
> +			}
> +		}
> +
> +		/*
> +		 * At this point we have a task line to record
> +		 */
> +		
>  		/* get the task field */
> -		ptr = skipwords(line, config_task_format_offsets.task);
> +		ptr = skip2word(line, config_task_format_offsets.task);
>  
>  		/* Find the end of the task field */
>  		end = skipchars(ptr);
> @@ -408,20 +450,21 @@ static int parse_task_lines(char *buffer, struct task_info *task_info, int nr_en
>  		}
>  		strncpy(comm, ptr, comm_size);
>  		comm[comm_size] = '\0';
> -		ptr = end;
>  
>  		/* get the PID field */
> -		ptr = skipwords(line, config_task_format_offsets.pid);
> +		ptr = skip2word(line, config_task_format_offsets.pid);
>  		pid = strtol(ptr, NULL, 10);
>  
>  		/* get the context switches field */
> -		ptr = skipwords(line, config_task_format_offsets.switches);
> +		ptr = skip2word(line, config_task_format_offsets.switches);
>  		ctxsw = strtol(ptr, NULL, 10);
>  
>  		/* get the prio field */
> -		ptr = skipwords(line, config_task_format_offsets.prio);
> +		ptr = skip2word(line, config_task_format_offsets.prio);
>  		prio = strtol(ptr, NULL, 10);
>  
> +		/*log_msg("DEBUG: task%d comm:%s pid:%d ctxsw:%d prio:%d\n", tasks, comm, pid, ctxsw, prio);*/
> +
>                  /*
>                   * In older formats, we must check to
>                   * see if the process is runnable prior to storing header
> @@ -437,10 +480,10 @@ static int parse_task_lines(char *buffer, struct task_info *task_info, int nr_en
>  			task->since = time(NULL);
>  			/* increment the count of tasks processed */
>  			tasks++;
> -		} else {
> -			continue;
>  		}
>  
> +		/* move our line pointer to the next availble line */
> +		line = nextline(line);
>  	}
>  	return tasks;
>  }
> -- 
> 2.51.0
> 

I think it would be better to squash it with patch 1.

