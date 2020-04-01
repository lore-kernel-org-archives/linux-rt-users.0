Return-Path: <SRS0=PGN5=5R=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49650C2D0F0
	for <linux-rt-users@archiver.kernel.org>; Wed,  1 Apr 2020 23:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29078206F5
	for <linux-rt-users@archiver.kernel.org>; Wed,  1 Apr 2020 23:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733230AbgDAXCO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 1 Apr 2020 19:02:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35911 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732667AbgDAXCO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 1 Apr 2020 19:02:14 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jJmN7-00020U-20; Thu, 02 Apr 2020 01:02:09 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 92D10100D52; Thu,  2 Apr 2020 01:02:08 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     trix@redhat.com, jkacur@rehat.com, williams@redhat.com,
        lgoncalv@redhat.com
Cc:     linux-rt-users@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: Re: [PATCH] Import a new test, jitterz
In-Reply-To: <20200401221310.7544-1-trix@redhat.com>
References: <20200401221310.7544-1-trix@redhat.com>
Date:   Thu, 02 Apr 2020 01:02:08 +0200
Message-ID: <871rp6q07j.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Tom,

trix@redhat.com writes:

> From: Tom Rix <trix@redhat.com>
>
> jitterz is a program for measuring system jitter.

The exact purpose of this is?

> +
> +#define CHECK_LOST_TIME()					\
> +	do {							\
> +		if (d >= dt_min) {				\
> +			lt += d;				\
> +			for (j = 16; j > 0; j--) {		\
> +				if (d >= b[j - 1].s) {		\
> +					b[j - 1].c =		\
> +						b[j - 1].c + 1;	\
> +					break;			\
> +				}				\
> +			}					\
> +		}						\
> +	} while (0)						\

Aside of having a \ at the last line, macros which rely on variable
names at the call site are broken to begin with. What's so magic to hide
this in a macro instead of writing a proper function?

> +static inline uint64_t tsc(void)
> +{
> +	uint64_t ret = 0;
> +	uint32_t l, h;
> +
> +	__asm__ __volatile__("lfence");
> +	__asm__ __volatile__("rdtsc" : "=a"(l), "=d"(h));
> +	ret = ((uint64_t)h << 32) | l;
> +	return ret;
> +}

Having x86 specific code in a generic test suite is a non starter.

> +static int move_to_core(int core_i)
> +{
> +	cpu_set_t cpus;
> +
> +	CPU_ZERO(&cpus);
> +	CPU_SET(core_i, &cpus);
> +	return sched_setaffinity(0, sizeof(cpus), &cpus);
> +}
> +
> +static int set_sched(void)
> +{
> +	struct sched_param p = { 0 };
> +
> +	p.sched_priority = priority;
> +	return sched_setscheduler(0, policy, &p);
> +}
> +
> +static long read_cpuinfo_cur_freq(int core_i)
> +{
> +	uint64_t fs = -1;
> +	char path[80];
> +	struct stat sb;
> +	int i;
> +	char *freq[2] = {
> +		"cpuinfo_cur_freq",
> +		/* assumes a busy wait will be run at the max freq */

Assumptions in tools which are meant to provide useful output are really
not useful at all.

> +		"cpuinfo_max_freq",
> +	};
> +	for (i = 0; i < 2; i++) {
> +		snprintf(path, 80,
> +			 "/sys/devices/system/cpu/cpu%d/cpufreq/%s",
> +			 core_i, freq[1]);
> +		if (!stat(path, &sb)) {
> +			FILE *f = 0;
> +
> +			f = fopen(path, "rt");
> +			if (f) {
> +				fscanf(f, "%lu", &fs);

That definitely has never seen a 32bit compile.

> +				fclose(f);
> +			} else {
> +				perror(path);
> +			}
> +		} else {
> +			perror(path);
> +		}
> +	}
> +
> +	if (fs == (uint64_t) -1) {

So here you have a typecast but at the place where this is initialized
this is not required, right?

> +		printf("Error reading CPU frequency for core %d\n", core_i);
> +		exit(1);
> +	}
> +	return fs;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	int max_cpus = sysconf(_SC_NPROCESSORS_ONLN);
> +	struct timespec tvs, tve;
> +	double sec;
> +	uint64_t fs, fe, fr;
> +	unsigned int i, j, rt = 60;
> +	uint64_t dt = 1500;
> +	struct bucket {
> +		uint64_t s;
> +		uint64_t c;
> +	} b[16];
> +	uint64_t frs, fre, lt;
> +
> +	process_options(argc, argv, max_cpus);
> +
> +	/* return of this function must be tested for success */
> +	if (move_to_core(cpu) != 0) {
> +		printf("Error while setting thread affinity to cpu %d!", cpu);
> +		exit(1);
> +	}
> +	if (set_sched() != 0) {
> +		printf("Error while setting %s policy, priority %d!",
> +		       policyname(policy), priority);
> +		exit(1);
> +	}
> +
> +	fr = fs = 0;
> +	fe = 1;
> +	while (fs != fe) {
> +retry:
> +		if (!fr) {
> +			fs = read_cpuinfo_cur_freq(cpu);
> +			fe = 0;
> +		} else {
> +			fs = fr;
> +		}
> +		uint64_t dt_min = (dt * fs) / 1000000;
> +
> +		lt = 0;
> +		for (j = 0; j < 16; j++) {
> +			b[j].c = 0;
> +			if (j == 0)
> +				b[j].s = dt_min;
> +			else
> +				b[j].s = b[j - 1].s * 2;
> +		}
> +		fs *= 1000;
> +
> +		frs = tsc();
> +		clock_gettime(CLOCK_MONOTONIC_RAW, &tvs);
> +
> +		for (i = 0; i < rt; i++) {
> +			uint64_t s, e, so;
> +
> +			s = tsc();
> +			e = s;
> +			e += fs;
> +			if (e < s)
> +				goto retry;
> +			so = s;
> +
> +			while (1) {
> +				uint64_t d;
> +
> +				s = tsc();
> +				if (s == so)
> +					continue;
> +
> +				d = s - so;
> +				CHECK_LOST_TIME();
> +				if (s >= e)
> +					break;
> +				so = s;
> +			}
> +		}
> +		fre = tsc();
> +		clock_gettime(CLOCK_MONOTONIC_RAW, &tve);
> +		sec = tve.tv_sec - tvs.tv_sec +
> +		      (tve.tv_nsec - tvs.tv_nsec) / 1e9;
> +		if ((fabs(sec - rt) / (double)rt) > 0.01) {
> +			if (fre > frs) {
> +				fr = (fre - frs) / (1000 * sec);
> +				fe = fr * 1000;
> +			}
> +			goto retry;
> +		}
> +		if (!fr) {
> +			fe = read_cpuinfo_cur_freq(cpu);
> +			fe *= 1000;
> +		}
> +	}
> +	for (j = 0; j < 16; j++)
> +		printf("%lu\n", b[j].c);
> +
> +	if (lt != fs) {
> +		printf("Lost time %f\n", (double)lt / (double)fs);
> +		return 1;
> +	}
> +
> +	return 0;

As the above is completely unreadable gibberish I can only assume that I
wasted time staring at a well done April 1st joke :)

Thanks,

        tglx
