Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56D71ADC6D
	for <linux-rt-users@vger.kernel.org>; Tue, 14 Jan 2025 22:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736894385; cv=none; b=qbqNe/ZJj05oiFcC93XffFCDn0yqPXscQP+0pWsDEJEDtby1EMJbjkz5iz58sUBF636wvVlyN0rxRwTQ2ukWeiuYgRQJ7eFQKXDgHs9GV3yTZLC9oys6sWfaiQkQRabOFNn5XUpU27FJxBIqO9VCZEY7ZxkRy+8pm+6U1hBpjgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736894385; c=relaxed/simple;
	bh=pg0i7Ls2j8OV31Sub8PkseqQZAcOGIW+y3iXfbCaFys=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MnMY5eK0IDIK0FjGZHKkilB8q279V9eX5FIa+/PpLvimmDGeEe47NnVVna2X7fOEgqHj8qSIDyK7KQyE5TLiwN9UPpVA2EcTuNQZM+LXxdZRjJi4WrQpVbBBVbxLjU+0EGFq8+hW/kP5QFBNueVP44ex+bmLTPG5qMwg1sARB2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IOl8HLZV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IOl8HLZV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736894382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KvSlf2o8L9D2foCeAbjGMfNMpw/p04FrvY6HaHVx8Lg=;
	b=IOl8HLZVlAbx9Wvi7AUZceD1kwrdphlRXQ+jg/HmNn2wBNTEPzW7VYhoPi7EtAVA7I57eL
	FHVg/6ad9rgIRnzBo8+TQpbBekXgp3RTF4adgV+np0Zxyn19xqHgD74ydwW3lC0RJPe+In
	Q4Kkftr0Vc/1JnzAS4rdJiKmF+ewwKQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-wFzYSrezPX-DKRj2U8awpA-1; Tue, 14 Jan 2025 17:39:41 -0500
X-MC-Unique: wFzYSrezPX-DKRj2U8awpA-1
X-Mimecast-MFC-AGG-ID: wFzYSrezPX-DKRj2U8awpA
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b6e5c9ef38so46277885a.1
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Jan 2025 14:39:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736894380; x=1737499180;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KvSlf2o8L9D2foCeAbjGMfNMpw/p04FrvY6HaHVx8Lg=;
        b=vxFSLtS69S2d/H3i7fjAEJQbYH92mItjWEe6Ne4JnZtSPRb8PGEhJlh73VNc05o6lh
         XzSY4iy9NETCWU+OPDRPb8PhiZbDQ6w0+2H5e4y2h10FsaBSfL6j5HpfG6f8YYSsA2oz
         Wydl3PMZsbGb6QnuIOTQeA89o4/f6Z4NUza+pnN+mk8TLSh4P5b4l3H5m9a9+xZlL2Vg
         Bbso+Hjt2g3GgYfu+6CEEB0SlyONnz4jheMsF9HWd7gdVTb/phhZtxkbpBKxRasaj/mU
         BJBblo/Pc4Uh3O6t6SVfB33EZG87KmVe2eQlYtMACQHIsV6qc9b6I6xfl2XXLF4sFZFb
         LhVw==
X-Gm-Message-State: AOJu0YyuosTWUHCBpS1mG9UQBXRhHJ4sl1GcnlyZEwK8X2rtiz3umh7A
	ORUff8Uc8RxcxRKOCgblYJlJw1DhbKVAB0hgiwYvcOV9JogEwTDpv9C5qruVBGAD73D1ckHnD35
	UnYWzpYr9xuVuskU/Kghc3DKfHp4edgcfjviVw5CqM9pZsodsuJJxM0ZT82dGtcwGkVTwQakQ
X-Gm-Gg: ASbGnctWiKVGx66yeqmuL6aYjpjn0Vu/1z68CnG+HFARtLQ3wHfE4Va9f38DtOpftJy
	tR4FhQWdTMyh81BamHZ3FE6A24HoGKr2NLXOxaHllRR4/i0fNDs89Dp9UGkrCftgSrzB9C3whyC
	TrCsyvr2K+gnuXV1jX8Z7lnuP06WWGKLNG6Q9Unk/IRGCmrs0jjdOih8ii21jmo91Jpy+TWcRmH
	CRNqiTWFrK/RqLDLKZVpsJcGAE/sSG1EYcd4CIb4QG8uuM=
X-Received: by 2002:a05:620a:4392:b0:7b6:da9d:d810 with SMTP id af79cd13be357-7be524645e3mr108716985a.24.1736894380593;
        Tue, 14 Jan 2025 14:39:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7G3Pqf/3ZrmoZm41HjD6EvSWmgoCzWreetxVpqWJfUhjr9xnEx2VZDFVxKJHBVfIIVW/W0w==
X-Received: by 2002:a05:620a:4392:b0:7b6:da9d:d810 with SMTP id af79cd13be357-7be524645e3mr108712985a.24.1736894380239;
        Tue, 14 Jan 2025 14:39:40 -0800 (PST)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dfad880dffsm57358236d6.38.2025.01.14.14.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 14:39:39 -0800 (PST)
Date: Tue, 14 Jan 2025 17:39:38 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Crystal Wood <crwood@redhat.com>
cc: linux-rt-users@vger.kernel.org, Clark Williams <williams@redhat.com>
Subject: Re: [PATCH 3/3] rt-tests: Remove unused parameter annotations
In-Reply-To: <20250107220229.156201-4-crwood@redhat.com>
Message-ID: <e1d00956-9a20-0a88-14fc-1fa87c98f683@redhat.com>
References: <20250107220229.156201-1-crwood@redhat.com> <20250107220229.156201-4-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Tue, 7 Jan 2025, Crystal Wood wrote:

> These are no longer necessary with -Wno-unused-parameter
> 
> Signed-off-by: Crystal Wood <crwood@redhat.com>
> ---
>  src/cyclictest/cyclictest.c           | 11 +++++------
>  src/oslat/oslat.c                     |  4 ++--
>  src/pi_tests/pi_stress.c              |  4 ++--
>  src/pmqtest/pmqtest.c                 |  7 +++----
>  src/ptsematest/ptsematest.c           |  7 +++----
>  src/queuelat/queuelat.c               |  2 +-
>  src/rt-migrate-test/rt-migrate-test.c |  4 ++--
>  src/sched_deadline/cyclicdeadline.c   |  2 +-
>  src/signaltest/signaltest.c           |  2 +-
>  src/sigwaittest/sigwaittest.c         |  4 ++--
>  src/ssdd/ssdd.c                       |  2 +-
>  src/svsematest/svsematest.c           |  5 +++--
>  12 files changed, 26 insertions(+), 28 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index b1f8420..890da5d 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -436,11 +436,10 @@ static int set_deepest_cpu_idle_state(unsigned int cpu, unsigned int deepest_sta
>  
>  static inline int have_libcpupower_support(void) { return 1; }
>  #else
> -static inline int save_cpu_idle_disable_state(__attribute__((unused)) unsigned int cpu) { return -1; }
> -static inline int restore_cpu_idle_disable_state(__attribute__((unused)) unsigned int cpu) { return -1; }
> +static inline int save_cpu_idle_disable_state(unsigned int cpu) { return -1; }
> +static inline int restore_cpu_idle_disable_state(unsigned int cpu) { return -1; }
>  static inline void free_cpu_idle_disable_states(void) { }
> -static inline int set_deepest_cpu_idle_state(__attribute__((unused)) unsigned int cpu,
> -											 __attribute__((unused)) unsigned int state) { return -1; }
> +static inline int set_deepest_cpu_idle_state(unsigned int cpu, unsigned int state) { return -1; }
>  static inline int have_libcpupower_support(void) { return 0; }
>  #endif /* HAVE_LIBCPUPOWER_SUPPORT */
>  
> @@ -1687,7 +1686,7 @@ static void rstat_print_stat(struct thread_param *par, int index, int verbose, i
>   * thread that creates a named fifo and hands out run stats when someone
>   * reads from the fifo.
>   */
> -static void *fifothread(void *param __attribute__ ((unused)))
> +static void *fifothread(void *param)
>  {
>  	int ret;
>  	int fd;
> @@ -1868,7 +1867,7 @@ rstat_err:
>  	return;
>  }
>  
> -static void write_stats(FILE *f, void *data __attribute__ ((unused)))
> +static void write_stats(FILE *f, void *data)
>  {
>  	struct thread_param **par = parameters;
>  	int i;
> diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
> index 0863297..9e5a08a 100644
> --- a/src/oslat/oslat.c
> +++ b/src/oslat/oslat.c
> @@ -220,7 +220,7 @@ struct global {
>  
>  static struct global g;
>  
> -static void workload_nop(char *dst __attribute__ ((unused)), char *src __attribute__ ((unused)), size_t size __attribute__ ((unused)))
> +static void workload_nop(char *dst, char *src, size_t size)
>  {
>  	/* Nop */
>  }
> @@ -596,7 +596,7 @@ static void run_expt(struct thread *threads, int runtime_secs, bool preheat)
>  		pthread_join(threads[i].thread_id, NULL);
>  }
>  
> -static void handle_alarm(int code __attribute__ ((unused)))
> +static void handle_alarm(int code)
>  {
>  	g.cmd = STOP;
>  }
> diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
> index 1116ee6..6f8c563 100644
> --- a/src/pi_tests/pi_stress.c
> +++ b/src/pi_tests/pi_stress.c
> @@ -388,7 +388,7 @@ int pending_interrupt(void)
>   *   1. report progress
>   *   2. check for deadlocks
>   */
> -void *reporter(void *arg __attribute__ ((unused)))
> +void *reporter(void *arg)
>  {
>  	int status;
>  	int end = 0;
> @@ -1334,7 +1334,7 @@ void summary(void)
>  	       t->tm_yday, t->tm_hour, t->tm_min, t->tm_sec);
>  }
>  
> -void write_stats(FILE *f, void *data __attribute__ ((unused)))
> +void write_stats(FILE *f, void *data)
>  {
>  	fprintf(f, "  \"inversion\": %lu\n", total_inversions());
>  }
> diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
> index b21dfa0..04e36a1 100644
> --- a/src/pmqtest/pmqtest.c
> +++ b/src/pmqtest/pmqtest.c
> @@ -418,14 +418,13 @@ static void process_options(int argc, char *argv[])
>  
>  static int volatile shutdown;
>  
> -static void sighand(int sig __attribute__ ((unused)))
> +static void sighand(int sig)
>  {
>  	shutdown = 1;
>  }
>  
> -static void print_stat(FILE *fp __attribute__ ((unused)),
> -		       struct params *receiver, struct params *sender,
> -		       int verbose __attribute__ ((unused)), int quiet)
> +static void print_stat(FILE *fp, struct params *receiver, struct params *sender,
> +		       int verbose, int quiet)
>  {
>  	int i;
>  
> diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
> index 5a29718..d211669 100644
> --- a/src/ptsematest/ptsematest.c
> +++ b/src/ptsematest/ptsematest.c
> @@ -321,14 +321,13 @@ static void process_options(int argc, char *argv[])
>  
>  static int volatile shutdown;
>  
> -static void sighand(int sig __attribute__ ((unused)))
> +static void sighand(int sig)
>  {
>  	shutdown = 1;
>  }
>  
> -static void print_stat(FILE *fp __attribute__ ((unused)),
> -		       struct params *receiver, struct params *sender,
> -		       int verbose __attribute__ ((unused)), int quiet)
> +static void print_stat(FILE *fp, struct params *receiver, struct params *sender,
> +		       int verbose, int quiet)
>  {
>  	int i;
>  
> diff --git a/src/queuelat/queuelat.c b/src/queuelat/queuelat.c
> index c057389..28cf7ab 100644
> --- a/src/queuelat/queuelat.c
> +++ b/src/queuelat/queuelat.c
> @@ -520,7 +520,7 @@ void main_loop(void)
>  	free(src);
>  }
>  
> -void sig_handler(int sig __attribute__ ((unused)))
> +void sig_handler(int sig)
>  {
>  	print_exit_info();
>  	exit(0);
> diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
> index 7b1917d..8afe083 100644
> --- a/src/rt-migrate-test/rt-migrate-test.c
> +++ b/src/rt-migrate-test/rt-migrate-test.c
> @@ -354,7 +354,7 @@ static void print_results(void)
>  	}
>  }
>  
> -static void write_stats(FILE *f, void *data __attribute__ ((unused)))
> +static void write_stats(FILE *f, void *data)
>  {
>  	int i;
>  	int t;
> @@ -489,7 +489,7 @@ static int check_times(int l)
>  	return 0;
>  }
>  
> -static void stop_log(int sig __attribute__ ((unused)))
> +static void stop_log(int sig)
>  {
>  	stop = 1;
>  }
> diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
> index 631d57e..32fd0d0 100644
> --- a/src/sched_deadline/cyclicdeadline.c
> +++ b/src/sched_deadline/cyclicdeadline.c
> @@ -1073,7 +1073,7 @@ static int calc_nr_cpus(const char *setcpu, char **buf)
>  	return -1;
>  }
>  
> -static void sighand(int sig __attribute__ ((unused)))
> +static void sighand(int sig)
>  {
>  	shutdown = 1;
>  }
> diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
> index 5412c50..d8cda97 100644
> --- a/src/signaltest/signaltest.c
> +++ b/src/signaltest/signaltest.c
> @@ -353,7 +353,7 @@ static void process_options(int argc, char *argv[], unsigned int max_cpus)
>  	}
>  }
>  
> -static void sighand(int sig __attribute__ ((unused)))
> +static void sighand(int sig)
>  {
>  	shutdown = 1;
>  }
> diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
> index 8c1c16f..026cc81 100644
> --- a/src/sigwaittest/sigwaittest.c
> +++ b/src/sigwaittest/sigwaittest.c
> @@ -370,13 +370,13 @@ static void process_options(int argc, char *argv[])
>  
>  static int volatile mustshutdown;
>  
> -static void sighand(int sig __attribute__ ((unused)))
> +static void sighand(int sig)
>  {
>  	mustshutdown = 1;
>  }
>  
>  static void print_stat(struct params *receiver, struct params *sender,
> -		       int verbose __attribute__ ((unused)), int quiet)
> +		       int verbose, int quiet)
>  {
>  	int i;
>  
> diff --git a/src/ssdd/ssdd.c b/src/ssdd/ssdd.c
> index 45f6a23..50f7424 100644
> --- a/src/ssdd/ssdd.c
> +++ b/src/ssdd/ssdd.c
> @@ -152,7 +152,7 @@ static pid_t parent;
>  static int nforks = 10;
>  static int nsteps = 10000;
>  
> -static void sigchld(int sig __attribute__ ((unused)), siginfo_t *info __attribute__ ((unused)), void *arg __attribute__ ((unused)))
> +static void sigchld(int sig, siginfo_t *info, void *arg)
>  {
>  	got_sigchld = 1;
>  }
> diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
> index 3c857dc..f3cddf8 100644
> --- a/src/svsematest/svsematest.c
> +++ b/src/svsematest/svsematest.c
> @@ -416,7 +416,7 @@ static void process_options(int argc, char *argv[])
>  
>  static int volatile mustshutdown;
>  
> -static void sighand(int sig __attribute__ ((unused)))
> +static void sighand(int sig)
>  {
>  	mustshutdown = 1;
>  }
> @@ -456,7 +456,8 @@ static void write_stats(FILE *f, void *data)
>  	fprintf(f, "  }\n");
>  }
>  
> -static void print_stat(FILE *fp __attribute__ ((unused)), struct params *receiver, struct params *sender, int verbose __attribute__ ((unused)), int quiet)
> +static void print_stat(FILE *fp, struct params *receiver, struct params *sender,
> +		       int verbose, int quiet)
>  {
>  	int i;
>  
> -- 
> 2.47.1
> 
> 
> 
Signed-off-by: John Kacur <jkacur@gmail.com>

