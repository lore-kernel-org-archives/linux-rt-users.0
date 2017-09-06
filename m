From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 02/40] tracing: Add support to detect and avoid
 duplicates
Date: Wed, 6 Sep 2017 14:47:22 -0400
Message-ID: <20170906144722.6eb71312@gandalf.local.home>
References: <cover.1504642143.git.tom.zanussi@linux.intel.com>
        <7f3ca68455bdac47285ed45d608075a4af287362.1504642143.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7f3ca68455bdac47285ed45d608075a4af287362.1504642143.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue,  5 Sep 2017 16:57:14 -0500
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:


> diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
> index 305039b..437b490 100644
> --- a/kernel/trace/tracing_map.c
> +++ b/kernel/trace/tracing_map.c
> @@ -414,6 +414,7 @@ static inline bool keys_match(void *key, void *test_key, unsigned key_size)
>  __tracing_map_insert(struct tracing_map *map, void *key, bool lookup_only)
>  {
>  	u32 idx, key_hash, test_key;
> +	int dup_try = 0;
>  	struct tracing_map_entry *entry;
>  
>  	key_hash = jhash(key, map->key_size, 0);
> @@ -426,10 +427,31 @@ static inline bool keys_match(void *key, void *test_key, unsigned key_size)
>  		entry = TRACING_MAP_ENTRY(map->map, idx);
>  		test_key = entry->key;
>  
> -		if (test_key && test_key == key_hash && entry->val &&
> -		    keys_match(key, entry->val->key, map->key_size)) {
> -			atomic64_inc(&map->hits);
> -			return entry->val;
> +		if (test_key && test_key == key_hash) {
> +			if (entry->val &&
> +			    keys_match(key, entry->val->key, map->key_size)) {
> +				atomic64_inc(&map->hits);
> +				return entry->val;
> +			} else if (unlikely(!entry->val)) {

I'm thinking we need a READ_ONCE() here.

		val = READ_ONCE(entry->val);

then use "val" instead of entry->val. Otherwise, wont it be possible
if two tasks are inserting at the same time, to have this:

(Using reg as when the value is read into a register from memory)

	CPU0			CPU1
	----			----
 reg = entry->val
 (reg == zero)

			   entry->val = elt;

 keys_match(key, reg)
 (false)

 reg = entry->val
 (reg = elt)

 if (unlikely(!reg))

Causes the if to fail.

A READ_ONCE(), would make sure the entry->val used to test against key
would also be the same value used to test if it is zero.

-- Steve



> +				/*
> +				 * The key is present. But, val (pointer to elt
> +				 * struct) is still NULL. which means some other
> +				 * thread is in the process of inserting an
> +				 * element.
> +				 *
> +				 * On top of that, it's key_hash is same as the
> +				 * one being inserted right now. So, it's
> +				 * possible that the element has the same
> +				 * key as well.
> +				 */
> +
> +				dup_try++;
> +				if (dup_try > map->map_size) {
> +					atomic64_inc(&map->drops);
> +					break;
> +				}
> +				continue;
> +			}
>  		}
>  
>  		if (!test_key) {
> @@ -451,6 +473,13 @@ static inline bool keys_match(void *key, void *test_key, unsigned key_size)
>  				atomic64_inc(&map->hits);
>  
>  				return entry->val;
> +			} else {
> +				/*
> +				 * cmpxchg() failed. Loop around once
> +				 * more to check what key was inserted.
> +				 */
> +				dup_try++;
> +				continue;
>  			}
>  		}
>  
