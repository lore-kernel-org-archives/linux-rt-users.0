Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5534438B;
	Mon, 14 Apr 2025 15:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744643909; cv=fail; b=dXesd9U/V9Sd8jcETJueQOcuOmkIvc1qNknaVV3JCs/LiewqbXxvCFHQ4v4eMLernrnS5NUbUISFCnRUCPdnV23lQWPdUtZKQEoNWZ8eB29WGBGrwQwPBvlHttdhmuX6y9G1en49+sTxnUdqhH4ICOoaJMbHLWPgAWgrYrQI3fU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744643909; c=relaxed/simple;
	bh=4aQG3+sJRMRo0l77vs2UqF61PjCqZb9T+juBnrvdobU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GKSx1VQZIB3XyPsL7VxYcj4yiUKEL0702iP/gXtybnThUBUkdl+FPP/wMRj7Rfyzvmcbo8wYAw4aoxexTvNWTlw7IWTPyRD9/Ntg59tZr2OHHU2i7cSS97+c8yqEZIumoWiIYJeDoGN0ZlFwDY1Z6anjlPhQCBOrZ4s/NLkGD1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P0KEP6Hn; arc=fail smtp.client-ip=40.107.93.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P0KEP6Hn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UL7BmbUSSA3m3eL1fWm1EE0G14rOrp+43qf4VOLUUbTOwb9LWAIQZGSwOrelOjkS7/ZLI9zF0+6T9nlfSdnmTeXV0nz0hsP4DUL91kEPVv+8jEnNb/U2HvuLUDfw1JyANkj0iQpdLh/R9XHNwsnvV8Yc004Qhx2y+3lSLjaSL7B/2TZjMXwmtcyY2zGdnia5VXKIuZZgNPlIzTaJ67F025rAMx4qtVDTzQG7dCbF/X0C/zULd3LW40+JgE1MZLK7gk0uJpTQswLNvl2hlcA+7eYrHShuNKZjEJiRj5R3xnzMx4SkXnb4Q7o3A/kICcaKXfk2KsWdGN1zQT2RpNIvWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xT1aJbtNpxpmCHoTkHAUEcVjX4t2nFMMMiewNyJrNVc=;
 b=k1J+dBszyt+80sE0yHuoo4Jef0/uAJcrcrfSunorBRLjP3AdJLYbtPB5ZwYuG4Ewcj+mggcyJdGLNirmKrlV1dj6jAXz9Vq+zwftLO4asyGHhZ830Po6aLepT2roV/LveeLHC5Qf5hbgDAU2kHl0ZMOzANukN9mt8eM6WPEtUuGiLAQdQFXxnO+EPG9h/9priaOB6/kYyvMdMNfMUOw5ArkYFq1QeD0DktDJw8daw7e+Zo5VWqwoX47dBZ5O6Mq2eAOp48W69yH93NVvF0+7glPYrxADnMyRkcS/j7774DpGQFKfyOdAYb5G6MvFEuVk/gZzEUPDGstuV5fS2iR4qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xT1aJbtNpxpmCHoTkHAUEcVjX4t2nFMMMiewNyJrNVc=;
 b=P0KEP6Hn8Zf0gc1cZh8BC5iKSGBObjKtVau4DjR2i/ewrYkWW2uynuGbDTrxXqeBtq+nRffgLcZgMn3fJuRyeL8SkYcfBq4dQ2T8KEOVVug1MwzeBD4apDTBqPWNSTX6eFVGjdbdnyjU+pW4Y8FV5ahRKQ70Az5kXzjjaNpN0cY=
Received: from SJ0PR03CA0222.namprd03.prod.outlook.com (2603:10b6:a03:39f::17)
 by BL3PR12MB6474.namprd12.prod.outlook.com (2603:10b6:208:3ba::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Mon, 14 Apr
 2025 15:18:23 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::b4) by SJ0PR03CA0222.outlook.office365.com
 (2603:10b6:a03:39f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.32 via Frontend Transport; Mon,
 14 Apr 2025 15:18:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 15:18:23 +0000
Received: from [172.31.188.187] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 10:18:18 -0500
Message-ID: <2637dc3c-80b5-40d7-b0e1-22ccdeba848d@amd.com>
Date: Mon, 14 Apr 2025 20:48:15 +0530
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RT BUG] Stall caused by eventpoll, rwlocks and CFS bandwidth
 controller
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: Jan Kiszka <jan.kiszka@siemens.com>, Aaron Lu <ziqianlu@bytedance.com>,
	Valentin Schneider <vschneid@redhat.com>, <linux-rt-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Juri
 Lelli <juri.lelli@redhat.com>, Clark Williams <williams@redhat.com>, "Luis
 Claudio R. Goncalves" <lgoncalv@redhat.com>, Andreas Ziegler
	<ziegler.andreas@siemens.com>, Felix Moessbauer
	<felix.moessbauer@siemens.com>, Florian Bezdeka <florian.bezdeka@siemens.com>
References: <xhsmhttqvnall.mognet@vschneid.remote.csb>
 <3f7b7ce1-6dd4-4a4e-9789-4c0cbde057bd@siemens.com>
 <c92290e0-f5db-49bd-ac51-d429133a224b@amd.com>
 <20250409121314.GA632990@bytedance>
 <3d13e35a-51bb-4057-8923-ebb280793351@siemens.com>
 <f2e2c74c-b15d-4185-a6ea-4a19eee02417@amd.com>
 <20250414150513.klU46xkw@linutronix.de>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250414150513.klU46xkw@linutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|BL3PR12MB6474:EE_
X-MS-Office365-Filtering-Correlation-Id: f5dc2cbd-95d2-4f80-7943-08dd7b6798e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rk9tSDlrd1VKRDFPTVRyMjRjYm5MUDlTckxDMm5ObXA2dDhvWjJTTm9nbkhO?=
 =?utf-8?B?dTlDTTNkN25RcVROeXR5NUphbUQyVGgvWStSZHVpMVloeVFmV2pnYk5uZEpF?=
 =?utf-8?B?VTZ4NG53WXZKbk9HVWI0SzNyYU9BU2Flb25NODdjdjNrNndXSVowdHovK2ZO?=
 =?utf-8?B?bGVhWXZndEtoUVZVVitWQmcwenI5ZWkxcW01TTZscEdpdEtheWFPbVZkSlZ5?=
 =?utf-8?B?UDFvdjdCc3BpcmQ5NFE4eW4xY3lJT3FlTlBRL21BeFBEKzJSRHdrUS9zOEdq?=
 =?utf-8?B?Z3RDekVoeVNZakJUbWthaXZRRWJRc2NCRVJldTdWV1NtZngrQUhFRVp5ZUVT?=
 =?utf-8?B?d3B4QVFTWkdxWWh2SXhCQjNrQWVUZlZaaFVvL2tJd3Y3dFhsUzNzTWJHMDNo?=
 =?utf-8?B?cERmTjNKamh6VFp1Qk0xRnkzT05RVTBLa2x5eWdkUmRQallDQVdZTmp0emNa?=
 =?utf-8?B?N3VDb0xUUWUvSHJnTDhSV0dsaHUzVUR1RkFyOFVObVppb3l0bytDbUxEeTF0?=
 =?utf-8?B?YnlGQkJoaXRDTW1peUtvVDhHY3ZEZ2Y5RFFtY1VWeXNLTFNpS29QdDNMdWhG?=
 =?utf-8?B?QVYyd1R1eUp4VEFaS3VINzY4OVN1RzVITi84L1VFWkxNTzJsYlh5Q3l0NGU2?=
 =?utf-8?B?SEZRdEI0M3NRVjJoVzJyYnNMbVZOcGZ5SzV6dDc2QmlCa0ZDTnZ5aVpHRDRv?=
 =?utf-8?B?WmlMUEtGY1dmTDBZL1NPQmVVMlhweE9IcDQ3cjliTzF4Y0Jta1lNaldmeDZP?=
 =?utf-8?B?Ym9WZGltbjlBdkR5U2FvSjVGWC9jdk1SQkd4Y0o0MnBJek4za1NsVms1UTU2?=
 =?utf-8?B?d3ZadUh1cmVqRkE5amUveHNDL21NaTN2cW5neS9jM2RtREhQem1jc0Y3TmFR?=
 =?utf-8?B?eHhmZ3hqYXVpL240L0ovK2owMFFWQm9VcXJxUUg5NDIvOGVWTTVqNmYycm41?=
 =?utf-8?B?SEF0SDRZb0NtVG1mb1hGN2NXR2EwdndZc1lTVmRwMmhSdWFXVHBkK1grMkJx?=
 =?utf-8?B?b2VCS3JlbkxsTVZ3NkI1R3VGVEI4ZGtHZWpmMFhDM05xdll5ZmRIQzVNN1hr?=
 =?utf-8?B?elRVS0dZR0ZINWN2S2liM0hXS04yVHpwcE5OTlJ0d2crS3pJaEJSWjZHOWpH?=
 =?utf-8?B?N0RTUkRBd0ZzUEZjTEhMYkdIZnpsSTVHWEduK0pxWXlmNzQzRnZvRXpQWUht?=
 =?utf-8?B?MWlpUGc5dHJYOE1oYjVUTFNPbkRCV1NmU0xzNTdwRk9kQ3BqMUNjN2MzUUlH?=
 =?utf-8?B?eWlkRlFpQ2VYQkJwQkJwaVYwb3A4YXc5UEg5MjdRZHZwM2NmbUl0ZVBjUk9W?=
 =?utf-8?B?b1Q5S2xhU2FwdTBDV2VwL0MycERiU0xFeldRWGxITWRXb0h5ZVJZOUU2NHY0?=
 =?utf-8?B?ZU1mUWZiTUtTYm4veEtaamh6VSs0R3prd3BML3BCeXFZN01oYS8zZDc1RGdO?=
 =?utf-8?B?eWZQem5scW12MFdlWmx2bVl4amV5ak9KMDNJaUxiZkNqcjJLVWhldjFKcURt?=
 =?utf-8?B?U3hPUzFVNU5sMURZc1daR05ZUTNjU25ubitHL0lQalhVcXIvVzFnSDhSUjhw?=
 =?utf-8?B?cFlQRVpiOU5BSWhISnVyOGZiTklpSFVTSytYMEhucmpEOEFpVTJzSUNxeFNw?=
 =?utf-8?B?dzlCR2Q2aWE5NDduRTV3YnF2eFhlTG0xNnVwZnFkUzBKbzZRdUNuVGFpVDBr?=
 =?utf-8?B?YS9OS2xZNjlsSUVYVVIxZUQyckRtWHpkUHRwbG9DeVYyWkJBTTl1dzdPRDZW?=
 =?utf-8?B?WlFpZUMzWmpsaFo5SnIzU09xVCtTTG5YTXdCSElRQXNPaFJQcWlUYmJFM2dI?=
 =?utf-8?B?a2ovUEdTdDRMWGtsK3lrZ2FmV042dUFRSDJ5OHR1T3A1Smx1cGxMUGwxeEcw?=
 =?utf-8?B?SGYyYXNnTnNzYUlUQmhRYnJsTm9LNDBzdC9mbkdvTTQ4a25UTjVBQlRXdkVR?=
 =?utf-8?B?ZWNHWEt2S3J4Q2lVU2MwNVlJdU1JUjA4TDJ4allxWlFsT29JNHRMNUZBWmts?=
 =?utf-8?B?bTJXcTRLczlBc1RhRW1ES1hCelQ1MlJTcjBJL3VWL0Y0QVdjSCtTWHY5N0dy?=
 =?utf-8?Q?Pk5/SH?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 15:18:23.1848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5dc2cbd-95d2-4f80-7943-08dd7b6798e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6474

Hello Sebastian,

On 4/14/2025 8:35 PM, Sebastian Andrzej Siewior wrote:
> On 2025-04-14 20:20:04 [+0530], K Prateek Nayak wrote:
>> Note: I could not reproduce the splat with !PREEMPT_RT kernel
>> (CONFIG_PREEMPT=y) or with small loops counts that don't exhaust the
>> cfs bandwidth.
> 
> Not sure what this has to do with anything.

Let me clarify a bit more:

- Fair task with cfs_bandwidth limits triggers the prctl(666, 50000000)

- The prctl() takes a read_lock_irq() excpet on PREEMPT_RT this does not
   disable interrupt.

- I take a dummy lock to stall the preemption

- Within the read_lock critical section, I queue a timer that takes the
   read_lock.

- I also wakeup up a high priority RT task that that takes the
   write_lock

As soon as I drop the dummy raw_spin_lock:

- High priority RT task runs, tries to take the write_lock but cannot
   since the preempted fair task has the read end still.

- Next ktimerd runs trying to grab the read_lock() but is put in the
   slowpath since ktimerd has tried to take the write_lock

- The fair task runs out of bandwidth and is preempted but this requires
   the ktimerd to run the replenish function which is queued behind the
   already preempted timer function trying to grab the read_lock()

Isn't this the scenario that Valentin's original summary describes?
If I've got something wrong please do correct me.

> On !RT the read_lock() in the timer can be acquired even with a pending
> writer. The writer keeps spinning until the main thread is gone. There
> should be no RCU boosting but the RCU still is there, too.

On !RT, the read_lock_irq() in fair task will not be preempted in the
first place so progress is guaranteed that way right?

> 
> On RT the read_lock() in the timer block, the write blocks, too. So
> every blocker on the lock is scheduled out until the reader is gone. On
> top of that, the reader gets RCU boosted with FIFO-1 by default to get
> out.

Except there is a circular dependency now:

- fair task needs bandwidth replenishment to progress and drop lock.
- rt task needs fair task to drop the lock and grab the write end.
- ktimerd requires rt task to grab and drop the lock to make progress.

I'm fairly new to the PREEMPT_RT bits so if I've missed something,
please do let me know and sorry for any noise.

> 
> Sebastian

-- 
Thanks and Regards,
Prateek

