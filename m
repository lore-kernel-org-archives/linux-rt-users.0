Return-Path: <SRS0=Biag=ED=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753C3C4363A
	for <linux-rt-users@archiver.kernel.org>; Wed, 28 Oct 2020 23:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D3B420829
	for <linux-rt-users@archiver.kernel.org>; Wed, 28 Oct 2020 23:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="koboPAhc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390402AbgJ1X0P (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 28 Oct 2020 19:26:15 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:16626 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387488AbgJ1XZL (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 28 Oct 2020 19:25:11 -0400
Received: from pps.filterd (m0098781.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 09SNMtZd020892;
        Wed, 28 Oct 2020 18:24:48 -0500
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2057.outbound.protection.outlook.com [104.47.45.57])
        by mx0a-00010702.pphosted.com with ESMTP id 34cga0vvc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Oct 2020 18:24:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IlwE+nHmOuccxceon8mwQXo2OPcXlvsnfBBqSY23bTut5LfMLAqiopW6hIyFccx0GeC1UbiGU5M1Yd3OpC/Fxg9wEvcZ4H+/zI+988Cnwns7T0j1N2S290mHRHShTmR8kSzdsJHVUaQ++Kh5FLD4RPTpUeRDtrQen7NQfFp5gwY+UGc45pqGjrRNPhCIvauoc5aL+KNnzJbRMzj3KvTZXX0mMsh1FmEspaHMj+CIlza+VmH7jn/1VteGloqcbRub2gtDvYThOXSLYk0fIKGKeXVSP1LMBV7amh/Ww9Rz/OD/gn8tSoZtUDen8KcUK5k3wDOkccoiD8J2PoscdEVtKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TevScVHN0HoWY2fV8sM14H0BKcVgLLAPd+HgLoZ1HlE=;
 b=DtacAiBepT6EFEuhcNO9/U0a5jKeqqh4RjjfgKZbsNb8ClTLPPc7y8BRjN1GExhtRQzUHhWj7xWir1FZdWn6eSCqTbjoHa0hq5GOtQJkWGcxcCrpTDB/hp238xemWmGf2rt7WQG3Ji7mv1b1PFIN8TR9FJ46UPrpMZ6SgxVDxiFqUMWtm3f3txU0A6NF7WQTBcB5ZPa9Kqi39w/NXKMYhv4Ijuc1Zlyyj3mC9MpRcFZHtjPYFQookv0tmXsgwc5uQcYsUtaV/FhE8Hko7oRjJuECPwPcNPKinQJ5jfpNMwJRRsMVxybaYedzWhDFjXcSWaPszc/41nP8djWA4Kp7FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TevScVHN0HoWY2fV8sM14H0BKcVgLLAPd+HgLoZ1HlE=;
 b=koboPAhcHqoZaQN1j8WZrwHacwA6x35O1M7S6Xr5cL9SH+4Ey12NzH9K7k3sN98QjCx9v/gnVARzTqA07qgVQsRJQZlRaHkWNCBT58ldqlQZsZiUsWn53i7zZXlYvlqov50vBG0pLVnWM8S5aB7++atczoLswfWNKiAzSVUTaPo=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=ni.com;
Received: from SN6PR04MB4496.namprd04.prod.outlook.com (2603:10b6:805:a3::23)
 by SN2PR04MB2174.namprd04.prod.outlook.com (2603:10b6:804:10::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Wed, 28 Oct
 2020 23:24:45 +0000
Received: from SN6PR04MB4496.namprd04.prod.outlook.com
 ([fe80::cc42:669f:a4f2:c1]) by SN6PR04MB4496.namprd04.prod.outlook.com
 ([fe80::cc42:669f:a4f2:c1%5]) with mapi id 15.20.3477.029; Wed, 28 Oct 2020
 23:24:45 +0000
User-agent: mu4e 1.3.2; emacs 27.1
From:   Gratian Crisan <gratian.crisan@ni.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Brandon Streiff <brandon.streiff@ni.com>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        James Minor <james.minor@ni.com>
Subject: BUG_ON(!newowner) in fixup_pi_state_owner()
Date:   Wed, 28 Oct 2020 18:24:40 -0500
Message-ID: <87a6w6x7bb.fsf@ni.com>
Content-Type: text/plain
X-Originating-IP: [130.164.62.214]
X-ClientProxiedBy: SN4PR0701CA0001.namprd07.prod.outlook.com
 (2603:10b6:803:28::11) To SN6PR04MB4496.namprd04.prod.outlook.com
 (2603:10b6:805:a3::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from quark (130.164.62.214) by SN4PR0701CA0001.namprd07.prod.outlook.com (2603:10b6:803:28::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 28 Oct 2020 23:24:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ccfe99f-2a36-4e7e-8496-08d87b98a780
X-MS-TrafficTypeDiagnostic: SN2PR04MB2174:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN2PR04MB2174C411DB9FCBCD470FD722FE170@SN2PR04MB2174.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1taXlaB/aabiqJHP8otH//f6O4LjwCX24+zmmwNoqu5LwkZ0dB+GyHhEqB5keZGugHqeEXMdGhLDON8Xce4zwd4i2rMSgMRPas08F6Akplk2AUkVSBPElp+moaECQObaWozuONPaT+Z/Omgo1XE6a3KzF0gjLFTN0Ud0CGrlc7Uc08qn1wUgedHEbv/9ahW+vQH7Nqmvd33tfDzW56vJi/d179cASR1DU1KR9T0P87ciFJQK5lhv5yhcVALRPnlXALBomsmZi0gY8LkI80NRGpuB/Nc4fDhKxop37YJ0J4QDpBWBjOXkcT3YZUgSVbUxotDKS+5HMdFuKaeES0eEb0fVq9FFKMEkS4AIHXl1lw105IaRTaNazE4ZZH6hHBYL3SnTKd7KkEF9jFHhadJfqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB4496.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(39860400002)(396003)(366004)(376002)(8676002)(54906003)(5660300002)(26005)(110136005)(86362001)(6486002)(316002)(52116002)(66476007)(36756003)(66556008)(186003)(16526019)(2906002)(66946007)(478600001)(966005)(83380400001)(6496006)(4326008)(956004)(6666004)(44832011)(8936002)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: ytj8xkzLZwf53QB34j1oXc35ab3kE/A1vA6dWBFfTcoszINfc9G6MF2bd+6AvLNiFbMc5EdNB+YlfUyUxLuRYFz++DVHWXP7yYnKispqispr+mN/OlhCUekl/NIhLFztKCsAh3NLmpLntJg0TOdcjfx0WeARzdmChQ46ZRmRjnCAXiC4Gj1wel476utGNrFcrpaW//bOqu3cjt4Q5nsji4NQQBR54nHHr5mytS6WgdntGh6zhFp/YxXblxXUG2fLzQGjhCdziPqQtrhBNPDdrV4LWaJ8SKHWV4cdYtewu0hxb5XmhrqRv5u3FG9wnSQB0CX4xpFmJ2hIGtEYxLS36RuJqjpZ0k90rP8HjUZ0H7B17S9SBnZO5pfphlVa5jB1MVsrCzkmHjDYRGU6Gf2weA662z4L4MhH8Dbyn4m9Ro1rV00aP7c4nQ3mpY4FvpYiUrgEfCpSOptRASjZf2lVV4hlDU6Vz01eD4jB0nBfJzAWuIBLQfm3tSV9ibeoyrylwD8tTo1XY4Zhg/rxUQjxLcyzA41hcuBvjuKowfAvHNFDKI5/YVYMVNmbHUFrX3REIMoRdtNHWekoLSlGrN8nh2rAtQ+Pp3Qgk17+OV5V+IqxP46+kq/C6IB4aKhKntI6nyFnP0H8eRxsalBFucvWRg==
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ccfe99f-2a36-4e7e-8496-08d87b98a780
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB4496.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2020 23:24:45.0876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cCByeovsyq0ndz2LG23VsIA2WR1lgUTGUEPeQur/pINTRwfacSXEZKDQkPMmalmD+qyIhdobzU3ncIZdroKFpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2174
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-28_09:2020-10-28,2020-10-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30
 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1011
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 mlxscore=0 classifier=spam
 adjust=30 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010280144
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi all,

Brandon and I have been debugging a nasty race that leads to
BUG_ON(!newowner) in fixup_pi_state_owner() in futex.c. So far
we've only been able to reproduce the issue on 4.9.y-rt kernels.
We are still testing if this is a problem for later RT branches.

The original reproducing app was complex and took about a month
to trigger it. However based on event traces I was able to put
together the .c reproducer below. This triggers the BUG_ON on a
2-core Intel Atom E3825 system when using 4.9.y-rt within
hours (up to a day).

Here's an attempt to describe in a pseudo trace the sequence of
events that leads to the BUG_ON. All threads start on the same
CPU (CPU1 in the linked traces). The waiter, waker and boosted
threads start as SCHED_OTHER prio:120, rt_thread is configured as
SCHED_FIFO prio:92.

waiter_thread                   waker_thread                    boosted_thread                  rt_thread

                                                                                                clock_nanosleep()
futex(FUTEX_WAIT_REQUEUE_PI,
      cond, lock1, timeout)
  futex_wait_requeue_pi()
    futex_wait_queue_me()
      <scheduled out>
                                                                futex(FUTEX_LOCK_PI, lock2)
                                                                clock_nanosleep()

                                futex(FUTEX_LOCK_PI, lock1)
                                futex(FUTEX_CMP_REQUEUE_PI,
                                      cond, lock1)
                                futex(FUTEX_UNLOCK_PI, lock1)
                                  <local_timer_entry>
                                     <sched_wakeup: rt_thread>
                                     <sched_wakeup: boosted_thread>
                                  <local_timer_exit>
                                  <sched_wakeup: waiter_thread>
                                  <sched_switch: rt_thread>
                                                                <migrated to cpu 0>             futex(FUTEX_LOCK_PI, lock2)
                                                                futex(FUTEX_LOCK_PI, lock1)
                                                                  <scheduled out>                 
                                                                                                  <sched_pi_setprio: boosted_thread,
                                                                                                             oldprio=120 newprio=92>
                                                                                                  <sched_wakeup: boosted_thread>
                                                                                                  <sched_switch: waiter_thread>
    rt_mutex_wait_proxy_lock()                                    <local_timer_entry>
      -ETIMEDOUT                                                    // boosted thread gets
    fixup_owner()                                                   // delayed expiring
      fixup_pi_state_owner()                                        // unrelated timers
        // acquires wait_lock
        __rt_mutex_futex_trylock()
          __rt_mutex_slowtrylock()                                <local_timer_exit>
            try_to_take_rt_mutex()                                // spins on wait_lock
              // fails to take the lock
              // the lock has no owner
              // but it has higher priority
              // waiters enqueued (i.e. boosted_thread)
        BUG_ON(!newowner)

Full ftrace event dumps on OOPS are available at:
https://github.com/gratian/traces

In the same repo you'll also find info on the boot messages for
this hardware and a capture of a kgdb session with prints for the
data structures involved. 

Some important data points - at the time of the crash:

  * the q->pi_state->pi_mutex->owner is 0x1

  * the q->pi_state->pi_mutex has waiters enqueued and the
    current 'waiter_thread' task is not the highest priority
    waiter

  * the q->pi_state->owner is the 'waiter_thread'

You can find the kernel branch used in these tests here:
https://github.com/gratian/linux/commits/stable-rt/v4.9-rt-ni-serial

The other thing worth mentioning is the fact that the comment in
fixup_pi_state_owner() related to this:

	/*
	 * Since we just failed the trylock; there must be an owner.
	 */
	newowner = rt_mutex_owner(&pi_state->pi_mutex);
	BUG_ON(!newowner);

seems incomplete since to my eye there is a code path in
__try_to_take_rt_mutex() through which the trylock can fail
because the current task is not the highest priority waiter but
the rt mutex doesn't have the owner set yet (i.e. the highest
priority waiter didn't get a chance to fix-up the owner field
yet).

I'll be happy to provide any additional info.
Thoughts and suggestions appreciated.

Thanks,
    Gratian

--8<---------------cut here---------------start------------->8---
/* 
 * fbomb.c
 * Reproducer for BUG_ON(!newowner) in fixup_pi_state_owner()
 * <linux>/kernel/futex.c
 */
#define _GNU_SOURCE
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdarg.h>
#include <string.h>
#include <stdio.h>
#include <unistd.h>
#include <pthread.h>
#include <err.h>
#include <errno.h>
#include <sched.h>
#include <time.h>
#include <sys/types.h>
#include <sys/syscall.h>
#include <sys/sysinfo.h>
#include <linux/futex.h>
#include <limits.h>

#define TEST_CPU	1
#define NSEC_PER_USEC	1000ULL
#define NSEC_PER_SEC	1000000000ULL

#define FUTEX_TID_MASK	0x3fffffff

typedef uint32_t futex_t;

static futex_t cond;
static futex_t lock1 = 0;
static futex_t lock2 = 0;
static pthread_barrier_t start_barrier;

static int futex_lock_pi(futex_t *futex)
{
	int ret;
	pid_t tid;
	futex_t zero = 0;

	if (!futex)
		return EINVAL;

	tid = syscall(SYS_gettid);
	if (tid == (*futex & FUTEX_TID_MASK))
		return EDEADLOCK;

	ret = __atomic_compare_exchange_n(futex, &zero, tid, false,
					  __ATOMIC_SEQ_CST, __ATOMIC_SEQ_CST);
	/* no pending waiters; we got the lock */
	if (ret)
		return 0;

	ret = syscall(SYS_futex, futex,
		      FUTEX_LOCK_PI | FUTEX_PRIVATE_FLAG,
		      0, NULL, NULL, 0);
	return (ret) ? errno : 0;
}

static int futex_unlock_pi(futex_t *futex)
{
	int ret;
	pid_t tid;

	if (!futex)
		return EINVAL;

	tid = syscall(SYS_gettid);
	if (tid != (*futex & FUTEX_TID_MASK))
		return EPERM;

	ret = __atomic_compare_exchange_n(futex, &tid, 0, false,
					  __ATOMIC_SEQ_CST, __ATOMIC_SEQ_CST);
	if (ret)
		return 0;

	ret = syscall(SYS_futex, futex,
		      FUTEX_UNLOCK_PI | FUTEX_PRIVATE_FLAG,
		      0, NULL, NULL, 0);
	return (ret) ? errno : 0;
}

static int futex_wait_requeue_pi(futex_t *cond, futex_t *futex,
				 const struct timespec *to)
{
	int ret;

	(*cond)++;
	futex_unlock_pi(futex);

	ret = syscall(SYS_futex, cond,
		      FUTEX_WAIT_REQUEUE_PI | FUTEX_PRIVATE_FLAG,
		      *cond, to, futex, 0);
	if (ret) {
		ret = errno;
		/* on error, the kernel didn't acquire the lock for us */
		futex_lock_pi(futex);
	}

	return ret;
}

static int futex_cmp_requeue_pi(futex_t *cond, futex_t *futex)
{
	int ret;

	(*cond)++;
	ret = syscall(SYS_futex, cond,
		      FUTEX_CMP_REQUEUE_PI | FUTEX_PRIVATE_FLAG,
		      1, INT_MAX, futex, *cond);

	return (ret) ? errno : 0;
}

static void tsnorm(struct timespec *ts)
{
	while (ts->tv_nsec >= NSEC_PER_SEC) {
		ts->tv_nsec -= NSEC_PER_SEC;
		ts->tv_sec++;
	}
}

static unsigned long long tsdiff(struct timespec *start, struct timespec *end)
{
	unsigned long long t1 = (unsigned long long)(start->tv_sec) * NSEC_PER_SEC +
		start->tv_nsec;
	unsigned long long t2 = (unsigned long long)(end->tv_sec) * NSEC_PER_SEC +
		end->tv_nsec;

	return t2 - t1;
}

static void set_cpu_affinity(int cpu)
{
	cpu_set_t mask;

	CPU_ZERO(&mask);
	CPU_SET(cpu, &mask);
	if (sched_setaffinity(0, sizeof(mask), &mask) < 0)
		err(1, "Failed to set the CPU affinity");
}

static void clr_cpu_affinity()
{
	cpu_set_t mask;
	int i;

	CPU_ZERO(&mask);
	for (i = 0; i < get_nprocs(); i++)
		CPU_SET(i, &mask);

	if (sched_setaffinity(0, sizeof(mask), &mask) < 0)
		err(1, "Failed to clear the CPU affinity");
}

static void set_fifo_priority(int prio)
{
	struct sched_param schedp;

	memset(&schedp, 0, sizeof(schedp));
	schedp.sched_priority = prio;
	if (sched_setscheduler(0, SCHED_FIFO, &schedp) < 0)
		err(1, "Failed to set the test thread priority");
}

static void do_busy_work(unsigned long long nsec)
{
	struct timespec start_ts;
	struct timespec ts;

	clock_gettime(CLOCK_MONOTONIC, &start_ts);
	do {
		clock_gettime(CLOCK_MONOTONIC, &ts);
	} while (tsdiff(&start_ts, &ts) < nsec);
}


static void* boosted_thread(void *param)
{
	struct timespec sleep_ts = {.tv_sec = 0, .tv_nsec = 600000ULL};

	while (1)
	{
		set_cpu_affinity(TEST_CPU);
		pthread_barrier_wait(&start_barrier);
		clr_cpu_affinity();

		futex_lock_pi(&lock2);
		clock_nanosleep(CLOCK_MONOTONIC, 0, &sleep_ts, NULL);
		futex_lock_pi(&lock1);
		futex_unlock_pi(&lock1);
		futex_unlock_pi(&lock2);
	}
}

#define SWEEP_START	500000ULL
#define SWEEP_END	900000ULL
#define SWEEP_STEP	100

static void* rt_thread(void *param)
{
	struct timespec sleep_ts;
	unsigned long long nsec;

	set_cpu_affinity(TEST_CPU);
	set_fifo_priority(7);

	nsec = SWEEP_START;
	while(1) {
		pthread_barrier_wait(&start_barrier);
		nsec += SWEEP_STEP;
		if (nsec > SWEEP_END)
			nsec = SWEEP_START;
		sleep_ts.tv_sec = 0;
		sleep_ts.tv_nsec = nsec;
		clock_nanosleep(CLOCK_MONOTONIC, 0, &sleep_ts, NULL);

		/* preempt the waiter thread right after it got
		 * signaled and allow the boosted_thread to block on
		 * lock1 after taking lock2 */
		do_busy_work(2000000ULL);

		/* this should boost the boosted_thread and migrate it */
		futex_lock_pi(&lock2);
		futex_unlock_pi(&lock2);
	}
}

static void* waiter_thread(void *param)
{
	struct timespec ts;

	set_cpu_affinity(TEST_CPU);

	while(1) {
		pthread_barrier_wait(&start_barrier);

		futex_lock_pi(&lock1);
		clock_gettime(CLOCK_MONOTONIC, &ts);
		ts.tv_nsec += 800000ULL;
		tsnorm(&ts);
		futex_wait_requeue_pi(&cond, &lock1, &ts);
		futex_unlock_pi(&lock1);
	}
}

static void* waker_thread(void *param)
{
	struct timespec sleep_ts = {.tv_sec = 0, .tv_nsec = 500000ULL};

	set_cpu_affinity(TEST_CPU);

	while(1) {
		pthread_barrier_wait(&start_barrier);
		clock_nanosleep(CLOCK_MONOTONIC, 0, &sleep_ts, NULL);

		futex_lock_pi(&lock1);
		futex_cmp_requeue_pi(&cond, &lock1);
		futex_unlock_pi(&lock1);
	}
}

int main(int argc, char *argv[])
{
	pthread_t waiter;
	pthread_t waker;
	pthread_t rt;
	pthread_t boosted;

	if (pthread_barrier_init(&start_barrier, NULL, 4))
		err(1, "Failed to create start_barrier");

	if (pthread_create(&waker, NULL, waker_thread, NULL) != 0)
		err(1, "Failed to create waker thread");
	pthread_setname_np(waker, "f_waker");

	if (pthread_create(&waiter, NULL, waiter_thread, NULL) != 0)
		err(1, "Failed to create waiter thread");
	pthread_setname_np(waiter, "f_waiter");

	if (pthread_create(&rt, NULL, rt_thread, NULL) != 0)
		err(1, "Failed to create rt thread");
	pthread_setname_np(rt, "f_rt");

	if (pthread_create(&boosted, NULL, boosted_thread, NULL) != 0)
		err(1, "Failed to create boosted thread");
	pthread_setname_np(boosted, "f_boosted");

	/* block here */
	pthread_join(waker, NULL);
	pthread_join(waiter, NULL);
	pthread_join(rt, NULL);
	pthread_join(boosted, NULL);
}
--8<---------------cut here---------------end--------------->8---
