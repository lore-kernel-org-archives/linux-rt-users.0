Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010006.outbound.protection.outlook.com [52.101.84.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050EA53A7
	for <linux-rt-users@vger.kernel.org>; Mon,  8 Sep 2025 16:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757350376; cv=fail; b=RdXtTEim5t9L1sIpwtyXXILWyXPBGFBMfdkuCRyKuxLeyZARYqMntPEpnLlBgg+5ZFQ8XcDDQ4E22AjFJjQ0/JXITJfbXgOpo25+aF4W4c5/+nOVXYsICnRoN5RwD9UvEHKYS4EnQZ9uTVR0lenL34WuAHXS7okz8T3KeqQnzGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757350376; c=relaxed/simple;
	bh=oNfLX4dnUg5nJqluaeMv+4Wt1Jm1bpJQawKSd+2clnc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Tq1z6u7tOt+OSQg13fE5UZwjitlGhVB2QSlz5BddR+vvnRQFUD2lAG1DLQ479ICx06WNsLnL/Yhvl3QQdv1Kq5X/yn+Ovz9shOQSFhB9s+JZQK7PX2PeVmP5vZfAi9l+GXfnYAoNrsqtXMLlGZIsZoAx1F9uyQx7tz6u//b9dSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=L/kf3spF; arc=fail smtp.client-ip=52.101.84.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="L/kf3spF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tNg54r/IbO6fiavEmiFVs/gNAqe9r+WNYpVu4QrBZSlp77j+cjZHjoDeSKcP/HBbUF9bFsHUFfZbV2060/MdVOXtxMZYh//VeSlnD6yi2HFNTOPBBXUIwPykXFeiJ1k+EohAWLXcbIdlUWxlPCXJ+6Tf8BRlTbmRJgPrA3I0aF3C6i/bfSQlCSMSZ1T7MIk54nDPffsDuU+VzNziTpEPiPvKRKpfNQ1pZCFovOOdf53O7OAUsmhmWUNOwF8kmysx7O04uYR/cJIirJejaY42jQMoSQr1xs6OeTMAEnZ11OTjgzeFmdunPhlIcCqQ+9Zk4xaVbCXLayw36ZbLrUq5Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNfLX4dnUg5nJqluaeMv+4Wt1Jm1bpJQawKSd+2clnc=;
 b=Mmr9qWt6sE0anTY93vUn7YT5z6dB4XdCvfX+W+yEDQtYKt0HyKG1hUq+8KzgqkNaWlx0SnZuYWvC/lkN3JJicf30MjD2Ov4nJHPLOsDMHsLbc3Dja7+ZULV4fgFe3lSlV4wEfN2rtbpNGnxrgvBSsYC0EQy8sRntvl+z08fpyDS/n8/U0LfZJxDKO83RtGDF2aiS4ynxGGCg/C6WqwsUPcDowLEtRPiSxdWZbYNprwRpFxYwXBPx9FK2Z4LV8c224/sig69cVdZpWghKC1Cr6+QuX64duOyziSrzGPkvKebJR6rV2571Sf9XqqkZ8d9jVC9WgzME7NJFQLqzeFC2yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNfLX4dnUg5nJqluaeMv+4Wt1Jm1bpJQawKSd+2clnc=;
 b=L/kf3spFDZdCRN758hHOwYG8rZc25hthsf2ba3CDkf3ypXaSwmy7gKV0LdKoHQ3DXgUK9QixFcAT8i3abnn0hGBgZhwXLCaG69T53YszjdcBb94cDX23V5IIvn7XiFC64aeKcU8uPkcckFKMvSk2J310Doueagkaku0775rXJJPWqP+VimZPTK5DZa0frcT8oDhOWcQPoaw6PjoUIMLGcYPkKHzJnyWF2dpRnzGrxhI0Qn28RInCDfgQsDJVgPMEyVjN5NB7QYI4OceOoEUQBCBjtyYN47BydQek1fZ8QFu7mD7MFvbJTuQm3gjtEUvC78VFnq7ZsKcAi1AqR4eHBw==
Received: from AS1PR04MB9501.eurprd04.prod.outlook.com (2603:10a6:20b:4d2::5)
 by AS5PR04MB9756.eurprd04.prod.outlook.com (2603:10a6:20b:677::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.14; Mon, 8 Sep
 2025 16:52:50 +0000
Received: from AS1PR04MB9501.eurprd04.prod.outlook.com
 ([fe80::e688:111a:fdd:4d85]) by AS1PR04MB9501.eurprd04.prod.outlook.com
 ([fe80::e688:111a:fdd:4d85%2]) with mapi id 15.20.9115.010; Mon, 8 Sep 2025
 16:52:50 +0000
From: Rui Sousa <rui.sousa@nxp.com>
To: Marc Gonzalez <marc.w.gonzalez@free.fr>, John Ogness
	<john.ogness@linutronix.de>, Leon Woestenberg <leon@sidebranch.com>, Daniel
 Wagner <dwagner@suse.de>
CC: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Daniel Wagner
	<daniel.wagner@suse.com>, Clark Williams <williams@redhat.com>, Pavel Machek
	<pavel@denx.de>, Luis Goncalves <lgoncalv@redhat.com>, John McCalpin
	<mccalpin@tacc.utexas.edu>
Subject: RE: [EXT] Re: Large(ish) variance induced by SCHED_FIFO
Thread-Topic: [EXT] Re: Large(ish) variance induced by SCHED_FIFO
Thread-Index:
 AQHcHj67UKiRHWx+bk+p0wWAnQ3v5rSEk/OAgAALMQCAABmGgIAACT2AgAAZ64CABC+pAIAAZocAgAAQ1lA=
Date: Mon, 8 Sep 2025 16:52:50 +0000
Message-ID:
 <AS1PR04MB95012A6D68FC8F5D446E3E56E80CA@AS1PR04MB9501.eurprd04.prod.outlook.com>
References: <5f7496eb-bf62-4cc9-bef0-9cae97a93dca@free.fr>
 <ac1ef5df-aa30-4b63-9beb-3e0522dd3cec@flourine.local>
 <afc4c145-4758-4924-b106-e7844624d269@free.fr>
 <841polf13z.fsf@jogness.linutronix.de>
 <42c5fb53-d423-41a5-80d9-557ff2a3e804@free.fr>
 <84ldmsevcm.fsf@jogness.linutronix.de>
 <3f1d4229-a95c-4d99-a98f-249d9e488b32@free.fr>
 <84ldmp8ewv.fsf@jogness.linutronix.de>
 <3fe55967-b4fa-4bc1-ae2b-58b5d1bbf3ea@free.fr>
In-Reply-To: <3fe55967-b4fa-4bc1-ae2b-58b5d1bbf3ea@free.fr>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR04MB9501:EE_|AS5PR04MB9756:EE_
x-ms-office365-filtering-correlation-id: a28a4b63-c2b1-42f3-9eee-08ddeef8256a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014|19092799006|38070700018|15866825006|41080700001;
x-microsoft-antispam-message-info:
 =?utf-8?B?UDZzeCtJT2wzT3MzalVlcDFlTjFWTTJFb0FTU3dpSFdzUms4NTY0MzFMZzJv?=
 =?utf-8?B?ZERWUjM4Mms5WGUxQWlZcFRDM0dRZ2t6ZmkyMlVDZFV5UlFuK3J2SkdIQzJw?=
 =?utf-8?B?SnVqVWNVQmlyNkpDZWswSW5JaVBHalYySFBMcTZBZTNnQmxwMEk0UjByRWFn?=
 =?utf-8?B?a0JXWmlTZk5BR2ZIK1FCYm9MQmlJUmVKWVFKOGlmYzIxVVBNUlBrTEhTZzBC?=
 =?utf-8?B?NkVsVkVUUXVxTVlaQXlJSXlSbDhjM08vclFnUXZuOVRpWGRjemd1a0NUYUZH?=
 =?utf-8?B?KzVyTGRFMlFrTU51UnhFZ2ZLUERpMUN4SXc5cVZ2Z0lLN3hlUkZReXdVcE1v?=
 =?utf-8?B?ZldBVG5kdmNhcHpCS21pWjBUdXZCU0psMjJOcEJQejBzRDJBUXlOU0kzVDAv?=
 =?utf-8?B?ZHpSQTdHNGx4WXlneisvRHJEUWsrZnJLKzRhYWhqY1k4dmorcE90VFM4UURa?=
 =?utf-8?B?QmcraC9VZkFwSFFoU2J3eEFDOEtCUFN1andmNEJjRTcvenFWRXliNzV2bWpJ?=
 =?utf-8?B?RDFZajBaS1EzYkoweHVxMW9GcjVOc1RqMGwrV1kvbHZFU09hU1AzYXRaZEZt?=
 =?utf-8?B?TGNaRmhEWElmV3duR1Ayb3J0Um9BNGRTT3RuaVdDVWVKbHdXOTFkZ2lITmtP?=
 =?utf-8?B?OXZ3MFpqMlVBV3dZZUFFZ2tBNk1iRVFOSExzS2ppcVBEc3hVV0grd1JyV0ZR?=
 =?utf-8?B?QUtsL1ZITGJ2TWVVRkJSakxnMVdkUXVFc1dZRXZHZHFWeUk4Z1psbzdXSnc0?=
 =?utf-8?B?dUkvdmQzK21SZ1JoMmNrRmNlbmlsWDlmWGJuVnZkeHlOcUpQUzZuMUhBQW5E?=
 =?utf-8?B?c2QzSFJKemhhV1d0b3A5SEtubmtPMXJVajZUekpCdlorblFWcGl6NHBwNDE0?=
 =?utf-8?B?aTNPSGI5SlQ4clg5bnc5TWZBWDRqZEVJRlJxYnVHSXFTVTBwZkdXQnF6SURK?=
 =?utf-8?B?dGtVbE81NE9zRlMybHBrN0oxV3pkcXdEd1ZpTEVnaTlUT1FOK0FYZmxJblI3?=
 =?utf-8?B?ZFRoMDIraVdQVFdMQW4yKzBFdTA1SmRPN2Zkd2M5MXN0NHVXdVAvS0V3dmd3?=
 =?utf-8?B?a3FjYythTkkrL2kyNWx2REF4azlWOHJ6cXV3eG9xUDI5MW03Nkczcm9nUURo?=
 =?utf-8?B?SW5vdVhvRGtGRFAxN1d5Y0huckVZbnVmaW5mNHFxWFZpd0hLN1BhczZJaSs0?=
 =?utf-8?B?QU05Vk92UmhGNGxYSHltQkRxV1E5OHBnUFNSUytpaGd0cnhwWHorVzloVUxX?=
 =?utf-8?B?Zm1OMis4UzlianFJNXB3VzQ4Q3p1blZaWm9jOWpnbUw4VUVVSWgxbnJBL1l5?=
 =?utf-8?B?ZVpUOXRSV0ljL3IydWl3Z2RmOXpzNlpZT2ZwSXhGY3pNbTc0bXFrSVRuUm52?=
 =?utf-8?B?Q3BNZjY2UDNMeXczZUlURlBhS2REWFBIQ0M1KzNXZEpGQm1hdEtmcGxYQXRM?=
 =?utf-8?B?cFJ5L1UybXNxci9oZkQ0R2ZieHRLLzFTZTVicUtVb2pITVpBT3ZoTG5COGRX?=
 =?utf-8?B?cGpXdzlsWVg1T1lDUmYvV2I4V0lnd1MzRjJUY0RBc2NmSGROZXM2NCtVM29R?=
 =?utf-8?B?dHhRK2dRRVB3WUcwNS9LUkFrMlE3TFljVDBOeitRdGdHL3U5TE9KLzZyeGlE?=
 =?utf-8?B?Q0pScm44Wnptdkg3QkpqN0lyajN4dWU2SlR0N2lvUi9JeUdvM1NQaGZoTWEr?=
 =?utf-8?B?OXlvUGZBVWduY0lvYW1SaGQ1ZzVPS2cxQkhlSFRVeVAza1ErTCtRS1lrelNZ?=
 =?utf-8?B?UmIya0tLNFdXZzE1N3BxZTI4UEM1cmJ0Z3VqZGszQWJibVRCM1licFhWUm1F?=
 =?utf-8?B?blZMVkxFSTRkTXIyYnlFZFM3QmFEZUc2cktaRlVPWUpyY01YTFlYeEp3aml6?=
 =?utf-8?B?UkZVSjVoenFNQXJUS1BndVRyYTVQRDFVMExUUTJ5ejUwTVQvdmFSTEdid0Y1?=
 =?utf-8?B?UlRzbGJIMzlxU3Q2aGdKRVRoZmdjUFJNdEZLeVhkSjRSMnZYR1JPQW5vT2lY?=
 =?utf-8?B?SG83cGhkam1TaVV6VUdBR2k1dkxKWTRZdURPQlgxclJOVCtKa05SeHhXdGN1?=
 =?utf-8?B?YjZ2ckpuZUdxcmhQN0d1bFhyaWt0bGlsY2RtQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9501.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(19092799006)(38070700018)(15866825006)(41080700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cFkyU3FwdWg1ZEpnSVMxUEhITnJTaUtCWHF0MS80OG9ZdjRSWG0ySzBQS01p?=
 =?utf-8?B?R0F1UXFOSUc2anZGbVJSd1p2OVJOZTFVdll6YmxHazNSUjRkQklkcEVzQ0I3?=
 =?utf-8?B?eDArbStwRXBjY2MrcDlKNkJWY2FZVUJTQzFEM3RRQVVrOCtSWWYrRm8rK3Ar?=
 =?utf-8?B?TUg4eHo4S2Nxdlc5MEFjTGpTSFI1MmpSR0tDdHhFQkZJcklXODdCQzJtN2Na?=
 =?utf-8?B?SmxZMnI5R3A1QndGMmxIME1GWER5ZVhlYjZSNUlZZDVSY2orVXpyVHgwRHJM?=
 =?utf-8?B?VU9PSS83QlpybEN4c0ZZRmF6d2VwT2Y2Ni9YcG5nUzN6bWh1aTJ2YXRCSi83?=
 =?utf-8?B?dVFjYUVVRktYYlhLT3NuR1dDbDhzTldvREpHbDJwMk51bHA4MS9sdW9wVDI1?=
 =?utf-8?B?b3lUM0RUcGVHbUlWU0FyUW05L2hVd1EzOHFLVTB2OVJlcmw2YWlaQUUxUDZL?=
 =?utf-8?B?N2lyMTRJdVE2VHhKYmFDNGtzL3dQdEVYMUVENFpzSmx2TGlBd2M0dUh4YzJs?=
 =?utf-8?B?ZHJka2VJOFdqQ0ZtNGVJenZxTTNwNEM0cUUvTVM3bktZeGZUZjQ2QnpUSEhn?=
 =?utf-8?B?OUFCZitYMVk1MUxlRHdvR3F0MUNxRXB2MWhwV3RaQytWdTZ6SXNXeEs5ME5P?=
 =?utf-8?B?R25KaXVaZ1AxaWxTWjZrNTNLVEVFUzRNb2VuekdYam5OaW5uYXRXb3YvajFR?=
 =?utf-8?B?MUs1Qzl6QmR2WEFabE83cEpEa3BLTUZsRDNGRElqcFQvbElDdEZmdEZNekk1?=
 =?utf-8?B?T2dTOVBTdXNsTk4ybkRuaFhuSHZYUS8wa2JlWDkxK1dvY1A4UmlLLzRJRVFz?=
 =?utf-8?B?V1lldGlxZFlyWDdpVThqTnptYVY4SXVQMTExWWR0d2Qra2lkV0ZMb1d3blEw?=
 =?utf-8?B?VUM3OTBHcUhBMVU5ZkJzTi8rZmtzbnFnY0hjY1E4cWJEeXNmMm5zMC9VTnM2?=
 =?utf-8?B?M1haNG8vQUQ3aDhzYzRLUGZ3d0JkUEdacXFLczFYZUgvNG5KYS8xbDBGUU5K?=
 =?utf-8?B?L3Q1NklUWjRpaG5JK0EwVEtpcmhUaXVHUkQ4R3FuNnZ1cDFwV3V3NjZVMDdO?=
 =?utf-8?B?eDhuTWdkYm5OTG9JVXEyWnFEUG80SHRKVXgyNHNaMnpmWGQ0QnhmcmIyNlA3?=
 =?utf-8?B?aStQMmt6VXFncFFBa0MrclJXUVRWUzF3eHJhN2xzSHh3R0ppbjB2TmxKMEg5?=
 =?utf-8?B?cVVXWGROaTM2Z3VyZjFra1kvR2JOcTk2QXNWbG5DVGlSRSt5M0FzczhROVNF?=
 =?utf-8?B?Rk5MQncwckFDN2xNMmVuT2JZNFBIUWdQdEZyVGp5TTJiTVlDTXcyMkVqR3JS?=
 =?utf-8?B?cTlXZ0hsVVVGVm1tTVlmQ0Q5MW1lQTFXYXl1WFpLYzBscG5uNHBYV0JES2ZZ?=
 =?utf-8?B?K09nMzFpVkRsK2dsSzJYR2lCOUpvSWRiU2l0ZjF1UzJQOGFuSFY2L0IrWGpU?=
 =?utf-8?B?Zk9OMGRqNml1UjRabVU1b1htbzBza0xvcFU0ZXYrQ2laTVlCOFRhdHZtVW1t?=
 =?utf-8?B?U2NPeTRESCtvMGk1SW95azVPL2g4YnBuUFZrNHNRdmMvRXh4cDh3b3daM3BJ?=
 =?utf-8?B?WEI3eGppWEd4OFlURHo4VzJlZmhyWWNOTFgrcEVjakdNNGV3VmpHTnYvT1BU?=
 =?utf-8?B?VVIwK2I0Tkt4TjQ3bjhnQXR0MUE5Q2MyRWdnLzRyeU9zNWUzSzhoU3VKUzdw?=
 =?utf-8?B?dnBpT1Qrd21KNWxKVnZZNWRaL05rYWt6K2Q4Uzk4K21nRk9XTU9MMFlXNEdG?=
 =?utf-8?B?L0FZVWoxR3phbUxrUVJvTGtaZlladXNWVjRMOTg4MVNSUHdBK003N0NtRlZK?=
 =?utf-8?B?MmppRGxuYU0xM0pBQTFsWTkvL3VqUitUSWI2dytxaHdsOUlnWndVRE1CUko4?=
 =?utf-8?B?REgwamhrb3ZpKzl1NXJnNDlGdzMrVU82VTR3QUl1c1NlOXRneUNkaVdZWGhZ?=
 =?utf-8?B?aG51KzNHa0htUTlVcDBhcXNoVDJFbERKYXlpMVd2UzFOdXdHc0lSMVBtaHR2?=
 =?utf-8?B?VzBZeHF3ZUNQQ2NQblIxUWxWZ2l0bVg3ZUF6SFBtY0M4aDRqRHVkNytwOWxY?=
 =?utf-8?B?NG0rV2UxcE1UYWZxZFRFM3hndXlFTWU1TiswTFRBSU82VFRqOVlRRTNKTTBw?=
 =?utf-8?B?SktudTMvTitmL3QyYkQrRFhUakEwbytITjEzRktNbTdpVGp2Z0FVdnNxaDBU?=
 =?utf-8?Q?rsGGbl3DgRD3iT71WoAR+yY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9501.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a28a4b63-c2b1-42f3-9eee-08ddeef8256a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2025 16:52:50.3020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D9EIeqXD1UEhyDrVFJ8ixGKBkpH8iPieVLwX4WNl/3hgKM7/ANxc1DAFdgR1ia07cnegfEr6leMiOcpZFYalSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9756

SGkgTWFyYywNCg0KSnVzdCByZXBsYWNlIHlvdXIgbGFzdCBzZXR1cCBzY3JpcHQgbGluZSB3aXRo
Og0KZWNobyAtMSA+IC9wcm9jL3N5cy9rZXJuZWwvc2NoZWRfcnRfcnVudGltZV91cw0KDQo/DQpZ
b3UgYXJlIHJ1bm5pbmcgYSByZWFsdGltZSB0YXNrIGZvciBhIGxvbmcgd2hpbGUsIGJ1dCB5b3Ug
aGF2ZSBydCB0aHJvdHRsaW5nIGVuYWJsZWQuIEF0IHNvbWUgcG9pbnQgaXQgd2lsbCB0cmlnZ2Vy
LCBhbmQgeW91IGhhdmUgbm8gY29udHJvbCBvZiB3aGVuLiBJIGJlbGlldmUgeW91IGFyZSBzZWVp
bmcgcmVndWxhciB0YXNrcw0KQmVpbmcgc2NoZWR1bGVkIGluIHRoZSBtaWRkbGUgb2YgdGhlIGJl
bmNobWFyayBtZWFzdXJlbWVudC4NCg0KRGlzYWJsaW5nIHRocm90dGxpbmcgbWF5IGJsb2NrIHlv
dXIgZW50aXJlIHN5c3RlbSB3aGlsZSB0aGUgYmVuY2htYXJrIGlzIHJ1bm5pbmcsIHNvIGxvd2Vy
IHRoZSBwcmlvcml0eSBhIGJpdCBhbmQgdXNlIGFmZmluaXR5IHRvIGxhbmQgdGhlIGJlbmNobWFy
ayBwcm9jZXNzIGluIGEgY29yZSB0aGF0IGlzIG5vdCB1c3VhbGx5IHVzZWQ/DQoNCkJyDQpSdWkN
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJjIEdvbnphbGV6IDxt
YXJjLncuZ29uemFsZXpAZnJlZS5mcj4NCj4gU2VudDogTW9uZGF5LCBTZXB0ZW1iZXIgOCwgMjAy
NSAxNzo0Mw0KPiBUbzogSm9obiBPZ25lc3MgPGpvaG4ub2duZXNzQGxpbnV0cm9uaXguZGU+OyBM
ZW9uIFdvZXN0ZW5iZXJnDQo+IDxsZW9uQHNpZGVicmFuY2guY29tPjsgRGFuaWVsIFdhZ25lciA8
ZHdhZ25lckBzdXNlLmRlPg0KPiBDYzogbGludXgtcnQtdXNlcnNAdmdlci5rZXJuZWwub3JnOyBT
dGV2ZW4gUm9zdGVkdCA8cm9zdGVkdEBnb29kbWlzLm9yZz47DQo+IFRob21hcyBHbGVpeG5lciA8
dGdseEBsaW51dHJvbml4LmRlPjsgU2ViYXN0aWFuIEFuZHJ6ZWogU2lld2lvcg0KPiA8YmlnZWFz
eUBsaW51dHJvbml4LmRlPjsgRGFuaWVsIFdhZ25lciA8ZGFuaWVsLndhZ25lckBzdXNlLmNvbT47
IENsYXJrDQo+IFdpbGxpYW1zIDx3aWxsaWFtc0ByZWRoYXQuY29tPjsgUGF2ZWwgTWFjaGVrIDxw
YXZlbEBkZW54LmRlPjsgTHVpcw0KPiBHb25jYWx2ZXMgPGxnb25jYWx2QHJlZGhhdC5jb20+OyBK
b2huIE1jQ2FscGluIDxtY2NhbHBpbkB0YWNjLnV0ZXhhcy5lZHU+DQo+IFN1YmplY3Q6IFtFWFRd
IFJlOiBMYXJnZShpc2gpIHZhcmlhbmNlIGluZHVjZWQgYnkgU0NIRURfRklGTw0KPiANCj4gQ2F1
dGlvbjogVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIHRha2UgY2FyZSB3aGVuIGNs
aWNraW5nIGxpbmtzIG9yIG9wZW5pbmcNCj4gYXR0YWNobWVudHMuIFdoZW4gaW4gZG91YnQsIHJl
cG9ydCB0aGUgbWVzc2FnZSB1c2luZyB0aGUgJ1JlcG9ydCB0aGlzIGVtYWlsJw0KPiBidXR0b24N
Cj4gDQo+IA0KPiBPbiAwOC8wOS8yMDI1IDExOjM2LCBKb2huIE9nbmVzcyB3cm90ZToNCj4gDQo+
ID4gVGhlcmUgYXJlIHN0aWxsIHJlYXNvbnMgd2h5IENMT0NLX01PTk9UT05JQ19SQVcgbWlnaHQg
YmUNCj4gPiBpbnRlcmVzdGluZy4gRm9yIGV4YW1wbGUsIGlmIHlvdSB3YW50IGEgdmVyeSBzdGFi
bGUgdGltZSBzb3VyY2UgdG8NCj4gPiBjb21wYXJlIGludGVydmFscywgYnV0IGRvIG5vdCBjYXJl
IHNvIG11Y2ggYWJvdXQgdGhlIHJlYWwgd29ybGQgdGltZQ0KPiA+IGxlbmd0aHMgb2YgdGhvc2Ug
aW50ZXJ2YWxzIChpLmUuIHdoZXJlIGlzIHRoZSBncmVhdGVzdCBsYXRlbmN5IHZzLiB3aGF0DQo+
ID4gaXMgdGhlIHZhbHVlIG9mIHRoZSBncmVhdGVzdCBsYXRlbmN5KS4gQWx0aG91Z2ggZXZlbiBo
ZXJlLCBJIGRvdWJ0DQo+ID4gQ0xPQ0tfTU9OT1RPTklDX1JBVyBoYXMgYSBwcmFjdGljYWwgYWR2
YW50YWdlIG92ZXINCj4gQ0xPQ0tfTU9OT1RPTklDLg0KPiANCj4gSW4gZmFjdCwgSSdtIGp1c3Qg
dHJ5aW5nIHRvIGNvbXBhcmUgdGhlIHJ1bi10aW1lIG9mIDIgbWlub3INCj4gdmFyaWF0aW9ucyBv
ZiB0aGUgc2FtZSBwcm9ncmFtICh0ZXN0aW5nIG1pY3JvLW9wdGltaXphdGlvbnMpLg0KPiANCj4g
QWJzb2x1dGUgcnVuLXRpbWUgaXMgbm90IHJlYWxseSBpbXBvcnRhbnQsIHdoYXQgSSByZWFsbHkg
d2FudA0KPiB0byBrbm93IGlzOiBkb2VzIHYyIHJ1biBmYXN0ZXIgb3Igc2xvd2VyIHRoYW4gdjE/
DQo+IA0KPiBUaGlzIGlzIHRoZSBmcmFtZXdvcmsgSSdtIHVzaW5nIGF0IHRoaXMgcG9pbnQ6DQo+
IA0KPiAjaW5jbHVkZSA8c3RkaW8uaD4NCj4gI2luY2x1ZGUgPHRpbWUuaD4NCj4gZXh0ZXJuIHZv
aWQgbXlfY29kZSh2b2lkKTsNCj4gDQo+IHN0YXRpYyBsb25nIGxvb3AoaW50IGxvZzIpDQo+IHsN
Cj4gICAgICAgICBpbnQgbiA9IDEgPDwgbG9nMjsNCj4gICAgICAgICBzdHJ1Y3QgdGltZXNwZWMg
dDAsIHQxOw0KPiAgICAgICAgIGNsb2NrX2dldHRpbWUoQ0xPQ0tfTU9OT1RPTklDLCAmdDApOw0K
PiAgICAgICAgIGZvciAoaW50IGkgPSAwOyBpIDwgbjsgKytpKSBteV9jb2RlKCk7DQo+ICAgICAg
ICAgY2xvY2tfZ2V0dGltZShDTE9DS19NT05PVE9OSUMsICZ0MSk7DQo+ICAgICAgICAgbG9uZyBk
ID0gKHQxLnR2X3NlYyAtIHQwLnR2X3NlYykqMTAwMDAwMDAwMEwgKyAodDEudHZfbnNlYyAtIHQw
LnR2X25zZWMpOw0KPiAgICAgICAgIGxvbmcgdCA9IGQgPj4gbG9nMjsNCj4gICAgICAgICByZXR1
cm4gdDsNCj4gfQ0KPiANCj4gaW50IG1haW4odm9pZCkNCj4gew0KPiAgICAgICAgIGxvbmcgdCwg
bWluID0gbG9vcCg0KTsNCj4gICAgICAgICBmb3IgKGludCBpID0gMDsgaSA8IDIwOyArK2kpDQo+
ICAgICAgICAgICAgICAgICBpZiAoKHQgPSBsb29wKDgpKSA8IG1pbikgbWluID0gdDsNCj4gICAg
ICAgICBwcmludGYoIk1JTj0lbGRcbiIsIG1pbik7DQo+ICAgICAgICAgcmV0dXJuIDA7DQo+IH0N
Cj4gDQo+IEJhc2ljYWxseToNCj4gLSB3YXJtIHVwIHRoZSBjYWNoZXMNCj4gLSBydW4gbXlfY29k
ZSgpIDI1NiB0aW1lcyAmJiBjb21wdXRlIGF2ZXJhZ2UgcnVuLXRpbWUNCj4gLSByZXBlYXQgMjAg
dGltZXMgdG8gZmluZCBNSU5JTVVNIGF2ZXJhZ2UgcnVuLXRpbWUNCj4gDQo+IFdoZW4gbXlfY29k
ZSgpIGlzIGEgdHJpdmlhbCBjb21wdXRhdGlvbmFsIGxvb3Agc3VjaCBhczoNCj4gDQo+ICAgICAg
ICAgbW92ICQoMTw8MTIpLCAlZWF4DQo+IDE6ICAgICAgZGVjICVlY3gNCj4gICAgICAgICBkZWMg
JWVjeA0KPiAgICAgICAgIGRlYyAlZWF4DQo+ICAgICAgICAgam56IDFiDQo+ICAgICAgICAgcmV0
DQo+IA0KPiBUaGVuIHJ1bm5pbmcgdGhlIGJlbmNobWFyayAxMDAwIHRpbWVzIHJldHVybnMgdGhl
IHNhbWUgdmFsdWUgMTAwMCB0aW1lczoNCj4gTUlOPTI3MzcNCj4gDQo+IA0KPiBPYnZpb3VzbHks
IHRoZSBwcm9ncmFtIEknbSB3b3JraW5nIG9uIGlzIGEgYml0IG1vcmUgY29tcGxleCwgYnV0IGJh
cmVseToNCj4gLSBubyBzeXN0ZW0gY2FsbHMsIG5vIGxpYnJhcnkgY2FsbHMNCj4gLSBqdXN0IHNp
bXBsZSBiaXQgdHdpZGRsaW5nDQo+IC0gdGlueSBjb2RlLCB0aW55IGRhdGEgc3RydWN0dXJlcywg
ZXZlcnl0aGluZyBmaXRzIGluIEwxDQo+ICQgc2l6ZSBhLm91dA0KPiAgICB0ZXh0ICAgIGRhdGEg
ICAgIGJzcyAgICAgZGVjICAgICBoZXggZmlsZW5hbWUNCj4gICAgODU0OSAgICAgNjMyICAgIDEw
NzIgICAxMDI1MyAgICAyODBkIGEub3V0DQo+IA0KPiBXaGVuIEkgcnVuIHRoZSBiZW5jaG1hcmsg
MTAwMCB0aW1lcywgdGhlcmUgYXJlIHNvbWUgbGFyZ2Ugb3V0bGllcnM6DQo+IE1JTl9NSU49MjUw
Mg0KPiBNQVhfTUlOPTI3NzQNCj4gDQo+IE5PVEU6IDk1JSBvZiB0aGUgcmVzdWx0cyBhcmUgYmVs
b3cgMjUzNi4NCj4gQnV0IHRoZSB0b3AgMSUgKHdvcnN0IDEwKSBhcmUgcmVhbGx5IGJhZCAoMjY0
Ni0yNzc0KQ0KPiANCj4gSG93IHRvIGdldCByZXBlYXRhYmxlIHJlc3VsdHM/DQo+IA0KPiBSYW5k
b20gMTAlIG91dGxpZXJzIGJyZWFrIHRoZSBhYmlsaXR5IHRvIG1lYXN1cmUgdGhlIGltcGFjdA0K
PiBvZiBtaWNyby1vcHRpbWl6YXRpb25zIGV4cGVjdGVkIHRvIHByb3ZpZGUgMC0zJSBpbXByb3Zl
bWVudHMgOigNCj4gDQo+IEZvciByZWZlcmVuY2UsIHRoZSBzY3JpcHQgbGF1bmNoaW5nIHRoZSBi
ZW5jaG1hcmsgZG9lczoNCj4gDQo+IGVjaG8gICAgIC0xID4gL3Byb2Mvc3lzL2tlcm5lbC9zY2hl
ZF9ydF9ydW50aW1lX3VzDQo+IGZvciBJIGluIDAgMSAyIDM7IGRvIGVjaG8gdXNlcnNwYWNlID4N
Cj4gL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvY3B1JEkvY3B1ZnJlcS9zY2FsaW5nX2dvdmVybm9y
OyBkb25lDQo+IHNsZWVwIDAuMjUNCj4gZm9yIEkgaW4gMCAxIDIgMzsgZG8gZWNobyAgIDMwMDAw
MDAgPg0KPiAvc3lzL2RldmljZXMvc3lzdGVtL2NwdS9jcHUkSS9jcHVmcmVxL3NjYWxpbmdfc2V0
c3BlZWQ7IGRvbmUNCj4gc2xlZXAgMC4yNQ0KPiANCj4gZm9yIEkgaW4gJChzZXEgMSAxMDAwKTsg
ZG8NCj4gY2hydCAtZiA5OSB0YXNrc2V0IC1jIDIgLi9hLm91dCA8ICQxDQo+IGRvbmUNCj4gDQo+
IGZvciBJIGluIDAgMSAyIDM7IGRvDQo+IGVjaG8gc2NoZWR1dGlsID4gL3N5cy9kZXZpY2VzL3N5
c3RlbS9jcHUvY3B1JEkvY3B1ZnJlcS9zY2FsaW5nX2dvdmVybm9yDQo+IGRvbmUNCj4gZWNobyA5
NTAwMDAgPiAvcHJvYy9zeXMva2VybmVsL3NjaGVkX3J0X3J1bnRpbWVfdXMNCj4gDQo+IA0KPiBJ
J3ZlIHJ1biBvdXQgb2YgaWRlYXMgdG8gaWRlbnRpZnkgb3RoZXIgc291cmNlcyBvZiB2YXJpYW5j
ZS4NCj4gKEkgcmFuIGV2ZXJ5dGhpbmcgaW4gc2luZ2xlIHVzZXIgbW9kZSB3aXRoIG5vdGhpbmcg
ZWxzZSBydW5uaW5nLikNCj4gUGVyaGFwcyB3aXRoIHBlcmYgSSBjb3VsZCBpZGVudGlmeSB0aGUg
c291cmNlIG9mIHN0YWxscyBvciBidWJibGVzPw0KPiANCj4gSG9waW5nIHNvbWVvbmUgY2FuIHBv
aW50IG1lIGluIHRoZSByaWdodCBkaXJlY3Rpb24uDQo+IA0KPiBSZWdhcmRzDQo+IA0KPiANCg0K
