Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E39E1C3025;
	Mon,  4 Nov 2024 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730740229; cv=fail; b=S6MKioyHCmC61SB3J2UFIpXUC6V4ae5GNAaSp5shp/wwXGlzczFmEwR/ZDUSbmgRuJ9uV1TNTufb+QzP9UloBagVmo1rFe5/SpnS8Uc66fVeMdZhU1pxXh4nPTSyKarvKdtILDZoWe0m6IPMDAskDKN/6nNZMKeMhx2prp2IxNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730740229; c=relaxed/simple;
	bh=G2hzh7Cq1JsPg/U1zExpjbK4pUnAqPc1I5HjWoG2oqk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LbO2u4htxLg+GT4dD3IDxx5FfMIhxFZSVBZEo6hXb1MYsYfxr+LO14ojs3WAPRiw/ohMXpR8r8bysVrk14Q/9NKxg+ilYc0rHsxcRQ5o4iDs2/GiCV1QbMbpYjXFUUq1Hy3bkvVw4uZ9ZL9RS6u1ySHspVBTe3YEZubAh8lyskc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mxuiGyRD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AOLXd2tp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mxuiGyRD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AOLXd2tp"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4GMddv015638;
	Mon, 4 Nov 2024 17:10:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=i5w6Q32hkVgkeqrQ4rAiChv0Bsn2I8LyufLBDRUrycY=; b=
	mxuiGyRDAt828qPLhj8HxQvnX/u7XTL2TBZKni4pIbNBQY8vp8JGnpnjwqdNyZtU
	LHWiyHCkFDUzkQQfpMq+BzB/R5Ma3kzpJ42nEK7dYTFGEEqTXkpXqX7vpddhI9nY
	/rGVcWRbm2qRaBAB5MLnQeEDqkXAjLhpaQq1Df/vA9hMpo9vEO+T/Z5NDzaxkZe6
	Ot/RHcN5fKBLUIgnXi2AswcZiWy/cPBt2T5VM4zYIxqsVHovxjjGw63IObeL01VD
	SW55GkmCy1gLTGdThUWWt4n0fQKpFb7bITHDo7X7dbBDU6tmSNvRM6gYPDtOM5tN
	bzvQHlnKtzWqFY+AAHpJmg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nby8u8qx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Nov 2024 17:10:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4GvHbu009744;
	Mon, 4 Nov 2024 17:10:13 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42nahcar6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Nov 2024 17:10:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymkz7MQ9ckY0xvuhdqe3B7RC/crsDDjYBWAPaIT7K4GBWmAXNopiDR1asjVhuLCSElEUT6VvIjLjqcuACuOmgVTSY6TJztCkIS3SxIQttvw5wHfp3SLSfOWdhIr6lXe7yz5EDwUTvbfoA7/RPnOPAYkgvSew15DmzQpinXVnKjwt9ORt3FH4w1XA/YlbwhIBP2iuGYz7r+pwaI8sm2b4yA8OVE5WOZXg1SeJiV3x1v7yQXuyDhO1Lmslm3cQ8v66Kx3GfFcqOZdUXGQXZb2/9KjursudTTa2A8WCZ+SyPpWhPIvrFyDj9quKKvQ4Us9wd8F+Fm8Gh4E5PbP6zm6u2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5w6Q32hkVgkeqrQ4rAiChv0Bsn2I8LyufLBDRUrycY=;
 b=ZmXVqjGweOb+sgGV1wdcC91OPpIgvQiNir1bnvfxtpz7xK0TH2oQX4GvwSBAX+5z6zlnU4Pf/VGUs8ZZvIrKvTLKhPMGgG3kAvSmcYmpFiFY6SN/5vSvRgEVCvXAq1KCxVAVrpCp0v6GUsn4JV9MYpkxeJ/rX8mOv0SZIb9wEr/gkZ9Bcw8YRyjPBbfP+02/aI5WKznaxto3Mq/6TqNvk+6AgLFdDnwHajLclrFqblQekvJDz4iSlxDmUGKDRIGEyQCyIwfcROjeTCgI/zDBFOzL7GncIeW/RIZ7MotQENA/tlQXCS76hZMCLJGDstyx6Y09kkaGRPSNF1K3/Hptwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5w6Q32hkVgkeqrQ4rAiChv0Bsn2I8LyufLBDRUrycY=;
 b=AOLXd2tpthuYpthG4bUn7W2eiblshGLhzw89ea0GGFEmc3KEqTGnjoAX50177W7HVm9DIXQtnlVCrnq/l110xShFbM5BdDfCciyVwjUMqMCZ//WnZNAdArLzNrn2b2yhpVybj7luAh800sxXyvpqv1v6sbft4Wvd/g+sF6MIrfc=
Received: from DM6PR10MB3881.namprd10.prod.outlook.com (2603:10b6:5:1fe::23)
 by IA1PR10MB6879.namprd10.prod.outlook.com (2603:10b6:208:421::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.26; Mon, 4 Nov
 2024 17:10:09 +0000
Received: from DM6PR10MB3881.namprd10.prod.outlook.com
 ([fe80::9c40:1c28:9d29:6d9c]) by DM6PR10MB3881.namprd10.prod.outlook.com
 ([fe80::9c40:1c28:9d29:6d9c%4]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 17:10:09 +0000
Message-ID: <d370e7e6-9b33-4901-b49b-699e1932dc49@oracle.com>
Date: Mon, 4 Nov 2024 12:10:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: Linux 5.15-rt still misses commit "NFSD: Fix
 NFSv4's PUTPUBFH operation"
To: Cedric Blancher <cedric.blancher@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Joseph Salisbury <jsalisbury@kernel.org>,
        Dan Shelton <dan.f.shelton@gmail.com>,
        Martin Wege
 <martin.l.wege@gmail.com>, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
References: <CALXu0Udop9Qx_N8KwScmGk+j3NrfDry1r-Fk=5bc+9EXsfnB=w@mail.gmail.com>
 <20241104132412.dFx8w7ZH@linutronix.de>
 <6aadadc1-63f3-4300-9ceb-0475e0203ea7@oracle.com>
 <CALXu0UdCqYJpDGKcvZ9ZvXeUkYtVW_7thGuQy4gMjgO6uo4Rew@mail.gmail.com>
Content-Language: en-US, en-AG
From: Joseph Salisbury <joseph.salisbury@oracle.com>
In-Reply-To: <CALXu0UdCqYJpDGKcvZ9ZvXeUkYtVW_7thGuQy4gMjgO6uo4Rew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0PR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:208:530::29) To DM6PR10MB3881.namprd10.prod.outlook.com
 (2603:10b6:5:1fe::23)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3881:EE_|IA1PR10MB6879:EE_
X-MS-Office365-Filtering-Correlation-Id: 838bde7e-b903-48a3-2d87-08dcfcf38949
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0t5KzFkN3ZsUDdOYlZzTmhQNkl4cCszdnFnUzJUWlJmcUdQTEpWeUs1eVJX?=
 =?utf-8?B?emVKbVlWeG16WWloUzhYOERuOGJ5bmtCVU9mejRVSVluakFZc1FJY000N29S?=
 =?utf-8?B?UGE4UFZHZVdyeTh4eThuRTlLc0NGaE03a05FL3dDcFdRbW5aTjZHNzM0OVBI?=
 =?utf-8?B?d3VncFpvRE1wWlZFK0hwOEl3bGg5MkNjTzlTQjFnVmliUDl6OFVyZnZHUCs3?=
 =?utf-8?B?dDVlalpBLzZmekM0ekVwSGI2M3hUNGpQZlRUZEhwY3hqaGZseVNFQnlsTUUv?=
 =?utf-8?B?V25mRERNMm8wdXRUTXZjbGNKdElPcDlzRG5LRHpzZUlDZEUzN3pmSTlDeGY1?=
 =?utf-8?B?M0o3SDVSQm5LdDl2MTJRZGx3MWYzMTA3SG1pRkgvNlRkUmt4ZGZTdWcwN0dI?=
 =?utf-8?B?bEIrVU0xTkhRdzFDa1J4OCt1U2NtZ09JcUtPVEdyUmpZYVorVldRN1l6aklm?=
 =?utf-8?B?ZXRpL3dUdFRJaDBQeWl1aXZJTWRhMnFTY01jc3BHd0JMRThYK2hSZXc1b3dS?=
 =?utf-8?B?bWpiZE0xY05KaGJHWE5MMGtIUWpqdnRGdGNQVS92VnlaeHVQaEdCNTlwRHFY?=
 =?utf-8?B?aS81Rm8rNnB4cW1BcE50T1VXRDQ4SlJFa2l4R3M4ZkJVcm5GZ205ZDBGQjB0?=
 =?utf-8?B?MVFTNG1IdExlK2dONHpyYjl2a1c1NmFWVC9YTm5Vc1VTdG1UWmRaSElOd2Jq?=
 =?utf-8?B?amdDODZMWEYxVXcwWmVmTFF1Y2lMZzJCa05mV1JzOWdZdWFTYVVjaVN5bHRj?=
 =?utf-8?B?eEIvOG9UTkN2NWJTUitYbDF1NjRmam1jSXRLQ09tZERtSTJTS3NMS0dtWE5y?=
 =?utf-8?B?L3d2bksyWEQrT2FIWHJkaTkrQytMYnFhSTNYaVFLVW5rMTdJeVFZTXlMSXRh?=
 =?utf-8?B?R1RSdmxUOCtqOEl4UWtSeCtzU01DOGN2OTZtd243SjU2SlluL1R6RjhmZHBN?=
 =?utf-8?B?MW5pM3A3RVovR2NaZUJOTDYyd24vOWNZaDlzYzQzNzNMS0NITS9JaGx4THZM?=
 =?utf-8?B?TGhSRWJ5UjhhWkxvQVdwTDF5TFgxTHFhVkNPYXNIQUtpeGtodTdBYlFqeUMx?=
 =?utf-8?B?aHhsVFN5MnN6ZnptM2NZNEZ1Y2l2UC85RGlNMFFLaGpWb3luOTlOencxR1hQ?=
 =?utf-8?B?Zk1vaVFPaVdCamV6T3lOZlZCWGFsNCtJdDNCUWFCTTFHOEc1dzBPaHpBZnBm?=
 =?utf-8?B?UUZCdWo5c0lKeWpFWVdGbDRoUDRRK0NRVyt4alE0QWd3Z0dkZUZKK2FGOEll?=
 =?utf-8?B?NU9TU3RpK045VHI1N2lPOG03Nm9jQ0Z0VFBMY1JLeStSWkhkLzYvNHM2NG52?=
 =?utf-8?B?MHlmZ0ppaGF4bFZhNGFxcWVaRWlmbjYyNWRRaWZpbzdjZnI2enJaY2VCMFls?=
 =?utf-8?B?dnNRc0xBMGQyVGlrTmhad3dkVkt0blVBTTh4SGR3RHhYaml3ZWZSV1F6VEYw?=
 =?utf-8?B?M3kxVklDcUFjT2ZVYk15NTZYRzNaTlZGY0RrcTlzUTFqYkVMemNIbVhSRWpk?=
 =?utf-8?B?bkNYU3ZXbFpGMTliZXliV0x6aGxveVZ1MkVPK3BpRGp0SmlYM2F1S2dESDNF?=
 =?utf-8?B?Z0dkUVNqRlJoRHhPdktEYktGVitsdWJoZ09FcGI3emRISEUzWGNoWm5mTThy?=
 =?utf-8?B?MERveGdLS0xDQ25vWkJOa3FMbnYxMUZZRitBcStIZDc5eGQ1NWYxY3JQTzFk?=
 =?utf-8?B?MnMrOGorU2ZiVjhPUEhnMkd5R1dnd0xaZlZ0WURlY1lMQTBNRU1vdTZoVnN3?=
 =?utf-8?Q?/XO5hbUdAQO/FZ0CBNAn1dcvQ95CT8eBgcJyJBc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3881.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bCtqLzBMN3FxWDZlYUFqbGFCdVVrS2RBQ2JVOHg1SForcitmOGIraU5PRjZI?=
 =?utf-8?B?cUxKWlhJbHVMdXBIZVQ1angwU1dtQkhzUk1HM0pxam81TEEwWWtzRkNjOUl0?=
 =?utf-8?B?OHVXZ3MxWmg2M05VcEF1L1NnY3VSL0dFeUIwVDlKN3B1ZEJuVyt5OWJyMHh5?=
 =?utf-8?B?ODNMS041UWozZHI4YTF1K1IzUCtPSHNvVjVaNFYvcDdLWjNkL09nWWNlY0Ns?=
 =?utf-8?B?ZDNscTgvVkpXMGFZMm4yYTNkMkZSaXlJcnI5dUxLaHVsT0ZwamNIcHBDUDB4?=
 =?utf-8?B?ZGlpdFUwRHJPTXVLOEtFZ1U2bXVkajE1MkdkeGlBM0dBMy9aRVIycWxsYTRP?=
 =?utf-8?B?Tm9rRzRRVHR4Vm83YWJoS1NkQThic29sTGhZaUlScTJIK204bFBMTHhyZ1FZ?=
 =?utf-8?B?d1VzRXZESVZoQmZLQTVJaEMxdFZ4b2RNekF5K0dRSWxSVkNxTnp6dENsajRR?=
 =?utf-8?B?L05oS3FTcTlpT2w0ekJoRitqTGpkcWx3T0wzd3RqMTE1SXBISi9oQ1dwZ0h1?=
 =?utf-8?B?VjQ4eTlFZ3llVjl1Q2haY09OSXU1dE9tVk1QYUpMOUZ6eVJTTEpzR3hTNEpX?=
 =?utf-8?B?cGZrRkZOU0RSUXBhdG93K3BhUmlMbmFBM1Fnbms1SFBZdXIzRVloSUhBeUtQ?=
 =?utf-8?B?WEZBYUYzNVVJTVVzTWVCQ1NXclBBSDNZbTI2SWdWb2J2T2RtZXplR2p4Wlc3?=
 =?utf-8?B?RW9kV3VVMFVSbkZpQWxuZEJLZUc5d29LM2VJSTNXczlnbEdXYmtxODZadzIw?=
 =?utf-8?B?M2NQa2gwQ0FNWkhjSnRJWW5WM1ZVSmJNM25oQTdGeWhVZGsvV214Rklra0NY?=
 =?utf-8?B?eXdRbGlVMTlnK0lab25kMzRNVG9tTkVvOXU2UDhPMC8ydGYvdTRLOGhPYXNF?=
 =?utf-8?B?My9BZDZQUjVGWHQxRkx3NTZuU2h6cDVnNjlEVENkd0lWMHJIRWFELzZXemxE?=
 =?utf-8?B?bVIwd0dsV1JBUE5sdlBRQ0dCbnVlcitHbUMxQzI2dGtTL2hiWkhOeVJkZFpt?=
 =?utf-8?B?RDdyaFdXdXJnWkplVUhXc0haTEZLWXF2QzZBUDNKRCtTSHNyWHV2MDRrdHpK?=
 =?utf-8?B?SGcydWhxb0xOTy9CRXorRmJTZ3hUSTRMOUlQVisrVDZVSUR4NTd4WGtEQUpm?=
 =?utf-8?B?UFZkRU5NK21QdEQrdE53WnFJN1BGdWZnTC83KzE1SGhacXZCMWk5b0hGU1JY?=
 =?utf-8?B?UjBHRlBFL09GY2IvR1Z4Z1krRjhQd0tKUURpdWRxS3h2ZFBjcnpWc2xHZG15?=
 =?utf-8?B?RC9hUi94R2x4SFA4L2hPakNuK2s0K24xYnZub0JQSWNWZVVDREcxamJlU0Vy?=
 =?utf-8?B?RzY1Ym9YelNxNnYwZWZ4NVVnczRWd2J1VW9NbUY5WDlVYXIvZFlXYld0amw3?=
 =?utf-8?B?clhBQUFncDBoeW4zK2pubFZmWGZ3Y3kvZ01ZeTJsRjkzd21TYUkwZVdWY21W?=
 =?utf-8?B?YWQ3TWxHNTcvYmNqTjVmMmYvNjJRa3dZNG1TcHFmaGZ4NnBWOEhFUW1KOG1Q?=
 =?utf-8?B?OGlreTh3SG1ucDZuazhkKzlhMnpxa2JScG5uQTNqUDVWc3c5a0REVGRTc0tK?=
 =?utf-8?B?eDdxMGhQYUJHYk1MTUJYclUxL0ErZ0ZMQytBQ1A2dHhMSjdiNEE3TVVDdVF2?=
 =?utf-8?B?QkFpWTBvZVJSRzlQTE9WR2Z6U3NIMEhkTTdDM2tMampialNYdTljYWlaODNR?=
 =?utf-8?B?Z2xlbWFJRm5aNDAwYmg4eEJ2YStPdTJ4ajBZQUN1TEJlZXNYejA4RGttaXAz?=
 =?utf-8?B?WlZ5clMvQk9xMDdobWMvbDVwcVZEbE03eEhIaWFPRjNOZmt2MEtHUWJVVDli?=
 =?utf-8?B?MTlXNSsxZzdqbjN3RU9UZzN0ZG45UERybmNGVWQwMlYvVkRpQi9Ud3NvVHFs?=
 =?utf-8?B?MHVyUCt1QkdFekcvSGs1cW5CR3ZRTkRlTVJSUUh2OFhlc2gvU3I0OE12ZzYz?=
 =?utf-8?B?R3RnbytjbDU2YzN2cXVkOGM2ZThrUE5JUDRQSmI2dW0xNUtTUHN6RXJnQnRx?=
 =?utf-8?B?Nm5uVm5JdE5iNVgrWWNYRWViUC9GbUkwZzBMbmM2V0o2RHJaOUNZTmVzc2Q4?=
 =?utf-8?B?RDYyUk1Fek1LdXVYMjVqOFJaeTVKZGxsbjBMdjFPQVhWMTRaZTNkeUZEUDBx?=
 =?utf-8?B?WDRFclVXVVUxdndaaGlnaEIrSUlhRzJnY0RnQXU4VDR2MWErYjVETFRwelcx?=
 =?utf-8?B?Z1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3/reibwqrt184U0F+nCNyQ60/RFxM5A1o1mZ6XJZzPo53U0avonGTZqKB0DTQDCOPbcxt0jk63wuxCLh61J2BrWKRyzy+Vl20gBmjcVCYhW4Bhc3pCKXH3Paly/A5BJiqGDNmm9ZrNnJ3rgzYlqCY4Nv/luSOQUrqitR73oQfPZZTBlyta87tbRKuHw7cXqmWB7ifCwcVZ7/1aA6x2OjDmAPbm6hM5hjtSZcqwWLse77ED5Xt2VrfyNcMQ4V1kzbX9cBzHniceSMD34M6WHMfbls6/Sp1iR0ZtNp9B4fxerivApxAH0cw5SO1v/D9yTA0zyK5rHEa0y38Ua9QDwOAmUrfp00wzFQBv0Z+0Jr8XbnrBT9QswlIfdqgQSPq9fucmO1bjzkG3Bq8uWEyfQ2uBZ/mKv8AiLtm//epASh6acDS8KGtA+HqKpHJh982vXlhMtaJf/OEfLHbOBhX0nlszG1xB2HqveBvzVBvLkxiJj81Mfm8Lag3foj4x9/nBzBptApD8cvuicNRHYihQfzo7hnWVvTu5gHWmVYqslJROgB0+LQr7zCTolUbiNgcXownbXz9t/ZUPUSZxc9mjK6BPSGPiUOV48e6SR6hNCcJ44=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 838bde7e-b903-48a3-2d87-08dcfcf38949
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3881.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 17:10:09.2283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FbbWk932IEojHHMNpZrZ9evxDfvgtrBEBiR6IffZy6VslbIp8h0BjqqXmw/UZMGtsYhy7w5d7bgKL5Qy9JZjl2pQe40h4orMle7BBRwUNpk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6879
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-04_15,2024-11-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411040143
X-Proofpoint-ORIG-GUID: 4IslMThjCzRvmm3aY0SFhEW4v6JoCgY5
X-Proofpoint-GUID: 4IslMThjCzRvmm3aY0SFhEW4v6JoCgY5




On 11/4/24 09:06, Cedric Blancher wrote:
> On Mon, 4 Nov 2024 at 14:53, Joseph Salisbury
> <joseph.salisbury@oracle.com> wrote:
>>
>>
>>
>> On 11/4/24 08:24, Sebastian Andrzej Siewior wrote:
>>> On 2024-11-04 13:01:42 [+0100], Cedric Blancher wrote:
>>>> Good lunchtime!
>>> Hi,
>>>
>>>> Linux 5.15-rt in linux-stable-rt.git still misses commit "NFSD: Fix
>>>> NFSv4's PUTPUBFH operation":
>>>> Title: "NFSD: Fix NFSv4's PUTPUBFH operation"
>>>> commit 202f39039a11402dcbcd5fece8d9fa6be83f49ae upstream.
>>>>
>>>> Could you please add this missing commit to the 5.15-RT branch in
>>>> linux-stable-rt.git? Thank you!
>>>>
>>>> References:
>>>> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v5.15.170&id=2f8f226f4d56fae0fabec23cf0af82c43cb4dce0__;!!ACWV5N9M2RV99hQ!J_i5oEOgM6dLLOAkgjiM9ncalWBDCr_5-CaHZBZI8r2RU3TtvlTNnrOBlTBiS6Z0M3ETfv4emw1N632COpow2bNbsDE$
>>> The v5.15-RT series is based on v5.15.167. The 170 minor release is from
>>> 2024-11-01. The commit will be picked as part of the update to 170.
>>>
>>> There is v5.15.167-rt80-rc1 is preparation, I guess 170 will be next.
>> What Sebastian says is correct. v5.15.167-rc80-rc1 is out for testing.
>> This version has a release candidate, since it introduces a new patch:
>> 4a1d3acd6ea8 ("netfilter: nft_counter: Use u64_stats_t for statistic.").
>>
>> Version v5.15.167-rc80 should be released the end of this week.
>> Currently v5.15.170 is the latest stable release.  I should be releasing
>> v5.15.170-rc81 next week (Or whichever is the latest stable release is,
>> if a newer than 170 one comes out prior to my release).
>>
> Could you please just manually pull this patch in?
We generally don't create releases for individual patches that come in 
via stable releases.

If you need this patch due to a time constraint, I can release 
v5.15.170-rc81, which includes this patch, immediately following 
v5.15.167-rt80. That would be towards the end of the week to ensure 
proper testing and allowing for feedback of v5.15.167-rt80-rc1.

>
> Ced

