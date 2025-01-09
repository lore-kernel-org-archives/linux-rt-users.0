Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2102.outbound.protection.outlook.com [40.107.22.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F4F195
	for <linux-rt-users@vger.kernel.org>; Thu,  9 Jan 2025 12:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736424277; cv=fail; b=T1/K1IIMVzaaq0qBs5b2qKl+i4eravepTweKmRSMGfaJLWiRm9FyzE7rB99dB6P3i2A9HlLC9me92d7kThySk+ji8uBTYMcqyf1aW1eDPh3mk67t9ITliKxbxZOgJ+wbh8/Hzjt+nAw1oJRUDcfe6sUldqxElRuzcfa8xyxk7io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736424277; c=relaxed/simple;
	bh=diDonDO2vob9Ij6vkTmFNlFU1Jidw0Cg5KIHvs9guDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Oj+EeGNERPgYSQLhgDejELWFIS2DywaU+jL6vv7ttH53B3+f2a7mAhS1Ecc/VtMeS8DSxd3dndf2+a+II+IqND8oCTv8lLykitZHSBOeOnZy7RpYT2gZR7S7MsxayLVzLkOD2Ezjqm11UGxzi0aJGOeiUSYhGoBWWZ5DoL3/CxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=navimatix.de; spf=pass smtp.mailfrom=navimatix.de; dkim=pass (1024-bit key) header.d=navimatix.de header.i=@navimatix.de header.b=rSWN17Nq; arc=fail smtp.client-ip=40.107.22.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=navimatix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=navimatix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=navimatix.de header.i=@navimatix.de header.b="rSWN17Nq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SRj7lVmdX/oyKU2PFitzmhhbzDheHfQstXnbHKPLsdpqa7HUJKFPCXplCs9SbO17dUL4dtSDMBherW4A8VVOjMozXVKF7D3TPzr16fOsMZnh7xlFnryOaKxn3TLz7c/5OP2UBPcTjlAQfxJMS4FVvpAWYIPR6ioZM0Gp0Eu/MLtY4tKwJXGmUuitmBXaLy94ALthUuH2vdD+OcR0K5lO1aVMO5fOsTb+idbMNTCak1udN/+uYVWDsxj+VCxe7HlJJBH8BE+sWv9d5twDvIihw1RJMf4ckGCD+A9U96YeqBAaaf5JZhiqvuqWh9bvz4st5YA5HII94EXlEE8BAtVunw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEEGd3saoznNJaCAoLROj7PmWjS8Na3xr8phgKQ1YzY=;
 b=PCtGkHH5vLKM7UQyM1nWDS/aLkq/WWlD2DWdBLTZI1W0IZIIIizUI/F3uINngDxP0sQoxOH+jJWtb61Tjs3e6G2S5AUQbNk7S3brNCsJyyWwPvSM/nZFjZVio38NMYFqIdgcec7NjSZJw2EOKhT4fKHMwntKw36JJUFiROm2IPVq4Mo09xLCmeuOChatUssLr9Q/WYNG2ByRnVZGzin1jLBJn5S2oSDaT83F698mRSN42tKkzos6aQ/bm36oJVRTu4w36GaOftk9zQSCsrYaeA9kK6O4v2wBR4DcLkchN7a/6bvcPqASngIzyTeKbmStc3M8MKWoSBKc//dPQ2v9tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=navimatix.de; dmarc=pass action=none header.from=navimatix.de;
 dkim=pass header.d=navimatix.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=navimatix.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEEGd3saoznNJaCAoLROj7PmWjS8Na3xr8phgKQ1YzY=;
 b=rSWN17NqcZn+3zAxA1EZ6tzSWDjHnWa6bIb23Ck8Jk8nsTkoFvWHNFyWD9Y81nTZ+zkAwuf1O7X0cSEvDU5PwmwvKZ19ULSR4lylsnoW/ozuBgt0N8mZrqW1YfzQdGnB6yawWSrJmSz1hwlRVFJtsHgad8dxvKCx4+T7nbXl62A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=navimatix.de;
Received: from DU2PR01MB8293.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:2d4::5) by VI1PR01MB6493.eurprd01.prod.exchangelabs.com
 (2603:10a6:800:32::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 12:04:29 +0000
Received: from DU2PR01MB8293.eurprd01.prod.exchangelabs.com
 ([fe80::d520:1b9e:a30e:69a7]) by DU2PR01MB8293.eurprd01.prod.exchangelabs.com
 ([fe80::d520:1b9e:a30e:69a7%3]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 12:04:29 +0000
Date: Thu, 9 Jan 2025 13:04:25 +0100
From: =?utf-8?B?SsO2cmc=?= Sommer <joerg.sommer@navimatix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: John Kacur <jkacur@redhat.com>, Kurt Kanzenbach <kurt@linutronix.de>, 
	Clark Williams <williams@redhat.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: rt-tests release tarball location
Message-ID: <zh2rljwmir3t4ndpgsv6na7vk7n4yes44yaxvjjeugbl6sct7b@qocgf2ikvwmz>
References: <20241228114346.6020d6b0@windsurf>
 <87h66b2c6m.fsf@kurt.kurt.home>
 <20250107141424.EoC5uS6y@linutronix.de>
 <f87b2d77-7925-8678-d0fe-9a0d471a38f1@redhat.com>
 <20250109080555.WpQmRgu0@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250109080555.WpQmRgu0@linutronix.de>
X-ClientProxiedBy: BE1P281CA0161.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:67::18) To DU2PR01MB8293.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:2d4::5)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR01MB8293:EE_|VI1PR01MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: 44960147-4361-4051-e07e-08dd30a5c4f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OHRnTzNsMll0V1lKSWZkTU1Pcmd4K1BvUE9YTEZaWWJ2dmNHd0F6UjRVb3Ru?=
 =?utf-8?B?S1V1YVUrT3l5VFdNMm1lbXZ6WDFzSGxGN3BVZURGcHhza2NaRmprUVFIblEz?=
 =?utf-8?B?ak1yK2pwcDJYOUxlS3EzMVI5WlJRZ2lqRUFjTkRNTUZtVDVON09vbkV2ZUNz?=
 =?utf-8?B?U3hEaElra3VBd2xRQ25YcWRld01mZVh0RE10VytjaHdNci9lSWpqV0V1alNt?=
 =?utf-8?B?NVlkTEtPN0FmT21takNrMkJVOThscHh0YnAybzFkT2ZiMVJUTVNweU1nMWRD?=
 =?utf-8?B?Kys5cUpoemI1ZEI4V1VYVkl1Y1gxMDVPY2tod2tqZHhmaDhJVUozTGpqVHdF?=
 =?utf-8?B?OXNycDliNFQxYlZlUUNhd1Uybk56Rm51M3lKZGt1VGpKYXlqczNSa3g1aEM5?=
 =?utf-8?B?WUdmc3BXVE5sMm5wcElTU3JWOFc4enlEQUdlV0Zkdk05YlB3WGQ0ZnZGWEJz?=
 =?utf-8?B?dWtjQThiQ0gvZjAzNytJT04rQ2pDeHhMcmRQZE1lRDQwN2xJU2xHbndlQm5C?=
 =?utf-8?B?R2FDU3R4d1hjZUp0bzJ4TDVQUm1nUHJ5WFN0RGFMNWpNdnIzZlFYamc2cTFn?=
 =?utf-8?B?ZmRpL25VVEowYmJwMnVpa09yQWtWYWZKNytMWloybnExTlJuZnBvWUNCYjdK?=
 =?utf-8?B?RlI5dGlTNmVQQklzU2RyQUFyQ0pGZ2thK2xJOGRKbkd2NXExMmluS0V1T1ZE?=
 =?utf-8?B?NXZSWDYyOEt4M2h2bnQwc3laZVRNUC8rS1dCQkpKc2l3amhsT0tUNFhXcnlp?=
 =?utf-8?B?MEp6THBaNk1Bbk9NenpLay83YmxSNjY2a243YlJXMVMrV0tubnppQTdWblR4?=
 =?utf-8?B?WmhJRzhsQmJ1M1hoSUg0Q1krOUdnQmEyK053ZktaWFozODEyTTRNZHIxVGtZ?=
 =?utf-8?B?Lzd4cTNWN2thWit0NjBLNjE4cTVKTDFwNWI4THl4cE9iUjhzMTA0VXI4V3E3?=
 =?utf-8?B?bGIvcUZ4cngweGFVcHhYeUp5UlFKUmdXUXBVL2duSFF6Q2UyVjdOazZ2a2Jw?=
 =?utf-8?B?Nm9nUmpmRHlXV2hyeG96WDZLZTRMcUU4TzczS25JWlk3dkJ4dkVMbTZSUmk0?=
 =?utf-8?B?TUE5NFF1bC9ZY1RaYkNRSlUrRU9OdHNEb2NCZ0NHUEZzcjR4NFlsSTgzVVBy?=
 =?utf-8?B?NVg0eWRXb0Zsb0N1Sm1vR3BEVTN4RVN3VTZ6ditYTlZGYzdic0ZFY2Z6Z3h6?=
 =?utf-8?B?NkhCZ1BIVWNIejJxbXAvL2pVME56eWNlWUJhWmNSUDZGVEY3a3FPUTRCVXFY?=
 =?utf-8?B?R0ludHlXQmVqZ1gxQi9nZUhOVFp6SkxCUCtLQUdJUEJnaEtyWkptYjFMN1FO?=
 =?utf-8?B?ZVpvalNaVHM4a3ZIeTV6cGoxWDBSZmpXZDNDbkwzWnZpYURvOXNNTUJtWS9v?=
 =?utf-8?B?UzRtVFh6NnpmL1JZSUhQdjNkZ2Z6WElIRkpHbjBKa1RvZHczeUFibjFQNmsv?=
 =?utf-8?B?cDBSVGwxV20vT1VVd3p3QXhLSkEyQjdETkRqTWk4bWNoNXpzY2xGaGVNdVls?=
 =?utf-8?B?UldOSEt5SVJ0aFMzeXBQc2piQTFhSTJPYnowV0pMc0xlOTRXK2xpYmd6L1Nx?=
 =?utf-8?B?SVdzQlRXSG1VcTNNM2pYS25YY09MV3pWQmlzSVRsQ0l6S2tWdDBaUDdIY1Jj?=
 =?utf-8?B?c3I4TGxVUkR4dzZSYjRVZStNSkxGaVc3UEl1TnpjUFNmTy9pZE5TS2hmdnpC?=
 =?utf-8?B?NHJDc1VZWm95YlNBb0JqZ1pLZGJ2Q2RYMGxvdXJmcEd3OUdzTlhBaVhzV0c3?=
 =?utf-8?Q?MJiuu+jmmko4Xr3dpetJ60yi4jLYqZhFe+TGiVx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR01MB8293.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VE9oS3BUTzA5U1Z0cmxCbTZOYlk1djNDSXJHM1FMNU5HeVI0ZkRlaGZFNkJh?=
 =?utf-8?B?Rm05cDFrM1Z3ems3UkJlMVZPYW1UM01pWlV3RzdBTEY3QTJocWZFb1JldWFp?=
 =?utf-8?B?WHU4OUFPNTRKMU51RDdxTnhpQXJ2T3ltNmJuc2RvVnFzZEt2OHBiWWhRc0hZ?=
 =?utf-8?B?dDVIWXhsV3ZxMzNycGtwQndsMFBoS2hzRG84cmU3ajk3aUFCc1k0YUJMd3Jx?=
 =?utf-8?B?ZTZHRHZLa28yZnhqNlhmaXM4NDloQS9oeEhNQkJQVnJOTkZEOFhxWWtFSTRu?=
 =?utf-8?B?bzZpcEZ5R0VHNjZhR3QrdlNEblJKREQvb3ZzQU1xZmtzN3lWTElIb08vK291?=
 =?utf-8?B?dXdYOUl2WGpjQkxwRDBIeERrL2xPTWo2YngzVjJvYURMSXJ0MDJ5UVlvbGRq?=
 =?utf-8?B?VVVuVXgvV2lSSWtXdURuREo5T1hpcTZCR1FnVEdQV3liMkh1WUZ4VWVXZGxV?=
 =?utf-8?B?SGFUdm0wQUtwRXUrdFNZeHIrNnc5WTZkVWNSL1d5dmRBeG92WktyMHl6SVVp?=
 =?utf-8?B?OFpsUDNuOTBGSmExd0FoOWtSQVc0YkhzTHoyV0VjR1VWakNLQU5CVmIyL1B3?=
 =?utf-8?B?d0VJL3dMRTlvQ2NwcCtiWG1oc2NubE01dVBBeXZXNktybno5OTgvaktLVEcy?=
 =?utf-8?B?Y0Y2V3pmM05iT2ZGOWZYcSsydmU5Vm5ISmgzSUlqQXhjbVhadnpZQmlYai9L?=
 =?utf-8?B?Y0hiWjU3alc1dE0xZytUSzFUcXZETWh2Nm8xK2dqMlIxSmFOa1ExOXFvUlBC?=
 =?utf-8?B?OGVlTDkyY1oxWksxMlNyeFIwUUxRNGJsSG0vMklvUktzQU1XQVBTKzFNQnI5?=
 =?utf-8?B?azIxNzhmd2VsdHBTd1VZeWt3U0kvUkF3NlljNjhlei9PVEYvenlwSVA3eHZ0?=
 =?utf-8?B?aitwOHh4bll3TnF4V2R1KzRsNFFyTVhDcEhNdDV4Nlg5YmdlNW90VGdlcy80?=
 =?utf-8?B?T0FCS29HNHZvRFpPY3ZPVU85UndYalVqU1VBMHY0QWt3MmE4cEdxOVNSODRI?=
 =?utf-8?B?WHR2bHZKV2N0K0NWcTRJZTgxT1JmTHY0bWVKeHZqdGp4d3hhWVJ6aHJ5Yldz?=
 =?utf-8?B?aVBzMVBuYVJUWXBSNUJOSG5VelpZQU50SlFZRGFuTHpFcllSUGZMM1FZUFcz?=
 =?utf-8?B?d1NmVVRLd2xuRUhiZEFjRm53R05Jc3djemtRR3FtYW5qOE5nb3RzRG8vYTJD?=
 =?utf-8?B?MFhEaW4ydnNBZTN1Z1ViWTh3ZzF3SHE5aFhKODhrTXR4dlVLa3FGWWdhWS90?=
 =?utf-8?B?bHJJSUFHQVZyVkJrWEYwOCtQWisyTEFCTEs5UkwrN2gzdDN0RlQ1T1dIUUJr?=
 =?utf-8?B?eW43SXlDL1VvSFNEWEVpdmQ3QXZqY25oV2xhbCtYU1Q5amx0WnFidUFiSnVs?=
 =?utf-8?B?VjZyWEdGTlFJWDNXYU5QUG40SkhJSHpUOG1YMEg4VjhtUEM4QVJlaW9YdlFq?=
 =?utf-8?B?VkNmdmFWd21RWjk2Y01QcGE2RFlucGdBT0Z2aE5Fc1A4c0RaRG10YjFXeWZz?=
 =?utf-8?B?cUYxNExHRTd1enR5NDNjSmFGSFpBYjcrVmZwQWQwMy81WnpPdWlybHljakRY?=
 =?utf-8?B?VG1CVzArNkszWWptK3hOY1h0K1l5VXRsaEJ4WldjdTBUZWNBZFVCT3NsNU5I?=
 =?utf-8?B?RUVvWXArM2FKZkF3RkdWSFo2eXl4Q1l1YlVBR1ZSbEZ0WnVvaG0rdFM1TjFp?=
 =?utf-8?B?RnNlem9XWGg5VmlQaUhvVk9CRlNYbFpRb2d2TnhmcGxTL3AxS0lKc0d2U2du?=
 =?utf-8?B?WTl5QUplUy9rWXFkSTN1Q1ZyUmlROTl6T3duR3hmaVdLTWsvcDdqLzlsZ0R0?=
 =?utf-8?B?TWlNaVN4Y1ovQWxRdHBZM0U3VUwxYkUwZmxxMzFUNHFMSUVzbnZhd1pDT2ZG?=
 =?utf-8?B?ejFyVk1rL2RpdDBFZnlCM0pRREJ3c0VBemduTEowbHBNNFZWZHdTVVY3YnJX?=
 =?utf-8?B?VGZGc3BVNTYvMmRCNEVqYVpvZGxZZDJOblZJS2ZMeXBlMU00bmF5WFZRZU1s?=
 =?utf-8?B?QzZ4WEhyUkxLeU0rSEFoOHdBZW1WT2ErWTE1Tzljbi9XK2RaQkVpUjRTNUpp?=
 =?utf-8?B?dVJ3V0dPQjJKbUowRWVYeTFqUGFOTW1HVHAybDIycUFDcEduS3JZREhQNmdG?=
 =?utf-8?B?WG1zSEhLajdmTDd4K3JvajRJOHB1MElJL2RuZjNZMkZYTXJUdmkyeWZySWd2?=
 =?utf-8?B?dGc9PQ==?=
X-OriginatorOrg: navimatix.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 44960147-4361-4051-e07e-08dd30a5c4f5
X-MS-Exchange-CrossTenant-AuthSource: DU2PR01MB8293.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 12:04:29.0714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c87b4f54-b992-4813-8f3f-4a876324197f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B/y3JDRuDmX2QG4B4KS/XlIiAFYqaLVkG3OVQ3WFbKewGtgHd5LQGdwSiYfqKJO5PofILpg35XDuW1PbDTYEbZEIONLiWjSmyhPNSXoCpng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR01MB6493

Sebastian Andrzej Siewior schrieb am Do 09. Jan, 09:05 (+0100):
> On 2025-01-08 13:21:19 [-0500], John Kacur wrote:
> > We've been doing this for 15+ years. Normally I would expect the package 
> > creators to come-up with a work around and not expect the people offering 
> > the packages to accomdate your packaging software.
> 
> This does not mean it does not deserve to be fixed once people complain.
> Debian and Fedora download the source package and host it themself so
> they don't rely on upstream's copy of it. Other, such as buildroot or
> Gentoo or even yocto download it on every request.

For the record: Yocto uses the git repository (pinned by commit ID) to get
the source.


Regards, Jörg

-- 
“UNIX was not designed to stop people from doing stupid things, because
 that would also stop them from doing clever things.”
            (Doug Gwyn)

Navimatix GmbH           T: 03641 - 327 99 0
Tatzendpromenade 2       F: 03641 - 526 306
07745 Jena               www.navimatix.de

Geschäftsführer: Steffen Späthe, Jan Rommeley
Registergericht: Amtsgericht Jena, HRB 501480
