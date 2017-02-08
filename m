From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 02/21] tracing: Reimplement log2
Date: Wed, 8 Feb 2017 15:13:58 -0500
Message-ID: <20170208151358.560a2c64@gandalf.local.home>
References: <cover.1486569306.git.tom.zanussi@linux.intel.com>
        <b247aa8251fe3d92695d63ec974d82f80ee4e711.1486569306.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751498AbdBHUOj (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 8 Feb 2017 15:14:39 -0500
In-Reply-To: <b247aa8251fe3d92695d63ec974d82f80ee4e711.1486569306.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed,  8 Feb 2017 11:24:58 -0600
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:

>  static void destroy_hist_field(struct hist_field *hist_field)
>  {
> +	unsigned int i;
> +
> +	if (!hist_field)
> +		return;
> +
> +	for (i = 0; i < HIST_FIELD_OPERANDS_MAX; i++)
> +		destroy_hist_field(hist_field->operands[i]);

Recursive functions get me really nervous. What limits it? Is this user
defined? Perhaps we need to find a better way to handle this that's not
recursive, or at least put in a hard limit of the amount it can recurse.

-- Steve

> +
>  	kfree(hist_field);
>  }
>  
> @@ -377,7 +393,10 @@ static struct hist_field *create_hist_field(struct ftrace_event_field *field,
>  	}
>  
>  	if (flags & HIST_FIELD_FL_LOG2) {
> +		unsigned long fl = flags & ~HIST_FIELD_FL_LOG2;
>  		hist_field->fn = hist_field_log2;
> +		hist_field->operands[0] = create_hist_field(field, fl);
> +		hist_field->size = hist_field->operands[0]->size;
>  		goto out;
>  	}
>  

