Received: from mail-qv2-f41.google.com (mail-qv2-f41.google.com [74.125.230.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8CB3A4F58
	for <linux-rt-users@vger.kernel.org>; Tue, 29 Sep 2026 20:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790713530; cv=none; b=W8f+WBWRVTAD5OmceGJyjRtEXzf9T1GzYFWr3HEJRDPzWcx52XwxihEEdanUdqSVhDs912qjcL5vcc/StK01ANh/Tfv5sd+g78pec4kFlys9ptau6VRdeTLstTH5WwNcz5c2c1miLYS4fGqhOGn0zUSTP8OniifKLOUxYlRfVqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790713530; c=relaxed/simple;
	bh=Z2CPlX6F8GOlX/5CHrYhAfEKCx/hKHnO7h2HN94Vxno=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=H2Cihu31xcv2TB1/GQFc9QQsgPBNpAfCuP2+wiCyXnCzKdSahYtgu15aPi5N5oBHN2NdNJmTuYBnwBS3fqB0snlvLok2TLuIfevI0BqBnprp8zADGTOAQeVWczf9k8ClP819+wOHX58Y3Xzyn4Ob505FsyvtuVh39ParkjsvuU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEbz+n3M; arc=none smtp.client-ip=74.125.230.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEbz+n3M"
Received: by mail-qv2-f41.google.com with SMTP id 6a1803df08f44-91799c58ba0so592216d6.3
        for <linux-rt-users@vger.kernel.org>; Tue, 29 Sep 2026 13:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790713528; x=1791318328; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DsuJfBjRoMo0TESKsCjz5Nifs5jq29JNQPauOFV3aps=;
        b=QEbz+n3M+4TKQyTHgmjenhpi9sWpx3XAjopobhNnFBx8tLHGyFTlrWHF9cWYRMUO4Z
         P2Dd9Ok9UHTMUETmLF0M5raAtTFNwo57t5r/jJp1uqA/oMeewTVwE4OW9Xxsm4Ty+kt4
         uHFDfZPZY4a8rIen+HC7udz6nQBLzPyK7pIEy0E1FPb6LAjgcpOek1uX/29LIzkj8D+K
         I0LmdMF4oJCUgS9EXwk9SKKx1Z5aS9KA7fgCxUh0d5CpbcOxOQHFvx9wRvX9EQR8C7py
         T/8T9wIdGIENWu08q4BWo4hzlGd/E7BYfZBhAPnZJFAcU3yB+o0TnQizCwOr05DPRN+F
         rMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790713528; x=1791318328;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DsuJfBjRoMo0TESKsCjz5Nifs5jq29JNQPauOFV3aps=;
        b=O66op+c5FWVCdF1GbYujV1k1KvHd49OeKS+NDwvaavDPktcqjfGQwPAQXoi0YiFyV8
         72n6198D3p9BHRhLXNEcUwwZra1P4lEo1rxE2pdfcLIcE5qP6UhBIl0YY9jh7U8wzKHU
         7sqf5rLHKRK7/JUaaPmtGSJbJ8lMXv8WyDGZTIWxDXpqQEcJZ9WzfbHpg2qM+BemvinR
         UQ0fgsoMSFxjBYzdWSKM2HPRW8FunnYKHcpey7FbMv3vZb9qp+cKnqMuBCw49Po2yGnt
         j525T8aNXhuirW2nAGMzwnXq4P2vEzESS7tFo1NFy39r0kM9VsaM5O5VF0ENE9EG9+Qr
         WWyQ==
X-Forwarded-Encrypted: i=1; AKwUvByoJZWQCAvN7vVsYeqASoQoeMbkmCVtLk+hw278q7L60k2Qw5t3xPvXEdT5bvmk/twQxXa/+B6LsOdBv/1f6A==@vger.kernel.org
X-Gm-Message-State: AFuF++mBjKPkiokgiF5kUWB3iElj4JEjGya1SdKgXpbs4Z/nB+ZtLbZV
	oKWXK0T8FWJs1eWqCavZFAg0Kg8ql3A86QikTy4m5jdTTRDxdzeLUc80
X-Gm-Gg: AYBFou1pujX1pSYOyA8+3Xre2OakMVbee4iiCKTwcgmPErQ+hpMkSImsrP2+hQ7B5oX
	kKzxy9LECYygJVNpVC4NCNwmGnnwAlBci9T0i3vS4pfvJ1hV875m79H6vwLI8dJk6ILEtjqHjbH
	r0dLt+JMTANEIBeXoqWZraTda0nNdQ3WipPJ4sOgLlMDbSGiqAKFCXAomRlT95wlDEqNfhKfEM7
	xp4pWp5li3MKWnNTfNURxH7WwRXBmSEECiDXZK2rPWa+ERrpXhwx/QV5R6D1Y/9cdDUN+hiFczy
	BCsCUfZnmQg9gctilJtFYFfpnUXRTMG9pneUGsRpGB4KOtQkX67bO6hzzAb74Qd/TI/OwSGHSy/
	oZlOYu1Jiy/dKyRQm7zmxFRcR/qBPYeexC1JQhCQ2dfh/3ddUr8/HgG+13mnGPS+L7xfF7QH7GL
	gtu/GyM1r+Br9HtjfFzchpTh+11w2MSVAWn743U0SyzIatrEPotKBbWWi5VrEo4xlhcA+MTiUf/
	keyqEzJo9+zxmk1OKs1t7ZM/RYLaKSreQ2Xl6cDhRBLFK63e6ly7B9dHA==
X-Received: by 2002:a05:6214:f0a:b0:914:3ef6:ec1c with SMTP id 6a1803df08f44-91799bc0dbemr5852296d6.31.1790713527720;
        Tue, 29 Sep 2026 13:25:27 -0700 (PDT)
Received: from Cumhall ([70.53.55.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917987e3776sm3575356d6.22.2026.09.29.13.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 13:25:27 -0700 (PDT)
Date: Tue, 29 Sep 2026 16:25:14 -0400 (EDT)
From: John Kacur <jkacur@gmail.com>
To: Costa Shulyupin <costa.shul@redhat.com>
cc: John Kacur <jkacur@redhat.com>, "Ahmed S. Darwish" <darwi@linutronix.de>, 
    =?ISO-8859-15?Q?Thomas_Wei=DFschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>, 
    Lukas Beckmann <lbckmnn@mailbox.org>, 
    Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
    Cheng-Yang Chou <yphbchou0911@gmail.com>, 
    linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH v3] clictest, cyclicdeadline: Exit with failure when
 breaktrace threshold is exceeded
In-Reply-To: <20260824101852.2237494-1-costa.shul@redhat.com>
Message-ID: <d414bdc8-361f-9768-1f6c-f8e1e8b80f7a@gmail.com>
References: <20260824101852.2237494-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Mon, 24 Aug 2026, Costa Shulyupin wrote:

> cyclictest and cyclicdeadline always exit 0 even when the latency
> threshold set by --breaktrace is exceeded, requiring test harnesses
> to parse output or json to detect a failed test.
> 
> Set ret to 2 when break_thread_id is set, indicating the breaktrace
> threshold was hit.  The exit code enables shell expressions like
> "cyclictest ... && echo PASS" and seamless integration with testing
> frameworks.  Also pass ret to rt_write_json() in cyclicdeadline so the
> JSON output reflects the failure.
> 
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> 
> ---
> v3:
> - return 2 on failure
> - reword error descriptions in manpages
> v2:
> - refine subject
> - "Assisted-by" already conforms format AGENT_NAME:MODEL_VERSION
> - add sob
> ---
>  src/cyclictest/cyclictest.8         | 11 +++++++++++
>  src/cyclictest/cyclictest.c         |  1 +
>  src/sched_deadline/cyclicdeadline.8 | 11 +++++++++++
>  src/sched_deadline/cyclicdeadline.c |  7 +++++--
>  4 files changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
> index fc6121aa4d47..c52e09cbd73c 100644
> --- a/src/cyclictest/cyclictest.8
> +++ b/src/cyclictest/cyclictest.8
> @@ -311,6 +311,17 @@ in mind, below cyclictest example invocation can provide a good start:
>     --histfile=output.txt
>  .fi
>  .
> +.SH "Exit status"
> +.TP
> +.B 0
> +Success - breaktrace latency was not exceeded.
> +.TP
> +.B 1
> +Error or invalid argument.
> +.TP
> +.B 2
> +Test failure - breaktrace latency is exceeded.
> +.
>  .SH "See also"
>  .MR numa 3 ,
>  .MR numactl 8 ,
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 71cf5cb25c22..032b3e411afc 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -2337,6 +2337,7 @@ int main(int argc, char **argv)
>  		if (break_thread_id) {
>  			printf("# Break thread: %d\n", break_thread_id);
>  			printf("# Break value: %llu\n", (unsigned long long)break_thread_value);
> +			ret = 2;
>  		}
>  	}
>  

Did you test this?
When I run (on a non-rt kernel)
 su -c './cyclictest -t -b50 --json json.txt'
Password: 
# /dev/cpu_dma_latency set to 0us
policy: other/other: loadavg: 0.70 1.00 0.80 1/2952 198115          

T: 0 (198100) P: 0 I:1000 C:  0 Min:1000000 Act:  0 Avg:  0 Max:  0 T: 1 
(198101) P: 0 I:1500 C:  0 Min:1000000 Act:  0 Avg:  0 Max:  0 T: 2 
(198102) P: 0 I:2000 C:  0 Min:1000000 Act:  0 Avg:  0 Max:  0 T: 3 
(198103) P: 0 I:2500 C:  0 Min:1000000 Act:  0 Avg:  0 Max:  0 T: 4 
(198104) P: 0 I:3000 C:  0 Min:1000000 Act:  0 Avg:  0 Max:  0 T: 5 
(198105) P: 0 I:3500 C:  0 Min:1000000 Act:  0 Avg:  0 Max:  0 T: 6 
(198106) P: 0 I:4000 C:  0 Min:1000000 Act:  0 Avg:  0 Max:  0 T: 7 
(198107) P: 0 I:4500 C:  0 Min:1000000 Act:  0 Avg:  0 Max:  0 T: 8 
(198108) P: 0 I:5000 C:  0 Min:1000000 Act:  0 Avg:  0 Max:  0 T: 9 
(198109) P: 0 I:5500 C:  0 Min:1000000 Act:  0 Avg:  0 Max:  0 T:10 
(198110) P: 0 I:6000 C:  0 Min:1000000 Act:  0 Avg:  0 Max:  0 T:11 
(198111) P: 0 I:6500 C:  0 Min:1000000 Act:  0 Avg:  0 Max:  0 T:12 
(198112) P: 0 I:7000 C:  0 Min:1000000 Act:  0 Avg:  0 Max:  0 T:13 
(198113) P: 0 I:7500 C:  0 Min:1000000 Act:  0 Avg:  0 Max:  0 T:14 
(198114) P: 0 I:8000 C:  0 Min:1000000 Act:  0 Avg:  0 Max:  0 T:15 
(198115) P: 0 I:8500 C:  0 Min:1000000 Act:  0 Avg:  0 Max:  0 # Thread 
Ids: 198100 198101 198102 198103 198104 198105 198106 198107 198108 198109 
198110 198111 198112 198113 198114 198115
# Break thread: 198100
# Break value: 52

the top part of the json.txt file is

  "file_version": 1,
  "cmdline:": "./cyclictest -t -b50 --json json.txt",
  "rt_test_version:": "2.10",
  "start_time": "Tue, 29 Sep 2026 16:18:56 -0400",
  "end_time": "Tue, 29 Sep 2026 16:18:56 -0400",
  "return_code": 0,

So the return_code is 0, and not 2

Looking at the code

	ret = EXIT_SUCCESS;

 outall:
	shutdown = 1;
	usleep(50000);

	if (!verbose && !quiet && refresh_on_max)
		printf("\033[%dB", num_threads + 2);

	if (strlen(jsonfile) != 0)
		rt_write_json(jsonfile, ret, write_stats, NULL);

So we write EXIT_SUCCESS before we even get to the part where we have
"ret = 2"; added to the code

	if (tracelimit) {
		print_tids(parameters, num_threads);
		if (break_thread_id) {
			printf("# Break thread: %d\n", break_thread_id);
			printf("# Break value: %llu\n", (unsigned long 
long)break_thread_value);
			ret = 2;
		}
	}

Maybe instead do ret = break_thread_id ? 2 : EXIT_SUCCESS;

Fix the typo in the subject too "clictest" should be "cyclictest"

John Kacur
