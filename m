Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7741712CDAE;
	Wed,  9 Apr 2025 09:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744190970; cv=fail; b=iejBCmHhpBGBnr5HrQveRb9yTcpOj+ijDeN0wp2PZf1DLyRyoRHcgLvR3Vhu+XcbzqSwHXgJ5YMUBt59i0jWcKV2rxGPGpDcoUIMf6kN9wmPSmkiyYl9bcEoxy3OlkoseG1nTc7KlsWRSCnpXleO+FihALl1dPokde52t29oP+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744190970; c=relaxed/simple;
	bh=BTIu1j71MWmi36wS+3KHNMK63mYglbizmK7+ErVpQpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XQycq/NtxenYn2pbYPoV9LbGFAYmk9jj66We3NY/abPGpgsa3ubXjyfdo0522hIW+dH8xYNQMMS6RObzVG1uymm9DhITmnxnHVglC5iMBTQFsO3frZsJemU8S6qBGSbPhV2QzmIkTrQSELODv9f1xb55D5aUQOAZ79OCaqJc6M8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BEO5Il4P; arc=fail smtp.client-ip=40.107.237.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BEO5Il4P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uflWFpP3q4SdURNxSGxRcPcuxHD7Mjc4SGqN7Sb+Si9zhGvvy/+PQxh8U0h56ptWyEX1iNlM1/SZapUuSzdWIqi1EBKI5DvcUTwDgEplwLhjOgsGlIsf5VjYoglbS8yMuytxcju6EKn9/7lCXDWfkZ5HeYX9WuqZc9j39fGCR0F3FzZ4an7d4h2MRd+qD0kYqnwcLoh2mZuVo2Wofd7x7wFzQcYSBGzNoF1hy4efmddH7wc5koPPkyy40S/aSYierwaRgXzBOt0eNFAZqSyT4Qwvq/hB60sa6ihrZmNb6w/6LfUwfRHr0Bue7PP2/PUG9mt3yJ7XD/FTGs1Jj960SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFg7BpnQEror9BFiteStlG5DkKH+7+JFA4LQ1bji1lQ=;
 b=t6DpBKlTwlKzKSAlnmFhzvziAjy6MBU9gywHerDRd1Xy++Wm472HKVDT5x4dgXjowwL69Tq3UCvDbpIZhbkBjzTUHfN16WmvXYdNzHfNDiFaI74o5a51TaTKqFV0KXr7Dis9cpjLBPuu4IbTAxIrPteD7E97zT45VhotzCXwY9tRDSsnY+uhPQ3NcCEsegEsVZ8Al7AxIKRT/0rqocEDjyY80Ex1OOKHQ9vlHbOHfvArktuM97QuQtM+tAVJYeLSh0OznpSkdJCqKeI5jx7uUuorDaCkX5gKUbsMVzUkHBny42rsQ7xhdjxkB02bgR/MqVA1EQk0fhXC2LetsO1g9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=siemens.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFg7BpnQEror9BFiteStlG5DkKH+7+JFA4LQ1bji1lQ=;
 b=BEO5Il4PavLe8Ko0YvWR7cBdBdy0594CVf7UWySoteMFil3zyCDYdgFqOKofqo8v8GOfH/P6douzkk1KvgVlKUgAwXQer95gg0U3Kfd1whGDFaeioE31p8mw4W+N2s/b4fL/vue/Ogs9xN1RAi41pFG6WM7QPenprWvDhoq+0IE=
Received: from BL1PR13CA0367.namprd13.prod.outlook.com (2603:10b6:208:2c0::12)
 by MN2PR12MB4111.namprd12.prod.outlook.com (2603:10b6:208:1de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Wed, 9 Apr
 2025 09:29:24 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:208:2c0:cafe::90) by BL1PR13CA0367.outlook.office365.com
 (2603:10b6:208:2c0::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.22 via Frontend Transport; Wed,
 9 Apr 2025 09:29:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Wed, 9 Apr 2025 09:29:24 +0000
Received: from [10.85.39.27] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Apr
 2025 04:29:20 -0500
Message-ID: <c92290e0-f5db-49bd-ac51-d429133a224b@amd.com>
Date: Wed, 9 Apr 2025 14:59:18 +0530
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RT BUG] Stall caused by eventpoll, rwlocks and CFS bandwidth
 controller
To: Jan Kiszka <jan.kiszka@siemens.com>, Valentin Schneider
	<vschneid@redhat.com>, <linux-rt-users@vger.kernel.org>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, <linux-kernel@vger.kernel.org>, Aaron Lu
	<ziqianlu@bytedance.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>,
	Clark Williams <williams@redhat.com>, "Luis Claudio R. Goncalves"
	<lgoncalv@redhat.com>, Andreas Ziegler <ziegler.andreas@siemens.com>, Felix
 Moessbauer <felix.moessbauer@siemens.com>, Florian Bezdeka
	<florian.bezdeka@siemens.com>
References: <xhsmhttqvnall.mognet@vschneid.remote.csb>
 <3f7b7ce1-6dd4-4a4e-9789-4c0cbde057bd@siemens.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <3f7b7ce1-6dd4-4a4e-9789-4c0cbde057bd@siemens.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|MN2PR12MB4111:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f094e16-fe08-43bf-a2d3-08dd7749045d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|82310400026|376014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmhjV1ZodFRjN0pacGU3ckJFakUyWi9oVnd2TmZlMy8xdGNYeVNSVnZtME1X?=
 =?utf-8?B?K0hZU3E3M2lORkNSQlFhV0VrV0FZZWdlMjhSSzBUdTh2REJZVVExVitjU0Nl?=
 =?utf-8?B?dDZ5S0Z6RjAraXNCUlZFS1ltcXBSMUFPMmVIWDc2c3NLTFR3Qm5zRHZXZ2NM?=
 =?utf-8?B?SFU3ajBUYzJ3eEtkelVaQU8wT1IvMTZUWkZJTTFhaHJkV0g5UTFhZ3hrdFcr?=
 =?utf-8?B?TDZzR0RsTWwwQm92bjhOcXFncnJJRUVXWnpzd0xBejJGOEJYejA5Zkk3d1Qy?=
 =?utf-8?B?Q1pOd1BXRGlmR0tMMHNsNk1rd0VyRkVMcDV3c3VrVlhOYWxsNFl5N1JVTmY2?=
 =?utf-8?B?M1Q5U05vOVRFbGFTQUZqc05GV05BaHYyWitRY2NOamdZVHFSb1VwV2FjMzBi?=
 =?utf-8?B?QXJKd0xIb2hGSUtwZi9JTTRkdzlTUzl0c1U2eEdhcFVxZE5iV0ltYzIySVJD?=
 =?utf-8?B?OWR4emNIeDQyVzBMUzRFQnBpM0hDWG5JRHVHeHJlQlIvNkQzYzh4U0d5RUxr?=
 =?utf-8?B?WG15aEx5dnIzQTNpNHpOMkJwRFFMMDRFakhpeVplUjRaU3duZnFyZmlIR2hF?=
 =?utf-8?B?My9ncUhxUnF2QUluU1hCTGQ5aEFaVUg0cHozMDIyNEtvYkovektJeElKYmJP?=
 =?utf-8?B?Y0ZIUmd6alQya0N1andFM1JHcXJqTVdVdVJQZEZIanh0bjNWaFBaNS9oWk5h?=
 =?utf-8?B?RHowTEsrbHVQT21xaXJYR0lnaHhTcGsxWm5ja2RSZGdDTDd0dkR1NFJvbFFx?=
 =?utf-8?B?Z1lvSjkweDVMdTZOTEt5NzRFVzV4Z3I3T3FYaUhBa3QxZHR3aC9vTTVhWnQy?=
 =?utf-8?B?cVlFTFRVZWpyNTB2MnUwbE5XNXVubWlBeVVYbnZFZTQzMjg5cDhLQ1lONEsw?=
 =?utf-8?B?VUNBcDZrMmk5WkJNZkN1V3Nwc09aSW84NUFNbjR3dVowZmtjZnVYVjEwUXZz?=
 =?utf-8?B?YUJrbHcyS1dYK0VyNzU1R3RGZk5kVkdhWUJ1MysyUVd3NWd5bW9GbDduZjZI?=
 =?utf-8?B?R2ExU0FtVW1Ec3FmSk14eWZja3MyNXVCOVliZHVOTGU1aEp3UXB6c3MrU25i?=
 =?utf-8?B?OWdPSHBCbnJ0RzdmamJrTDY3K21iY09xQ3JKNHptWUpzYVBXTXRwalIzUDFi?=
 =?utf-8?B?eE1qc2JtL3pDM004UVZQT05SbkRvYko0ZzJ0RUUwM1ozSnZzNUxkcmxiOFho?=
 =?utf-8?B?alVPQlRxU01rTGdCZlYzeitNUy93WkRZYkxRVTRHVVIwSkx3N2puRkRrekdu?=
 =?utf-8?B?MzF2WEJST2JLcUNFdGl4LzJLS29mcEtIVTFKcjhONFZQcFVneFFkb05JVDNS?=
 =?utf-8?B?Skp3WWJVSGM1UEZyN2Y1RVlOdW9MSnhPZXlNU0Rua0ZhM1pqRzgxWXNOanZI?=
 =?utf-8?B?Z242OHhpTlJTWTBZK3ovS0Yyd0FqdmNLWUxBRmg5Q0hFS0VSMDV3MFlYcWJ6?=
 =?utf-8?B?M0ZHVWFlNG93dUUvV0krYXY2cU55NnJKVTNPV1AwRVVrV1RVb2pMR3NBWCty?=
 =?utf-8?B?VUd0NWxpOWkzeU1HM2dSaXdSS0YzR25UcDJLSjdkbC9qQVdMOWVmWUdQL0la?=
 =?utf-8?B?YVQ0Y1JTVzBYb3htbTlsbm0yWGJqY0tZTFB0SmZjanMyT3prZURmT1ZIb2Z0?=
 =?utf-8?B?R1gwT2VlUUJYeUc2d1ZyWVFNZ0gvSUY4NWNkcmFoV1VRZUdpUkR5SGZLUFpG?=
 =?utf-8?B?RnQ3SCtWL3U1SHlqV2MxZmpYUGQ3VzFSaTNHMFJEVmhkZmFrN2NYYUNjS0xM?=
 =?utf-8?B?bXJwTlp5dVFZempxUGNtZllWWWlmOUVMTDZhQURta2w0ajNWc3FJN3BzazVH?=
 =?utf-8?B?bjhjdWR0alBDbUJWeVhvKy82V2Q5ZlZ0akhkeUZoU1l3MjNVQXIwdExseVk4?=
 =?utf-8?B?VlhjaTlTYlR3R0VmelRHWVIyOTIvVWNKN1p4R3BWcjRHUFJyQ0NLNnFQS2ZV?=
 =?utf-8?B?QWxEV25IR3JCSUFnZ3VNSFo3MEZoKzdNOWRYNHRKZDhJQkI4bEpDSUlIODdu?=
 =?utf-8?B?ek5xSWNraHZIYWs0MlZtNm5zWEtUQnlMQXlHTnVrTnhKSjVSOXA1V3V2OTd1?=
 =?utf-8?B?bGFYS1Y4YUUxOFN1T1ovNVlEVWFVMDhHYjg2QT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(82310400026)(376014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 09:29:24.5573
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f094e16-fe08-43bf-a2d3-08dd7749045d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4111

(+ Aaron)

Hello Jan,

On 4/9/2025 12:11 PM, Jan Kiszka wrote:
> On 12.10.23 17:07, Valentin Schneider wrote:
>> Hi folks,
>>
>> We've had reports of stalls happening on our v6.0-ish frankenkernels, and while
>> we haven't been able to come out with a reproducer (yet), I don't see anything
>> upstream that would prevent them from happening.
>>
>> The setup involves eventpoll, CFS bandwidth controller and timer
>> expiry, and the sequence looks as follows (time-ordered):
>>
>> p_read (on CPUn, CFS with bandwidth controller active)
>> ======
>>
>> ep_poll_callback()
>>    read_lock_irqsave()
>>    ...
>>    try_to_wake_up() <- enqueue causes an update_curr() + sets need_resched
>>                        due to having no more runtime
>>      preempt_enable()
>>        preempt_schedule() <- switch out due to p_read being now throttled
>>
>> p_write
>> =======
>>
>> ep_poll()
>>    write_lock_irq() <- blocks due to having active readers (p_read)
>>
>> ktimers/n
>> =========
>>
>> timerfd_tmrproc()
>> `\
>>    ep_poll_callback()
>>    `\
>>      read_lock_irqsave() <- blocks due to having active writer (p_write)
>>
>>
>>  From this point we have a circular dependency:
>>
>>    p_read -> ktimers/n (to replenish runtime of p_read)
>>    ktimers/n -> p_write (to let ktimers/n acquire the readlock)
>>    p_write -> p_read (to let p_write acquire the writelock)
>>
>> IIUC reverting
>>    286deb7ec03d ("locking/rwbase: Mitigate indefinite writer starvation")
>> should unblock this as the ktimers/n thread wouldn't block, but then we're back
>> to having the indefinite starvation so I wouldn't necessarily call this a win.
>>
>> Two options I'm seeing:
>> - Prevent p_read from being preempted when it's doing the wakeups under the
>>    readlock (icky)
>> - Prevent ktimers / ksoftirqd (*) from running the wakeups that have
>>    ep_poll_callback() as a wait_queue_entry callback. Punting that to e.g. a
>>    kworker /should/ do.
>>
>> (*) It's not just timerfd, I've also seen it via net::sock_def_readable -
>> it should be anything that's pollable.
>>
>> I'm still scratching my head on this, so any suggestions/comments welcome!
>>
> 
> We are hunting for quite some time sporadic lock-ups or RT systems,
> first only in the field (sigh), now finally also in the lab. Those have
> a fairly high overlap with what was described here. Our baselines so
> far: 6.1-rt, Debian and vanilla. We are currently preparing experiments
> with latest mainline.

Do the backtrace from these lockups show tasks (specifically ktimerd)
waiting on a rwsem? Throttle deferral helps if cfs bandwidth throttling
becomes the reason for long delay / circular dependency. Is cfs bandwidth
throttling being used on these systems that run into these lockups?
Otherwise, your issue might be completely different.

> 
> While this thread remained silent afterwards, we have found [1][2][3] as
> apparently related. But this means we are still with this RT bug, even
> in latest 6.15-rc1?

I'm pretty sure a bunch of locking related stuff has been reworked to
accommodate PREEMPT_RT since v6.1. Many rwsem based locking patterns
have been replaced with alternatives like RCU. Recently introduced
dl_server infrastructure also helps prevent starvation of fair tasks
which can allow progress and prevent lockups. I would recommend
checking if the most recent -rt release can still reproduce your
issue:
https://lore.kernel.org/lkml/20250331095610.ulLtPP2C@linutronix.de/

Note: Aaron Lu is working on Valentin's approach of deferring cfs
throttling to exit to user mode boundary
https://lore.kernel.org/lkml/20250313072030.1032893-1-ziqianlu@bytedance.com/

If you still run into the issue of a lockup / long latencies on latest
-rt release and your system is using cfs bandwidth controls, you can
perhaps try running with Valentin's or Aaron's series to check if
throttle deferral helps your scenario.

> 
> Jan
> 
> [1] https://lore.kernel.org/lkml/20231030145104.4107573-1-vschneid@redhat.com/
> [2] https://lore.kernel.org/lkml/20240202080920.3337862-1-vschneid@redhat.com/
> [3] https://lore.kernel.org/lkml/20250220093257.9380-1-kprateek.nayak@amd.com/

I'm mostly testing and reviewing Aaron's series now since per-task
throttling seems to be the way forward based on discussions in the
community.

> 

-- 
Thanks and Regards,
Prateek

