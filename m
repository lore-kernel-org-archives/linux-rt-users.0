Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E99BC4707F
	for <linux-rt-users@archiver.kernel.org>; Tue, 25 May 2021 22:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F558613FA
	for <linux-rt-users@archiver.kernel.org>; Tue, 25 May 2021 22:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbhEYWTS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 25 May 2021 18:19:18 -0400
Received: from mail-mw2nam10on2054.outbound.protection.outlook.com ([40.107.94.54]:47841
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232575AbhEYWTQ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 25 May 2021 18:19:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FRKBunlYj4GZ0FipQPV6sKBK97hx9/OpQvNOI3DaFTQwS9VCyJuRBm23VL/zsrEEAWovwCSz9ZBUgKhVBVABJBv5UTAFUfuZ5tBf7sHgSqNTMKtlyjs7IW5yH0U2GenmY5KnG1zmoUO0a6YlM+zjRpoltU3MbOML297hicYYCUmwo5YRf0OuyxERyi7HHKoBK75H1r2vk8mLLOG8xv17aUzN+6EXojyVaj83pHjsAUxAriJ/EdpqHrYk8I8iWEDv6RmSD/Pmyvn6T8SZdEEqjfA95curIq78zzJ9+oFHi09qjz3PR0aRFvxT/XIf8+/7tVmG/8NeRvlLzWGtp3x8ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eL/KfDVBUWViHVFwfzj/3pPW6xZm6aLRAbamxEY2OCw=;
 b=MZ8rNOLYfhGU275HuD/SR+/ys6GerbJ4GcAkigvA5lTF8iWhgX96tGAqJ2FBYqJqx4w2d+DVe0FNbHkD3LmIzFrH0bRSEow8PDRhZyr4zRnEVNnzmRvFcGiCgyypidma0xIG277tFpjgtx20FsZsKNwzozE1V0P2/mzHCm5IybC59XWQZSgn6Htg9/AomMVFdkjTfDveYdxSM0AY99iMXLTYazyBg9nzO8HcUo+eInz7Xyj/uuns1GmMIi56lLloz2U3rPYV1iByD7pXwnuipuwC03vfG7k+SOTlC9qA+tzdpRraKjM35r7H6wNcKoyYwP/Q/pkHOLZVWNib2hH2oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=linutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eL/KfDVBUWViHVFwfzj/3pPW6xZm6aLRAbamxEY2OCw=;
 b=kF55qsrx0cJ0ZbXk8HUboF0epdVFwKjxtBNATIFWGU+D9anmO6x/YMeXWK2erIq9/FIkW4RQDMteNU4yxZcgCsaHo2L/TtxvEmeU2PPMaiHIB1VMXXCIT8CpuY+vbFbbdlmCHNYc8K92hfGrMbfoAxaWqO6p2NiA3riOCkhYGxYwY40D/X+qbeP5MSEx0IJMZfbcift9huR/SXR4AUiKOkO4zGWao3RB1JGMKqV2jzTZJgwGL+cTBMp6Po0wj4itUDCUXufbCNHCJOtaGzJ5xA5iepK0qXkct4hPQBG4oAftRJPfHkhvOl09Ci2KpM2pjvHENEd/KPE67w9BPi/ORw==
Received: from DM5PR19CA0063.namprd19.prod.outlook.com (2603:10b6:3:116::25)
 by DM5PR1201MB0201.namprd12.prod.outlook.com (2603:10b6:4:5b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Tue, 25 May
 2021 22:17:45 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:116:cafe::75) by DM5PR19CA0063.outlook.office365.com
 (2603:10b6:3:116::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Tue, 25 May 2021 22:17:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Tue, 25 May 2021 22:17:44 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 25 May
 2021 15:17:44 -0700
Received: from [172.17.173.69] (172.20.145.6) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2 via Frontend
 Transport; Tue, 25 May 2021 15:17:44 -0700
Subject: Re: Multi pthreaded RT application - mlock doubt
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
CC:     <linux-rt-users@vger.kernel.org>
References: <896cf71c-f610-961a-9d30-8a82d433e0f6@nvidia.com>
 <YKymwnknCImO30CU@lx-t490>
From:   Dipen Patel <dipenp@nvidia.com>
Message-ID: <95b1b0f8-4957-f9cb-0cf7-82c79d819c38@nvidia.com>
Date:   Tue, 25 May 2021 15:24:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YKymwnknCImO30CU@lx-t490>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a885e4a-ba10-4403-9801-08d91fcaebce
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0201:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0201AB6F3C62F0A2BF4B1F06AE259@DM5PR1201MB0201.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a/wcGvEC660d2Uglyy08z6Fkk2hcK9hV2A4GtnAYqLMmZkheUTskIZqbdshNPEzQkb123QaVdoARSbRT1jy9WoKmD0QfO5tGiccpv2IoktD5agln29XUasH7uus0ianIShWezat2qLANIs038xpvEPKrsDxIVoBr2tb8VCdwLZRp7XZDMD4SuGYfm6WqTtMN1Pwfz4mdT1FV2Cn7JPm26Eg2kNfjqP0kdvCXa/9n+05M02b1KgQ/utKy0SHiMUiZT1MkduSxM0jOZhcvuom5sVB0lGvn1fsEc3VcUvgzneT6/W2tn68S5UQ0KEPUUR44ODOpLzffJjPrJ6mYR0dDjt77xYBVSWlK0of6qVS4W5dYoG3x6LxCa8fTYyjj8MiTG749eEXEwAPGLfx3e15r4wj6UK/Xw3tQTqbVll7ywRu2+BPjX46mPt6qZzudR8cFRWfK3075koDqJx5zuhpLRfMN9B+6wMY0a2m0c4NWdI9l0Qq6fFvw3z8gS3YT2IAaBKjNqohmfZd4IMk9sPuWzJipDFJxQJYK5SgJ2FwiQ0hCeoyrRBS5FLsRrR9emm3pviWNBQ2EPGylKN+8f7R6+/EO96DlyDigdd0TL16/yPo/MmFNCAaTndiaVyE7QNHF/3JTX6CNklRGG7dj38Y+Syfemr7LCVLYMXqfs6dKpZzt/AxAaoB3vzEq2mkXb65J3TMc+l+zyL2QzHhD1mg+5UXLV5LQTaKpznpn9e2LK1D++Q2539idd+8l4A3HnJRxSMk23Luaf8ypWAiAxUuuncJ3pOORi7VgKp5honCrxG8=
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(346002)(136003)(36840700001)(46966006)(8936002)(8676002)(6916009)(47076005)(70206006)(70586007)(83380400001)(82310400003)(336012)(2616005)(26005)(186003)(53546011)(426003)(966005)(31696002)(356005)(7636003)(86362001)(36860700001)(16799955002)(2906002)(478600001)(31686004)(82740400003)(316002)(16576012)(36756003)(5660300002)(6666004)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 22:17:44.8626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a885e4a-ba10-4403-9801-08d91fcaebce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0201
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On 5/25/21 12:26 AM, Ahmed S. Darwish wrote:
> On Wed, Mar 31, 2021 at 07:06:26PM -0700, Dipen Patel wrote:
>> Hi,
>>
>> I was following
>> https://rt.wiki.kernel.org/index.php/Threaded_RT-application_with_memory_locking_and_stack_handling_example
>> with some below changes:
>>
> 
> The example above is a bit inaccurate, as it prefaults the thread's
> stack much later than it should be.
> 
> ...
> 
>>
>> thread_fn {
>> 	getrusage(RUSAGE_SELF, &usage);>
>> 	print and save usage.ruminflt;
>> 	prove_thread_stack_use_is_safe
>> 	getrusage(RUSAGE_SELF, &usage);
>> 	print usage.ruminflt - last_saved_cnt;
>> }
>>
>> I observed there are still page faults.
> 
> Well, in the snippet above, there will obviously be page faults, as
> you're also measuring the faults generated by
> prove_thread_stack_use_is_safe(). On first invocation, this is actually
> the method prefaulting the thread stack.
> 
Original example shown in above link uses the prove_thread_stack_use_is_safe same way.
I just extended it to call it locally and calculate it locally because of the mutli
thread.

> To make sure the discussion is more concrete, can you please send a
> complete, compilable, *.c file?
>
 // Compile with 'gcc thisfile.c -lpthread -lrt -Wall'
 /*
  * This program is modified to have multiple threads each with CPU affinity
  * and priority from
  * https://rt.wiki.kernel.org/index.php/Threaded_RT-application_with_memory_locking_and_stack_handling_example
  */
#define _GNU_SOURCE
#include <stdlib.h>
#include <stdio.h>
#include <sys/mman.h>	// Needed for mlockall()
#include <unistd.h>		// needed for sysconf(int name);
#include <malloc.h>
#include <sys/time.h>	// needed for getrusage
#include <sys/types.h>
#include <sys/resource.h>	// needed for getrusage
#include <pthread.h>
#include <limits.h>
#include <ctype.h>
#include <sched.h>

   
#define PRE_ALLOCATION_SIZE (100*1024*1024) /* 100MB pagefault free buffer */
#define MY_STACK_SIZE       (100*1024)      /* 100 kB is enough for now. */

/* Added by Dipen */
#define NUM_THREAD	8 /* Do not change this, start_rt_thread hard codes its usage */
int SEED_PRIO = 90;
int NUM_PROC;
struct th_info {
	  int cpu_number;
	  int other;
	  int prio;
} ti[NUM_THREAD];
  
pthread_t thread[NUM_THREAD];
pthread_attr_t attr[NUM_THREAD];
/* End */

static void setprio(int prio, int sched)
{
	struct sched_param param;
	// Set realtime priority for this thread
	param.sched_priority = prio;
	if (sched_setscheduler(0, sched, &param) < 0)
		perror("sched_setscheduler");
}
   
void show_new_pagefault_count(const char* logtext, 
   			      const char* allowed_maj,
   			      const char* allowed_min)
{
	static int last_majflt = 0, last_minflt = 0;
	struct rusage usage;

	getrusage(RUSAGE_SELF, &usage);

	printf("%-30.30s: Pagefaults, Major:%ld (Allowed %s), " \
   	       "Minor:%ld (Allowed %s)\n", logtext,
   	       usage.ru_majflt - last_majflt, allowed_maj,
   	       usage.ru_minflt - last_minflt, allowed_min);
   	
   	last_majflt = usage.ru_majflt; 
   	last_minflt = usage.ru_minflt;
}
   
static void prove_thread_stack_use_is_safe(int stacksize)
{
	volatile char buffer[stacksize];
	int i;

	/* Prove that this thread is behaving well */
   	for (i = 0; i < stacksize; i += sysconf(_SC_PAGESIZE)) {
   		/* Each write to this buffer shall NOT generate a 
   			pagefault. */
   		buffer[i] = i;
   	}
	/* commented out by Dipen */
	//show_new_pagefault_count("Caused by using thread stack", "0", "0");
}

/* Added by Dipen */
static void confirm_sched_para()
{
	int policy, ret;
	struct sched_param param;
	ret = pthread_getschedparam(pthread_self(), &policy, &param);

	if (ret)
		printf("ERROR getting sched param\n");
	else
		printf("policy=%s, priority=%d\n",
			(policy == SCHED_FIFO)  ? "SCHED_FIFO" :
			(policy == SCHED_RR)    ? "SCHED_RR" :
			(policy == SCHED_OTHER) ? "SCHED_OTHER" :
			"???", param.sched_priority);
}

/*************************************************************/
/* The thread to start */
/* Modified to add CPU affinity and calculating page faults
 * locally in the thread
 */
static void *my_rt_thread(void *args)
{
	struct th_info *ti = (struct th_info *)args;
	struct timespec ts;
	ts.tv_sec = 0;
	ts.tv_nsec = 10000000;

	int last_majflt = 0, last_minflt = 0;
	struct rusage usage;
	cpu_set_t cpuset; 
	CPU_ZERO(&cpuset);
	CPU_SET(ti->cpu_number , &cpuset);

	sched_setaffinity(0, sizeof(cpuset), &cpuset);

	if (ti->other != 1) {
		setprio(ti->prio, SCHED_FIFO);
		printf("I am an RT-thread [%d], executing on [%d]\n",
			pthread_self(), sched_getcpu());
	} else {
		printf("I am an non-thread [%d], executing on [%d]\n",
		pthread_self(), sched_getcpu());
	}
	confirm_sched_para();
	//<do your RT-thing here>
   
   	getrusage(RUSAGE_SELF, &usage);
   
   	printf("[%d]Pagefaults, Major:%ld, Minor:%ld \n",pthread_self(),
   	       usage.ru_majflt - last_majflt,
   	       usage.ru_minflt - last_minflt);
	
	last_majflt = usage.ru_majflt; 
   	last_minflt = usage.ru_minflt;
	
   	prove_thread_stack_use_is_safe(MY_STACK_SIZE);
   
	getrusage(RUSAGE_SELF, &usage);
   
   	printf("[%d]After stack usage:Pagefaults, Major:%ld, Minor:%ld \n",pthread_self(),
   	       usage.ru_majflt - last_majflt,
   	       usage.ru_minflt - last_minflt);
		   
   	/* wait 400 ms before thread terminates */
   	clock_nanosleep(CLOCK_REALTIME, 0, &ts, NULL);
	printf("Thread %d leaving\n", pthread_self());
	return NULL;
}

/*************************************************************/
static void error(int at)
{
	/* Just exit on error */
	fprintf(stderr, "Some error occured at %d", at);
	exit(1);
}

static void start_rt_thread(void)
{
	int i = 0;
	int csnum;
	cpu_set_t cpuset;
	int RT_POLICY = SCHED_FIFO;
	int RT_POLICY_MIN_PRIORITY = sched_get_priority_min(RT_POLICY);
	int RT_POLICY_MAX_PRIORITY = sched_get_priority_max(RT_POLICY);
	int PRIO_LOW    = RT_POLICY_MIN_PRIORITY;
	int PRIO_HIGH   = RT_POLICY_MAX_PRIORITY - 5;
	int PRIO_MEDIUM = (PRIO_LOW + PRIO_HIGH) / 2;

	printf("prio low=%d, %d, %d\n", PRIO_LOW, PRIO_HIGH, PRIO_MEDIUM);
   	/* init to default values */
	for (; i < NUM_THREAD; i++) {
		if (pthread_attr_init(&attr[i]))
			error(1);
		if (pthread_attr_setstacksize(&attr[i],
					      PTHREAD_STACK_MIN + MY_STACK_SIZE))
			error(2);

		if (i < 3)
			csnum = i;
		else
			csnum = 3;
		
		ti[i].cpu_number = csnum;
		ti[i].other = 0;
		if (i >= 0 && i <= 2)
			ti[i].prio = PRIO_LOW;
		else if (i >= 3 && i < 5)
			ti[i].prio = PRIO_MEDIUM;
		else if (i >= 5 && i < 8)
			ti[i].prio = PRIO_HIGH;

		if (i == 7)
			ti[i].other = 1;

		if (pthread_attr_setinheritsched(&attr[i], PTHREAD_EXPLICIT_SCHED))
			error(4);
		/* And finally start the actual thread */
		if (!pthread_create(&thread[i], &attr[i], my_rt_thread, &ti[i])) {
			printf("Thread: %d created\n", thread[i]);
			//pthread_detach(thread[i]);
		}
	}
}
   
static void configure_malloc_behavior(void)
{
	/* Now lock all current and future pages
	 * from preventing of being paged
	 */
	if (mlockall(MCL_CURRENT | MCL_FUTURE))
		perror("mlockall failed:");

	/* Turn off malloc trimming.*/
	mallopt(M_TRIM_THRESHOLD, -1);

	/* Turn off mmap usage. */
   	mallopt(M_MMAP_MAX, 0);
}

static void reserve_process_memory(int size)
{
	int i;
	char *buffer;

   	buffer = malloc(size);

	/* Touch each page in this piece of memory to get it mapped into RAM */
	for (i = 0; i < size; i += sysconf(_SC_PAGESIZE)) {
   		buffer[i] = 0;
   	}

	free(buffer);
}

int main(int argc, char *argv[])
{
	show_new_pagefault_count("Initial count", ">=0", ">=0");
   
   	configure_malloc_behavior();
   
   	show_new_pagefault_count("mlockall() generated", ">=0", ">=0");
	reserve_process_memory(PRE_ALLOCATION_SIZE);
	show_new_pagefault_count("malloc() and touch generated", 
   				 ">=0", ">=0");

   	/* Now allocate the memory for the 2nd time and prove the number of
	 * pagefaults are zero
	 */
	reserve_process_memory(PRE_ALLOCATION_SIZE);
	show_new_pagefault_count("2nd malloc() and use generated", 
   				 "0", "0");
	NUM_PROC = sysconf(_SC_NPROCESSORS_ONLN);
	printf("We have %d processors\n", NUM_PROC);
	start_rt_thread();

	//<do your RT-thing>
	for (int i = 0; i < NUM_THREAD; i ++) {
		pthread_join(thread[i], NULL);
	}
	printf("main thread exit\n");

   	return 0;
}
 
> Good luck,
> 
> --
> Ahmed S. Darwish
> Linutronix GmbH
> 
