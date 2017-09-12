From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2 36/40] tracing: Remove lookups from tracing_map
 hitcount
Date: Tue, 12 Sep 2017 11:16:11 +0900
Message-ID: <20170912111611.a629bdf12ccaa001c3c518ff@kernel.org>
References: <cover.1504642143.git.tom.zanussi@linux.intel.com>
        <4c3ada8f9d958a5a926bbfa812c816bf8e73764b.1504642143.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        namhyung@kernel.org, vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751035AbdILCQP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 11 Sep 2017 22:16:15 -0400
In-Reply-To: <4c3ada8f9d958a5a926bbfa812c816bf8e73764b.1504642143.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Tom,

On Tue,  5 Sep 2017 16:57:48 -0500
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:

> Lookups inflate the hitcount, making it essentially useless.  Only
> inserts and updates should really affect the hitcount anyway, so
> explicitly filter lookups out.
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---
>  kernel/trace/tracing_map.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
> index a4e5a56..f8e2338 100644
> --- a/kernel/trace/tracing_map.c
> +++ b/kernel/trace/tracing_map.c
> @@ -538,7 +538,8 @@ static inline bool keys_match(void *key, void *test_key, unsigned key_size)
>  		if (test_key && test_key == key_hash) {
>  			if (entry->val &&
>  			    keys_match(key, entry->val->key, map->key_size)) {
> -				atomic64_inc(&map->hits);
> +				if (!lookup_only)
> +					atomic64_inc(&map->hits);

Is this a kind of bugfix for current code?
If so, such patch can be posted in separate series.

Thank you,

>  				return entry->val;
>  			} else if (unlikely(!entry->val)) {
>  				/*
> -- 
> 1.9.3
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
