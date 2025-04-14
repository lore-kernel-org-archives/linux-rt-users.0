Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3602DFA3D;
	Mon, 14 Apr 2025 16:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744647676; cv=fail; b=OthNPQtnBohKVJzUoZYWQghNdHlkXWG9MWSN0EyGBlzSjnrfAoAi3fhE+vqUrk9GKRwt/g+iznKdk/qTPThYFtEEN4/6PnEegtaBreGOSDbjA1OVNtWOWVHZTZv0IM/V8OyE8Pz0Po7FGfboP85qms+tE3wpCeh3ZmLKz9+dT18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744647676; c=relaxed/simple;
	bh=M12Hz2vWkr5YwWOkMv89PCXTusFctcHxbhND7rO5fkk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=QFsqszg+yVPTk+VoRCAn2vBCHzE93nUg1BzkFAeRrq/RjklKukZT/cwGhbIeoeYvvlCXB1wjXGDMixzW7L0TNlGgPsyCYgQ8wCkv6NdvSMfQuYswPPxCxpUV7WETSr9uGIUD2WVgdTqtvUwwJ3LSQ2ZEEScxrB2GltmtMrYzFDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B0yyf/If; arc=fail smtp.client-ip=40.107.236.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B0yyf/If"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qDl+2OyFcGBukFhJMir4Ji1P95Hw2K1tFo2OEB6b8CA6MCF0dWFxXT0VDguqEMNM4Lu102gi+Cm024kdc1jeRo0c2j2Vi3sYCYEjhUJCFj3ZCl0rnSdQh6DTiCD3JB3PNRizqDLWqCKRTBi6ZaKIeRsIVQUmW3qNpB9cOeHdoD+y/va6U//OA7wIRQH5wyiC/44QA5gtTrGK6b9Pvz4/vxt8RydbnHo+WTwnThhRw2VFNmO5NbpY8SXXbUQMG567YDPxjae3rRkIe4cf3OQ+f7DNMQm3erAV2ooZ9G/dPVAurrUaIAoyy/fom7lWkExKLGFIwivc8NySeXwGU3mXnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMqMsGAcq2jRaH1j/naiqpBJhLxVAgYi7Q4Nuou8gfU=;
 b=RDJECVil/BFR6oJVD9uVG1Vgos6CbsYkMSU6q9HWKd/A6cazK63kthoZcVU3GDpHWJcfAnYTHl7cmOkpPy+C5Ol54GwuzqONDQKHRBT5AwCHDacAUeJ70BwhEdLXOVjNzMTkPG+bsCRHXi3hrbmc7Exg229Zmusy5hxrDRG14ESRJhiaBMmiKBPll37bADj/C3dkDvOc65r0RVi9M+7c+9wEiHiu5bQVmA34NVIMZUURur7NW7E3U+X2bu5A4nCOVXBrQF0M22LykLglxeFbsu2Vs9Lre7PVJZvjnS8/wLxC6TAOQzCOoX+GhHgqqO6BSvyp3yLYSz2Pdq5eYIHSMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=siemens.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMqMsGAcq2jRaH1j/naiqpBJhLxVAgYi7Q4Nuou8gfU=;
 b=B0yyf/Ifzl9vzXpzR4wKfJBRvaWqxZYrPUmrprnGP1TZ0TvpinIqz4FPvronvMmZc3INdp7GGGrC95HFYyqi4gIJASiMR/71VO9ntqS3erCSotBd9riyRbtPot3UvyiSodgnhATbSobN2Gakr2ORxxl/jt8KYHBiaT2ejGtN99g=
Received: from CH0PR03CA0052.namprd03.prod.outlook.com (2603:10b6:610:b3::27)
 by SJ5PPF2CD49510F.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Mon, 14 Apr
 2025 16:21:10 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::25) by CH0PR03CA0052.outlook.office365.com
 (2603:10b6:610:b3::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Mon,
 14 Apr 2025 16:21:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 16:21:09 +0000
Received: from [172.31.188.187] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 11:21:05 -0500
Message-ID: <534df953-3cfb-4b3d-8953-5ed9ef24eabc@amd.com>
Date: Mon, 14 Apr 2025 21:51:02 +0530
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RT BUG] Stall caused by eventpoll, rwlocks and CFS bandwidth
 controller
From: K Prateek Nayak <kprateek.nayak@amd.com>
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
 <f2e2c74c-b15d-4185-a6ea-4a19eee02417@amd.com>
Content-Language: en-US
In-Reply-To: <f2e2c74c-b15d-4185-a6ea-4a19eee02417@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|SJ5PPF2CD49510F:EE_
X-MS-Office365-Filtering-Correlation-Id: 40fc33e6-09b1-45ff-5e20-08dd7b705ddf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WHNRK3BJZVpNdzd3RUtKR3JncDQ0RTRYdEU4OG9CWGpTNGM4SVVIZGtkeW54?=
 =?utf-8?B?bWl0WStnSkdER3IvL0d3NFdJYWRDWkxNRG0xNHh1dEg1VHJpOVBJMmNnV3Vh?=
 =?utf-8?B?MXZNNWZMWUx3VWhQQzQwUGVJUFJ4bW50U1B0eUtoOHJWVW9odXQvRmc0Y2dT?=
 =?utf-8?B?T3U3cC9uZmN2bVpRTXp0US9MR01MZFVpZWFjd3E0amN4WGpNWVl4Zm5lVVEz?=
 =?utf-8?B?YUR4ejBZSkhpelVvMWk3cGFlUEJzVTFQU1VOSXYrKzZlV29XTG1NNXlyV3Nx?=
 =?utf-8?B?cjFEY1hSQkQxamV1diswbXFEV3JYWC9PYndHTWlHZGZlTWVabzNRNWZCWkpB?=
 =?utf-8?B?TkY4TlQybTRLeHUrWGtEZnZCQ0tZSmJha3U0WW9ZdWNXZllzNXFMbFo1SEZB?=
 =?utf-8?B?MElxbTZKTG4xa0hiQ1hQU0JsemQzMlQ2MnozenNUTGw0Rlp0b3BrLzljU3B1?=
 =?utf-8?B?U1NYNmkyMHhEVGlmSW4zSzdwY0VkSkl3cnJ3U0hWUittNnhmRFNvaWhzWkFU?=
 =?utf-8?B?UkIzTzE0QWdnYTAxSkdCcXVYVy9IM0VhSmt5MWFrREFlc21yTk1WSkpraTN3?=
 =?utf-8?B?OGx0Ti9tSTZWUFRZS05MM2VSZHpJV0JDeUE0NGE2SUJKMzJBenJ0bFFMNE5z?=
 =?utf-8?B?b0lxeUYyV3pxakhsVUtJa0U1V25QU3hjU2FRRE52MHV5bVA1cloyU0pEU0RV?=
 =?utf-8?B?UWZlME1pWnlUYU5BYTR2dmlMd0ZaYW9FOE9TR0k1ZUVXMS8wd0h5eW5Sajgx?=
 =?utf-8?B?V0dmQnZCUWdUTkt4NzdBUktVS0tSMkV4TmlkRG1vQ1NSNFVsUUtjRkpDV3V1?=
 =?utf-8?B?akhxdFdSdUU5WHJQQTVOWis0VHg2MG1EQ1lWYVV0azJKR2J5REMzZTdhTjJs?=
 =?utf-8?B?UUFRSjM1clR1NnBrTEMwaFZzQXN0Z3hqZjcxUkpxUVFlVTlvYW53d1FJWlAy?=
 =?utf-8?B?QnN5OVdybEN5b0RNaitUUllNdFJhZXlESnE0MjZ0b2xtS3d0TEs5YTdMSE9i?=
 =?utf-8?B?c0VST0lxM1g0SjdmU3k4TE5vQzFIa1lDemtmY250ZjgvRVNsZGdXaFE4SGxO?=
 =?utf-8?B?a2xuUlFjaTQwdlh6S044dGpOMFRhMFhKcC8vUzVGMCtCMWlNdWtsU0VLbWh1?=
 =?utf-8?B?YUpLTkZMUzBWN3NrVTJUU2IwK2ZoZ1pjOCtOQTRzZDhRa2FrVHdLYTJtL2lt?=
 =?utf-8?B?STQ1a1ZjaTFBbDBSMUk3SW5ySnJKWE5leGkyYkg2YTlQeWphdXc2TGxYMGxB?=
 =?utf-8?B?emlyYjZPenJIY1dQZGkrZGJqTGdBODFzaHlWaDI3ZFBBUzZpRUZFZytUeXlU?=
 =?utf-8?B?WHFwczEzaDZxUmdNUTh0Q09mSVVXQ1pLS21KMWhQc1VsT1VUWnhKaEp3anBB?=
 =?utf-8?B?OXJuTmtkeHI0di92UTA3YW0yVnYyUHBYUytvRGFuQVVYUWVLT1Y0ZFdBd25R?=
 =?utf-8?B?YkJGeDk1d1dsaXZMVGJRNjV1NTBBcnNnMlhEY0dGRVR1OWJqUmpvVkVDQ1R1?=
 =?utf-8?B?V2ZhZjJQTytRRWNvNXhFV1ozaXZjRXNtbFUybkFEaStVZUxEYWp1OUZ5T3pl?=
 =?utf-8?B?cUpWbU95elRNbSs1bTlsQ2VQekNlNjh3WXZrWi9Mdm5TR25wUHdSMTVPRktk?=
 =?utf-8?B?emFMNHNXSis5TnF4SDBZRzhMakRmTitFQTFNT2lFTHNpWkIybERIeHA5U3Bv?=
 =?utf-8?B?U3JHd1BOYU1IdWZEanJKRmk2anQ4MjFQOWp6SDQzMnFrUURBWC9COWhCMVFR?=
 =?utf-8?B?dElkRGZEb1prWmU4RVFXam5SSTNha0RoeklRZWJIeEI4OFIvd2ZTZXpwckxG?=
 =?utf-8?B?K3VrY2R5dmlBNGw2emsraTZDNG5oUExzUFdDV2did0JPNC82NFhWRFZkYmJp?=
 =?utf-8?B?NXloR3h4MGNObUEwdnpDR2RHcUFmVGVRNWRkMHM3MDVFdmNrUjhWcStvTFZ4?=
 =?utf-8?B?VTJaTVhnSTNBZllEeGVWdDFoMld4dVBqVngwLzRxNWdjSnZwM2dPeHRvVnZ3?=
 =?utf-8?B?ekd2QVJadk84VmtHcGdvOVZUSXRqYmxDUnhvUXlNRTByRys3NHZsUnBLbHI3?=
 =?utf-8?B?YVFhWGt5dUd1OXNlS1B4UDJ6SG80OE9XVzNCUT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 16:21:09.7326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40fc33e6-09b1-45ff-5e20-08dd7b705ddf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF2CD49510F

On 4/14/2025 8:20 PM, K Prateek Nayak wrote:
>>
>> BTW, does anyone already have a test case that produces the lockup issue
>> with one or two simple programs and some hectic CFS bandwidth settings?
> 
> This is your cue to grab a brown paper bag since what I'm about to paste
> below is probably lifetime without parole in the RT land but I believe
> it gets close to the scenario described by Valentin:
> 
> (Based on v6.15-rc1; I haven't yet tested this with Aaron's series yet)

I tried this with Aaron's series [1] and I did not run into any rcu
stalls yet. following are dmesg logs:

     [  122.853909] sched_cfs_period_timer: Started on CPU248
     [  122.853912] sched_cfs_period_timer: Finished on CPU248
     [  123.726232] dumb_ways_to_die: Started on CPU248 with 50000000 loops
     [  123.726574] dumb_ways_to_die: Queuing timer on CPU248
     [  123.726577] dumb_ways_to_die: Waking up RT kthread on CPU248
     [  125.768969] RT kthread: Started on CPU248
     [  125.769050] deadlock_timer: Started on CPU248

     # Fair task runs, drops rwlock, is preempted

     [  126.666709] RT kthread: Finished on CPU248

     # RT kthread finishes

     [  126.666737] deadlock_timer: Finished on CPU248

     # ktimerd function finishes and unblocks replenish

     [  126.666740] sched_cfs_period_timer: Started on CPU248
     [  126.666741] sched_cfs_period_timer: Finished on CPU248

     # cfs task runs prctl() to completion and is throttled

     [  126.666762] dumb_ways_to_die: Finished on CPU248 with 50000000 loops

     # cfs_bandwidth continues to catch up on slack accumulated

     [  126.851820] sched_cfs_period_timer: Started on CPU248
     [  126.851825] sched_cfs_period_timer: Finished on CPU248

[1] https://lore.kernel.org/all/20250409120746.635476-1-ziqianlu@bytedance.com/

-- 
Thanks and Regards,
Prateek


