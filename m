Return-Path: <SRS0=c1g4=R5=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97024C43381
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Mar 2019 08:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6244D20866
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Mar 2019 08:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553588570;
	bh=4VuJdYoW27ty/umu9Sr/06n6fgW/6tGcO4jT4QYwpT8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=WfHD6OIOu8jLs48L6zykDzLkJq9nnV0tgDFqm8A6R+JmenEquf6hGd6yWE+0sKgtA
	 T0MyXOaiDVt+m5O3o0Qh3J5kYf4XlyQw2qShEJ8Dnmz309CXrVOAzgH/81PzZk/AzM
	 M+V7MeoQzVBxK/DJ4WxC+2BKYiCixbISE3HSJ+8w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730456AbfCZIWp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 Mar 2019 04:22:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:46326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfCZIWp (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 Mar 2019 04:22:45 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E39FA20830;
        Tue, 26 Mar 2019 08:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553588564;
        bh=4VuJdYoW27ty/umu9Sr/06n6fgW/6tGcO4jT4QYwpT8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QkPZL5Tutbbb8JkHRv97jAdTMS2wHBVSz9cgdVAkxq30z8XWbG8FM6Nsrz31gdo3s
         2h9FsVTnocbPJ/PfJX49JwW/mVw1n903+QimVFKlxbCuO5KbSX7Vxt8HdrboD2ihIK
         nuJ2rIeqzLbMhFtRYg8osjKeBmFz7yGVLzFbQmcw=
Date:   Tue, 26 Mar 2019 17:22:39 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        namhyung@kernel.org, bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v4 01/11] tracing: Add tracing error log
Message-Id: <20190326172239.563f933cceb1f71c45f7e474@kernel.org>
In-Reply-To: <5038ab97eaa3cf23c16264299221c5f1c5cf8147.1553268040.git.tom.zanussi@linux.intel.com>
References: <cover.1553268040.git.tom.zanussi@linux.intel.com>
        <5038ab97eaa3cf23c16264299221c5f1c5cf8147.1553268040.git.tom.zanussi@linux.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Tom,

On Fri, 22 Mar 2019 10:34:27 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> +static int tracing_err_log_open(struct inode *inode, struct file *file)
> +{
> +	if (file->f_mode & FMODE_WRITE) {
> +		if (file->f_flags & O_TRUNC)
> +			return 0;
> +		else
> +			return -EINVAL;
> +	}
> +
> +	return seq_open(file, &tracing_err_log_seq_ops);
> +}
> +
> +static ssize_t tracing_err_log_write(struct file *file,
> +				     const char __user *buffer,
> +				     size_t count, loff_t *ppos)
> +{
> +	if (count == 1)
> +		clear_tracing_err_log();
> +	else
> +		return -EINVAL;
> +
> +	*ppos += count;
> +
> +	return count;
> +}

Hmm, could you make this as same as "tracing/trace"?
- It clears buffer at open with WRITE & TRUNC flag
- It just ignore how much user wrote (works as /dev/null)

See tracing_open() and tracing_write_stub() in
kernel/trace/trace.c.

Thank you,


> +
> +static const struct file_operations tracing_err_log_fops = {
> +	.open           = tracing_err_log_open,
> +	.write		= tracing_err_log_write,
> +	.read           = seq_read,
> +	.llseek         = seq_lseek,
> +};
> +
>  static int tracing_buffers_open(struct inode *inode, struct file *filp)
>  {
>  	struct trace_array *tr = inode->i_private;
> @@ -8258,6 +8478,9 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
>  			  tr, &snapshot_fops);
>  #endif
>  
> +	trace_create_file("error_log", 0644, d_tracer,
> +			  tr, &tracing_err_log_fops);
> +
>  	for_each_tracing_cpu(cpu)
>  		tracing_init_tracefs_percpu(tr, cpu);
>  
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index d80cee49e0eb..b711edbef7e7 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -1884,6 +1884,10 @@ extern ssize_t trace_parse_run_command(struct file *file,
>  		const char __user *buffer, size_t count, loff_t *ppos,
>  		int (*createfn)(int, char**));
>  
> +extern unsigned int err_pos(char *cmd, const char *str);
> +extern void tracing_log_err(const char *loc, const char *cmd,
> +			    const char **errs, u8 type, u8 pos);
> +
>  /*
>   * Normal trace_printk() and friends allocates special buffers
>   * to do the manipulation, as well as saves the print formats
> -- 
> 2.14.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
