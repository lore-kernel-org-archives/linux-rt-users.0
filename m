Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010048.outbound.protection.outlook.com [52.101.84.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC3D38C40C
	for <linux-rt-users@vger.kernel.org>; Mon, 20 Jul 2026 13:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784555911; cv=fail; b=s+Fs0zKCGGlOpGe2azYIILja0jlfz50NUXIBHEGEPbIZrPQt+YOKkCfMpvi/8IRI1U8fM7R39abPUW4PzECETExokJrXsnB3VyB4iF9cT3dk9A0MmFCQ1FpCTopP3InYWH3Q6UvPaALkI9amlnW9JLiv4K8b2Ls/JbU1WuxBgyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784555911; c=relaxed/simple;
	bh=5TaYRWWAuOHSRY5QHxxzYbIGkJ3+EHXsCNN48qnSlIU=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=O5z3gXQS1T0IMpdJefItfhNGgOY+/qJk4HlUXqcxYcokShkjNR5Qfrg+YbgNQ093p8lEIT2bhZ5vUOG0wCVMINMCDbryspq6wYXOYXnPPMxpw4RcRBmq/ymMHweLyMa3x8rySge4SX6kDTqJ6hiBUDwDXca9A5v8s6oWsIr2Pzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ovQORjH5; arc=fail smtp.client-ip=52.101.84.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ovQORjH5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y7DxsJmYaC6M8Qn+qynDhj5zSavCwlhz1+mR+gea3xJNiLkkcX9R8iN0XRKTN0wszvnh8eGnpxoKTXH88zN/HVqGtMTAR6HGE3O9DEx8MmSkOymk9XK45ZMg+dkuPz/sShpZMj9WBOTF8eSDMZ8JtOAemF+nvNXLeYMimP71GRe6f2vWTYes+kvn9VDN5Ik9IF1G2wgenH8yPMKST9k8oq/9/pIO69Hl6LEwnmAaUlLr3Cjlem7yRJdChsI9N6W3H7WhI8DVHav6GZ9o/lkt83kjs7gmt95cQaJSLihfNCnR9skfujflSNQYyNq/AfoNWkQVMDedHKhFMZUszHYbpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGLTVgrHZC8GNaWxjiqO9Rcd/Y2NHhIbBamkAW3dGE8=;
 b=leuoQYFFKUbdMGuVraiLpa8tITS4fyXOX0mikaBVEXGKvblCxstE2NoUGITY3R5TqlohDkrLnkulW3ApuZRJXd94sW63w08jPmXR/Dh8AidVAtV7ReWLdGBRvZfhBPIfYEPA7e9MvUeRBQtFk5ygQTKJpLyyjPuNUhahNns4FSB44wrIQHpXnQQotov2RuGzufOu6wUFp2eugBDHFUpuzbqD5eAI4xnY04X1OxxTkqqcFwu42KUrqWwum9KpeeBBYvX4WRt7A9udrHjIfmQfBvEwUhMXQjo25MDFHGVvtdAEq/lkvEdYTpo2vFmrY7UyD9hgsNMUgoFMhV8BYP2LYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGLTVgrHZC8GNaWxjiqO9Rcd/Y2NHhIbBamkAW3dGE8=;
 b=ovQORjH586JDt6mefvsQLI6G7fHD3vaQZJbSIDtfdKBWbarnRFcaHqpgKbswlSNWiJCjLx5x7FhUvNKhYZIKNl4rx2UNnt7HJB/BscZk1AdRuhrBpKpuIam83RvfzCswgsni+POPdNRL7mkj9MQt7zg6YXZQHiNBNwvMxf0SoqN01JvGCXRNR9cgdSJD19HTPtNISj2VDK1Z/gNhuNlWRijt0zZ4rLtBVfDRGTFxUVdV3t8Rw6GgKneBnMEo/bTut2ybj3yI2dY4s9UA8N4Wg3ILW+7+Owl8hhnQ5MIYEqcLdKodGoiu41epiRhrZdoS1+jnVvc5v2NSUt+RDRzXvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PA1PR10MB8893.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:451::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 13:58:22 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%4]) with mapi id 15.21.0223.013; Mon, 20 Jul 2026
 13:58:22 +0000
Message-ID: <020538a3-4a09-4b16-a3f4-5bc09d65b5b1@siemens.com>
Date: Mon, 20 Jul 2026 15:58:19 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CFP Open for Real-Time Linux User Forum - October 6 at Open Source
 Summit Europe
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Jan Altenberg <jan.altenberg@osadl.org>, Min Yu <myu@linuxfoundation.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0128.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::7) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PA1PR10MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: 1af3733c-9af4-46a0-cc8a-08dee666f5e8
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|18002099003|55112099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
 jMl4znjHvHIYiLPsZHCK6QcTYY1zm7PjB0nd2KCvMnT0+8bZPddbtgXylZWnNgbKdDQONLyursoZGCyOF1NoHHVxYwaadHXU2lMOdU/1YttQn1pxEpdVvhSgr4A5Qhaqm1izULhF/VPjgMOM9GbVzwW6YseUBOIDC8Q0a6vGBSAO40OA5FzmihP6nFv3POvG6h/9CcGVBNJf5CPjFae2FfbKEpWuQXV0zJJK7mt+sr7iBNFnmsjS3sV6iekY4bHhTBSaMvUIuZ6Llr6hFAKUdG07l6hEunGYw7mMQCw1k/+1Yynl3k3GyJgE4XijNXPSDk5aJgSL8t/oihZ9oAhp0LMUgtJOPVG5QQpvs2C38RfF01GJZjNSDiLwPvN8sQ03gHjHP52vMhBlkujbbcFDJxb1e/Pxk+5gB3wgScUNNecqf3jSmb4ezHLPHkC12Ehs1B92e2OuJAGQ55Ko1yOTcm5OpWYb0zl8oX0EWfNqsNSw8YA3V8tvcfOa4bfvdOm6ZkbkagmGmiDvOUOYmb3M1rJZpPOTHh5y39aTmgr4pPW69bS/wTQEPFdafMCw7R3I1aw+sLXXYIaiebyIFnDMXfjSX+IxArDHQ1jJNIv3llk=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(55112099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?WnF0UEFJd2NJZXQxbndjb2QwekhTWXRhMDdOWEZSVEF2UEVteURGQ3hGWGs0?=
 =?utf-8?B?K0FzbnBJbFN6OU00VkU1L2FkNnRESGs4SE0rdVdIdEhtZ0w5eWZqclBDMk8w?=
 =?utf-8?B?eEE5ZmNuUVNtZjBweHFYOGJDcTlYeWhMdklMaHluQ2lnM2VKRFFOSFM5dGpp?=
 =?utf-8?B?ZHp0ZDdZZjhUalRTL3crcEl4cGRaVTVaUmxqR21KWUxCS1IzazVmSDFKTldn?=
 =?utf-8?B?TG4xclpxbDZpcWk3QzdMTEtJY2VMcFVQeDhYaEdhL1JHd0tEYWpjbUUvMnFH?=
 =?utf-8?B?RmxhUlFjbFRCSFBEM2p2TGVwQVF3NU94Q2Zmd3ArVlFCR2IyanpPbWF1OUw5?=
 =?utf-8?B?TG9veEhRcWxiMysrUnorUWV6NERHVDMwdDhPVTU4UVpSSnFJK0xPWC9haERv?=
 =?utf-8?B?MThyTFNpbUdBSjg5M2s2T2pRVGRJMUg1amlWNTc0RUlkZlhmVzNBSC9OZmc3?=
 =?utf-8?B?bFErdGpxSDFHaWxWVVhJYXZ3cmZkRjYxT3pNL2ZrdHlDZ1BjRnhMS0R6d1ZV?=
 =?utf-8?B?YzJsNWNKeXlMZjZMdDkxdE8wV1hvaDluK3JnYWI3UWNjZUNqcWpLSzVGa3Zo?=
 =?utf-8?B?OWpSb3RtU3RYZU1hNWRNNEdiN2tVQUFrcTZkayszZW9sT2hWNDFJWnMycGtJ?=
 =?utf-8?B?RitJWi9vMStkYnc5QkFRZEwwcmQ3SVdkMkFINkNKaWR2dkFZK09UZmZDNE9t?=
 =?utf-8?B?Y0NOdmVDMDZ4Snh6MHhqckFtQnhzTy9hY0dxYlJGQzNpdmx0d2VRbG5sZGEx?=
 =?utf-8?B?dVZEbUR5WFVZaEZpZS9yWjFFb1hIdG1ZbDhHTDNCWUk5cW5iQlVWZWlqMmg1?=
 =?utf-8?B?V3Jia01DYkV6clBYZnB1NVFsM1IvRi9jWEFXTnJwUS9qQUNuaG83dlNrWTZi?=
 =?utf-8?B?TG5Kd0hzV1FheEdMQTBIQTNFdE5Qb1JkMzQwcXNDV3VCY2pnN2xEcjlLQ1Zi?=
 =?utf-8?B?WHlVWTJsaWo3czYvWTNsQXVBUFFLRG1IdVcyTEJkblozVFNHVGJ0OUg3alp4?=
 =?utf-8?B?MDZoYUFpYWxmbDRBakEzdFZkeE9vRGpEVERoWUkyUyt2Z2I0bnRxTk50dWNa?=
 =?utf-8?B?R2pRN2dNUnUyR3JuZXZ6TTI5RXJhRS9vOGNLek9ZL1FSUG5Qb1hJV2J1TmZ5?=
 =?utf-8?B?eStwZnFDZ1NadnhjUFhrTW5ERWgvVEhpL09ESkZpVFMxNFY4ZU04bkxiNnlo?=
 =?utf-8?B?OW5xSVNwSTJnVzNBdzAvMlVLZy8xZTFOdzJyOFFEU2pJczVVeTZNdm01V2xR?=
 =?utf-8?B?bEhsc0pkTjREMkt3Wkp3elNiT2tZeUFRZ2hpMGNVdjZqVFgyTG4rQk9DclZ0?=
 =?utf-8?B?d1FoUFB3eVVVYXZUYmtvUnNCOHdqNUMvTlIxRjI5Z3BBUjZaMkN0WkJiUFdO?=
 =?utf-8?B?SVRiNTVkcjNPZSs5ZFA4L0R2K0x0RklhQlYxZ0tTTTRYYVc0OVBMcndJTTU1?=
 =?utf-8?B?WG1YdGlNR0ZwWk5uU1JMdE95QUNIMzBnUTdGVWEvWGxTNUsxelRlR3JGVndu?=
 =?utf-8?B?dHBFQkkwVDNtcWdwVEFyeG5QbkhxZnRpL1UyY283YW9nWFFnWURPMFdIWW1J?=
 =?utf-8?B?bk5aM1JSdXJJcHpCRkFTYjFiYUt1MUgyYTF3S0hvbURBeWF0Sm1wSDhoRmdI?=
 =?utf-8?B?YW10T3B3K2FyVXNOSk9Mckd0NG1iVmt5bHQ1UTdLa1IvdHhDMUxmSThqMzFQ?=
 =?utf-8?B?VHloaStQU0RaeWp5K0Rwd2hhcHlEMGw0WlFyd1NhaFYvYVFERFJVYkxGaEFI?=
 =?utf-8?B?Q2VPOEFlT2tOVUdmQWQ3SGhaUHR3ekVHdS9zSDBXMU1qWCt1VDR0N2pDME1G?=
 =?utf-8?B?OHl4L2RoWDFOOFQzenc4Q25aMllnYkJCMEZTTnJKZGFRRENDd0V6ODFiTVVa?=
 =?utf-8?B?d0F0V3BIRFNPaFlhQ2RwdkQrOFBRU0lRbXd2WXFsVSs1RXhqaEFZbGFOYmQx?=
 =?utf-8?B?S0Y0OEdWVHhMaXNPTlFvN0hENEdDR3M5R09SaHpNZ0NGczZaSmJuVFJ2NitL?=
 =?utf-8?B?d0VBUGJTMS84c1IzbHlmSDBLdnI3Q0RLQk43UWdGYlFLc01LcU0yRUV2YkpU?=
 =?utf-8?B?cG81OGxaRWRzK20rQXNMSFNDb2pwZDBaaTJZQk85ZlgxV1ArbVZxSkozOHAy?=
 =?utf-8?B?S3o1WVpzeDNSdHFnUFFuejYvRXY0ck5ZNHpKaVFudjBsWlhzdjRTdFYwYzJr?=
 =?utf-8?B?dDJTK29ISjArbjl4Mmd0SXBuMnZGeGJrSGxzcUkwQ1JJcm1wYkNtYlFybGtM?=
 =?utf-8?B?MVBqeHBvQWgrN3R5RDJjK0cyVUVwZUF2UVJoQkQ1SWQyblQ2dXhCOTNLNnZB?=
 =?utf-8?B?QWR5QUJ4TmZmcEl6dGpVOHZLV0YwWitGTnpBMjVZMGd2cnJLRWU5dz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af3733c-9af4-46a0-cc8a-08dee666f5e8
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 13:58:22.2866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7tKbB5wPh5abX8VS381PtadazPK1qN51RgdmFutrnAFMqnmRdhvCbTeGWsUNJHgQGmkFZQM8g4TnZinjbSJ/Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8893

RTL users,

We're very excited to announce that the Real-Time Linux Project
https://realtime-linux.org/ is hosting the Real-Time Linux User Forum
https://events.linuxfoundation.org/open-source-summit-europe/features/co-located-events/#real-time-linux-user-forum on
Tuesday, October 6, 13:30–17:00, the day
before Open Source Summit Europe in Prague
https://events.linuxfoundation.org/open-source-summit-europe/.

This 1/2 day User Forum is intended to bring together PREEMPT_RT
developers and tooling experts with users who are building products and
solutions with PREEMPT_RT. It is an opportunity for users to
share real-world experiences, and exchange ideas and collaborate with
developers on the challenges and opportunities shaping Real-Time Linux.

We invite you to submit a speaking proposal highlighting
your user story, implementation experience, lessons learned, technical
challenges, best practices, or innovations related to Real-Time Linux by
using this form: https://forms.gle/iRK48ACWnMatihg59. Please note the
following timeline:

  * Deadline for CFP submission: August 16th
  * Speaker notification: August 28
  * Schedule published: first week of September

Please circulate the event and the CFP widely within your network and
community.

We look forward to putting together a strong agenda with your support
and contributions, and seeing many of you at the event in October. 

Thanks,
Min, Jan, Jan
