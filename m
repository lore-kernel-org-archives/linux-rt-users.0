Received: from mx0b-000e8d01.pphosted.com (mx0b-000e8d01.pphosted.com [148.163.143.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D792720A5D6;
	Fri, 10 Jan 2025 22:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736548622; cv=fail; b=KoLkUMgp2Az7WcCqOpYGkkPNyfoGTi1hg2PpJ/DK6KDwTblUaiN3SFwk8Fy0Yx+RL4YlIgTT9k6vU0iDoklqId/hyeWq4uurkck2+HBysQuL4adwYjNJ/1c94K4hYl3UQf8lqxwE3MBID9/wIz24cKmvjHdRkOqqscBLSOzUtoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736548622; c=relaxed/simple;
	bh=MchvQ/qcJ+KO2rmVtUW/Z6/sEAvm58Y5+o/pjHFBPEo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dehe2UTJLk+TFJ+xrGyzbNRBjkdIgl/Tg5CRCjm6OMOqkRJzvjpIvy2oV8G1D1Oiq7K/mCZEIxe8OT1m1N8BqBqZ5rghtSp9+V0irX7XBUZgmm0IJAlj58zSOXdheNfT0B5z+zpnIBWehR2WV5/ndLv1T9FzxTHLJZs3YWHlBOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=selinc.com; spf=pass smtp.mailfrom=selinc.com; dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b=tKIGXL2h; dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b=nwl1Lh2U; arc=fail smtp.client-ip=148.163.143.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=selinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=selinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b="tKIGXL2h";
	dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b="nwl1Lh2U"
Received: from pps.filterd (m0136176.ppops.net [127.0.0.1])
	by mx0b-000e8d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50AK02qc015023;
	Fri, 10 Jan 2025 14:36:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=sel1; bh=MchvQ
	/qcJ+KO2rmVtUW/Z6/sEAvm58Y5+o/pjHFBPEo=; b=tKIGXL2hlbA1QHd7Myi8/
	2TXcBmYtnbpDqXyMaPOUiVCbx+/1r74R8ImQwt7b+Aie5GpiJfoukgltFY040dED
	c/EiY0kXDphg60ge7Qhev2tMl7hfY+trWVJZfTA/DtwGevZhn0DO6qxS7J33NJex
	UG0Q8AHCiO5WIYkRuqZLk8RFjwmX7+rTCw8NTHEuCtRs6Yyb5zB4t148e0a2hSSU
	sTSyF5Edi7XvpdY1uS/j0K1hvweFlp5u9KhPcLrLkDF2D9MK5i8t4r8X3eQ2Hvlh
	vk9+qQwLyJ9waJYStTeNqyzqkqT7XXZ+XXjJjfdepPZfDX/t5zA2NEJkc1NOZhXz
	g==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by mx0b-000e8d01.pphosted.com (PPS) with ESMTPS id 443a6sr320-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jan 2025 14:36:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sRtsnI4vlAbSvwEOPjmbyanOyR3hJskm+YWRSJHYnUGekNzQd1H6IKL6tTmJibfk7ZpsVbe3tVmhY7Q5QgR8l9b4qZ5XB7b+FKNUPYzdLRab5uYq8ZlKVJ2YpBQQd4oTo6zJtCXf2D1Zr07hZwAzBwBD2LuYmku1/ajB1A+bbvgyEyX5omNCjM8REY5FV7ryLBuF23hDd08g9vFIMLsDYWwEOiFmvtuvnHfM2+aH8WSKoTEOHZuFY4LVrUmLjY5RgBoUiEGIMCMlpZPm0UVN7179TRHCTvlODLg5Ycl+jBuNy1DyGREQvLG9csIKF8qrQoJFpPOCA/FLB52a1KGUeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MchvQ/qcJ+KO2rmVtUW/Z6/sEAvm58Y5+o/pjHFBPEo=;
 b=b92Sze6RYNm9/A818Uyrpi/oU0Kwony4xqLrPfZj6yJmPpNpnXkvcCcd2UaAe/R0cGHsapS+llXjh/q4SFBNVvhu574+5Y6+2F+OF2xtFMh4wmE2sgGk7B8w8VCqQAziP4IsO4DVGCz+u+GjVwbowTVRh+jNEP9+Tb+aNHCsFJ0j1iROcdFmlHthZjfIMpyLJfMwe9caqwCC+2QdHmrDPXl0Y+msl3aE91GQNXatAu0NU5zdzcParI6H85sNuLFPXdTFjWH55+DCcFVEk+jX0aIgd761BN7ylYWHp4DIkO/OBUe2nwbTiHxp7pRyQX8w7Cg7s+qAImgumPEvgHBAzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=selinc.com; dmarc=pass action=none header.from=selinc.com;
 dkim=pass header.d=selinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MchvQ/qcJ+KO2rmVtUW/Z6/sEAvm58Y5+o/pjHFBPEo=;
 b=nwl1Lh2UwXV83H14mrAoNChvHHgjB7LR8DcbbDHVMUF4YMhApLfkbOjuIOu/c9d5FUGrQ9aE3g0bt6D3l+Iodf3hQZw2hwmYzOsvQMCQL2HBKknI1gNi2pdwdIzpP6bCJG8SYtQOShq1GjW/hcQg1cETPY4tm2H14Jf7E+1nvBtRSPCuSOe/PNmjXqM6C6biblhkNKo6JY2oodJ1hDuS+8FhwVDFQNRlBloZ1+Ylqa7TsVfjMzN+70CxyLoqckipv/xuV9XANSNN7QVAtTbOptNQ6rJOBUIa8lXL5hJYKXmjxc8HCM6UJ38LdYG3Hjdk00Mnz4V8GwoICiA1yjC3dg==
Received: from PH0PR22MB3809.namprd22.prod.outlook.com (2603:10b6:510:297::9)
 by MW4PR22MB3111.namprd22.prod.outlook.com (2603:10b6:303:16b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Fri, 10 Jan
 2025 22:36:39 +0000
Received: from PH0PR22MB3809.namprd22.prod.outlook.com
 ([fe80::dc78:5b2b:2e12:8731]) by PH0PR22MB3809.namprd22.prod.outlook.com
 ([fe80::dc78:5b2b:2e12:8731%4]) with mapi id 15.20.8335.010; Fri, 10 Jan 2025
 22:36:39 +0000
From: Robert Joslyn <robert_joslyn@selinc.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "rostedt@goodmis.org"
	<rostedt@goodmis.org>,
        Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: RE: RE: [PATCH] powerpc: Allow scheduling of IRQ with PREEMPT_RT
Thread-Topic: RE: [PATCH] powerpc: Allow scheduling of IRQ with PREEMPT_RT
Thread-Index: AQHbV8o+5QBkEbRjDEWM0suiKTr7tbMLRq8AgAAArgCAAGR9YIACvD4AgAJErFA=
Date: Fri, 10 Jan 2025 22:36:39 +0000
Message-ID:
 <PH0PR22MB3809CB75F0E567EA0C72E997E51C2@PH0PR22MB3809.namprd22.prod.outlook.com>
References: <20241226191238.2559880-1-robert_joslyn@selinc.com>
 <20250107115606.q67--i0f@linutronix.de>
 <20250107115832.jLUSKKwG@linutronix.de>
 <SJ2PR22MB382271FBE556A6A4AD978F0CE5112@SJ2PR22MB3822.namprd22.prod.outlook.com>
 <20250109114428.4fvi0KRC@linutronix.de>
In-Reply-To: <20250109114428.4fvi0KRC@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR22MB3809:EE_|MW4PR22MB3111:EE_
x-ms-office365-filtering-correlation-id: 34dc4a16-4541-4fcf-8741-08dd31c73fb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TjdWUGlqMW9MUHNIeGFwNEhVR2M3cUpwVUdEMUdDWmpSNmFyRnp2UFplU3ZD?=
 =?utf-8?B?ajI2cE5BaURYZXB4L3IrdGhzZnhLK0pBb2U2dm1TNEpKOTc2dG1IMm5JN0kx?=
 =?utf-8?B?aUxRaVY2NE9mMnVrUFF2djBnQ0NQK25Db1k1a3JYcTM0RTlhaUhJT2hUU1pl?=
 =?utf-8?B?Y1VsNU5ONkhxR1cyOTd0cW0rUmtkUzJSUHNibXZTMHVYbkh5dWxXV3FDckVZ?=
 =?utf-8?B?YjN0VHprcWszQXBIWWFmQzU5QVBxa1FSVGJtRDcyZjBYVHBmZUQyTURUR1lT?=
 =?utf-8?B?RVJqaTl5citqeEdmdFRScGZucXV5bTBWcmNIZHAzeWMzQ1RRSWpmRnE1S3hi?=
 =?utf-8?B?Q0FBWk1PWFVOVDVwUzJVOTRHNHVKOWc0M2EvR3B3dFAwZFZNK2pwWmdBWjNC?=
 =?utf-8?B?SDZYMGJyRkZ4aGV1T0x0RFgvL1g3blNIUEVLSWlTUVU2SUF5bU5yTU9yL1Zt?=
 =?utf-8?B?TndOT1FlYmJDUkxjckxKaDd0ZFdWcGtDQjFvWjNKSFhsbEtOUHVmZGZZWmtm?=
 =?utf-8?B?L2Q5TWp0SWx0czJtelU1ODMzUC9GUHNBazN5STN6dktQa0dqQ3ZjM2ZGUGRj?=
 =?utf-8?B?Q3dVNGVwaWhvYUVtR1hSRzF0ZnErb3dVUHFjdXE2NkN3MSs4bi9zbWc1MXQ4?=
 =?utf-8?B?cWlwT016dmFPNnJiV2NTSDBEM2FxRVBtRUNGak9WQnRrZ0JJNm9rMlJWNlha?=
 =?utf-8?B?NHkxci9OWWN6cGhqMTJoai9LMUY3VThsUHJGQzdUNFRnM0ZRRURBRWdQUUpk?=
 =?utf-8?B?NGl3U1ZsdktyUmhnRkRqOUpVS3l6TDVmMm4vQ29OL0QyVHhyNHFVcGJTS0FJ?=
 =?utf-8?B?ZnFjZldvd21ZVkVNTDJmT1BXaEJYbGE3OXAwK25ubUUyNHZZUlRmclU2TzMv?=
 =?utf-8?B?UG9OdnN1NDlpRXFGQWdmNkdoMGwwbmhFODRXakZ3cng3R2ZJUmQ4V3I1cWVL?=
 =?utf-8?B?ZW5laENvMUNRT1hFYW9lL3ZwZm9XbWVwbUNzTkZXT3lXeCt0cnhzTTNEMG9w?=
 =?utf-8?B?MFRFU0JNbS84Z2ZNeU90NmMwcjg1RW5KRHVWMVpoSlpLSzVJcHp6VzdTb24w?=
 =?utf-8?B?ZFloS1JPeGxoRGhjVjBDYnZJY1Evc1hoVTlpbnZQbWZlaW12elI3QkNFNU1a?=
 =?utf-8?B?Z2k2THNRcDRjQVY3dzhqMkxGZGFqZDZpUUtRTStLM3pQKzI1NHUzZWhtR3Jm?=
 =?utf-8?B?aC91dFJMaitveHFMNW5aRVNWN1FmWUxlYjBWMUhCeWQydUxuamwwU1Vkb0Vy?=
 =?utf-8?B?S0pUQTJZdDVOS240R0dsdTBqclJuZEZ4RkJUZExzTTkyUkd4UVNtdCtCRXVi?=
 =?utf-8?B?Nms5Y1NpZ2lqTDdya1lheVFvR0tiOVd4UUwzMXJjM2t3Q01hd1ZoN2hqelFm?=
 =?utf-8?B?QnRHTHZKWFdKZWJ2MFlZY1R6eURvL0VpdXY3bXVQLzR2YlBzRURoSDFiL0Rv?=
 =?utf-8?B?NitHcjZBQ1l4Smh1bW1DRVpka3ZRdVZML05JMVJ1SWQ3Si9FOFQxZWwyM25H?=
 =?utf-8?B?Ylp3ckEyOFBjNXdBVnh2OHNVVkYvSVdTWEdFZzB4OW9OQ3lRSW5ScmhiaVRQ?=
 =?utf-8?B?SHZ4Ym9uUEZFRnpYblZub3E4RDA1cmdzT1FPQ0tZLytlVjduZnl6TG9XQVhQ?=
 =?utf-8?B?UVRxTDhUK3NTWmJjaTNLSHhQQ2FJd1BUYmQrYjZqSjRGNXA4bDVXQXBZWmlM?=
 =?utf-8?B?RGxWc0srcFV6T1RjdFNyMmdLbEYwdEl1U1BmMFM4NGRxb2M3ZXcxSjkydFUy?=
 =?utf-8?B?SDByaWR3Sm1keUlEMW5UQU5rVzhGNncxcnRSRzBKS2dDTGtoZ2h4cmsxbmov?=
 =?utf-8?B?WnNxWmYrWXhoUkszQkY0ekhZRDYxOE5TaG1HaGdCeG91ZVAxd2JzZ0tVWlFh?=
 =?utf-8?B?eGY4ZDhhNzJUejJvWGlVL2xqM1FIbDVnV3hSUWx1VmY2bTFTdll3eXBabk4z?=
 =?utf-8?Q?2CnbWITnJcA0y6cxLgatsRprLizEX7gF?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR22MB3809.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MHFaZ3VmZWcvQ1Y3bWpQdXhwYUlPbmYyMDY4d0d4eW0yMFRjRDhXVElOUGsv?=
 =?utf-8?B?ZFYxcm56NHlvaEVsZ1AxcWVTRG1aeE1VSVVlVjlKTXJwcEd5bHVyNDExWHA0?=
 =?utf-8?B?bjRFakgvcVUyTzBmYUlpKzhFaDhzb0xHT0JzeFhmNksrNGV3U1RycUpDdURm?=
 =?utf-8?B?N2NtWVFZS1M5V2VkWWNNYjVPKzhNNFd2dzBOZDlWZmZyOXo3eW1PVUcxd1FH?=
 =?utf-8?B?Nk0xanJqQmEra2FVZi8wcHNZbTUvVGdFZy9xRlJFdzRxaEZpMS9mMnowemZV?=
 =?utf-8?B?ZEUxWk51ZGMwSXM0ek5jellualFuTW91SFJtaDFUMXBmVlpweGhWcUt0c2xJ?=
 =?utf-8?B?eDd3YjBLa081cXNJYk5aT0o0RS9jZmpUNGxFbGlNajd5bC9wQzZpaTc5NXQz?=
 =?utf-8?B?Mlp4VVRQRUlyem9Ub21ER1J2RHAyWFRmczNkV0lCV0ZiSWd6blZTcVByR2pU?=
 =?utf-8?B?MTJqK1kyOG0zcTI5Tkd6UG9jODdwZTVOcGVVRC8zUDlSMnRpckF0SHZsRDZX?=
 =?utf-8?B?RHJVSGVQVzd5N3FBYW1ibnNBYkllNVhDYWtvdDAvWmg3TTV1bUh2OStRTDA4?=
 =?utf-8?B?VERaa1dlSTFvbXExKzkrOUF0TDJNdXkycTA2QWx1aWVLdm5GTjAwSWlWK2gx?=
 =?utf-8?B?bFZoSU1xaElDVG9pVStlNGd6REwwTHE4OFFtdWVyeitVOVRQdlpEelBhUVF0?=
 =?utf-8?B?S29makZJMlYzNjN6bWpMVGl0UjFhY3BhRnBKL0lUbWoxSXpHdzhwckFIUFFV?=
 =?utf-8?B?azdJbTBPTkhLWkcvQUc2dTU0WmcxWlB5Mnk1cUxYZHAvdzNtQzZzK2lwdFZK?=
 =?utf-8?B?RmpoWlNZSC9tMU5icjUwbExhbUZsWTMxWk1LekVCblNzNzBaM21jVVhCT0RD?=
 =?utf-8?B?emcvUjMzNndVK2RTSWpQNkFtZkRiTGw5c0Y0YzVLZUdmdnU3Y0taNWNhRkdm?=
 =?utf-8?B?ZjMxaUp5YjVGcUpsR0IrbWpMNW1YeGprVE1iRERSbHIwQ1JiTHhHRXh2NVRC?=
 =?utf-8?B?cFZwV0oxcHIrMjgwNmZtZW14RFVyZWRhSlNwMnI1WG9qV1JFUTRKc05DVVB0?=
 =?utf-8?B?RDRtTFo5ZlhvV2Q4KzZ2UU5tZHJMUkpmV2NtaldHY3lwS2swSjEyOStoNnI5?=
 =?utf-8?B?eitaQlFUZ3FDWlJWVHZkZ21nYVZVU1VhZzFOcWJWL3ErcEJRMFBhVjBqMVh1?=
 =?utf-8?B?UjRjQ1ZiTUVPamRHb0R4cFJ0d1g1TGh2M25wSDg3L1hRRzVFdElXQSt0T2ln?=
 =?utf-8?B?VXNMN3BYQko3aFMyLzlhbHMwZEE3VEptRHdMaGNQZFA1ZjdQNlhvYkdMbFEx?=
 =?utf-8?B?YWNTQVVwU3FZOHcrK05sUjh1djNpYnRCeDcxaG9oUjA4K1orWHBPYWNrcXlN?=
 =?utf-8?B?bkczbkx2UWFvVmZ4TDRaVDNLNVRyWDU2VGtBWGJEbHFvYjRvYkMxRWZmRlJ4?=
 =?utf-8?B?VXR1K3pkMFJkbzduOC9TU3RUWnBIRzdzbnFmNEdGNVY3VmdJUWZHQUl3NENv?=
 =?utf-8?B?eUpVZ0hjbGN1dUk0cFFCdnlMVFpLTCtldEUxQ1hSdUc4ZWJhcWZqQUV6a24z?=
 =?utf-8?B?cVdjVE9udHFVUXV1dG9peDMrT25ZbEM2TkU4TnA3bXFvYzhTeVRQNDRUdGxL?=
 =?utf-8?B?SVJ3b3NpY1BzcUpzNG5qcGczVy9RNHVQenRNZlRoODVrVE1KSW1UWUk0bkhR?=
 =?utf-8?B?VGExNUdoQUV6UHBpaEcxZE1Hakd6eEwvdjA2ckh1TWFFR2I2WDFoeHhabGsr?=
 =?utf-8?B?RzFoNmxSMEt4bG4rTjhtK1kwMVdaaWNGdURxckdWOUFoUDNzOTlvNmJvZU41?=
 =?utf-8?B?WStIaFJBZjJ1d28yeEwvRVNGYTRCVitrV3VNVHB0dlYzWWQ3ODhuZWZNZGhi?=
 =?utf-8?B?S09GanFWRjVEd1JqYUsvd0FlUEx3YWYycE5kSXJuMFZQQVpaRlFNeENFc25x?=
 =?utf-8?B?OUdNVDl3VHZUVW9qK2ZjVENud3FUR2UzRnRkVXBvYm5LMTN2NGdMQThJQ2Zi?=
 =?utf-8?B?SzgwNzJrUzFsZWowcmhiVmwzeXVqWUUzSTFXbHluL0VMcjZoT21XVDlsUGFM?=
 =?utf-8?B?c2lIelFoUnFkL1RRY3BnM1p1cjRxc3pVOWxoMXl0YWI0VmpVUjJmS2FieVdt?=
 =?utf-8?Q?Ip/rMzAoDfH0lCXHlZpBQ//ZX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: selinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR22MB3809.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34dc4a16-4541-4fcf-8741-08dd31c73fb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2025 22:36:39.3293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 12381f30-10fe-4e2c-aa3a-5e03ebeb59ec
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K1sCsZcvXKFcWW2cWf5sqCdY7o/FKdnJjlWbqDIALBbzQvapxVTgO6Av6Hls9G9SELqSWD5LdwW1bWdKNHFTOr5/qhpRAHqn0y1qXJqqEaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR22MB3111
X-Proofpoint-ORIG-GUID: ULo4Cei3B2b5stYvfvnjddI2ZJkQ8Ej-
X-Proofpoint-GUID: ULo4Cei3B2b5stYvfvnjddI2ZJkQ8Ej-
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=689
 bulkscore=0 mlxscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100174

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTZWJhc3RpYW4gQW5kcnplaiBT
aWV3aW9yIDxiaWdlYXN5QGxpbnV0cm9uaXguZGU+DQo+IFNlbnQ6IFRodXJzZGF5LCBKYW51YXJ5
IDksIDIwMjUgMzo0NCBBTQ0KPiBUbzogUm9iZXJ0IEpvc2x5biA8cm9iZXJ0X2pvc2x5bkBzZWxp
bmMuY29tPg0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtcnQtdXNl
cnNAdmdlci5rZXJuZWwub3JnOw0KPiB0Z2x4QGxpbnV0cm9uaXguZGU7IHJvc3RlZHRAZ29vZG1p
cy5vcmc7IFNocmlrYW50aCBIZWdkZQ0KPiA8c3NoZWdkZUBsaW51eC5pYm0uY29tPg0KPiBTdWJq
ZWN0OiBSZTogUkU6IFtQQVRDSF0gcG93ZXJwYzogQWxsb3cgc2NoZWR1bGluZyBvZiBJUlEgd2l0
aCBQUkVFTVBUX1JUDQo+IA0KPiBbQ2F1dGlvbiAtIEV4dGVybmFsXQ0KPiANCj4gT24gMjAyNS0w
MS0wNyAxODowOTo0NiBbKzAwMDBdLCBSb2JlcnQgSm9zbHluIHdyb3RlOg0KPiA+DQo+ID4gWWVz
LCBJJ20gdXNpbmcgNi42LjU4LXJ0NDUgYXQgdGhlIG1vbWVudC4gV2UgZm91bmQgdGhpcyByZWdy
ZXNzaW9uDQo+ID4gd2hpbGUgdHJ5aW5nIHRvIHVwZGF0ZSBmcm9tIDUuMTAtcnQuIEkgaGF2ZW4n
dCBwbGF5ZWQgd2l0aA0KPiA+IGxhenktcHJlZW1wdCB5ZXQgYnV0IEkgY2FuIGNlcnRhaW5seSB0
ZXN0IHRoZSBwYXRjaGVzLCBwcmVzZW50bHkgd2UNCj4gPiBydW4gZXZlcnl0aGluZyB3aXRoIFBS
RUVNUFRfUlQuDQo+IA0KPiBTbyBJIHJlbGVhc2VkIHY2LjEyLjgtcnQ4IGFuZCB2Ni4xMy1yYzYt
cnQzLiBMb29raW5nIGF0IHRoZSBsYXp5IGJpdHMgSSB0aGluayBJDQo+IGp1c3QgZm9yd2FyZCB5
b3VyIHBhdGNoIHRvIHRoZSBzdGFibGUgcXVldWUgZm9yIHY2LjYuDQoNCkkgZGlkIHNvbWUgYmFz
aWMgdGVzdGluZyBvbiA2LjEyLjgtcnQ4IGFuZCB0aGF0IHdvcmtlZCBmaW5lIHdpdGggYm90aCBw
cmVlbXB0X2xhenkgYW5kIHByZWVtcHRfcnQuDQoNCkZvciB3aGF0IGl0J3Mgd29ydGgsIHdlJ3Zl
IGJlZW4gdXNpbmcgdGhlIHBhdGNoIGZvciA2LjYtcnQgZm9yIGFib3V0IGEgbW9udGggbm93IGlu
IGludGVybmFsIHRlc3RpbmcgYW5kIGhhdmVuJ3Qgc2VlbiBhbnkgb3RoZXIgaXNzdWVzLg0KDQpU
aGFua3MhDQpSb2JlcnQNCg==
