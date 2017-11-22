From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v6 25/37] tracing: Add support for 'field variables'
Date: Wed, 22 Nov 2017 15:05:19 +0900
Message-ID: <20171122060519.GA19409@danjae.aot.lge.com>
References: <cover.1510948725.git.tom.zanussi@linux.intel.com>
 <aba56805d86084cc9634ada2bd5ad4de845d4afd.1510948725.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, julia@ni.com, fengguang.wu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        kernel-team@lge.com
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <aba56805d86084cc9634ada2bd5ad4de845d4afd.1510948725.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, Nov 17, 2017 at 02:33:04PM -0600, Tom Zanussi wrote:
> @@ -1387,6 +1405,8 @@ static struct trace_event_file *find_var_file(struct trace_array *tr,
>  	list_for_each_entry(var_data, &tr->hist_vars, list) {
>  		var_hist_data = var_data->hist_data;
>  		file = var_hist_data->event_file;
> +		if (file == found)
> +			continue;

Shouldn't it be moved to the patch 22?

Thanks,
Namhyung


>  		call = file->event_call;
>  		name = trace_event_name(call);
>  
