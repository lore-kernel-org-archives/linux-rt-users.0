From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [RFD 2/5] tracing: Add support to sort on the key
Date: Thu, 30 Apr 2015 21:02:24 -0500
Message-ID: <1430445744.17922.22.camel@picadillo>
References: <1430388385-29558-1-git-send-email-daniel.wagner@bmw-carit.de>
	 <1430388385-29558-3-git-send-email-daniel.wagner@bmw-carit.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Carsten Emde <C.Emde@osadl.org>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Daniel Wagner <daniel.wagner@bmw-carit.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:15399 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750809AbbEACCh (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 30 Apr 2015 22:02:37 -0400
In-Reply-To: <1430388385-29558-3-git-send-email-daniel.wagner@bmw-carit.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2015-04-30 at 12:06 +0200, Daniel Wagner wrote:
> The hist patch allows sorting on values only. By allowing to
> sort also on the key we can do something like this:
> 
> 'hist:key=latency:val=hitcount:sort=latency'
> 
> latency:         16 hitcount:          3
> latency:         17 hitcount:        171
> latency:         18 hitcount:        626
> latency:         19 hitcount:        594
> latency:         20 hitcount:        306
> latency:         21 hitcount:        214
> latency:         22 hitcount:        232
> latency:         23 hitcount:        283
> latency:         24 hitcount:        235
> latency:         25 hitcount:        105
> latency:         26 hitcount:         54
> latency:         27 hitcount:         79
> latency:         28 hitcount:        214
> latency:         29 hitcount:        895
> latency:         30 hitcount:       1400
> latency:         31 hitcount:        774
> latency:         32 hitcount:        653
> [...]
> 
> The obvious choice for the bool was already taken. I haven't found a
> good name for the the flag. I guess it would make sense to refactor the
> sorting code so that it doesn't really matter what kind of field it
> is.
> 

I think you're right - the current flag is kind of an internal thing to
the implementation, and uses a name that's too generic.  Of course, you
should be able to sort on keys as well as values, and the code shouldn't
care too much about which is specified.  The original code was more
capable wrt sorting and I probably simplified it a bit too much - I'll
refactor things taking all that into account for the next version.

> BTW, I wonder if it would possible to drop the need to always provide
> the 'val' argument and just assume the 'val=hitcount' in this case.
> 

That also makes a lot of sense - I'll make that change too.

Tom

> Not for inclusion!
> 
> Not-Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
> ---
>  kernel/trace/trace_events_hist.c | 35 +++++++++++++++++++++++++++++++----
>  1 file changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 9a7a675..fe06707 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -89,6 +89,7 @@ enum hist_field_flags {
>  struct hist_trigger_sort_key {
>  	bool		use_hitcount;
>  	bool		use_key;
> +	bool		use_real_key;
>  	bool		descending;
>  	unsigned int	idx;
>  };
> @@ -260,7 +261,7 @@ static void destroy_hist_fields(struct hist_trigger_data *hist_data)
>  	}
>  }
>  
> -static inline struct hist_trigger_sort_key *create_default_sort_key(void)
> +static inline struct hist_trigger_sort_key *create_hitcount_sort_key(void)
>  {
>  	struct hist_trigger_sort_key *sort_key;
>  
> @@ -273,6 +274,19 @@ static inline struct hist_trigger_sort_key *create_default_sort_key(void)
>  	return sort_key;
>  }
>  
> +static inline struct hist_trigger_sort_key *create_real_key_sort_key(void)
> +{
> +	struct hist_trigger_sort_key *sort_key;
> +
> +	sort_key = kzalloc(sizeof(*sort_key), GFP_KERNEL);
> +	if (!sort_key)
> +		return ERR_PTR(-ENOMEM);
> +
> +	sort_key->use_real_key = true;
> +
> +	return sort_key;
> +}
> +
>  static inline struct hist_trigger_sort_key *
>  create_sort_key(char *field_name, struct hist_trigger_data *hist_data)
>  {
> @@ -280,7 +294,10 @@ create_sort_key(char *field_name, struct hist_trigger_data *hist_data)
>  	unsigned int i;
>  
>  	if (!strcmp(field_name, "hitcount"))
> -		return create_default_sort_key();
> +		return create_hitcount_sort_key();
> +
> +	if (!strcmp(field_name, hist_data->key->field->name))
> +		return create_real_key_sort_key();
>  
>  	for (i = 0; i < hist_data->n_vals; i++)
>  		if (!strcmp(field_name, hist_data->vals[i]->field->name))
> @@ -306,7 +323,7 @@ static int create_sort_keys(struct hist_trigger_data *hist_data)
>  	int ret = 0;
>  
>  	if (!fields_str) {
> -		sort_key = create_default_sort_key();
> +		sort_key = create_hitcount_sort_key();
>  		if (IS_ERR(sort_key)) {
>  			ret = PTR_ERR(sort_key);
>  			goto out;
> @@ -984,6 +1001,12 @@ static int cmp_entries(const struct hist_trigger_sort_entry **a,
>  	hist_data = entry_a->hist_data;
>  	sort_key = hist_data->sort_key_cur;
>  
> +	if (sort_key->use_real_key) {
> +		val_a = *(u64 *)entry_a->key;
> +		val_b = *(u64 *)entry_b->key;
> +		goto out;
> +	}
> +
>  	if (sort_key->use_key) {
>  		if (memcmp((*a)->key, (*b)->key, hist_data->map->key_size))
>  			ret = 1;
> @@ -998,6 +1021,7 @@ static int cmp_entries(const struct hist_trigger_sort_entry **a,
>  		val_b = atomic64_read(&entry_b->sums[sort_key->idx]);
>  	}
>  
> +out:
>  	if (val_a > val_b)
>  		ret = 1;
>  	else if (val_a < val_b)
> @@ -1372,7 +1396,10 @@ static int event_hist_trigger_print(struct seq_file *m,
>  		else {
>  			unsigned int idx = hist_data->sort_keys[i]->idx;
>  
> -			hist_field_print(m, hist_data->vals[idx]);
> +			if (hist_data->sort_keys[i]->use_real_key)
> +				hist_field_print(m, hist_data->key);
> +			else
> +				hist_field_print(m, hist_data->vals[idx]);
>  		}
>  	}
>  


