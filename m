Received: from mx0a-000e8d01.pphosted.com (mx0a-000e8d01.pphosted.com [148.163.147.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354BD1E0B77;
	Tue,  7 Jan 2025 18:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.191
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736274706; cv=fail; b=mNfuQMcRJVZyJRGczHjVWYz0uXevUAAPKeHoi+11JOzW1Es0HyADHU8FT1z6dlHwp1/QYEr1FDlzrkltN5/l4d8PWGOGUhuH/riJmlpEpWsTMer7cMjd79J28IM0nLxjEVoWAJtwr1AW3Z/E2QgKR3fx3oPEZMhdBo6MBFqRgoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736274706; c=relaxed/simple;
	bh=Qt/T3vrbaWnvTXJ3iIA3gBH+C0wuEnYykM5pkiuMZF4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cAIQ9/tSSRr7DK7ENbhn9xO+a/uuccVghkYYbRKrlp1jKGHmM8XfhbL990s9WSqViiXgf+D54LTuFjgqe1cr7O5meRjz3kuoOoNqeCL9JKxzk+Fd/ZpasCC0IhcvRweh49qa1BFXBtBcesyNF+WpTeYhzFnF4qXbS/zEp6+2938=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=selinc.com; spf=pass smtp.mailfrom=selinc.com; dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b=StJsjVnm; dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b=bfx8ea4s; arc=fail smtp.client-ip=148.163.147.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=selinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=selinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b="StJsjVnm";
	dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b="bfx8ea4s"
Received: from pps.filterd (m0136172.ppops.net [127.0.0.1])
	by mx0b-000e8d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507EvTjs020041;
	Tue, 7 Jan 2025 10:09:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=sel1; bh=Qt/T3
	vrbaWnvTXJ3iIA3gBH+C0wuEnYykM5pkiuMZF4=; b=StJsjVnm6wJWkZZr03bow
	FgfijqWbNKsSUh7E9F4/iFMEt5Z/qBxyUJLPdbWi2abp6bEfgfPoB7vSiUqNF+lc
	pCvVFxvmqbIuXkMo3V4iv0UmF1M1n3spr/6HmWJwY6Fucq2Cqe0ARwA2OfKTz37E
	99a3hILT2us8JtMKTLiZ6H9iKNV0RBDOAK4y03yoh1TMqpfWes3pCIp5etlXLaT9
	iovUMeaZBhjK3vN0TkmGgmyPcG1QBvAofH5mHbqun2CXMnuPfXIa/9eFu1zYmWra
	a9rrrqARNa8rPpBS8eP0J4nKip8h9v1Nv7TKKXfmmsYC0YtvWNzJoZ2XO7SVsW/U
	w==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by mx0b-000e8d01.pphosted.com (PPS) with ESMTPS id 44162c05qj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Jan 2025 10:09:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZWQfTR2lB17H42GRLgvMnnpUZetXZnTZl6eC1tRDyhd/PKSZ64OSrsYl1Zqgia4MUprJAYNGkgWm3PBQpm6i6wnRWGpd48YXFG3k/NKnTjnJgP1HQkfugmd5zQrXN8pM1eLNS5O2qzL0sLtoUeWkO6B12dJNWhv8Kp/xq7m8Tt1vwY+Wz1r0cZkBRVRiHwj0i5ye9ZfGg9vM9Rgou56KEoLTY57yJw45U9CyyGz97vdd40uCIqQpQpfc6/1UQsGc+TCM65R+TWP6VCIYS+xnHmRCtHymShk6bqAU0RCMYwnLHo1OKFFGcwmMBNFzQi7Wmdz1RvNFW2vsQi+NzYveQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qt/T3vrbaWnvTXJ3iIA3gBH+C0wuEnYykM5pkiuMZF4=;
 b=Pw33sCL+sa2bZ0PeN7atbWIkUs+D6FmEYKlUcDnuU+sHpfqq9mAozH6Ig6FlWc8kkfsbimuT23zaNGCFrlemqlzT9XNJk67uN2R/H09w8Okp+ceD1x9tk4m4/vjtLkTcA7Db3CeZGqrKpl0YUMDXozkkEpC+juFAKwHsH2dhEPlxvUkGg3wi3LSBDU0/TbKgrTtSb86LU4IvUYFsjc6/wniIx96wLPPzKrntw6krnZsnJjR8fSAmrIyg6EiTkK1RHxyML26OECaiFsd3UVv6R8jvCg3n863GgT2a43MBN9/8lBd6bVyksIoBa50Na4VGA+VbIBJwy85MwbLSWxKlwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=selinc.com; dmarc=pass action=none header.from=selinc.com;
 dkim=pass header.d=selinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qt/T3vrbaWnvTXJ3iIA3gBH+C0wuEnYykM5pkiuMZF4=;
 b=bfx8ea4siZLyltGfNVjUVwI4YegoSiFmg8E+/Jtmg6xZPsmi7SvaQr8zKTm/p95mikzRxz8C6RFeBOXJ2/eqQ5epR8kM3KX02hNh4Wt4Zi5/gPiceU1gGc9loFQ8LpSp5KvNXPQOGJwjRvfajiaVzHpxL9k/jOWBI5+D3fhR/U4UhiLpTaE3cQzaL5UhRfEq+okEDUmtYZme4WWp+2mkVqx5Xxj6Cr5WR9GRu+6bIGjZUfUDdACvHWRzX5VLs1RHGUYrMhGN+FXfwQBzJyNXO7JorULJHgj/drKS2crjFSFnKaQKN1WVXua41GhmJNlNqaF2C5KvPY9wzBRyPIwLhQ==
Received: from SJ2PR22MB3822.namprd22.prod.outlook.com (2603:10b6:a03:4f9::18)
 by SN4PR22MB2839.namprd22.prod.outlook.com (2603:10b6:806:206::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 18:09:46 +0000
Received: from SJ2PR22MB3822.namprd22.prod.outlook.com
 ([fe80::216a:eac:870a:8f4b]) by SJ2PR22MB3822.namprd22.prod.outlook.com
 ([fe80::216a:eac:870a:8f4b%3]) with mapi id 15.20.8335.010; Tue, 7 Jan 2025
 18:09:46 +0000
From: Robert Joslyn <robert_joslyn@selinc.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "rostedt@goodmis.org"
	<rostedt@goodmis.org>,
        Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: RE: [PATCH] powerpc: Allow scheduling of IRQ with PREEMPT_RT
Thread-Topic: [PATCH] powerpc: Allow scheduling of IRQ with PREEMPT_RT
Thread-Index: AQHbV8o+5QBkEbRjDEWM0suiKTr7tbMLRq8AgAAArgCAAGR9YA==
Date: Tue, 7 Jan 2025 18:09:46 +0000
Message-ID:
 <SJ2PR22MB382271FBE556A6A4AD978F0CE5112@SJ2PR22MB3822.namprd22.prod.outlook.com>
References: <20241226191238.2559880-1-robert_joslyn@selinc.com>
 <20250107115606.q67--i0f@linutronix.de>
 <20250107115832.jLUSKKwG@linutronix.de>
In-Reply-To: <20250107115832.jLUSKKwG@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR22MB3822:EE_|SN4PR22MB2839:EE_
x-ms-office365-filtering-correlation-id: d51f30e8-889e-4035-f666-08dd2f4677ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?djVlRnBwRTU0OTg2QTR2enlJVENnSWJqNW5FdHpCSS9RdlBXdStQbWJEZWNR?=
 =?utf-8?B?eDFJL0hha2FqRjFwSEJOUTVNbkRnb0MvSEdXODY2ZExMbG5PWWpqQ3QzZXla?=
 =?utf-8?B?aXNpMWYzeDQ5SXNiR0FvYUNZZmlYb3hseVJyVERqT1JxL3NrRzAxbEZxRjd6?=
 =?utf-8?B?aGd2VWVaam9WL3hIYXJqVHhnT2JDakdDNUZMcXovbXh2SVRCMTRvY01kSEEz?=
 =?utf-8?B?N2dpY082am1HSXFCRGw3dER6cy9vY25wZlNTSGVRZlZMWG81Vkt3MEtva1lj?=
 =?utf-8?B?czVHL0U3STJhb1FjNDhVZzE3VGduclFtTzVMdld4K0hraldIMnRZS0ptWElo?=
 =?utf-8?B?ckdMSjk3SEFEUlEzdXdzNTBaYXRFbllDcElVUlEvNGRza3lqbkZuUjJ3c0o5?=
 =?utf-8?B?b21VMTR3Rmc2TmlqdGlnQk1SOHFKREV2L0FHaXF2dnZUMmJZcXpKaXNTS3RL?=
 =?utf-8?B?ZE84SGdldWVEZHlSbDc2OGZMWlF2aXI1QW9oUDFEOGwvTllQcUNRak5Zc2o4?=
 =?utf-8?B?bE5Ud0p0LzZpNEdzQ1h3ZTdJYTFrelloVGRQekI3cDZCMGxCWXQ1bnVubzJ1?=
 =?utf-8?B?SkVDcGE4TEZHQzUrUUJUbkJTVzYzeitNa0pBMUNXcm1oYVZobXFJeEVnR0ND?=
 =?utf-8?B?TVF4OUV3cUdJcTBnZzU0OTJTTi8zQmd5NW1WdytEMEQwSTJHL2p4dGxOYmYx?=
 =?utf-8?B?aFYzMmIyUlFLK0pweW5CYldZK0tZTXRkWDQrT2MxQVRCRzBjcGVNcWhYSDZE?=
 =?utf-8?B?ZW5Md2l6Mk9aQlkwelJra0ZyVjgwWTZLdVJxYzNlNGJTRVlHeDIzUUtwWnda?=
 =?utf-8?B?MFA0ckxvUEJWL2lzczBFamgzQnNKbXJJSngxM0Mwd1J3ckg4QXBPZDBYMHBj?=
 =?utf-8?B?T1ZPdWJqWVM4a1FLNEo3NFNYcTNSUGhCaDk3TzVsMDFQcnZjMFFzVlFKZ0RN?=
 =?utf-8?B?b1ZFNmpBN1VLd2ttRmlTUk1NckhvcmZvbEVyTWVkbFp2SGk4b3BzdU95cFlr?=
 =?utf-8?B?bklQQ0NoZncxRjdSakFkWDF6QkJQOGw0VURGQnp5cjErdHpXcjZqQ1RsNWZ1?=
 =?utf-8?B?ZmM3d0tHTDZzeEtkRlFmWjU2VC8xdlNBRU1mTTRYTnpHY04vVXdGSk9ZOVE4?=
 =?utf-8?B?N1Vlck1GTnNBdUZSckJmTVNsbUhsL2tDRGdJOHg4WGxzOEUwVksxZ01uMkM1?=
 =?utf-8?B?Z0ZoT3VrMUZsMlpBL0JHYmJCQVl6Z3AzaDRudHdKY3hQLzNCY0lUZ25vVFhV?=
 =?utf-8?B?OSs3TGpxVzMvMy83Q1RWRC9pOG5BK0EzNWVLSmJPdWpRcERodyt5WENxa25l?=
 =?utf-8?B?NlA4VnJaN2tTQjdFcWpZdUtJeUUyb1UrR0hDb1I0WTFxaTJwVzBWOHFqT1hr?=
 =?utf-8?B?YlJNVnZlc1JtYldTVmptdVZhZ0ZNdzJPcmUrVFVjQVNscDNHQnRidDhrQ29n?=
 =?utf-8?B?V3d4emtjbE9iNG5TQ3J4ZlpucGZpaW0wMkpCMkhTOU8vM0U1emNzT0VISWdW?=
 =?utf-8?B?SHBSeCs5L0oxMDdrdVZnZXE0L3djY2s0Y1RycU1DODh2ZTFEdXBQRlhscGcx?=
 =?utf-8?B?blFaU1Q0S1ROSkladFNNblZYQXh5ODZGejJONG1xUzZVUUZGZnIwQjJoV1pU?=
 =?utf-8?B?WUFSSmN0U29XQk5UYnlkUGNKcmU3UnRXRFpzWnErQUJLQlNkdW1LTHZvU2hL?=
 =?utf-8?B?YVFiV2I4N2RmcUwrVk04U1hEUm52QllNeHg2VkM4Y09BQlpreFFkVjBqNXBm?=
 =?utf-8?B?c1lFOXByK2hYbEYxVVl2cks0Z1daNHE4UnhsVEpBaUt4K0IxWGptYkVOY3Rl?=
 =?utf-8?B?c3VFMnMzTWhQVVZWL3pvNVloaC93a2NWUEUva25NQ21hazYvQWVDY3h1ZUFh?=
 =?utf-8?B?dE1pSWJ4ZnR3aGNpc2huSmgyQUFmOU9Zby92MnNIVjlRbWJNMlNaOCt1SDFu?=
 =?utf-8?Q?o2cruy0jLgaSI1XDcApYCFxT8wS4j3Tt?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR22MB3822.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TEZGNmdLbXpwZ1JsYjFyMEduTldwZkJtVXE3WWhjOThlMS9OV01hTGV2anpP?=
 =?utf-8?B?WnRHR0hjZ1Z0MlIrNU12U3pFem4ybjJnUkc3MzJuTHJvM3c5UDh1Wk50WWo5?=
 =?utf-8?B?UTY5YXR2S0sxVGxSdlFOWXlpRkRPb25NSnkwYUNQem4rbW5laVhPbmpoVEZT?=
 =?utf-8?B?MHNSNFBuZGxUa1NxMmJsaG9jOWhVcE1lVVdwdUI3VmNaT3l1Vi9rSjI4N2hj?=
 =?utf-8?B?K2VvbzJFRDNJamlBNzl1TU5MWFVuN1ViNHJnSlYxZlYvUjNoYkJjdEJ6cndu?=
 =?utf-8?B?clFhcVRDdW5SZjFkRkhxckJWL3MvSmt1djZEaGVwTk1vV1c3OFQ1anQwYmxt?=
 =?utf-8?B?RUdpZkJuenJSNFhBZWk3eFNVUk9tU3NLamptN1JUWXZ6VHhEa0MwSXpWMHdZ?=
 =?utf-8?B?N0JSbFNwZVdXZk5venR2bU9HMDJtUkJmbSt3dEdRRWR3RzBjSW52VHBHZ1lz?=
 =?utf-8?B?YTYrQUdzMXNDOS9BTEM0TU5zTEdjRzM4TkRHUmpvYUk4MG0wVlRDMDB6SHBC?=
 =?utf-8?B?cUFOZ0d4TzFuaWFsTkNLTHZRYUN4QWdQNGlEd2JjZ0I1Rk5aNDRsY00zQWVT?=
 =?utf-8?B?ak1EMUdTeEdBM0tqTTBGakNtUkU1UkoyaE1MMjlHS016L1VXYWFiZ09JZjRy?=
 =?utf-8?B?c1JmZnBpam5aMzE4VDhvRFVYeGRTSnJyaFBmZWFkMnJaRGpkczgwNTZlQXBZ?=
 =?utf-8?B?YlRWZDFDOEtiWXJOSzFab0YxenRrUGpyWG13U3E4bm8xMTlNdEJLbkdTSXNC?=
 =?utf-8?B?NXUzakxUNWlXbDJFalp2aUlOOEwwbmJxQUpmMXJSV0ZrYjdqam93QUdUa1gv?=
 =?utf-8?B?VG5DWUc0RDJTZWhDYzlPSzNrdkllUjE0TzRwQ3lNL3QxeHhWSG5QVzc0emRL?=
 =?utf-8?B?YllXWWxBZFNCc010bDRzYnErOUhxb3d6RElXS1p4ZXBEQnZ0TGhYWEkrS3Iw?=
 =?utf-8?B?VlE5ck80MjR1MDJUK2VvcW9tZkVIQ09GOGlUOHpyL0dYZHc1dG8zYVUyYmNJ?=
 =?utf-8?B?Y0VtcTc5UTJNYW0zY3ZvQ2l3N01nOTBVK1VTWFh4WDBLSXUzTHROWTdsTGQ0?=
 =?utf-8?B?VDhoVXZidU4zc3VIaVQ2VWNiajd3ZDBEc2pZeHRGRHQraHFsbXdXcFpvSEJR?=
 =?utf-8?B?cUNlQlU2SGh1YkZwMjdWV3NDMEVuQ25xM2R2aTg5Ym00WW1zcVI1bnA0Ni9a?=
 =?utf-8?B?QUdtT05KN0lQRWlzV1NqWGpVYlYxcHRHUDJjbWR3VXNLQ0VzYzl1dlZ5VDY0?=
 =?utf-8?B?dlp0dXh5bzQweEEzTjJHS2tSZWNxMGM0L3FwLzRWcWY4RUVJdmFUenJNL0dk?=
 =?utf-8?B?UnlTdER5YkRoZ21XMUV3QlF4cjNZTldBWVljcHFRVm5aTFE5M1Z1K09ZMFpM?=
 =?utf-8?B?VnJ3QU93d1EvZUNiTXFVak81MHUzMStsVjltczRidGZmTmVja0haTHhnanJI?=
 =?utf-8?B?RC9vYUJQVDliVE5vbHpzQU1pWGpFS0w3TG5uL2pOMkdGem9DMExiY2Z3REhz?=
 =?utf-8?B?Wm80SEcway9KUE1oUWNvQk1jMHI2WEEyWWFSbXc5N2MxQVI0U1NSWVRGRkQ4?=
 =?utf-8?B?SjZEamFpRU1iVGwwMGZvaUd0Z0NFSE5HUVE3aThuS1lNWUhlNE40L1hiMDFn?=
 =?utf-8?B?ZmtDVHAxbVJOMlhHVWxDVk84cmtaWkhzdnA5V2JpdWtjL1ZmMFlqSzRBTmNj?=
 =?utf-8?B?TnpmTW8rWDlWUG85R3RYL3ZleURLejZBYTdHQ1NQQjRXN1hWeTh6ZW1BNFpm?=
 =?utf-8?B?UlZ2TGphRjBYRmJ1dm9YUFJlNWt5M2dMVWtPZ0hKU1h3dGN2SmpWdlRhOUNQ?=
 =?utf-8?B?b1pQYWNHMnJVQks5ZFBXKy9jTTZ6UnkyWlpYaGZzL0kwS1JDcTQ4ZHJiZmZE?=
 =?utf-8?B?SW1ZZW81aHdHV1dHSEt2Y2V3OEVxM3Q1SEQ3SC9YcStYQUNIUnpBSmdrVHZw?=
 =?utf-8?B?aFN5eHhGSGJsN1BORkNlWmtGKzhsRm93bXRmcXpLSmgyZjhuWmVJcW1FOHFx?=
 =?utf-8?B?aFdmMjdMZUpIYUdhaFRtV1pzNHFlcU0yTFUyTDA1MzBQSnpGbmZxcEY4M3NC?=
 =?utf-8?B?dUFNbXl2Tmk0ZUtrNTV5SlZmUWErRzNEUHRCMXM1eUNkYzFEUWdnM1d1bzVB?=
 =?utf-8?Q?ug8aa7QHOaXGlMi+jGzk9D3iG?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR22MB3822.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d51f30e8-889e-4035-f666-08dd2f4677ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2025 18:09:46.3395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 12381f30-10fe-4e2c-aa3a-5e03ebeb59ec
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W0hgYEZLnS+rvFwAcL9yzYSEYHV+pucEjUiSULE816qfJfbqFJvvi1ezAVGdfi/Q6PFj0uhbpXpoylCwl86SAL0HjuiFAOo2KwRbw9NDuag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR22MB2839
X-Proofpoint-ORIG-GUID: wJkjNjpfGFERGAbQlWFDciYJEa5OLP5H
X-Proofpoint-GUID: wJkjNjpfGFERGAbQlWFDciYJEa5OLP5H
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 mlxlogscore=893 priorityscore=1501 malwarescore=0
 clxscore=1011 suspectscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501070150

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTZWJhc3RpYW4gQW5kcnplaiBT
aWV3aW9yIDxiaWdlYXN5QGxpbnV0cm9uaXguZGU+DQo+IFNlbnQ6IFR1ZXNkYXksIEphbnVhcnkg
NywgMjAyNSAzOjU5IEFNDQo+IFRvOiBSb2JlcnQgSm9zbHluIDxyb2JlcnRfam9zbHluQHNlbGlu
Yy5jb20+DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1ydC11c2Vy
c0B2Z2VyLmtlcm5lbC5vcmc7DQo+IHRnbHhAbGludXRyb25peC5kZTsgcm9zdGVkdEBnb29kbWlz
Lm9yZzsgU2hyaWthbnRoIEhlZ2RlDQo+IDxzc2hlZ2RlQGxpbnV4LmlibS5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0hdIHBvd2VycGM6IEFsbG93IHNjaGVkdWxpbmcgb2YgSVJRIHdpdGggUFJF
RU1QVF9SVA0KPiANCj4gW0NhdXRpb24gLSBFeHRlcm5hbF0NCj4gDQo+IE9uIDIwMjUtMDEtMDcg
MTI6NTY6MDggWyswMTAwXSwgVG8gUm9iZXJ0IEpvc2x5biB3cm90ZToNCj4gPiBPbiAyMDI0LTEy
LTI2IDExOjEyOjM4IFstMDgwMF0sIFJvYmVydCBKb3NseW4gd3JvdGU6DQo+ID4gPiBUaGlzIGJy
YW5jaCBpcyBuZWVkZWQgdG8gYWxsb3cgcHJlZW1wdGlibGUgSVJRcyB0byBiZSBzY2hlZHVsZWQs
DQo+ID4gPiBvdGhlcndpc2UgdGhlIGtlcm5lbCBoYW5ncyBkdXJpbmcgYm9vdCBvbiBteSBlMzAw
IGJhc2VkIHBsYXRmb3Jtcy4NCj4gPiA+IFRoaXMgYnJhbmNoIGlzIG5lZWRlZCBmb3IgYm90aCBD
T05GSUdfUFJFRU1QVCBhbmQNCj4gQ09ORklHX1BSRUVNUFRfUlQsDQo+ID4gPiBzbyBicm9hZGVu
IHRoZSBjaGVjayB0byBDT05GSUdfUFJFRU1QVElPTiwgd2hpY2ggaXMgc2VsZWN0ZWQgYnkgYm90
aC4NCj4gPiA+DQo+ID4gPiBUaGlzIHdhcyBwcmV2aW91c2x5IHNldCB0byBDT05GSUdfUFJFRU1Q
VElPTiwgYnV0IHdhcyByZXZlcnRlZCBhcw0KPiA+ID4gcGFydCBvZiByZW1vdmluZyBMQVpZX1BS
RUVNUFQgc3VwcG9ydC4NCj4gPg0KPiA+IEkgcmVtZW1iZXIgSSBwb2ludGVkIHRoaXMgb3V0IHdo
aWxlIFNocmlrYW50aCBwb3N0ZWQgdGhlIHByZWVtcHQtbGF6eQ0KPiA+IHBhdGNoZXMgYnV0IGRp
ZG4ndCByZWFsaXplIHRoYXQgSSBuZWVkIHRoaXMgaW4gUlQgdHJlZSwgdG9vLg0KPiA+DQo+ID4g
VGhlIGxhenktcHJlZW1wdCBwYXRjaGVzIGZvciBwb3dlcnBjIHdlcmUgbWVyZ2VkIHVwc3RyZWFt
LCBJIGFtIGdvaW5nDQo+ID4gdG8gcHVsbCB0aGVtIGludG8gdGhlIHY2LjYtc2VyaWVzLg0KPiA+
IEkgYW0gZ29pbmcgdG8gQ2MgeW91LCBob3BlZnVsbHkgeW91IGNhbiBjb25maXJtIHRoYXQgaXQg
aXMgd29ya2luZy4NCj4gDQo+IFJvYmVydCwgeW91IGFyZSByZWZlcnJpbmcgdG8gdjYuNi1SVCwg
Y29ycmVjdD8NCj4gDQo+IFNlYmFzdGlhbg0KDQpZZXMsIEknbSB1c2luZyA2LjYuNTgtcnQ0NSBh
dCB0aGUgbW9tZW50LiBXZSBmb3VuZCB0aGlzIHJlZ3Jlc3Npb24gd2hpbGUgdHJ5aW5nIHRvIHVw
ZGF0ZSBmcm9tIDUuMTAtcnQuIEkgaGF2ZW4ndCBwbGF5ZWQgd2l0aCBsYXp5LXByZWVtcHQgeWV0
IGJ1dCBJIGNhbiBjZXJ0YWlubHkgdGVzdCB0aGUgcGF0Y2hlcywgcHJlc2VudGx5IHdlIHJ1biBl
dmVyeXRoaW5nIHdpdGggUFJFRU1QVF9SVC4NCg0KVGhhbmtzLA0KUm9iZXJ0DQo=
