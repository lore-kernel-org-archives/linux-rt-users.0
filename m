From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] rt-migrate-test: exit early if nr_runs is non-positive
Date: Tue, 17 Feb 2015 15:08:38 +0100
Message-ID: <20150217140838.GP26177@linutronix.de>
References: <5476FAF2.1060702@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: 716237@bugs.debian.org, linux-rt-users@vger.kernel.org
To: Boris Egorov <egorov@linux.com>,
	Clark Williams <clark.williams@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:43857 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756624AbbBQOIo (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Feb 2015 09:08:44 -0500
Content-Disposition: inline
In-Reply-To: <5476FAF2.1060702@linux.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Boris Egorov | 2014-11-27 16:20:34 [+0600]:

>Program will crash if nr_runs is 0 due to dividing by it in
>print_results(). Let's exit early instead.
>
>Fixes: http://bugs.debian.org/716237

Has this been dealt with? I can't see this applied. I would prefer
doing the value check in parse_options() itself. And looking at it, it
seems that run_interval is interval ignored. Or is there macro magic
invovled?

>Signed-off-by: Boris Egorov <egorov@linux.com>
>---
> src/rt-migrate-test/rt-migrate-test.c | 5 +++++
> 1 file changed, 5 insertions(+)
>
>diff --git a/src/rt-migrate-test/rt-migrate-test.c
>b/src/rt-migrate-test/rt-migrate-test.c
>index e3c7a09..876a122 100644
>--- a/src/rt-migrate-test/rt-migrate-test.c
>+++ b/src/rt-migrate-test/rt-migrate-test.c
>@@ -465,6 +465,11 @@ int main (int argc, char **argv)
>  	parse_options(argc, argv);
>+	if (nr_runs <= 0) {
>+		fprintf(stderr, "Warning, --loops argument is non-positive. Exiting.\n");
>+		exit(-1);
>+	}
>+
> 	signal(SIGINT, stop_log);
>  	if (argc >= (optind + 1))
>-- 
>2.1.3

Sebastian
