Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBB8221D85;
	Wed, 21 May 2025 15:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747841715; cv=fail; b=Jv+yrE5YSsVeB4YZ4d7YGCXri8ByJiCZCVkAPCX4T9pugI+kLGsxOUygMhsJt+HKdO0sZTemq8dUPQljC8n2FtaPJnwA8jZG6tlLz6lHisAczPtlXMp92MN7K/A+pb8JCBHso+9cUPguJd6AD+lkPW1ujeGuivh/udsAenMdsnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747841715; c=relaxed/simple;
	bh=AxR1XkOBIbmz7hvjYSsVqg1IxpxyObZDi/w7hK4MnM8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pt897pv7JRVh54KaIXFX/Kwgbldz2UmhyY5R9y7lB3wbSoPfAvPXJ9eE7lsEYWbEzriDBStmbo2rE6r3WXKO0Jg7Nf/aCrpH+XnZ6l9XcxjH2sgUzV87iwRv/8sa0y0SnruNw0NJSCkaO2rpHhaDFrLoQSwBZwb4s45erFrlC5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ggG1O8TI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=elrMXsmi; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ggG1O8TI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="elrMXsmi"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LFUQRp020618;
	Wed, 21 May 2025 15:33:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=AxR1XkOBIbmz7hvjYSsVqg1IxpxyObZDi/w7hK4MnM8=; b=
	ggG1O8TIy0NACVJTmq/yeQ0J9t0zq8lYAVk4wMcrfW4Ni2zTJnXbcE+SRtKGDuKM
	4RkJmLS/SJw6EoXzyvBYRUXCfu78l0mrr0zecfmesp9houOJGPkhCMZFLpgY2cSZ
	GWZME8lUspEZ9P/p1v4XcemsT/RwdEDcDiU2CZ8k8G1xTXPB3zhLJCwZZWHmV4+5
	EeOL8WSuQcdRzRZDJ/15k18pPPK2iYAQN5BK7Lrju9aHn0n8twvVJJfeQsGQC3X/
	6BnktBIZ+3Xv4eVGISqZZv+sRW4sC3eYnu8xW02vdf6VFNW9QAQ++yzBimQY5dmP
	pWNtlTUl/P+hrYT81+KMrA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46shb9g0wv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 15:33:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54LE479Z001766;
	Wed, 21 May 2025 15:33:25 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46rwesh0f3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 15:33:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gddatTGPBHw8kC5US/dczNO5+oDzjuYhJzmZPexe+YciJqT2UxNu0XsN8hGSbb1plHa7XA3dU52USS5WMUJaVNLerYOXoN9QS3J55x691Z2UcJEQSalrFANR05+iMtqX1FuO1Kt/HI8jdbBf0tL0GEheN5XOpjG8AalL2xFHBg8awtCLgQauBeVOj7+GVYSbfxjmFpVYYHAeUiGkzyvZZvs7ShJE/5ThNRLgh1iwh0SGoxRvecnN2LO+3XtIJ9UUycaEeXO4DIBdD30i9S/YHLzVM44L7gmaNlOWdrRJ9EnEwFZ4yFlErWwTsTtsrOhJKDrdVLMei2edOYaMq2einQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AxR1XkOBIbmz7hvjYSsVqg1IxpxyObZDi/w7hK4MnM8=;
 b=T/PNHkc71OV7Ed7g9YvD+Jj7inR8tg7jA97xND+2OeqSUYB8HXGroHWgbxLJ8524qbBqCu94i1EAkjJMiLbxQH0uDOs2Nt1hxJunQ0UYVQP/i1CLMswy155NOuhe/IVfn4W3bpQv4CX/0F/p+T69Hcgri00f9iYIyh/Tdyhd0YkBlWGUP73Wq8NAUJqFgeqYy4pWFl7VkauO/6vQkP+L41SnJE4oeGG0n0tHPGcadG4yQiLkaSJhm+G5S6BwjwqzgsFBVHARQOADCJsT84QtjJOmS1OH41c/YLrPGQLv67Xi8AcPhUwRAwqVWF3g0ZmxC7J6hr5LrAdSz8fkg22vXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxR1XkOBIbmz7hvjYSsVqg1IxpxyObZDi/w7hK4MnM8=;
 b=elrMXsmiX6vWRwLGl7ay0YFdeF470YWKcPFQF+GMMvvRaoo9SxcrTEXiACHMlvWJ5ZP2xtcnPh8I4yXDmr5XESa62ZMxxuuB8fq+O1whxGpyOoJ3Ec/oao0o/Fcds1f9Nh9buCqaTspCC34cIMDi9m3xK1dEHFi1jX7K0Ciu19M=
Received: from IA1PR10MB5994.namprd10.prod.outlook.com (2603:10b6:208:3ee::18)
 by DS0PR10MB7456.namprd10.prod.outlook.com (2603:10b6:8:160::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 15:33:01 +0000
Received: from IA1PR10MB5994.namprd10.prod.outlook.com
 ([fe80::f2ab:1ccf:7941:1757]) by IA1PR10MB5994.namprd10.prod.outlook.com
 ([fe80::f2ab:1ccf:7941:1757%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 15:33:01 +0000
Message-ID: <a009e3dc-6c68-4dba-8eec-4d0e9be195f4@oracle.com>
Date: Wed, 21 May 2025 11:32:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: [PATCH 5.15-rt] printk: ignore consoles without
 write() callback
To: Krishanth Jagaduri <krishanth.jagaduri@sony.com>
Cc: John Ogness <john.ogness@linutronix.de>,
        Clark Williams <williams@redhat.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Michael Thalmeier <michael.thalmeier@hale.at>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Kento.A.Kobayashi@sony.com, Daniel.Palmer@sony.com
References: <87zg9d99mp.fsf@jogness.linutronix.de>
 <20250423-singing-bat-60c6f6@krishanthj>
 <ac016cdd-f1c7-46bc-bd27-0248b5dd6123@oracle.com>
 <20250521-platinum-mustang-ed54bb@krishanthj>
Content-Language: en-US, en-AG
From: Joseph Salisbury <joseph.salisbury@oracle.com>
In-Reply-To: <20250521-platinum-mustang-ed54bb@krishanthj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0320.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::19) To IA1PR10MB5994.namprd10.prod.outlook.com
 (2603:10b6:208:3ee::18)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB5994:EE_|DS0PR10MB7456:EE_
X-MS-Office365-Filtering-Correlation-Id: 45def5e0-cfcf-46b6-c50b-08dd987cc545
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SzdQUVluTmd0OU9LbU43eGhza2NWWTFmQldVc3RnNlFhWFlFTGh0WFVvUGs1?=
 =?utf-8?B?c2puU3NqUVlSLzJmS3ZkODd4V2FlSjBwZ0ZaeWNweFZsRk9pVi84UXZSTXln?=
 =?utf-8?B?dGg4UmcrdzNKbjMwUWNkNm9tRXRpN1BIeGVlR2NjdnFsTThCMnBxOUxUSllG?=
 =?utf-8?B?b0ZPS0JmdlZybnM0aUkxUUFHSFRoNXVnaGRZNXVYS045ZFNkd00xLzdIMjhF?=
 =?utf-8?B?cG1MUWdNOGFsanBNb3dhRTRrdG1HUXkxeEFsemIrUzB4Rm1kK3VZbXJvZnpC?=
 =?utf-8?B?RFBTL012N1lxbThJU1YwaG9PaTdRc0V4eExCM3FPUjlIQXFYL2xId1liRGxp?=
 =?utf-8?B?Tm5oZVhabGM5eVBJS0xDTVYxK24yTC81ZFcyUUZ5c2ZkTGh2TG9PVkVIcTZY?=
 =?utf-8?B?bmdCUmpDZXZQZ3dCQkM5NEMrMkUvdU5TR2owTGR5eGRuZWVFMUNBWmsrUnJo?=
 =?utf-8?B?eU9qcjVtb2Z2NDBSTXZ4SlJ0L25ic0QyMzRtQVNaQWNjNjBCZDJwLzExRU1P?=
 =?utf-8?B?VCttbXA3cTZ5aitxR2paUTgxYVU4TEFFN3ppTVdvbFlremVDSFEwRVN0eU9u?=
 =?utf-8?B?bDU1Zkk0S0M1QWVZY1JDOG1wSXlmRVVTNWYxNlRSai8vbVJabzBXZ3VrYmVK?=
 =?utf-8?B?RkFtSldKelJCNU1pTEdYbW4yM1NhNENZdllTeXpqNU9MK1JJeFBpckZncWV1?=
 =?utf-8?B?VVMyZ3ZPQ3lBb0IyaWQyMHdMbkdKVm1YVEQ2ajBXaXFLMEJDeVA3aXhRUkEx?=
 =?utf-8?B?bkFvMjhaMC9IQW4rbFVLOFNnaEZ1R3RXeDd0ZlJxbUlib0VuT2l0aStKYWVU?=
 =?utf-8?B?R3pyb1hHNWNJNE5PZTU2WTdoVnhDWFBoZWx1YnVOY3p1TTZnRTZ5TkdFanJX?=
 =?utf-8?B?aTFuREcwOU16VzFHUjA4aWJVSjJVYlVwK2ZlUTRCeUV6UnNKT1pvMWdGMGdt?=
 =?utf-8?B?MjExbHQ0UFVZTE1hL1hmWFp3SnNIVWU5eXRQaE84anB1bHZNTTVJTml5QnZJ?=
 =?utf-8?B?TEc0L3RVUFhqY2hOcjdRVExld2hDRmx2Y2xCa1FFUDF4ZWREQjhqWFg2SVRO?=
 =?utf-8?B?VTNPQTRXYVovYXhNS0NNRFl0dmZjeDdrVEk2dXQzRnovTXExZjJQR05kcXRW?=
 =?utf-8?B?WFNNN2tuMHZkcmFrUzRaSlJMTDRSQ2UvNGRFbTlsa3JoaWNEcGdPZmZEM1dQ?=
 =?utf-8?B?bGNveEV6L3NQcG5iZUpuK1Bnbk55d2t3eU5WRTR2VFBoVDFyd1VqSmdNK1c4?=
 =?utf-8?B?TDFDdEU4ZHBYS011empWT09RZU4rTGpsZFBKOHcwdktBQzVFN3V1S2dLMklM?=
 =?utf-8?B?RjBwYjRSdVdNZ2JmQmFTUTlNZk15cTNXd3pTSktsZ3ExMFdCUzVVdEk4WEl0?=
 =?utf-8?B?YjUwU3F5MFJsRlRIU2VYQUthRFVsVk5aanlLUmVJelF6bW91dmFCN2psUzZR?=
 =?utf-8?B?U1k1NjQ2d1ROOVdweS9qYjl6WUxhSFovOVdwMFhHM1U4TGJ4clFDVDhLemNw?=
 =?utf-8?B?Q1ZzQTVXLzZCUHA5dXFyRVR3eVdJYStER3dlaWxPUDgvekdSdVU1NEVpZFk1?=
 =?utf-8?B?eWorZ0g2a2lxeENKSlVtanBYRDdvZ1pZWXNKcm5EbW1jT3BMSXR2Q3U5bVpS?=
 =?utf-8?B?T2YyS1FiNUNjcHdyMGJzYytja20wMHRkczBoOVNVak01d2g4MFl1M1U1TDZF?=
 =?utf-8?B?RWE3cUJRN0h4aGhRZzIwV2xNQjVYSmJKeXdCRVlVVHR4cUJGQzFicGVHZ3pE?=
 =?utf-8?B?MmQydlhPdkFjaEt5TlhwZ0xKaTlhSHF2TDhkTDFmTlV4NUIweEZyUGcwcWRJ?=
 =?utf-8?B?QW4zNHozdDk4U2F4NG1EUTE4VlpvZTBJRUhtbkQxalJFTFFZNVV2OGRFelpM?=
 =?utf-8?B?bWlvSW9NcWlINURSdjhNSWk2dDY4S3NzS1BHZTFzVmo1RUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB5994.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkVIU0RldGNtVHFRa1RpT01ZUjdQeHJ3bTk5d20yVkdBR0puM1hzYjVNK1l0?=
 =?utf-8?B?c2V3VGJjNkVzdEU5MzZ3YVVlYUJZMERqWFplS3MrcEJudVZDSDQxYTYvZkJE?=
 =?utf-8?B?dkkrNlZjbVpQSG9TTzJFRGoyTUJ0VVIzMGhaQUlyWHZGZTg1SFFqRFNETmY5?=
 =?utf-8?B?WVdMbTgzMDA3amg3OHVURG1CNUMzSzlvVUdRWjY3YWVlN2dKNTQ5blVCc0Fu?=
 =?utf-8?B?V05mdm5wOHRrT08reEpDZjhhYlJQNnNtQy9SZ2FaanF0ZE5OL2JGR3FxcUFv?=
 =?utf-8?B?ZWJzNzBUUzJ1N01IZnl0ZmJsdGFMOVdneWJWMnFrRUpuaVVCYjFUZHVNdkR4?=
 =?utf-8?B?YkJWZW9KTkZ5K0pvTW5NRzQzcDBGVlhMcWhNK3FORXJhVXNKck5ySEVrdGFL?=
 =?utf-8?B?RFVwNlZtenQrWFBCdzVnS2tlK0JDdUs0SkRGN3pTdmNGMnJ3RUp3MU0wSlk1?=
 =?utf-8?B?NjVwSE0yUU9JalNlWTQ4RTU1K1dwZXM1bWIxRE0yT1lLUUJNNUh2RzJOSmc4?=
 =?utf-8?B?VXBOYWJmSlhUbkYvR3VYcEZVaDNScFExNVhiL3BMdXdKVHU3M2FCVnhoZDYr?=
 =?utf-8?B?OUhVSHRJL1Vyb1k2WDhFa3EwZUJNc3dpYk81aVRkdzFhWnBEMVFOREVJY3JP?=
 =?utf-8?B?bmVvRFRXWHpic00zMmtvc0t6S0NMUGtYbTZONWIza3AwWmdQNDdidGFuZ3A0?=
 =?utf-8?B?dEhlQkhBbi81WVNJV2lzeGdURUl6SnRKYVBZeWQrUHF1cnlra3dsSkNUMGta?=
 =?utf-8?B?STMwNWJCMFo5NExkTkVYK2dtTHhKek9ISTJrUElHdkdzZmloNkZNeXd2U1NZ?=
 =?utf-8?B?TTZ2cER6bC9iWDJLek9BTExCQW84VGV1eTRyWGljTmlqc2piV1FoZUg0Y3pF?=
 =?utf-8?B?Y0cyK3RybkU4NXpxL3JuSmNLd3RUcWJRWmlBRkZPY3ZjUDlHTDNDSGV6bFVJ?=
 =?utf-8?B?K2lubDljUk0wTFNvSVpURzJBOTI3aFNKN2lQOGdDbUlYYVBna1IvT05aeGlU?=
 =?utf-8?B?MkhNajg3U2hWVUhjYTZhaHFBQWlpNnpFKzRpTHJSUXdDbUl0VkdEM2ZabS9P?=
 =?utf-8?B?akJUYU9Qd2lCTi9aWFJQbmlOdUJzOVNVSHo4aWFqUURRbHBrSjFRcTRlbmdG?=
 =?utf-8?B?cEJDVUZJVGdUK3MxbUJ4dWJEdWZ4QnZSQ2tyRGhrN0cvQ2hKQmhaK09uN3Z1?=
 =?utf-8?B?eWI0bGlpMCt2QlJvZldmdXE4eDZoMk1telRvWmVDdW4za2dMN2xuVFRIc2lr?=
 =?utf-8?B?OGhyUTRSdExtMVdDM0tlWHdjaDVZdmtlbEVWZys3WlVRMmRpYTlBeG1aQXpL?=
 =?utf-8?B?YnNCQUd1OEFLbk5NTU1nZFBzaGVmN3lKcitSeFNwalI1QWhjaFUzZVJpZU85?=
 =?utf-8?B?SzNjVGhxN0RjbWRiOFBiRUJMZ2NET3VPSHdRT3VDL0R3Z1ZxZWZ1WW1Jb2Ew?=
 =?utf-8?B?ZlltbDljdlYxbmRXdDBvUklPZlNOWWUwMGxiWTVPQU95aGVGR3IvcFlYRk9z?=
 =?utf-8?B?VGRFdmVrNDllblVjREllempMTDBIbFVLVW1YYXNDOXp6MDZuK3RobUxDSmpi?=
 =?utf-8?B?TGI5b2I1NEFLdEllbzd5aWNkKy9CL3dRUVg1TWc2RmYzT3JVNWJsMDF0OHkv?=
 =?utf-8?B?b1FyQ2NJU3dkc2g3TU5aYWJSMEQyY0lwYTVvVnZaLzJ3dlRmV2NjRkl2QWpu?=
 =?utf-8?B?bjYyTVUvQS8rdk02K1FFbm5SOFdRakM4VERXTzRjNmVNWDl0eGRqV2tWYkMz?=
 =?utf-8?B?NDFyRUFwQXNhWEdMa0xKZTN4U1g3dVRMeWN2bGFvQkVWNkgwVDF4VzVNYldW?=
 =?utf-8?B?MHpYd0h2WFFPSGJENzV4Mkh3QWIrdEYwc21jNG95cGg0bUJGQmVyaG1PQzF5?=
 =?utf-8?B?OWJMNlZucjlNSThhKzU5eGlZdXgyOGY5eEhqaGdQM29SRmEvVEd4Q0k0Q2dJ?=
 =?utf-8?B?c0MzWjB5cFpXVU5rMWJLS1pXc2o4ZExyYjZPWFl3aS9aRXNOcEF5MTZ0eXdx?=
 =?utf-8?B?bHlGWURSN0dnNHVtNGRKOUlCY01tZERVYUFRSXZBQ0IwY3hKVU5maXcxWVdF?=
 =?utf-8?B?WVRHN0FqRG1QQy9Oa1VoenNyRWVwSnhLamo1OU9hdEpTdmhFNTdTTnVwMEgx?=
 =?utf-8?B?cUoxY1pnVGV3UGZ2RkF3WXYvZFVnLzhxUUNscUFyN1dVZzV3MGNzWVd6OGZS?=
 =?utf-8?B?ZUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	An/zHign4hxfkxn5efLF2Cjjzt2PlBCJZYhdM2NGOimYn3DDZUXfo3wDbwnVHBmRAo42coP5j6JiWCnIIB8NdXOu7iP9bAaEHkl0vkat8SMjNWHwjjuHgUQd2JTVKey+8gULEc7+mDEyH8E/b4j8YSNGY2/kZK/uQ4ZWOf+HP6S0UFzMdht/+uAdTmZI10LQvjflBtbtLHg9bAq84qKAkLJXZXVDpwilLgMCf2kYcxWoALROg8rmzAtmWn291HtilkthmpNd62BbLawnCribbQvVfZULJGwVtYl4CLk6GizcSb9MAiZRuQYEgok38NJwjSaOatUw5UGdbJEuNP8smdZryBUy2oOh47PJ6OXZDxsYVCSmadSaH2mSWCM4KwlJSyjnWdIH1Dcm771RtDtkv1zg0DkD/TsMPt3Q9i0dTHVsqULONhzERwAYfLkMVJPZpsQ41/DhwoNh5rsLP63yBWA9lE1ZPYTRaLQzGw4nkIMh8kQC4OQOoXkKI55UElNU90sQHHwzDgi6M2ei1ux0Qv4RH0+nMvP7YPVpDk1GDX1Vh6W+C8yDVju2s6ntpoDbLsFtTfJcxPqDBiPKh52risGtqRsZAbEV0YZ0GFs07po=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45def5e0-cfcf-46b6-c50b-08dd987cc545
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB5994.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 15:33:01.1823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7aL6bCGbv5aCjnJxPgvid1D402wiHgbT1wuQNfjzFaxZDjepxIWV7pC1J1rl20WfDwNrgkIB6KGmjO1nOWV3wsFqdgtkDtT5t5zJqJpe27s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7456
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_04,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505210152
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDE1MiBTYWx0ZWRfX28W/pNDQMq0b IQFI1FN9m4uM+5cruAS9J9U/U2pwgoH1ZmOIcigEm2cCTtpJIRKvMw7Lg04BNpUISZU8hW9m2CE F6wcwxhNHRa8r/C5V9YK+3DECvNcIsPK5P6Wid4nYauBssbw93Os4EEwcewQpXsF8KnPewA1BeY
 tcZVenWXkpb3PcoObbhNcEvHAQmPG9Poa93+pAlG6ntXu8HjFX+V+FmF/Qwe0QjMblNcEiR5mnv 1vjnoXpfRRPTxrup/LGgZv/gxySYn2b2Awf0h1e/dkDh0qr1P3z+XHwv2ZXvEkbpbpeKOSBS28J FQ7rGWIUNIFdq0NLRdgsJ2nifgavjgEPyaESepg2jXteCLhakcEtJrAm9lQZNnN3G6vpxc9RZwc
 feVtjvEmVS5bFwNcg5QZHzJnzvNrbXqJ4jfBX2AtPSFTc5WNKFOkZ+xAJrg1NxX+Zpytnh8h
X-Proofpoint-GUID: MXdaKYigiS9PTfvB1jCVwsvLv32CWT6a
X-Proofpoint-ORIG-GUID: MXdaKYigiS9PTfvB1jCVwsvLv32CWT6a
X-Authority-Analysis: v=2.4 cv=W8g4VQWk c=1 sm=1 tr=0 ts=682df246 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=1uIZsu1OEERXhkW-lTYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10



On 5/21/25 08:30, Krishanth Jagaduri wrote:
> On Mon, Apr 28, 2025 at 10:45:08AM -0400, Joseph Salisbury wrote:
>> Hi Krishanth,
>>
>> Thanks for pointing this out.  I will investigate including this patch in
>> the next v5.15 patch set, which should be released this week.
>>
>> Thanks,
>>
>> Joe
> Thank you for including this patch in v5.15.183-rt85.
>
> Best regards,
> Krishanth
Not a problem, Krishanth! Just let me know if you run into any issues.

Thanks,

Joe

