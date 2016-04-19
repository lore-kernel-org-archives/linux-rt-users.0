From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] cyclictest: avoid using libnuma cpumask parsing
 functions
Date: Tue, 19 Apr 2016 15:14:04 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1604191500090.9751@riemann>
References: <20160413153700.7a930369@sluggy.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: RT <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160413153700.7a930369@sluggy.hsv.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



On Wed, 13 Apr 2016, Clark Williams wrote:

> John,
> 
> I ran into issues with parsing cpu masks when trying to run this command:
> 
> sudo ./cyclictest -i100 -qmu -h 2000 -p95 -t1 -a3
> 
> I had previously booted a 4-core system with these boot options:
> 
> 	isolcpus=3 nohz_full=3 rcu_nocbs=3
> 
> The intent was to run loads on cpus 0-2 while running cyclictest on the isolated cpu 3. 
> 
> Unfortunately, the libnuma function numa_parse_cpumask() (which we use when it's available) seems to check the current affinity mask and fails the parse if any of the cpus in the input string are not in the current affinity mask. I find this "unhelpful" when trying to place a measurement thread on an isolated cpu. 
> 
> This patch removes the wrapper function which uses libnuma cpumask parsing functions and instead uses the parser function we wrote for when libnuma is not available. 
> 
> Signed-off-by: Clark Williams <williams@redhat.com>

For the record, I tested isolating cpus using two methods.
1. Using tuna after booting.
2. Using the isolcpus kernel parameter

The default way of compiling rt-tests (and cyclictest) uses 
numa_parse_cpustring() which fails if the cpu is not in the current cpuset 
as you described above.

Distributions that have libnuma versions with
numa_parse_cpustring_all() that can parse all possible cpus, can compile 
like this

make HAVE_PARSE_CPUSTRING_ALL=1

When I did this, cyclictest is able to run your test scenario without 
returning an error.

The default compile is the ultra safe method, but it could be that we are 
maintaining backwards compatibility for an old libnuma version that nobody 
really cares about anymore.

I'm a bit reluctant to replace the libnuma version with our own version 
right before we'd like to freeze a stable version, when you can simply 
compile this correctly for your system to get the desired results. Perhaps 
we can do this for the devel version? On the otherhand, if we don't care 
about maintaining backwards compatability with a library that no-one cares 
about anymore, we can just drop the the old version and use 
numa_parse_cpustring_all(). Maybe that's what we can do going forward.

For this version, we could also swap the default to assume that 
numa_parse_cpustring_all() is available, and make people compile with 
NO_PARSE_CPUSTRING_ALL or something like that if they care about backwards 
compatibility.

Thanks

John


> ---
>  src/cyclictest/rt_numa.h | 82 ++++++++++++++++++++++--------------------------
>  1 file changed, 38 insertions(+), 44 deletions(-)
> 
> diff --git a/src/cyclictest/rt_numa.h b/src/cyclictest/rt_numa.h
> index ec2994314e80..d65cd421863b 100644
> --- a/src/cyclictest/rt_numa.h
> +++ b/src/cyclictest/rt_numa.h
> @@ -32,6 +32,12 @@ static int numa = 0;
>  #define LIBNUMA_API_VERSION 1
>  #endif
>  
> +#ifndef BITS_PER_LONG
> +#define BITS_PER_LONG    (8*sizeof(long))
> +#endif
> +
> +
> +
>  static void *
>  threadalloc(size_t size, int node)
>  {
> @@ -89,22 +95,6 @@ static inline unsigned int rt_numa_bitmask_isbitset( const struct bitmask *mask,
>  	return numa_bitmask_isbitset(mask,i);
>  }
>  
> -static inline struct bitmask* rt_numa_parse_cpustring(const char* s,
> -	int max_cpus)
> -{
> -#ifdef HAVE_PARSE_CPUSTRING_ALL		/* Currently not defined anywhere.  No
> -					   autotools build. */
> -	return numa_parse_cpustring_all(s);
> -#else
> -	/* We really need numa_parse_cpustring_all(), so we can assign threads
> -	 * to cores which are part of an isolcpus set, but early 2.x versions of
> -	 * libnuma do not have this function.  A work around should be to run
> -	 * your command with e.g. taskset -c 9-15 <command>
> -	 */
> -	return numa_parse_cpustring((char *)s);
> -#endif
> -}
> -
>  static inline void rt_bitmask_free(struct bitmask *mask)
>  {
>  	numa_bitmask_free(mask);
> @@ -157,32 +147,6 @@ static inline unsigned int rt_numa_bitmask_isbitset( const struct bitmask *mask,
>  	return (bit != 0);
>  }
>  
> -static inline struct bitmask* rt_numa_parse_cpustring(const char* s,
> -	int max_cpus)
> -{
> -	int cpu;
> -	struct bitmask *mask = NULL;
> -	cpu = atoi(s);
> -	if (0 <= cpu && cpu < max_cpus) {
> -		mask = malloc(sizeof(*mask));
> -		if (mask) {
> -			/* Round up to integral number of longs to contain
> -			 * max_cpus bits */
> -			int nlongs = (max_cpus+BITS_PER_LONG-1)/BITS_PER_LONG;
> -
> -			mask->maskp = calloc(nlongs, sizeof(long));
> -			if (mask->maskp) {
> -				mask->maskp[cpu/BITS_PER_LONG] |=
> -					(1UL << (cpu % BITS_PER_LONG));
> -				mask->size = max_cpus;
> -			} else {
> -				free(mask);
> -				mask = NULL;
> -			}
> -		}
> -	}
> -	return mask;
> -}
>  
>  static inline void rt_bitmask_free(struct bitmask *mask)
>  {
> @@ -204,8 +168,6 @@ struct bitmask {
>      unsigned long size; /* number of bits in the map */
>      unsigned long *maskp;
>  };
> -#define BITS_PER_LONG    (8*sizeof(long))
> -
>  static inline void *threadalloc(size_t size, int n) { return malloc(size); }
>  static inline void threadfree(void *ptr, size_t s, int n) { free(ptr); }
>  static inline void rt_numa_set_numa_run_on_node(int n, int c) { }
> @@ -280,4 +242,36 @@ static inline unsigned int rt_numa_bitmask_count(const struct bitmask *mask)
>  	return num_bits;
>  }
>  
> +/*
> + * Use this instead of a wrapper for libnuma functions.
> + * The libnuma function numa_parse_cpustring() checks the affinity mask
> + * and fails if an input cpu is not in the mask. This of course sucks when
> + * trying to place a thread on an isolated cpu. Avoid libnuma parsing functions
> + */
> +static inline struct bitmask* rt_numa_parse_cpustring(const char* s,
> +	int max_cpus)
> +{
> +	int cpu;
> +	struct bitmask *mask = NULL;
> +	cpu = atoi(s);
> +	if (0 <= cpu && cpu < max_cpus) {
> +		mask = malloc(sizeof(*mask));
> +		if (mask) {
> +			/* Round up to integral number of longs to contain
> +			 * max_cpus bits */
> +			int nlongs = (max_cpus+BITS_PER_LONG-1)/BITS_PER_LONG;
> +
> +			mask->maskp = calloc(nlongs, sizeof(long));
> +			if (mask->maskp) {
> +				mask->maskp[cpu/BITS_PER_LONG] |=
> +					(1UL << (cpu % BITS_PER_LONG));
> +				mask->size = max_cpus;
> +			} else {
> +				free(mask);
> +				mask = NULL;
> +			}
> +		}
> +	}
> +	return mask;
> +}
>  #endif	/* _RT_NUMA_H */
> -- 
> 2.5.5
> 
> 
