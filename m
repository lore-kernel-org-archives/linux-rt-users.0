From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 16/33] tracing: Generalize per-element hist trigger
 data
Date: Wed, 4 Oct 2017 13:34:14 -0400
Message-ID: <20171004133414.4840c351@gandalf.local.home>
References: <cover.1506105131.git.tom.zanussi@linux.intel.com>
        <18c12e2cd12243914d9cc98909c6720da084f3bd.1506105131.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <18c12e2cd12243914d9cc98909c6720da084f3bd.1506105131.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 22 Sep 2017 14:59:56 -0500
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:

> @@ -1742,7 +1746,8 @@ static void hist_trigger_stacktrace_print(struct seq_file *m,
>  			seq_printf(m, "%s: [%llx] %-55s", field_name,
>  				   uval, str);
>  		} else if (key_field->flags & HIST_FIELD_FL_EXECNAME) {
> -			char *comm = elt->private_data;
> +			struct hist_elt_data *elt_data = elt->private_data;

Weren't we going to add a "if (WARN_ON_ONCE(!elt_data)) return;" here?

-- Steve

> +			char *comm = elt_data->comm;
>  
>  			uval = *(u64 *)(key + key_field->offset);
>  			seq_printf(m, "%s: %-16s[%10llu]", field_name,
> -- 
