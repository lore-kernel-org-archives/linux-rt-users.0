Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4602E36F3
	for <linux-rt-users@vger.kernel.org>; Fri,  4 Jul 2025 20:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751661244; cv=fail; b=SNylQfXlD8+Kg78VjNwulY8aFjJZ3eDS6ETFNCHg7deLNEEHZzqqq8YTRyVhF/LcZf1FdgDiPcdN1jnrs9sprmiNdA5rV/kEiMcWGYuQKpiuz1JQPPj9BD9tbn1XUma5vvLlc7X8rVW/wGhTKzDPdLD8imqbFFWM69mer4LZVdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751661244; c=relaxed/simple;
	bh=aRo4GLukldxYlE94+G3u2BNjP8CQ5I2cnBZSbdvATgk=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=iTWBJs1Bj4AZe701oEVcczrowUBLFeWpLCViK1c/LNQ4P6J7wcrGsrwW1zkOSrY08FuklsFFR0xreXPp0MXbgCwAHK0Q7gR6eG3IbAxipSpIhp1clV0MG1EHZw3CuhxahI9uXkY0ahHN0VNyB+SJH3oQTAHwNQQLv9mMQFBoF4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 564KU3Ye021148
	for <linux-rt-users@vger.kernel.org>; Fri, 4 Jul 2025 20:33:55 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 47j5m1f6ag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-rt-users@vger.kernel.org>; Fri, 04 Jul 2025 20:33:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fhNn4MQSYjM4c2neFbh8/sgSMOP02uhFLwn7zqo3iOUCbbxhAbjZPuUaq8m/Pzbqlh9Mc1Xksjyiy7v8YYCF4irkbxsHisby9j7Dn0bXWmchDNb49fu2Dm3Ke0SuP0ph8utci6lUPU6K+ZH1pH+BY2oxghYAtj3WioE/FoFw3KTbRJu1BscOwHsrIvsBBDs2WNxQlQVQGNRZ5dJSX1zPCu+yJw4JIk9ewTtNwW40ESCfGY6j2wXKF0+t1AqiaTWmp8yts5Ei5lxgTZqo+2aEXTefIQ0f9zgoLqS9m6qeqDoCLUP+qv/Zu/ECotRr/OToctEzuUNC2SopHYyml5ucZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7WedY0fnTjKd/RvyDbTPI/yN1Ghr8JYn7IaBMxPlpU=;
 b=KPF9AcVfAFs2av7HUKghsY44EfM6bpnFOQwBkfVZPK17WbTs3baIXF8mpELldKCx4k99xVPmSFiUB7UnmMT/dyLNuwrCWrAQcE+N2zBhEG1NKgHDs+15xIY44PVnDu3Du14d97zOqJ2+ihMS5uqq+g2vKCaR0HtjHZAwfJVvGO0uE2yByGZNljJvK+dF0/PErfo0aAtIuSvw1MNJlZmhWNlCAepWTeKYYRl9YwYYiVahuxKDp+UPzlPxtRzGhTqmuZpy3yxANXLNkw7U6SMmdqrSRcmSgySudIhG8sb+AV8Zooqg57tDDnT+y/R0XIF9DWzE+5CPuBAiiMFtfRwA4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS7PR11MB8806.namprd11.prod.outlook.com (2603:10b6:8:253::19)
 by MW3PR11MB4652.namprd11.prod.outlook.com (2603:10b6:303:5a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Fri, 4 Jul
 2025 20:33:51 +0000
Received: from DS7PR11MB8806.namprd11.prod.outlook.com
 ([fe80::fd19:2442:ba3c:50c8]) by DS7PR11MB8806.namprd11.prod.outlook.com
 ([fe80::fd19:2442:ba3c:50c8%5]) with mapi id 15.20.8901.018; Fri, 4 Jul 2025
 20:33:51 +0000
Message-ID: <25673be5-e83f-419d-9066-336ecb32ba3d@windriver.com>
Date: Fri, 4 Jul 2025 14:32:51 -0600
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-rt-users@vger.kernel.org
From: Chris Friesen <chris.friesen@windriver.com>
Subject: question about semantics of RT mutexes and RT throttling
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAP220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::13) To DS7PR11MB8806.namprd11.prod.outlook.com
 (2603:10b6:8:253::19)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB8806:EE_|MW3PR11MB4652:EE_
X-MS-Office365-Filtering-Correlation-Id: 3367169f-72c2-4e91-e698-08ddbb3a1651
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVpQT0E2UTYxSUo2by8wdHpldzl1a3ZoUUt0bTRPckwxRkx2dVBMTlNlSjJ6?=
 =?utf-8?B?cnVJcjVRQS9BSXBLRlVFK1hURll5dldQeW1zVUNIR2czenNXQWYrV1k2THdY?=
 =?utf-8?B?UUZSQ2FXcC9HSTlNanY5U2w4dGJITjF5NFd2bWIyS1hrZWhUNmdISFc3bFF6?=
 =?utf-8?B?Ky90Zm1rMFNCV293dXFTamlybnNhZmFxSjQwUnNHWjkwSFBPUUcwV1FydGRL?=
 =?utf-8?B?QjBVTzd4L0Y4eENMZlhTMU84QjFHT2hEd05aMkZqclZRVmJOOXpvWjRtU0Rr?=
 =?utf-8?B?QWl5V2E3bDNoUmVscE44cnhPY294SUMyQjI5TlJ2Wng3ZzNnOUhtUUlxYXIy?=
 =?utf-8?B?K1JtNHgycit4cVM2RFZBNTZucHAvRFUvL09aOFlXZ1V6U0dwTzF4ZmlsWmZs?=
 =?utf-8?B?WDhHeUN2RTd4RWU5ODgzcG1uV2JRTGJsUjFVeWJ5NW5XZHgxb2toamlsTENr?=
 =?utf-8?B?b0FxeGJrdWxVdFluRUJqTDA0alBzTG4xV1J2dnFyeFd1WWVFd1VoUEdtcTFN?=
 =?utf-8?B?Y3NhLzJHU0pNd3pVNFFlYmZhL1VtcjFSb2Z3a1prcjF4azlFM25qd08vaHlM?=
 =?utf-8?B?MFpNbkFpa1hEMXJsUmZQUnpGQVowSFJSQ3Zvb2tsTkRwOWd5aHEyQitmOXI4?=
 =?utf-8?B?QUZmdG12YzdXWUlnUUZhSGFOQ21meXNHcE8rd1EyMWxHaWtTN2VoTlJOR1lQ?=
 =?utf-8?B?ZUx3aWlqYktTd1NqOStBSGFENURNWDNScjB3d2R4Y05OUm5MOGNpY2FHV1ZC?=
 =?utf-8?B?VVEybUFoVWlmbXRpSjFhRGlsQkhzOE5RNjBOY1ZnVzdqSFIrQnVnNlpGRUdq?=
 =?utf-8?B?aS84V2xDNkM3bGlhRi92L0R6eEMvUkN5QU1aa3A0NzZOUitnSEg4TVgyaTJx?=
 =?utf-8?B?UUt6VWhYcWtPK0ZXS211QmEzQURzNUlMeXZDZVVJN0JmYThFK245N2g3UjlY?=
 =?utf-8?B?NjQxRVVaQ0hSRks1d0dGOEhPNXJlT0M0Z2ROd0UybEYraERRbU03OXA3ckRs?=
 =?utf-8?B?cEtuNk1Rdi91MmMvWFFBVGtjUGJTaE5RNWVna0pGbWgvdzdTbGJVaCtud2tN?=
 =?utf-8?B?R0daRU0rN0ppMHVXMnM0NUZ1REExa3lpU3lnRE9iUUcvdGFST3NFZWt1MXFS?=
 =?utf-8?B?eWZGTTQwU2dQdnovVkFlNjdpVEQyMTYwZStZTlBLWE90TFpqemFlc2kvR0NO?=
 =?utf-8?B?STFoVGVyZlZNTGovWDVhbUwxdXpxeG5HQ3cxVVRaVXhmOVFpQVNpODJGNC9M?=
 =?utf-8?B?ckE3OTB0VldwckxLMFdpamZ5RGIyKzlFWTBpaTZ0YlV0QUxtQi9ndWE3bU9q?=
 =?utf-8?B?RUxXa1hqbGFVeXNibnBDRlI2RnpkWlplNDVQL1VrUUVWekRtQVpUSlA1N1hZ?=
 =?utf-8?B?WDcvekduT1ZxeElRVDFrYnZPL3RuMlJHeXpGaXNGZjM4cEVmTmxKTkx5cW5Q?=
 =?utf-8?B?bTJXcXcxWHpnT0gxdWFxVWVOZ0NVK3VEdnBiSXNiZ0tnU0dYSFdWS2hTMzBV?=
 =?utf-8?B?U3llVExjN1ZNRGlHRlV0a2pHSjJzb1lLY0dNNEdJQnRueTc4Rzl2OXE4MG9a?=
 =?utf-8?B?VTYxNjNjTDJ4NVplbVVUU204OGtQOHplaHdoZzNGOFlZVzgwU3liL2YrRjdQ?=
 =?utf-8?B?MC9nTFgwOTA0WGtMZDQ4SHNVMnFOaWFGMjVHM0RXdUNSRXdidmJJaHNDSnBh?=
 =?utf-8?B?bGUzSWJnZU1hc2hKZHB4WEQweEhXQnNVWHNBTnF2b0hHRk42Z0J3RmxQM2JU?=
 =?utf-8?B?YXFRNjVWbjlRUTZrZXlqOWdSMVpOcENFQUI1T0VWR2FaNXNqQkJGVi9LMVVY?=
 =?utf-8?B?VzRFQ3M2QTFNY1lZaUdCYWdJVWR4RG1mRkRXMTV2V0xKS3l6M2JsZUdZS1Zt?=
 =?utf-8?B?SkM1bkc2UjZOUTM3dnZkcVZIcWxKNjE2QnMrNjdwQ0xaN0hkTEJRWStkT1d1?=
 =?utf-8?Q?ni/mM8xnBSs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB8806.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTRpa0IzRWpXWWJDQ0s0d1ZQSzRBbXNHYzBiMFN3NWRmVjZnaDZ6ZDFqMmMv?=
 =?utf-8?B?dHZzVnFseldwODNPTFA0MU1YTG04aXRFVTFrVjlIdkNFV05YWGR6MjNmd3dP?=
 =?utf-8?B?V1RicHRTZkYyZTN1K05CWUI5MC9lZ3h0LzdQeGxMczJjcTgwcUhibXdaKzhQ?=
 =?utf-8?B?Ui90R0FiMXQvV2VldWgvQzZva2tzQkVLbXJPczhBOTZyVDFvbmcvR3l2SXY3?=
 =?utf-8?B?eFJ5WGpvcklGNkNPWkhLRnkwenFRQ0xkektmS0pTQyt1RHNkMmxxRUhya2Vr?=
 =?utf-8?B?TkswaEsrc3FaZDVoczdUaGJtU2dtbDZ1a2t2MW0wa0hua3hpTFVBcnN5K0pp?=
 =?utf-8?B?c3E3OVFYNlNEMXhqMkVkL3Z2UENmZXpXYUpyZzM4TVYvMXU5SDJxTFRReEg3?=
 =?utf-8?B?MzhLVXJTd0t5QTl1Tkx6QlVTdHMzbmRMcjFlbWs2RzZhRjBGNGJHL0Jlekdk?=
 =?utf-8?B?T1pSSUorTmxDWVJ0WElCSEdMNjl2VVF0Sm00ZWUrRjVSTHoyQ0l0b1pvM1Ay?=
 =?utf-8?B?RkNuY2M3NkI0MlpCREZOLy92NGxlZFFZUmFxbEtYcmFQdnNvcFNweHlJdE44?=
 =?utf-8?B?RjJocGVpVUJiK0V1eHU5TkNJcEM4NlE3aXR6Zm45dlR6L0Y4RFMzcUJnR1Z2?=
 =?utf-8?B?NExOcVpYd0oyTWx3TXpOOWJxdk8vTUVXNXk1bXlmN1lramxHYlRSdHRQbTB1?=
 =?utf-8?B?OVpkYVpKVklLUFh6QVFyYlVBN2lvL25xaktwQklDRXVmZ2pJMjIvZ0pzZHB1?=
 =?utf-8?B?Zy9lSW55RWdoZnhuOVlRVExxMWJ3MVFMcFhDYkswUW40WTRybTlwSmdadjRv?=
 =?utf-8?B?UzNlNlRXRmFXNFpkWjBISktvOTlrU0FUeGFJdVRoMS9RcnQ0SnJYb1NkdTFV?=
 =?utf-8?B?N29tSVZYUStDSjkzWEVyK2daSzV2UGl2ai9rc0VQTlk1WDdwVjRRUzhpaUZm?=
 =?utf-8?B?b09qeFAyWlhUeGRMMnhBWTRwOHF4R0hRanpYSHJFQk05OTF3dU9vMnliRlNM?=
 =?utf-8?B?Q1ZqeWkvM2R2S002Tml5R2FDTEJBYjIvUThCQmVHUGVHNE1jNGRQL1R4ZG9k?=
 =?utf-8?B?VmJ6ZU1naTJ6d0ZFZ3pLKy9UTnpFZWRrQll6NlEzU1U5M1ZKb1hjakVEYTRJ?=
 =?utf-8?B?VnBLVXY2TVp3NS8xRDJ5OTNQY29oVDlnejZJWHc2MTQ2R3FUb2NwWDBScTZY?=
 =?utf-8?B?V2hRQUVLeW9qZzlINjhLR2g0QXlKUVVQMzhQTkt2SHV3cGtRdWJaa1FweUpw?=
 =?utf-8?B?S0hVb3ZWR0RyREZaQncvbXBZRUpIVzI1eUpaT0Z6eFllK3Fpai95eXlETGdB?=
 =?utf-8?B?Q0tRMUs5NlpZMTByTWw0SUp5WjNMN3ZIeWJ6aEdwUUFUMzZ0cXZJd29UdkFB?=
 =?utf-8?B?N2h0OHcxMjN0c2hLNTF6ZXg4ODZ6Q2ZYd1ZzR1QwWHFVOEFZUFR6VklzdDhG?=
 =?utf-8?B?VHNac0tnOVhBOVhxaE9yNlR0cG1aR3BkeFF3Q2U5c1o2blEvbDk4YkZDaDdq?=
 =?utf-8?B?YytsZXNpcXlZK2JCbE00UWg1VDFCdEtRYnFRbG9NdFFwZExhQWJERGsxQ1lV?=
 =?utf-8?B?YzhKRnJQZjBUbjBMUTBEN2Y4UzgyaFE4bXZ3R0lGNXg0RWRDd2dGUDhsYzNY?=
 =?utf-8?B?MEhYL0QwUm0wQVlRVTZBb0tMaURZdGlIbE01S1JxbTdZYXUrb0llVStkamVq?=
 =?utf-8?B?UEt2Zjg5MjNvd3pjMm1scThkc3Q4dFlnR1lHMVJVdFhtNk1YNy9hcFl2aU43?=
 =?utf-8?B?eUN5OHErT3hhSWhhSnl6dlV1c3k1Nm12bHJUYys1UmVjcEpiNlczQWNLUmhB?=
 =?utf-8?B?cWZFb2d5UTRvdnNaRUtiWkNwMXA1U0ZmMWFCb1orUHVCeURiQVUwTnBHalNw?=
 =?utf-8?B?dGxXa2F3SEtwRS9lNWJTa0hJVktmdUV2SGhadk5CL0V0a2x0YlppSzYrcVg3?=
 =?utf-8?B?Mk00VEJwRmRXRXFPZXoxOFJRZWVoOEpPVUhVVXk5VEVpTVdjY0luNk0zcGdh?=
 =?utf-8?B?MmM2eGRrMWVOeGtCd2QwOFBzOWV3SVFZRm9zcWw4VEpDMjNwRE03OE1XSjA1?=
 =?utf-8?B?OFNyc3dYRGJoQytOVnJraWczUXNyNy9pV0JFMTQ4aEVkT291d3ZGQ3RSZ1k5?=
 =?utf-8?B?OTljeHBZazlRcjdEMVVMaWlVMkR3TWFabFRLd3dOcU5pVG5GZ1RsTmFKYnQx?=
 =?utf-8?B?cnc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3367169f-72c2-4e91-e698-08ddbb3a1651
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB8806.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 20:33:51.5690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7yvUd7EZvt7OH7sfrAJDpC0FwcGnUMxCstdg6dqWp5ea9Tbc+94BQsCkHcwaLv9Xs1VH0wwrb0UiBSTfus00NjDWh+ITqwGCIfCX5TPNtJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4652
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDE1NSBTYWx0ZWRfX09G7PK3JX8XY TsDQZRrb/UIbXMTrNoSsYUgmdL1xBN0r3/RTyEPD57vbk7JagmLxz7ZWBzsSWFOib0tL37p10dt I8QPZ+lKRPCGQqHiVC6lE455Etb6VaVklq9jZLo2G40hYqgPUZgDdczoBxE0pSyMgtki6n4PsKp
 RPhby/qCnpRGR1DAGyjkMpvo39WOJ/4I17t3fznbnOEx5Ep4Holhe6SJNCPmVeL0Wx38tDzzq7w MdgFlbFVqlde70uFcMVKvTxd6xp4/E+PleWaF3GbvcusdzvDv9mGJutFkybslc/c62sTIdUraBf BNb5ZAmhXiVJKN9HZySdsk2DL7kQu8pcKsyM1UQjqSLj3ZUgZNNzrRB5i1eBp7BI6QoGkg9zCgU
 dqgiQ+WIMBmuUWmNZZG1Gx0FiHjmgVGXBjQsQWpaof4plyTlHlEQvHDXdd1JF1lN5dS9urtp
X-Authority-Analysis: v=2.4 cv=IOsCChvG c=1 sm=1 tr=0 ts=68683ab2 cx=c_pps a=nbz8heNEc1OWkMMTQbiTjw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=PWlMuy4nkWDbdMFYZewA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: PCBXekZMBgm9OqCGKYnuysi2Pk0Ft6kX
X-Proofpoint-ORIG-GUID: PCBXekZMBgm9OqCGKYnuysi2Pk0Ft6kX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_06,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1031
 priorityscore=1501 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=593 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2505280000
 definitions=main-2507040155

Hi all,

Just wondering, with PREEMPT_RT on the 6.6 kernel (and I'm curious about 
the 6.12 kernel as well), if a realtime-priority task is on the waiter 
list for a mutex, and RT throttling kicks in, are non-RT tasks able to 
acquire the mutex?   Or does the RT task acquire the mutex even though 
it's supposed to be throttled?  Or does nobody acquire the mutex until 
RT throttling ends?

Just wondering if RT throttling helps at all if multiple RT tasks are 
contending on a mutex at the same time as non-RT tasks?

Thanks,

Chris
