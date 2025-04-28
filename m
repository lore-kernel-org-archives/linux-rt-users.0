Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3463126FDBB;
	Mon, 28 Apr 2025 14:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745851540; cv=fail; b=XSXRJXMGWaQ798q6LZPfOwJvSJCPRh2RnwcsYyZEbq/Sfz0OwL+dJuEWYQBkmis0cz/8o48fIxw+n/sE/jDoBnchZvzb+95kcX8aqoaAwOnQ22m/StO6fysNh5L55LfCX09zTtQvDav+U74FRwrHeL4gUvCT+GexCaqu8UURTPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745851540; c=relaxed/simple;
	bh=laq63BMBAntvbptQ+J+5+RFqolShx5sj2FU3qqm2Sxo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uQl3nBN9CIZt8/Xe86MhcI8zO1/HEz8JqKZ1wlM+aU+8GkgcqqoYg446V1lrWUDo5Eyt0A2neSrMLy6VAQAGAydZCSlApyE1nhbTzWEAEvITWoiIM1f8ZUfXAePTK9/ru8HeevREKJcbJNq0AV38FkhGkBUyeDEuqsBS+S2YzIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mcL1T5EB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gcqnq7Pc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mcL1T5EB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gcqnq7Pc"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SD4btu012879;
	Mon, 28 Apr 2025 14:45:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ikB+aLw09fKx85GJy5tz527SFtzrtCU5/e52NiwZfUY=; b=
	mcL1T5EBxJ9g6PsYq8YOy0CLMcuiLm3+lM+IPkUyRzigOHPuPeJ3bS15DXKwY6T+
	OTcNQhvAB3XNoCsW1q32LBAb4AJ/WqLPSvBWTBcMBDejX0KelefO2eCGsm5Dl7PG
	GEugrwGye04JXEiwYfg+NRDdh6cWzCQhgidqTCLWVTqR0V4TyOODGcukj+q46S5i
	5fQDbyuQp5Y26gWps65uBrYUBmX+ZXAfiNp5Tdouk5fRB5S4/Pbstt4fxNsfK+Tm
	TgZZ9U3+F8tcfoOPaLKvU9MKkaAFe2xou184ZmIyZNO9mdhoJ1hQIfzYRpBd1oR7
	pXjXw7FsoCCjGrwYFoe6XA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46a9d28dg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 14:45:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53SDFeV4003837;
	Mon, 28 Apr 2025 14:45:16 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nx8hbdr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 14:45:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZYw76W6AtJ7vjtQEujAWc/2wArl358CkoVPuKpZgCwT/GMg+XssO16QbPq73c/VYJsezbl90+HjJwOn5R15fHd9dNX9x0sUEznXZaU9C8sDZmE7T0Gj/ZIARE2yq6U/G3fGXKsWxEA8NUh44R9vwHwFJj+zVc4v0Zl7CHM+re/yD42tjpj4qbkGcxGOzZbNn39sp2SYz80X+crqclL2NItLaGMLxYbKRNL7iI9ziACaKscDA0ATfYvEhLXySG0rQwoqFKghAe60UJCYep8tVy0OBUVfVI6baR0bZeDI1VlGnAUScyMUcT+GikxmdVsb2iHchZjYNK+t7lMqtgt43g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ikB+aLw09fKx85GJy5tz527SFtzrtCU5/e52NiwZfUY=;
 b=qwjos0REGhnz42U2+v/iVcfQ4WBlgu6KMR6d/62dqmKl61/7N55Bmcvhe/2BTgiGpXUD0GMQ3zdwIaiQvIK13yJbW9Zjqqt/qa7vmLP4lrdX/0lhHkH6WXH/v6WOAAO4tpdT9zML2kwOhNzpd3qMNDmN/4hGE3uw1s4LwZwCe4YfFRI+4pXuP+oaOoHCgb/4qS1YHD4f17lfgx2FrISx0yC0/9g4u/6KZYeD3hqekULROEqa1XxaLeDvxQ45n9VDaUPRu1ZWbp1pyo6q/GrHBSbT2uNc1cHBoOBEYSzDGAVAgeiCp5D00PE2Rkts2gfe2FR8LLW9AZUxyE4lFvyOew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikB+aLw09fKx85GJy5tz527SFtzrtCU5/e52NiwZfUY=;
 b=gcqnq7PcM05WxlaV66fqv4mJiIEk9vnRxBJfxKzuAU9YebRhYkzkXc8vc+mueJFHNp4D+dqIfZMg1FTdm5la3Oze1O02z7sIVvsFBKAiFDWGhZL8bMQG2Etl9ZR+2siYRMVZDYhVoPdslTIRNqWKy9EoDNucAHCZuQNPO11esQY=
Received: from IA1PR10MB5994.namprd10.prod.outlook.com (2603:10b6:208:3ee::18)
 by DM4PR10MB6789.namprd10.prod.outlook.com (2603:10b6:8:10b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 14:45:13 +0000
Received: from IA1PR10MB5994.namprd10.prod.outlook.com
 ([fe80::f2ab:1ccf:7941:1757]) by IA1PR10MB5994.namprd10.prod.outlook.com
 ([fe80::f2ab:1ccf:7941:1757%3]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 14:45:13 +0000
Message-ID: <ac016cdd-f1c7-46bc-bd27-0248b5dd6123@oracle.com>
Date: Mon, 28 Apr 2025 10:45:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: [PATCH 5.15-rt] printk: ignore consoles without
 write() callback
To: Krishanth Jagaduri <krishanth.jagaduri@sony.com>,
        John Ogness <john.ogness@linutronix.de>
Cc: Clark Williams <williams@redhat.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Michael Thalmeier <michael.thalmeier@hale.at>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Kento.A.Kobayashi@sony.com, Daniel.Palmer@sony.com
References: <87zg9d99mp.fsf@jogness.linutronix.de>
 <20250423-singing-bat-60c6f6@krishanthj>
Content-Language: en-US, en-AG
From: Joseph Salisbury <joseph.salisbury@oracle.com>
In-Reply-To: <20250423-singing-bat-60c6f6@krishanthj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0207.namprd05.prod.outlook.com
 (2603:10b6:a03:330::32) To IA1PR10MB5994.namprd10.prod.outlook.com
 (2603:10b6:208:3ee::18)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB5994:EE_|DM4PR10MB6789:EE_
X-MS-Office365-Filtering-Correlation-Id: 14085f32-88f1-4a81-ebbb-08dd86634875
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nk9HejdiaWFtYjJiY3pxMUVnOHpscndZSTBWNysxZjV5RTFyeUVxbVJTNG4x?=
 =?utf-8?B?MTM2RG1qTkZkWFQ4d3g5b2J2R21abytrL0RmWVgzL1pHYXVMa1Z0ME5WMWIr?=
 =?utf-8?B?dVAzTmMxMFd1ZFczT25sYU9KZGtmSWNKTVp1enRlZ3NhL1NmcjJaRGZkMWRX?=
 =?utf-8?B?WWg5WUxVUExXZHQwQ2RRWW9WdFdqckxlK2VjOTJ4Wm1JV1lUdnU4YXcvZXZ5?=
 =?utf-8?B?Slh5WWJvcXQzckd4VTNkVy9xeE9wdTBBQmVKZkF2UWwzbTBCT2lXSFRoeTRD?=
 =?utf-8?B?U1N3akNEQ1BLWTJuMTdmODlMZlFXdGRjYTRRSVY1WENZdlluYlcxYlgzMUV1?=
 =?utf-8?B?bS9rN1p4VCtOak9xMy9wZTdrNTIvejRUeGZ3TC85S3R6WGpMWXJJdnRBRUF2?=
 =?utf-8?B?OENldmsrWXJTT1NYYmlHZlRRcnhnZU5Tb3ZnbjdjWEZzQ0lDc1RGdnJuVkpI?=
 =?utf-8?B?OUloUDZnWEkzTFJjZm90MkJNQ1hGK3ZESktybUhDNFFnSDF1V1cybGVzS2Q1?=
 =?utf-8?B?OTlVTkF5N2gzV0dVb2poUlpLa0czclZYWXZVUGsxVzUxSThmdzBzbDBHcGNN?=
 =?utf-8?B?Q1JjMExPUGZZd01WSG1ZWmg2d0JvOHdBa3A4K3FFWjV0djZ4Ynh5WHZ6U0ZP?=
 =?utf-8?B?U2dPdFdMd3hKb3YvaURuVWgwS3RUenArV0d1MURqZkV4RmJqSHBqeGhtR2Zh?=
 =?utf-8?B?ZmZTMVZOMDd0eEJrNlc5VkZWTUlqRDRUOFFoYytieFNyNGMxQmkrbG1mVkVN?=
 =?utf-8?B?S2ZEZHNCTFRNVTgyaStVMkNkc2g3U3lmdk1CTGNQZDJKQ3pPZ3F1WjhVT2o2?=
 =?utf-8?B?S21mTmcvekMrQlRNaHUyTm5aNmk5a29LTStFcVRzaDhaditCSzBYdm82MDcy?=
 =?utf-8?B?Y2MxcmxzcG5TcWpiUEtLT3Rhb1YvU3p3VFpWZnk1MXBPNlE1ZVRtMUlXaXF0?=
 =?utf-8?B?cEFnaTB2V2l1Y3BoOUw2Vkl3cDBzamY0YS9jNVRrSkQ5dEtBQ1pWZElJOVdX?=
 =?utf-8?B?R3NDVmxnbDhwQ0haNHI0S0FpaUQ2bUhsRXNKUnF3Z1dHQWdTSVIycG5BMU5L?=
 =?utf-8?B?bFZsV2FkVjY4blRBOGt4dDVEUSt2K3l4SEFUbnMxbE53a3dsdjFtT0JrTmd6?=
 =?utf-8?B?WWJYenV5VWxPQWI2MnluaE45ZWg4UExBdEZUVVFOS20weXQxVWhCcUR5cmJD?=
 =?utf-8?B?OHR5N0orTDAzbktObCtwMU5UWUZVUWtQZzMrbXErL2JVOENiTWk5d3dYTTdu?=
 =?utf-8?B?NUtFQk5PckhkUDJNRUtZTlFUSnFRTk5HZ01UTWovVUExYTdaSjVjeENFb1JL?=
 =?utf-8?B?b244dVdDSDQyRndhVUZQalNOa1pqNU9RN3NkZ2dIYVpBMzFnNFJ2SlR4Q213?=
 =?utf-8?B?ZzdKSnBkU0NEZkV3SlFmTHV1ZnBvMWFubDVoL2hYaGVNTE5LU0VHM0VWUHZh?=
 =?utf-8?B?M1JFQUU1MVZmODJrMWliVFI0eFAzd3RoakpBdU1SQUdoRDNvUWZad0swcEpv?=
 =?utf-8?B?NEpuZFRhMlU2YUUrYWZSZlVhaDN5TmNWcEd5T0JSa0xvcWc2SytDems5VHd2?=
 =?utf-8?B?UEh2OUFPdkhScEpYQVNhWGxWNDI0d0hTMnRVbzZPbG9OTUlzZWhlUHZvY2Ri?=
 =?utf-8?B?di9Pc0EyRHkyQW9BdVQ4c3FnWHR1R3RyMjJ0RlZaTXVJekdMZjlWdXpIVTRJ?=
 =?utf-8?B?UnJtWVl2WHNJRXJQOEhDaDBUU3UzZTFMN0pCb21nSkdCamIweldLbE1VZk1J?=
 =?utf-8?B?L1hkQjVHNVFLcStrL2phRnJSM09ydzB4UXovM0xCLzh3QW40RWU2MmRBckpr?=
 =?utf-8?B?K3lRNVh6WEdLTzhZUk1XRzJhTVp2cStmYWNxK2hEbzI4TTAyZ3pjaHk2RW9S?=
 =?utf-8?B?ZjlmYTJEZFpCaDVIR2ZJcU12SzJaYWNpVXV3ZlM4M25tSUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB5994.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2g4cjJtaVBtZG9XK1NwTjhSU3RIQU1BT3pVb3NZTklIejBpSDJTMmMwVEsr?=
 =?utf-8?B?NmYrQWt1RTF5Uzk2TEFycGlVUiszRzNoRHdUcXc0TmVMUElwZjVzNzlzY1Bq?=
 =?utf-8?B?cHRJcERBNDFTNmZnbk1yQkhSNndkbnlZYXJ3OEJoemMyVDNqb3puOUViczVt?=
 =?utf-8?B?MjBPc1U3N2ZDQnYrVjZvRE1aeDV3ZjdkTXIzWHVvMGl4VDVVK1ZkN2hlb3B0?=
 =?utf-8?B?T280b2U1U0EyREl3T3NLSk00bG52S0pybkx3Y3V6ZTU0UW1qYUpqL3RINHhM?=
 =?utf-8?B?VDZzQjBNdHN2N056QnFpN1Y5NU1GblhwajloejhGN3ZPL3M1YjJ4cGo3aXFl?=
 =?utf-8?B?SFI2bFQvS1lEVTNGT0M2b2d4UXgrNUpoS0lYQWV5VlFWcVg1b2RzbGJrbjQ1?=
 =?utf-8?B?NzNxTE15OUFOekJOKzVvZlV4MGFQU2RrVnFhMy9PT1FUeit4WFpIdXZlL21w?=
 =?utf-8?B?VWFBckpyam1MODdkcVF3Z2wrSXo0bGp1NG1FMW9KbHVtVmxxQjAzbnBockFG?=
 =?utf-8?B?czVtVU5aOHdNdS9ocitrUm9lSjNSNVY3VmNLTm5RRDdhK2F4bVVjdHNaWVdO?=
 =?utf-8?B?QmtOd21WK3hlSWt2UnNWc0E1THhKNlRlZDJxZG56djA5OHpTaHlVbllUTWZw?=
 =?utf-8?B?a0xxOUdNM09aQS9wcitkWGYxb0ZMTTYxV2RRZmZ5RmplSFVjSFJ4dFR0a3R6?=
 =?utf-8?B?VVRtOWtNenNkeGR5N2JUUGdic1BkNXhDZDdBbmVyaW41UHkvYVp1MFlWT3E1?=
 =?utf-8?B?RGZRUUVQQ1NCbjM2Y01zbFZCQnN4dEN0UkROSWZNS0FQdjNRaWo1dlBSKzhh?=
 =?utf-8?B?NjBPbnpDdzczWm5JaWs1Nlh2RUJtWjZLUHdMVGVoMExoRE13WXhjMmlCSStT?=
 =?utf-8?B?V3dqWWNkOVNUOWZDckRSZjljUDd5QTFVUTU4ZzFEdWZyblVYL2h2aVRQN1JB?=
 =?utf-8?B?WlQ1MWhYYjhySDFJZVJGSGIwVzU4aW9yRWlQWjFmMnN0RFQ1M3hZUDZRaXQx?=
 =?utf-8?B?Skk2UFZXVk41WnV5WGg2TjBuQ08wQndkcG9CUTM1OElaV3JSOEtvSzZEREcz?=
 =?utf-8?B?MU1rckdjVHlPd1VjYUoxaGVHWGlYWmFOWHZvenJ5clJMUmRWaHdqUVV4Wkhh?=
 =?utf-8?B?RzEyQmFVZ3ZBb2JEU2pWL1lCd2VzSURhaDdVYWJEQXMvR2JFVkJZTXVYallI?=
 =?utf-8?B?ek4xdndhSkJ1ZVd6OHpQQmZERGJ3aFF5V1Bidjl4ZWQrTW5Sb2t1ZDNOdGV3?=
 =?utf-8?B?bUh1aU1BalB1VzJsUmMzUWU4allKYzQyTllmMUFBTEZYWStSUFdnLzVMRGpk?=
 =?utf-8?B?ZjZLT3dxaDQ5M3h0K3RrTzNiSUlNVVNSMGNnYWszaG9kR2V3NXNPY3N5cStn?=
 =?utf-8?B?SldEdXJydkJKWEtDV0s5N3VmMjdMUllINVAxY1ppQ0w1SHVnMTFrS2ZEUjBC?=
 =?utf-8?B?SjhSb255aXNTZEZERVcyL2QzZDJXa2dRQzF5WmNKOFJXakJ2dmYveHg0d3Qx?=
 =?utf-8?B?L0lEakhUYzhVTUtuWDVQZk1wdGpaUHhFd3ZCcldpYjArMXEvS2xTaUdrWU13?=
 =?utf-8?B?NkJXSGJ4WGdibkFzMlFqK1RDS0pOMzFpTXJlK0pZWTJSTkpSQlFLVnlYZXdX?=
 =?utf-8?B?S21JSVdCLzkybUR2U2VodWNCS3dmYnZZd2Jnb28rSGRHRlRVUWFvU09FNEFS?=
 =?utf-8?B?WUhZK0Y3b25rczViTWNrRTdycG9qV0tGWjB4ajBjOXM5UVZhcGZ6V3RNWWZV?=
 =?utf-8?B?VTRleDViYkE0Y2N2bnJENHh2dVdjR2ZJQVlxUWJIRWRsdHlsSGtPV1FBM09n?=
 =?utf-8?B?UUg0eXJ2bHZldExiazJGd0VwM2VNdjU5VS9ZNWI3TjhZQk5xeXFCZWQ5bkRh?=
 =?utf-8?B?M3hNSjEwbEVYdDl3NXVYQy9QU1BUVjh6V3E3R2ZPYlZJVHBrV1J2TUlqTGxu?=
 =?utf-8?B?MjhaTFp4TE9wWEwvQ0FDc2Z2b3U4U0VjS2F1VWVTWXFpK2U4SXJKcTcrZUhn?=
 =?utf-8?B?cVBKeXNlY3VzRHl5NCtqaHROenpPcFFJejZvS1pLWmhkQkRMa3ZDVkZoOWRF?=
 =?utf-8?B?NFY5dUo0MS9KUVFOcGJORmlackZKbTVldDBJcmJlejBMeHY2eVFKZFdSK3FT?=
 =?utf-8?B?QmVNZmxxM0FIb3ZMU0ZKL1BTNXJsc29Wb0pkTWFFdVFXVWNSaXBTUmx4VCsv?=
 =?utf-8?B?QUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ucDgZ0wDp7GAEbtmmgXwfe3FfSx7HMjMnMfnW3OaIgw6jS7AgZ6vE0ZEm2Nz1ZRQD5rm42h7/l7alk/6DXSyInPd3ctxRhqZP3xxw55v8K1nzl1JsU2pmlHlvs2ihHzk01bm0gODMQzsVqtNqq8cOE2ZIUWI+a7h/VfVo7dgKakviYO+GITbbxThld14ibh0ZSom9TbfozQMhaWytR2Ie818zzn3uknrZNb20qxhLKSqY8vYByYOYnWYlx/qMVOHdD+HsoNFMzRqXi5d/8/nCzGbDSDQcnvOIwhUUf74ydqkJtAF9udJhHZIGOWADyvib17ROY6AthBOQw3t5oYQDTVopc0fAD+GKOhBJhSU3Xv/BTuOMoWCQLTkAHa/3fNV2yUUo7KOhYBSSzTbBRN2GG/TrSxZMepC3Wr9R0XmkOF+LFtOpw9puu9Xe/1CukjCP9mUJKlAUzeE/UOlLV/IPvWR39RHs5uV7bEKh9LsWJD4FY2sL9ludT+Emyxluxp1dswAXfIS/8nMy0RmJhMVNKOwW0+hzUK84ISS857E/iGDn5nC+y0sfeFGsVsjsTPR+8t3grpZxY4EI4CO1/9Q0e95pawuXIFnioNte+UUOFY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14085f32-88f1-4a81-ebbb-08dd86634875
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB5994.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 14:45:13.4546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rJNNW/3tw3Wb9BQ+KLbAwk6O8TUIwUaUyZstbu1aTLuwG4GVet39hGjXwZcya6Cdzijjt1+nYNhSAJs2LKge42UyZEwir0T1Wwz2xRRbUCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6789
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=914 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504280121
X-Proofpoint-GUID: eJefG5jIdoOZLOuUNe2ezEqAKImLuP9w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDEyMSBTYWx0ZWRfX/OsoWjsnQcCC 7DaZqNp4/nIkSCRWiFSkppidx6J50XQtwdVRwn7jZZdeNNIZVfCKJAgd8/bvzQ769NxZH+Scy5G 9Auk5uC8syKOMSjnlWwA5jQiCTiXhw2wZ5+gqu7n+aMBkjUwHyS2BS1mqGemnZ+39wQfsYr0FfY
 IN9wOIp9KxRycrN4xWKP2wetl/7KWXRgptRBSNaJfhT1x4rtU/8RMGexychPFScwrQ68Vh9jqCp wX/6OhPIUS0YK09VVeqbeW+y+L7I6jzP1t8Fw8/KqGGmtY3qn7LBnaHmbTgFdOJZi9FuuZ5jJsQ XoS3tLARivKxotptq0jXVAJIIHYW+Tm/FiLeHLrcW3tLI649EYopO//x9/o7FWYPu5on6jyzk3M GsKs9Enr
X-Proofpoint-ORIG-GUID: eJefG5jIdoOZLOuUNe2ezEqAKImLuP9w



On 4/23/25 06:10, Krishanth Jagaduri wrote:
> On Thu, Feb 16, 2023 at 11:45:58AM +0106, John Ogness wrote:
>> The ttynull driver does not provide an implementation for the write()
>> callback. This leads to a NULL pointer dereference in the related
>> printing kthread, which assumes it can call that callback.
>>
>> Do not create kthreads for consoles that do not implement the write()
>> callback. Also, for pr_flush(), ignore consoles that do not implement
>> write() or write_atomic() since there is no way those consoles can
>> flush their output.
>>
>> ---
>>   This is only a problem for the PREEMPT_RT tree. Mainline does not have
>>   this problem.
> Sorry for resurrecting this old thread but we actually want this patch
> in 5.15-rt.
>
> I am not sure why this was not applied to 5.15-rt yet since it is already
> applied to 5.10-rt.
>
> Could you please consider to pick this for 5.15-rt?
>
> Best regards,
> Krishanth
Hi Krishanth,

Thanks for pointing this out.  I will investigate including this patch 
in the next v5.15 patch set, which should be released this week.

Thanks,

Joe
