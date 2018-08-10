From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v3 6/7] tracing: Add snapshot action
Date: Fri, 10 Aug 2018 16:04:04 +0900
Message-ID: <20180810070404.GD479@sejong>
References: <cover.1533753152.git.tom.zanussi@linux.intel.com>
 <b3cfc09e0c3e55dc0d6682cd2b89525f3f446665.1533753152.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
To: Tom Zanussi <zanussi@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b3cfc09e0c3e55dc0d6682cd2b89525f3f446665.1533753152.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, Aug 09, 2018 at 09:34:16AM -0500, Tom Zanussi wrote:
> From: Tom Zanussi <tom.zanussi@linux.intel.com>
> 
> Add support for hist:handlerXXX($var).snapshot(), which will take a
> snapshot of the current trace buffer whenever handlerXXX is hit.
> 
> As a first user, this also adds snapshot() action support for the
> onmax() handler i.e. hist:onmax($var).snapshot().
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---

[SNIP]
> +static struct track_data *track_data_alloc(unsigned int key_len,
> +					   struct action_data *action_data,
> +					   struct hist_trigger_data *hist_data)
> +{
> +	struct track_data *data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	unsigned int size = TASK_COMM_LEN;
> +	struct hist_elt_data *elt_data;
> +
> +	if (!data)
> +		return ERR_PTR(-ENOMEM);
> +
> +	data->key = kzalloc(key_len, GFP_KERNEL);
> +	if (!data->key) {
> +		track_data_free(data);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	data->key_len = key_len;
> +	data->action_data = action_data;
> +	data->hist_data = hist_data;
> +
> +	elt_data = kzalloc(sizeof(*elt_data), GFP_KERNEL);
> +	if (!elt_data) {
> +		track_data_free(data);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +	elt_data->comm = kzalloc(size, GFP_KERNEL);
> +	if (!elt_data->comm) {
> +		track_data_free(data);

It seems to leak 'elf_data' here.

Thanks,
Namhyung


> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	data->elt.private_data = elt_data;
> +
> +	return data;
> +}
