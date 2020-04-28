Return-Path: <SRS0=fi+z=6M=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6BDC83000
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Apr 2020 15:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E6AB206D9
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Apr 2020 15:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=concurrentrt.onmicrosoft.com header.i=@concurrentrt.onmicrosoft.com header.b="mrXIEXPq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgD1Ppm (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 28 Apr 2020 11:45:42 -0400
Received: from mail-dm6nam10on2100.outbound.protection.outlook.com ([40.107.93.100]:38209
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728035AbgD1Ppl (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 28 Apr 2020 11:45:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7qsCIRmJAuMcRPUhX+KpDhSwkgKhmHHhbfsM9t3LaWjGR13+duk/aKmOZK0LliUc7f7pi/fcpwxGuF8NZ3bYRS9HK5/vWrtJP5FG56U7ZpM5EatG5skNnYrYnW3JSl/fvlzeSAVy2yiJXsNCImKYsoa2YOo3L0650F1p+Ux0HzynsqP0EAMWKuH9ZAqZ9mYy5GIW3vh3fFrZMHBxbaMCPJ/rmZHoFJVC/CDoSBdxThpAutmFEr7NBATi317K+u1rrf07RN+ZZOoW4a/WhLSeIr+J/Gb/8aQq4KNqLqlpSlFLhHUhUFr23lWiju3goflSH++8Ck13xL9oyjOL6NXzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LI+V9LLTmWHwBDybvGQ+gZtfbOwK70OlVE3VVwnRfA4=;
 b=YdthA44dSO32wIjv43jB9WLNhBUvrnB4K/1N7fhH0mUFpBe2plaS3162lkHI+m1vtmvSYWk1YK/Zg28qB/B6562YIJmYe5vkKCxcXXWzTaUXB6XLg1WAYVSOqGcJGmE6OkQxMIrWe8umnF/SgywA5dqOTS3K26BevlLXzLap2WNLOxzNCpfbOlrogHEO/fMANJeJqTQvfxjSywvSkcDMVzLIxR4s05iCSrmxr73CfFxpVRZYvBcVJEgXJWNnUsaH3QVmJzEDLqvKaYsPzUFwSDSs3y6OKEubbhYsOvn34I7gbbiyhaD98Rjpu/GVGr5PvPC/pDiIUQiashxDrw2zdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concurrentrt.onmicrosoft.com; s=selector2-concurrentrt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LI+V9LLTmWHwBDybvGQ+gZtfbOwK70OlVE3VVwnRfA4=;
 b=mrXIEXPqAvUc4w84gGInwLFVsGSGNP7xBFpYEOWlDrU5+D19j92xZnXAYEUf0C136/fQme2oxDfOUdCZ9+Sf1pBpcGxmwjZjBEcdcyUeJ8D0whrg6HNQYGqLZ9G8sIacFLIrEowA5JdNSrghg7/hrbRmHy19CLd2If0rACAG9y4=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none
 header.from=concurrent-rt.com;
Received: from CH2PR11MB4341.namprd11.prod.outlook.com (2603:10b6:610:3c::19)
 by CH2PR11MB4485.namprd11.prod.outlook.com (2603:10b6:610:46::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Tue, 28 Apr
 2020 15:45:38 +0000
Received: from CH2PR11MB4341.namprd11.prod.outlook.com
 ([fe80::c988:43f9:15c3:7085]) by CH2PR11MB4341.namprd11.prod.outlook.com
 ([fe80::c988:43f9:15c3:7085%7]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 15:45:38 +0000
Date:   Tue, 28 Apr 2020 11:45:36 -0400
From:   Joe Korty <joe.korty@concurrent-rt.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Kill(2) and pthread_create(2) interact poorly in 5.4.28-rt19
Message-ID: <20200428154536.GA33300@zipoli.concurrent-rt.com>
Reply-To: Joe Korty <joe.korty@concurrent-rt.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: BN7PR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:408:20::30) To CH2PR11MB4341.namprd11.prod.outlook.com
 (2603:10b6:610:3c::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from zipoli.concurrent-rt.com (12.220.59.2) by BN7PR02CA0017.namprd02.prod.outlook.com (2603:10b6:408:20::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Tue, 28 Apr 2020 15:45:38 +0000
X-Originating-IP: [12.220.59.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac04c61c-6a80-43a5-9498-08d7eb8b3315
X-MS-TrafficTypeDiagnostic: CH2PR11MB4485:
X-Microsoft-Antispam-PRVS: <CH2PR11MB4485CE24415778F7C3798B84A0AC0@CH2PR11MB4485.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0387D64A71
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR11MB4341.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(396003)(39840400004)(376002)(346002)(3450700001)(508600001)(8676002)(81156014)(2906002)(66476007)(66946007)(66556008)(55016002)(8936002)(86362001)(7696005)(956004)(44832011)(5660300002)(6916009)(4326008)(1076003)(26005)(186003)(16526019)(33656002)(316002)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tn0Q4aBrw6yz2eKCdEAAEiraRvLeRyc6xRxJYcA3UcmbM/vLnA2mezol/tzRSKswV7dLyvidMCKsLMISDLzHsk6jOAF/htj1J5aO0+V2JtCZR9rmbOPI2/pTfuc4u88UagQo/3WZmJkSYhVN8dRAM6IS4w0/MCNqB/mc5JytGZqj13f29lakCNRXXuyZ8sB4UTuq4iMhxC/jr86wGvRtF0nQycIWXP4+w/yfOcUL41/gEaV1k0dPJMTiCH/C7fIQdVv7NrnwLK9Ojw8F8yItLvmKWKKssB7XadnIuK09dd0n5nxjelL0oGamr//TDe0gT1QvydjSoD9Iwm0vwKR6qFZZucS1BZI46QTfG/gh7yKYf64/zKmI8eujYr3PLeWMqCfjWVZact9AUUayzJyuaHoq5ptkkgNxQMX5o9TwfsR6ubXKNjB0pt+8hTY0cf2i
X-MS-Exchange-AntiSpam-MessageData: gF9OsEFO5lFGZlHba0MGrqI9HYbN38gU75jWiObYwQZfl7pt0cIyCk8SGz+IpBcd6VSRnTbFgpEj8XgHnOoOCwJ3GfjrUoj+0/hcTNNtZT+tJnnuvGon/jl87TM7VT7Z1rZKsgWGUTUytTgGpMiwjBoPaBSRVpnpbc31B3s6jCNqLxMnOBSfAmUra3kWwx4dllItHCIvbg25h8mINkTjbcDUlXiU4/hf4Z/qghk/6iuU0iE+Za7nRE+OFUQikcsLZWN2L0RNtnMBTv8J9hLnTbq1xX9WoxfJd4qfcQVwg7Q9Y880peR686dDY5zsBrfXEYCwKkSQNCLckgKYzjblaI+MK5Ve1NY/5npejeHbzFpSgM3T2erK2xYTIZssRePoF9CIr/lMzcflzMltopx4X/c+TBbIQA0Crb9a2xfVEbn8tfCSt+OeKfo/aDIHH95wjv7yxxKKYE+Y2xvYkt8MDH9Xc/9f9Yo7WbLl1qGaiDsEw8TOOfjJlyl0EDkdVeqFF9h0+72otpBW1/MKN5EhJ9BVTodcbIQc0twsli+zl21Q0ZqQCahS0YHRXFR8O95cM9UGG4AFllCb05/yMxGztf7+rcTjL2KgMxb1wU0Om3/5YM2H4pYS52/5vj40DOL2G5uTxuOGyNmDhKOz64BIihVUtP6yNRll8zidRRq+WUvjuQkLnj1mGvqzHS7nomnRX28ZdVKTBImdohNWpucyM7Gw82fhwvxDOOQ/rxqgXUFn7l00Q/uJ3FVflpJZPZ08/P1QuI6rde7/Qgojbykto58sf8jeMHFHxNQVAvICMho=
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac04c61c-6a80-43a5-9498-08d7eb8b3315
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 15:45:38.7827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OAWOxR+yHLOMo1bzonYL4NymTDYHem1fiTR4MkYigvOkI4FU5gzNCg++bFEUrR0d3MJS9tdf/BVs5VmWz0FmseKJ3STxHP9qjR6dm2VWOos=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4485
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Kill(2) and pthread_create(2) interact poorly in 5.4.28-rt19.

The following kernel splat can be made to occur when
running the attached test program:

    virt_to_cache: Object is not a Slab page!
    ...
    Call Trace:
     free_uid+0x93/0xa0
     __dequeue_signal+0x21c/0x230
     dequeue_signal+0xb7/0x1b0
     get_signal+0x266/0xce0
     do_signal+0x36/0x640

This was discovered on 5.4.28-rt19. That kernel was
compiled nort, with preemption, and with lots of debug
options selected.  Subsequent tests on the following
kernels show:

     5.4.26-rt17     passes
     5.4.28-rt18     fails
     5.4.28-rt19     fails
     5.4.34-rt21     fails
     5.6.4-rt3       passes

The attached test, tb.c, does a pthread_create-n-join in a
continuous loop, while from other threads in the process
group, SIGUSR1 and SIGUSR2 are continually being sent to
the process group.

When I revert this rt patch in 5.4.28-rt19,

     signals-allow-rt-tasks-to-cache-one-sigqueue-struct.patch

the kernel cannot be made to fail.  However, since two
of the above kernels pass without removing this patch,
I do not believe that removing it will address whatever
the root cause is.

Normally, it takes five or six runs for the test to oops
the kernel.  For some reason, when I run it as:

      sudo chrt -f 1 taskset 2 ./tb

it fails, if it is going to fail, on first try.

once I get a splat the system keeps on running.  But I
find I must reboot to be able to get another splat.

Regards,
Joe


/*
 * Test interaction between pthread_create(2) and kill(2).
 *
 * Algorithm: In a loop, as fast as possible, create
 * and wait on a NOP thread.  While doing so, from other
 * threads, send SIGUSR1 and SIGUSR2 to the process group
 * as fast as possible.  All threads except for the targeted
 * test thread are blocked from receiving SIGUSR[12].
 *
 * This test runs for one second.  It is known to generate
 * a kernel splat on 5.4.28-rt19 when compiled preempt,
 * nort, and with lots of debug options selected.  Fails at
 * most once per boot.  Test may have to be run several
 * times times before failure.  The below seems to trigger
 * the problem more easily:
 *
 *      chrt -f 1 taskset 2 ./tb
 *
 * This program is a revamp/simplification of the LTP test
 * pthread_create/14-1.c.
 *
 * Signed-off-by: Joe Korty <joe.korty@concurrent-rt.com>
 */
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <fcntl.h>
#include <signal.h>
#include <semaphore.h>
#include <pthread.h>

sigset_t usersigs;

sem_t semsig1;
sem_t semsig2;

volatile int doit = 1;

volatile unsigned long threaded_count, siguser1_count, siguser2_count;

/* thread to send SIGUSR1 serially to this process as fast as possible */
void *sendsig1(void *arg)
{
	pid_t pid = getpid();

	pthread_sigmask(SIG_BLOCK, &usersigs, NULL);

	while (doit) {
		siguser1_count++;
		sem_wait(&semsig1);
		kill(pid, SIGUSR1);
	}
	return NULL;
}

/* SIGUSR1 handler merely lets the sender know it can send another signal */
void siguser1(int sig)
{
	sem_post(&semsig1);
}

/* thread to send SIGUSR2 serially to this process as fast as possible */
void *sendsig2(void *arg)
{
	pid_t pid = getpid();

	pthread_sigmask(SIG_BLOCK, &usersigs, NULL);

	while (doit) {
		siguser2_count++;
		sem_wait(&semsig2);
		kill(pid, SIGUSR2);
	}
	return NULL;
}

void siguser2(int sig)
{
	sem_post(&semsig2);
}

/* dummy thread, does no work */
void *threaded(void *arg)
{
	return NULL;
}

void *test(void *arg)
{
	pthread_t child_id;

	/* expose this thread & its children to SIGUSR[12] */
	pthread_sigmask(SIG_UNBLOCK, &usersigs, NULL);

	/* create and re-create a thread as fast as possible */
	while (doit) {
		threaded_count++;
		pthread_create(&child_id, NULL, threaded, NULL);
		pthread_join(child_id, NULL);
	}
	 return NULL;
}

int main(void)
{
	pthread_t th_work, th_sig1, th_sig2;
	struct sigaction sa;

	sigemptyset(&sa.sa_mask);
	sa.sa_flags = 0;
	sa.sa_handler = siguser1;
	sigaction(SIGUSR1, &sa, NULL);
	sa.sa_handler = siguser2;
	sigaction(SIGUSR2, &sa, NULL);

	/* block the main thread from seeing SIGUSR[12] */
	sigemptyset(&usersigs);
	sigaddset(&usersigs, SIGUSR1);
	sigaddset(&usersigs, SIGUSR2);
	pthread_sigmask(SIG_BLOCK, &usersigs, NULL);

	sem_init(&semsig1, 0, 1);
	sem_init(&semsig2, 0, 1);

	pthread_create(&th_work, NULL, test, NULL);

	pthread_create(&th_sig1, NULL, sendsig1, NULL);
	pthread_create(&th_sig2, NULL, sendsig2, NULL);

	sleep(1);

	doit = 0;
	pthread_join(th_sig1, NULL);
	pthread_join(th_sig2, NULL);
	pthread_join(th_work, NULL);

	printf("#threads %lu, #sigusr1's %lu, #sigusr2's %lu\n",
		threaded_count, siguser1_count, siguser2_count);

	return 0;
}
