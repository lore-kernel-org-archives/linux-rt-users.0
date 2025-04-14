Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F220A15442C;
	Mon, 14 Apr 2025 14:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744642222; cv=fail; b=qnx/AXzLsEdY2MHIWStbMbH0YXLmooaNvv4wW5dczBURSHkGeUf07H4RfUSdKxuCbb0Fsz2TGvsxXJaeGzGf2tGIDugQpk6wEMEEDPWo2TpaoeKr8YgQU7ofPwTCDACAHnap2K6LZF1qf75RLshy+reCzOf5ovL4Q2AbQmWEots=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744642222; c=relaxed/simple;
	bh=Q7yda52BN8YpH2VawEsMraB2c1VyRz3p7dyyI3Bfo3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Wk0tfC9psklrdHwjv8j88p+1LhOrSVAWpR8ZW3LDPtrJhXZ5I25QNcA5g/58WYmWLcNq4D9RSCbdqb1h4jlTaJwSNLnyC4XAQhBPps6q5eERXWAdi7gfKGLz7X719DXnbM+QZOV2Sa5jjpXscVH2REXOUVvXrW08kn22qHhGp2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Sf5aiodY; arc=fail smtp.client-ip=40.107.223.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Sf5aiodY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pO6NGZywMU+D8UzNAMOb65Q9J7kYpJYN5CVmqaKXrGwmY3D7vqwyLOwEnRdfEeL3YzTkWokx321bQtkhxG9tRleVD5StNoa00YsuQel2BSUcmoC30dBF7XxCQkKW1f3KviZoezwVXuH4LzSZodtj40sPV6dqOfWrjgz9fuMU+8dD6AIsLlYNG9AWdD/8LjyXjAw19y7zq/Fx/emGcQzAw3Unzv4LmDKwjmybkPq9k0R2xfQQAQzOofZjCSQOY9ObePwod81l4BnKzr18amxUFQwjX348VcXJ2peNuSRUpKU4Wi6edqGO2q2iZYcMgRmhZgkMXoR2UsusixlYaQFO1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLj/ie2m6rwkBW2RX5VOSOGyWWb/QRipjPmUgHqq2u0=;
 b=qJbIZIjjnfshP6mcCvMcZRqM+dL9QLsLYCE1vYKEnWcXDW7lNNCssfMjHVAd+h/NQklMQ9q7577zkjGwiDiv/QyiMVLIlNDiejV29bZdY8oai3Y6Z3aL0ceqrzI7vaorTHi+uWci1g0b6uyfSn3mXZbmEwlO/u0fFcqENbK4w2XL5cetVQ1jEI0jom2R5Jhb6gwSos9J3U7xAKa0WGjO53llSXqcneO2r7BdaGwg9LvtiM64iZBSmEb7RurolwZy3zOyDLiz1pv+yTS6Y0yd+N2Ei7f3Cxa63wCv12wqntVeYDiqR2JVjSR0pZVY7i7OhG8O7Wv5C5la9twh0430oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=siemens.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLj/ie2m6rwkBW2RX5VOSOGyWWb/QRipjPmUgHqq2u0=;
 b=Sf5aiodY3MgUTPjlG8N4FaRUNsk7+f6yLx7oKoQSGfhkCN3ka2MfjmGCe/ZDPLZsZR4JShDxzLASjFqBJj74Gcn3VEpH4Vs9mTAtlnIf/xOx9TfLXcEBgVp3otRxDTyopzqzpwszKcfdPUCY2afHXDtCtnASLb3ploCBKoEEFCs=
Received: from BL1P223CA0029.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::34)
 by DS2PR12MB9565.namprd12.prod.outlook.com (2603:10b6:8:279::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 14:50:16 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::b1) by BL1P223CA0029.outlook.office365.com
 (2603:10b6:208:2c4::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Mon,
 14 Apr 2025 14:50:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 14:50:16 +0000
Received: from [172.31.188.187] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 09:50:11 -0500
Message-ID: <f2e2c74c-b15d-4185-a6ea-4a19eee02417@amd.com>
Date: Mon, 14 Apr 2025 20:20:04 +0530
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RT BUG] Stall caused by eventpoll, rwlocks and CFS bandwidth
 controller
To: Jan Kiszka <jan.kiszka@siemens.com>, Aaron Lu <ziqianlu@bytedance.com>
CC: Valentin Schneider <vschneid@redhat.com>,
	<linux-rt-users@vger.kernel.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, <linux-kernel@vger.kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>, Clark Williams
	<williams@redhat.com>, "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Andreas Ziegler <ziegler.andreas@siemens.com>, Felix Moessbauer
	<felix.moessbauer@siemens.com>, Florian Bezdeka <florian.bezdeka@siemens.com>
References: <xhsmhttqvnall.mognet@vschneid.remote.csb>
 <3f7b7ce1-6dd4-4a4e-9789-4c0cbde057bd@siemens.com>
 <c92290e0-f5db-49bd-ac51-d429133a224b@amd.com>
 <20250409121314.GA632990@bytedance>
 <3d13e35a-51bb-4057-8923-ebb280793351@siemens.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <3d13e35a-51bb-4057-8923-ebb280793351@siemens.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|DS2PR12MB9565:EE_
X-MS-Office365-Filtering-Correlation-Id: a41ac8df-957c-4247-30fb-08dd7b63ab84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1BKSThiYU9wRGVkNU5hRE5uKzFDSVpuUmY3eEVUYmFFVDRQWTFBWWFJVFBS?=
 =?utf-8?B?YXJaREFaN1R4Zk9QZHhMZ2l6eHVLZE1xaFBFb3NvVHRwK3dLWWpGVWtIZm5U?=
 =?utf-8?B?Q2t1SFM5Y0dKYjJuaFZBbS9KMkJiYk1oOW1lM010YTVJNDQzN3lldG1mdmtD?=
 =?utf-8?B?dE1QdFdTdnpnWDF2dWM2eERCdWY2UDUxbXJRckFyWWNjaFB3OUZwOHhUWURQ?=
 =?utf-8?B?dnVLcU5PeXFCMVRoVEtLMHl2VEhQRDc5MXVRZWxXOU5iNHl6ZFoyRU1jTFF5?=
 =?utf-8?B?bXZYUjRySHZaVWF0Y2F2TGtrUXVzTER4TlhqbVBiemlDT1c3dEdhdUNKMDJj?=
 =?utf-8?B?STU5VGpvUlk1WTZYencybzRlL2wxMzgreS9CRUFPbStzRW9MazRBajAxRFpk?=
 =?utf-8?B?RHp0OTdEVXJHR1ArTGdUWlFnb2x6TE93R3U5bkFCUkk1YWppVElVbC81S3dq?=
 =?utf-8?B?QjM0R3ZULzVWYVhJQU1xem9qaFB0LzQ5b2J5eEx3Q1BORXFGak9xc1Axamgr?=
 =?utf-8?B?clVxd1psNTIzQmx0RVQyY0Uxc2Q1WHYveWNUWGozTlRNSGMrWHNrR0svMHBW?=
 =?utf-8?B?Qzg2M3pUVFo5LzZNY2VRMEF3aHR1Y3J3dnVjYXlmNVBLckdMUDdVZVF3aVpN?=
 =?utf-8?B?NzA0MjBDVXZyOHJ2a05UdDJtNmk5c3pZRS96YXF5V0xNaDNkT2Ixc20vc3py?=
 =?utf-8?B?dkNxT0lhNlFxcWVFRGRzN0xybnJmNWpkM1FCY1l3b1dQaU02RitPYzFkVWlO?=
 =?utf-8?B?Sk5FRVFFRm4zdDQ5NkcwV3R0TlRZOHZSVmcwSXZJdkVSZkd5QWsvQ0VETS9H?=
 =?utf-8?B?NUpUOW5DcHJUMlpwZ2ZNNVF3LzF1MkFSQjIvNjlQOG1zaTdlM1lhOFVIa2da?=
 =?utf-8?B?blRwL3F5YWtuaCtXOWQyakJGSzlhVEpZSXdyR2JQeUU2UFJ0bGsxbDloeFBP?=
 =?utf-8?B?cXpXWks4M3ZsZ0ppWkZhWWpsK0V0NzUzdjlZRVpyenRwWWgrVGlhS2xHTGRa?=
 =?utf-8?B?emhsL2N6Y1JCOG4ybDhsclhydmhSZzBWYXB0a0wwZEpqUHNuTmRUZTNYQlZT?=
 =?utf-8?B?V2tSekgwN2FsaDgrTXJBQlRnN2FIb0gwYk5hbjg1YTdTbzd2SldPcnBFSytw?=
 =?utf-8?B?MStrWUxqREVVV1VwOERVRDcrWUtKZGZtM3VJd1RhV3NOV0RGa2ZHQ25GL01t?=
 =?utf-8?B?T0daZ0ZaaGhpSnZUelo2WVhCbDlVbEhLMXpwU0M3RnNOQU1UWnZ1Y1ZwcHgr?=
 =?utf-8?B?N2VKRHpvOWhNcHVlcnM5TzhCeWxIM2tqdmJ6d0RoN3JoTTE5Q2RmNTJBcmJG?=
 =?utf-8?B?Tkg4d1ZGajVUYUJHSzkzMUVLOGVNcVdrelhWOEwvd1lhZzhRZS9LYXZ5YThI?=
 =?utf-8?B?UWFMZVFET2VNM3NHazZsdjBzTlI1WEFaWXRON0M2U2Yyeks5K3FNMVJqenN5?=
 =?utf-8?B?WEFGOGRUUGt4alVJc2JDaFVjbHJmcS9DSjhscDlvYk95VzFmeFdMeURSeGE1?=
 =?utf-8?B?d1RFeFB4am1FMlJOdTVTcmZDMDJQcmYzcldlcjZ1aTN3QmR0OTlhZWJxTDB6?=
 =?utf-8?B?dCtadHFOUFJYRlY5YWtQMmdSc3EvcXpqWDNXM0tSaVZiQjAyZmhrOFU3ZVpj?=
 =?utf-8?B?VUtneS81VGJ4c01xWFRFZ3IwVlBwTmRreWhTTUh0b3BWaEVSOTdTcklhSVlE?=
 =?utf-8?B?blFVV0RCVjN2YmUwdXMvT01sSmZMZWc3aVBxNXZZdWNqMDF0ODZUbFZCcWRP?=
 =?utf-8?B?WXYyZjNWaVRkUHpkV0xVVXlvY0Jvcm5sOGlVbjB5SExNRThDbnRqeUNvVXZs?=
 =?utf-8?B?eERWUmxFY0lmbmxvVy9rbWVFcGpMbG5xSFFKclpxaXRhSGhjZndMZTV6Sy9K?=
 =?utf-8?B?TmtBYm1rOXo3VkVqeENxV1J4ek5wRGZ5WHZkQTFDcWFJaUhSUk5wRjB1a2xB?=
 =?utf-8?B?aFliUERZQkFER0RhKzN2OGZSVUFVMmRscmNWcVgrWHhVUGFqWlNEclFNZjNi?=
 =?utf-8?B?WUNQRk50NXlBWVZiOXN2S21MNnMyb2M1N212NTNPNjRkZnhueVFmZmxKbXA0?=
 =?utf-8?B?T2lBaU9tdElvRlkzcWEyL0RkelFDSlNxdU13Zz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 14:50:16.5555
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a41ac8df-957c-4247-30fb-08dd7b63ab84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9565

Hello Jan,

On 4/9/2025 7:14 PM, Jan Kiszka wrote:
> On 09.04.25 14:13, Aaron Lu wrote:
>> On Wed, Apr 09, 2025 at 02:59:18PM +0530, K Prateek Nayak wrote:
>>> (+ Aaron)
>>
>> Thank you Prateek for bring me in.
>>
>>> Hello Jan,
>>>
>>> On 4/9/2025 12:11 PM, Jan Kiszka wrote:
>>>> On 12.10.23 17:07, Valentin Schneider wrote:
>>>>> Hi folks,
>>>>>
>>>>> We've had reports of stalls happening on our v6.0-ish frankenkernels, and while
>>>>> we haven't been able to come out with a reproducer (yet), I don't see anything
>>>>> upstream that would prevent them from happening.
>>>>>
>>>>> The setup involves eventpoll, CFS bandwidth controller and timer
>>>>> expiry, and the sequence looks as follows (time-ordered):
>>>>>
>>>>> p_read (on CPUn, CFS with bandwidth controller active)
>>>>> ======
>>>>>
>>>>> ep_poll_callback()
>>>>>     read_lock_irqsave()
>>>>>     ...
>>>>>     try_to_wake_up() <- enqueue causes an update_curr() + sets need_resched
>>>>>                         due to having no more runtime
>>>>>       preempt_enable()
>>>>>         preempt_schedule() <- switch out due to p_read being now throttled
>>>>>
>>>>> p_write
>>>>> =======
>>>>>
>>>>> ep_poll()
>>>>>     write_lock_irq() <- blocks due to having active readers (p_read)
>>>>>
>>>>> ktimers/n
>>>>> =========
>>>>>
>>>>> timerfd_tmrproc()
>>>>> `\
>>>>>     ep_poll_callback()
>>>>>     `\
>>>>>       read_lock_irqsave() <- blocks due to having active writer (p_write)
>>>>>
>>>>>
>>>>>   From this point we have a circular dependency:
>>>>>
>>>>>     p_read -> ktimers/n (to replenish runtime of p_read)
>>>>>     ktimers/n -> p_write (to let ktimers/n acquire the readlock)
>>>>>     p_write -> p_read (to let p_write acquire the writelock)
>>>>>
>>>>> IIUC reverting
>>>>>     286deb7ec03d ("locking/rwbase: Mitigate indefinite writer starvation")
>>>>> should unblock this as the ktimers/n thread wouldn't block, but then we're back
>>>>> to having the indefinite starvation so I wouldn't necessarily call this a win.
>>>>>
>>>>> Two options I'm seeing:
>>>>> - Prevent p_read from being preempted when it's doing the wakeups under the
>>>>>     readlock (icky)
>>>>> - Prevent ktimers / ksoftirqd (*) from running the wakeups that have
>>>>>     ep_poll_callback() as a wait_queue_entry callback. Punting that to e.g. a
>>>>>     kworker /should/ do.
>>>>>
>>>>> (*) It's not just timerfd, I've also seen it via net::sock_def_readable -
>>>>> it should be anything that's pollable.
>>>>>
>>>>> I'm still scratching my head on this, so any suggestions/comments welcome!
>>>>>
>>>>
>>>> We are hunting for quite some time sporadic lock-ups or RT systems,
>>>> first only in the field (sigh), now finally also in the lab. Those have
>>>> a fairly high overlap with what was described here. Our baselines so
>>>> far: 6.1-rt, Debian and vanilla. We are currently preparing experiments
>>>> with latest mainline.
>>>
>>> Do the backtrace from these lockups show tasks (specifically ktimerd)
>>> waiting on a rwsem? Throttle deferral helps if cfs bandwidth throttling
>>> becomes the reason for long delay / circular dependency. Is cfs bandwidth
>>> throttling being used on these systems that run into these lockups?
>>> Otherwise, your issue might be completely different.
>>
>> Agree.
>>
>>>>
>>>> While this thread remained silent afterwards, we have found [1][2][3] as
>>>> apparently related. But this means we are still with this RT bug, even
>>>> in latest 6.15-rc1?
>>>
>>> I'm pretty sure a bunch of locking related stuff has been reworked to
>>> accommodate PREEMPT_RT since v6.1. Many rwsem based locking patterns
>>> have been replaced with alternatives like RCU. Recently introduced
>>> dl_server infrastructure also helps prevent starvation of fair tasks
>>> which can allow progress and prevent lockups. I would recommend
>>> checking if the most recent -rt release can still reproduce your
>>> issue:
>>> https://lore.kernel.org/lkml/20250331095610.ulLtPP2C@linutronix.de/
>>>
>>> Note: Aaron Lu is working on Valentin's approach of deferring cfs
>>> throttling to exit to user mode boundary
>>> https://lore.kernel.org/lkml/20250313072030.1032893-1-ziqianlu@bytedance.com/
>>>
>>> If you still run into the issue of a lockup / long latencies on latest
>>> -rt release and your system is using cfs bandwidth controls, you can
>>> perhaps try running with Valentin's or Aaron's series to check if
>>> throttle deferral helps your scenario.
>>
>> I just sent out v2 :-)
>> https://lore.kernel.org/all/20250409120746.635476-1-ziqianlu@bytedance.com/
>>
>> Hi Jan,
>>
>> If you want to give it a try, please try v2.
>>
> 
> Thanks, we are updating our setup right now.
> 
> BTW, does anyone already have a test case that produces the lockup issue
> with one or two simple programs and some hectic CFS bandwidth settings?

This is your cue to grab a brown paper bag since what I'm about to paste
below is probably lifetime without parole in the RT land but I believe
it gets close to the scenario described by Valentin:

(Based on v6.15-rc1; I haven't yet tested this with Aaron's series yet)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e43993a4e580..7ed0a4923ca2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6497,6 +6497,7 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
  	int count = 0;
  
  	raw_spin_lock_irqsave(&cfs_b->lock, flags);
+	pr_crit("sched_cfs_period_timer: Started on CPU%d\n", smp_processor_id());
  	for (;;) {
  		overrun = hrtimer_forward_now(timer, cfs_b->period);
  		if (!overrun)
@@ -6537,6 +6538,7 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
  	}
  	if (idle)
  		cfs_b->period_active = 0;
+	pr_crit("sched_cfs_period_timer: Finished on CPU%d\n", smp_processor_id());
  	raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
  
  	return idle ? HRTIMER_NORESTART : HRTIMER_RESTART;
diff --git a/kernel/sys.c b/kernel/sys.c
index c434968e9f5d..d68b05963b88 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2470,6 +2470,79 @@ static int prctl_get_auxv(void __user *addr, unsigned long len)
  	return sizeof(mm->saved_auxv);
  }
  
+/* These variables will be used in dumb ways. */
+raw_spinlock_t dwdt_spin_lock;
+struct hrtimer dwtd_timer;
+DEFINE_RWLOCK(dwdt_lock);
+
+/* Should send ktimerd into a deadlock */
+static enum hrtimer_restart deadlock_timer(struct hrtimer *timer)
+{
+	pr_crit("deadlock_timer: Started on CPU%d\n", smp_processor_id());
+	/* Should hit rtlock slowpath after kthread writer. */
+	read_lock(&dwdt_lock);
+	read_unlock(&dwdt_lock);
+	pr_crit("deadlock_timer: Finished on CPU%d\n", smp_processor_id());
+	return HRTIMER_NORESTART;
+}
+
+/* kthread function to preempt fair thread and block on write lock. */
+static int grab_dumb_lock(void *data)
+{
+	pr_crit("RT kthread: Started on CPU%d\n", smp_processor_id());
+	write_lock_irq(&dwdt_lock);
+	write_unlock_irq(&dwdt_lock);
+	pr_crit("RT kthread: Finished on CPU%d\n", smp_processor_id());
+
+	return 0;
+}
+
+/* Try to send ktimerd into a deadlock. */
+static void dumb_ways_to_die(unsigned long loops)
+{
+	struct task_struct *kt;
+	unsigned long i;
+	int cpu;
+
+	migrate_disable();
+
+	cpu = smp_processor_id();
+	pr_crit("dumb_ways_to_die: Started on CPU%d with %lu loops\n", cpu, loops);
+
+	raw_spin_lock_init(&dwdt_spin_lock);
+	hrtimer_setup(&dwtd_timer, deadlock_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
+	kt = kthread_create_on_cpu(&grab_dumb_lock, NULL, cpu, "dumb-thread");
+
+	read_lock_irq(&dwdt_lock);
+
+	/* Dummy lock; Disables preemption. */
+	raw_spin_lock(&dwdt_spin_lock);
+
+	pr_crit("dumb_ways_to_die: Queuing timer on CPU%d\n", cpu);
+	/* Start a timer that will run before the bandwidth timer. */
+	hrtimer_forward_now(&dwtd_timer, ns_to_ktime(10000));
+	hrtimer_start_expires(&dwtd_timer, HRTIMER_MODE_ABS_PINNED);
+
+	pr_crit("dumb_ways_to_die: Waking up RT kthread on CPU%d\n", cpu);
+	sched_set_fifo(kt); /* Create a high priority thread. */
+	wake_up_process(kt);
+
+	/* Exhaust bandwidth of caller */
+	for (i = 0; i < loops; ++i)
+		cpu_relax();
+
+	/* Enable preemption; kt should preempt now. */
+	raw_spin_unlock(&dwdt_spin_lock);
+
+	/* Waste time just in case RT task has not preempted us. (very unlikely!) */
+	for (i = 0; i < loops; ++i)
+		cpu_relax();
+
+	read_unlock_irq(&dwdt_lock);
+	pr_crit("dumb_ways_to_die: Finished on CPU%d with %lu loops\n", cpu, loops);
+	migrate_enable();
+}
+
  SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
  		unsigned long, arg4, unsigned long, arg5)
  {
@@ -2483,6 +2556,9 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
  
  	error = 0;
  	switch (option) {
+	case 666:
+		dumb_ways_to_die(arg2);
+		break;
  	case PR_SET_PDEATHSIG:
  		if (!valid_signal(arg2)) {
  			error = -EINVAL;
--

The above adds a prctl() to trigger the scenario whose flow I've
described with some inline comments. Patterns like above is a crime
but I've done it in the name of science. Steps to reproduce:

     # mkdir /sys/fs/cgroup/CG0
     # echo $$ > /sys/fs/cgroup/CG0/cgroup.procs
     # echo "500000 1000000" > /sys/fs/cgroup/CG0/cpu.max

     # dmesg | tail -n 2 # Find the CPU where bandwidth timer is running
     [  175.919325] sched_cfs_period_timer: Started on CPU214
     [  175.919330] sched_cfs_period_timer: Finished on CPU214

     # taskset -c 214 perl -e 'syscall 157,666,50000000' # Pin perl to same CPU, 50M loops

Note: You have to pin the perl command to the same CPU as the timer for it
to run into stalls. It may take a couple of attempts. Also please adjust
the number of loops of cpu_relax() based on your setup. In my case, 50M
loops runs long enough to exhaust the cfs bandwidth.

With this I see:

     sched_cfs_period_timer: Started on CPU214
     sched_cfs_period_timer: Finished on CPU214
     dumb_ways_to_die: Started on CPU214 with 50000000 loops
     dumb_ways_to_die: Queuing timer on CPU214
     dumb_ways_to_die: Waking up RT kthread on CPU214
     RT kthread: Started on CPU214
     deadlock_timer: Started on CPU214
     rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
     rcu:     Tasks blocked on level-1 rcu_node (CPUs 208-223): P1975/3:b..l
     rcu:     (detected by 124, t=15002 jiffies, g=3201, q=138 ncpus=256)
     task:ktimers/214     state:D stack:0     pid:1975  tgid:1975  ppid:2      task_flags:0x4208040 flags:0x00004000
     Call Trace:
      <TASK>
      __schedule+0x401/0x15a0
      ? srso_alias_return_thunk+0x5/0xfbef5
      ? srso_alias_return_thunk+0x5/0xfbef5
      ? update_rq_clock+0x7c/0x120
      ? srso_alias_return_thunk+0x5/0xfbef5
      ? rt_mutex_setprio+0x1c2/0x480
      schedule_rtlock+0x1e/0x40
      rtlock_slowlock_locked+0x20e/0xc60
      rt_read_lock+0x8f/0x190
      ? __pfx_deadlock_timer+0x10/0x10
      deadlock_timer+0x28/0x50
      __hrtimer_run_queues+0xfd/0x2e0
      hrtimer_run_softirq+0x9d/0xf0
      handle_softirqs.constprop.0+0xc1/0x2a0
      ? __pfx_smpboot_thread_fn+0x10/0x10
      run_ktimerd+0x3e/0x80
      smpboot_thread_fn+0xf3/0x220
      kthread+0xff/0x210
      ? rt_spin_lock+0x3c/0xc0
      ? __pfx_kthread+0x10/0x10
      ret_from_fork+0x34/0x50
      ? __pfx_kthread+0x10/0x10
      ret_from_fork_asm+0x1a/0x30
      </TASK>

I get rcub stall messages after a while (from a separate trace):

     INFO: task rcub/4:462 blocked for more than 120 seconds.
           Not tainted 6.15.0-rc1-test+ #743
     "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
     task:rcub/4          state:D stack:0     pid:462   tgid:462   ppid:2      task_flags:0x208040 flags:0x00004000
     Call Trace:
      <TASK>
      __schedule+0x401/0x15a0
      ? srso_alias_return_thunk+0x5/0xfbef5
      ? srso_alias_return_thunk+0x5/0xfbef5
      ? rt_mutex_adjust_prio_chain+0xa5/0x7e0
      rt_mutex_schedule+0x20/0x40
      rt_mutex_slowlock_block.constprop.0+0x42/0x1e0
      __rt_mutex_slowlock_locked.constprop.0+0xa7/0x210
      rt_mutex_slowlock.constprop.0+0x4e/0xc0
      rcu_boost_kthread+0xe3/0x320
      ? __pfx_rcu_boost_kthread+0x10/0x10
      kthread+0xff/0x210
      ? rt_spin_lock+0x3c/0xc0
      ? __pfx_kthread+0x10/0x10
      ret_from_fork+0x34/0x50
      ? __pfx_kthread+0x10/0x10
      ret_from_fork_asm+0x1a/0x30
      </TASK>

I left the program on for good 5 minutes and it did not budge after the
splat.

Note: I could not reproduce the splat with !PREEMPT_RT kernel
(CONFIG_PREEMPT=y) or with small loops counts that don't exhaust the
cfs bandwidth.

> 
> Jan
> 

-- 
Thanks and Regards,
Prateek

