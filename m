Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013071.outbound.protection.outlook.com [40.107.159.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F8A2580EC
	for <linux-rt-users@vger.kernel.org>; Thu, 30 Oct 2025 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834007; cv=fail; b=O26/fo2vejOB5SGqHQ2X6Tku8Sd3qaUDWmwUcz11uI9ayssJz49c1W51d7OYjU3oJrCfEYEM9hJa4eHLdHfkshTrRBzAyBMcZ+jIVYsytfBMjzd/c/1V3QQ3goo3FlNtwqKa/S8OHps7BvLgMYfpQlpht534gQv1bAZxlkQvssU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834007; c=relaxed/simple;
	bh=ETz+EmGc2sUf6E+hP3xBM4eZieUgnAuVTkVrxtGCaC0=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TYDnO163x1b+gxHFdCiBYJXWllwBZdyBD4X2czA3nsKiWqPk2TLDDIbe0uMjiZmgL2fZDbDt0vmLY9ktj7LEa+aIICiW8hiRl3WJ6/NWEvItoXzJh+tXLgbmCdpXHTyAH6bjL6w9M4Rg+aq1gOKAj5d1cScQI1qD5Wy2kSeRpnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=uHbTlbx4; arc=fail smtp.client-ip=40.107.159.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="uHbTlbx4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sjLfhHKuz1k6gxuyR71y6vhvlHXzCc1znXL4siBPG9qAR3MJXgINefdBSERT8L+gRDE93s6Za3DhW8hFFLUmk6qTra+8JSyXXJH1+DrB/wFdNs7qCurZMLEb0CtK9XHZEyByK4pmOvrOTg201Em2vpW/ZPGDl+RhGsuTOmBFq+a0RFeYC9mzUVULyHallUjWXxare5iR5lPbG/1Ts5O8RdkIzjw16FQRF1z6vnlAw5f0LrFlqmQWs/4RkVYZwZDKLb3a4XQ/zwCrYLT6cljqUhQ6pDjOxEznw2wr6YEKSRK4xXGg60agVZwEkLl/F3Prw8yJ3B0ZlFl0T+3sCETNnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETz+EmGc2sUf6E+hP3xBM4eZieUgnAuVTkVrxtGCaC0=;
 b=HtXioOarucLstEllUxK7B54iZ/KTk5KDZiT1NxioyV8aBocIp2VdzK4LVnC7D+BfUiTXtG1c35VJImUAEIo5LBKtqujRIi841kQtNaWexz2QlhQEX5mWrCfTQMSO9obPzZQqNlVtS6VKnRJsUUAlHmJEQaeuPn3Eqb89IsSdJg0soCFjFqMqsw6rFkQ6Wa87gx/I7XTCZM6dmuc9lPuDzRqYmTuoB4VAulzBJY2NRVsFtQ8GWK1j7zFIVW1ajy9FsQGjz2q6usTWlRyJ9kbnqkcz+ZgmPIabWYeUk5nzRpyOdrNvEhumLNIUebOmYgJ0rmse6CNBFvKXe9WG5GOghA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETz+EmGc2sUf6E+hP3xBM4eZieUgnAuVTkVrxtGCaC0=;
 b=uHbTlbx4PKVEjl6Jdeuu89/lQ2xnFz49/DQBm+cQkVC4BBRv47dHYbhXheA5zv0sKAvogCjIVfQAMH1KeBbk3ufLNVNhXcMpp1WinN4UATaiW+7nU+IESYb9Rh+lh7k+djkQYxGDNOodmO/VR47wpkmzSDXIMkjxnb7ciksDXaNubYw6G+bgLgKuxvolmc0xwBFSbb7cwMmrxXK3tuU2dEk+CU1Oy79ICSOqvXLBhjVWYv+i2viKQdgHbjiOO4ueUlAgSGkFXYcznUXxNV9UKE7m1/e+o+iU5qSK+E8wCQOSFnJuMaiVbkJn0w7vUoOMv5+/hNvUN/nRZACQKk8Qmg==
Received: from PAXPR10MB4994.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:206::20)
 by DB5PR10MB7918.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Thu, 30 Oct
 2025 14:20:01 +0000
Received: from PAXPR10MB4994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6dac:adb2:9097:f3b6]) by PAXPR10MB4994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6dac:adb2:9097:f3b6%6]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 14:20:01 +0000
From: "Preclik, Tobias" <tobias.preclik@siemens.com>
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: Control of IRQ Affinities from Userspace
Thread-Topic: Control of IRQ Affinities from Userspace
Thread-Index: AQHcSahHPtCJhoY4FU22bwFWblWb2w==
Date: Thu, 30 Oct 2025 14:20:01 +0000
Message-ID: <a0cad8314124ca98d7c6763e3e08d7192598cf92.camel@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR10MB4994:EE_|DB5PR10MB7918:EE_
x-ms-office365-filtering-correlation-id: eace6f2b-1f31-4d6a-9319-08de17bf69db
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?cFV6Z1RydU5LZHJHWkQvN3NTbFcwZzM2SEZFR0cyQlR0bmsxbUhuSTFUcnVC?=
 =?utf-8?B?a004K1dYSnlVM2MxSU93cmpCck1FZmtNdldxaE5mUlB6TjRhNW0yYzU1a2lZ?=
 =?utf-8?B?NTZkWnR4VGwxZzF3UDhmTEtWcTgzMFk0WlRyVE00YjFGU1o1QmRpVVIycWxE?=
 =?utf-8?B?VHFlY2trcnJxdm1DaDNCTHhUSWxLWmxkbndKSkk4RVpnMmxHamJHbTBqZmFN?=
 =?utf-8?B?YkdQSVJhTW4raXVZSFJnS1YvQUhUNTdNakRIaDVxTlk0OFBrY09tcTdUMEN0?=
 =?utf-8?B?MXR2c0RyK0NFY1ZEUFNqR0VVVG1sa203Yk5Zby9sa3gvZlNjS3JjT0Y3Qjh6?=
 =?utf-8?B?dE41cENPZzF6YldxZGZxTDNpU3Z4MnpTUnJQdW8ybk5BWGxScEduRW1LS2Fw?=
 =?utf-8?B?WHRnNlNYM1oweVhUMlAxWThFNlhHTEVVSE9yZWt2SEtxSGY0WU1YaUpUOTVo?=
 =?utf-8?B?M1lLVndxdGNiUEtaWnVNUmZMenR3N0FYTmhuTDlTQzJYU1A2eHFMMDFtZGo2?=
 =?utf-8?B?akFjbW9mZDJyMVgxNUZPN21UejRzTlM1UjJCT1h3MDk5c0VzWExxcGkvY0tt?=
 =?utf-8?B?VTZIK0o2KysrS1BXMVVJTlJIemZ4STkyT3c1bkk5UTRGM1V6MXQ1Ymp5R1l0?=
 =?utf-8?B?ZGJ6d08vMG5tbDB2ZitXMDRyRVY1d0kxWmI0R3pHSGhJdWtHb0xSam01aGRF?=
 =?utf-8?B?blZVOE9oY0VtU2sreWF0YlhkeTgrRVI5M1d3VjNOT1BDSFRsa216S1UySktk?=
 =?utf-8?B?bXNYZWFpVkI5TTFiNTlIYjdHb21HOUppeHpYOE5oRVB0WTcreThMVW1wMThr?=
 =?utf-8?B?K3BZNkI0eTY5MFk1ckJ3enhGeFVEVmgxM0oxMGNBaEc4bXJtTXBIalY5VlZz?=
 =?utf-8?B?bndJeTdCeXNmYmVzc1R6bEMxbEJ3U1NWbisrNjF5bnI4RzFSaXloemhvejRJ?=
 =?utf-8?B?eGl4SURuL2xTSFRzRFY5T0NJNzh5aHJyMEJkMjk5dTI0eUEvajhxMHYwRk1J?=
 =?utf-8?B?VThWRGMrMHI0Vk5DMUFyQkFzL253a0NqcCtzbzZPdHVVRVE4blhYZVpXMG51?=
 =?utf-8?B?VzhKVkRyVWNKNGNNcDkzSWJkU3gzTWtFWVJPaHBsMExEejBud3BrZkQrQ1pz?=
 =?utf-8?B?TEkxTkdBU0ZzajluNVBDVkdtc2Y1UEdVc1NySFJCN3VNU28xTVJxRmpDR3Bj?=
 =?utf-8?B?bEhTZjBpOU9KanZVRXdrUUVBREYzRFBwdnJaKy9nNm9JbmNJL3FXY2o3MXBV?=
 =?utf-8?B?MUtmNHJiZlE0QmdXcm92UVNqVHAyMWNHeWR3VTlkSlpwcUtMYk1IZWRuY3hw?=
 =?utf-8?B?M00wTVhvYlIrSUgyYTYxVkRrY1JvZjVwS0U5K2t3U3ZxMEdFVXJFU1JFYlh1?=
 =?utf-8?B?TXFrYllya2ZDYTFNNU5MdVpTUFB1aUtDQy9rVWtZblhtTlVXZTF2QzJJQ2ll?=
 =?utf-8?B?OHZSemFaSWZ3VGNIMk9kc2Y3U2dEaTRhczBFY0xrTEcxVHhZOVJwRzRCNno3?=
 =?utf-8?B?VFI0NmluMlo2dlM5aVZoSENPck9vOGhwUWRyWlhnZnhDWkR0bldBUUtacWJw?=
 =?utf-8?B?RUlsUmlEMVNOcVJvWmZyQ2U1TlRwbzFLRjM1NU5wWHdqOU5xUUdTbklDKzVn?=
 =?utf-8?B?RGhJK012RmxaQkYzckF1bno1TE16aVY0ZVlNYnRxV0p2RUFmZGc0Zm40OVdp?=
 =?utf-8?B?UGlBQmRWdEJDd3ZtV3hKdjVabFZ0MmxWdWtBeVZSZTBTU2t2NXo2b2RON3BO?=
 =?utf-8?B?am10NW9QY2ZEVi9FanVqWUZWYUxZRFRhYit2OE1ubmoyTWsycWp1RnVTZ1lK?=
 =?utf-8?B?ZGxXd21WNFZFQjNVTXArMzJLUTk0Nlh2dW55ZlZXUzVnM08xczlHSFFYTDRU?=
 =?utf-8?B?a0xicDFUd0swWDZpNlFoNWw3WGxsTGl5eFlubFloS1pESzRwc2k5TXFoQzZk?=
 =?utf-8?B?bGJXaVFsaE0zcTlaVUZ3cWRNVEpQeUpxVDN3OENwei9tS2pQWTI0ejhoTUxn?=
 =?utf-8?B?eGR4d1RFN0M4dThDakpsTlBVaGIxMDNvTHJjaENBWjZsbTV4QVBNRnNTNHZO?=
 =?utf-8?Q?71aPxS?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4994.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eGlSeEp1Ukpobm9INjJKUS9XMmpJZFRISGtkOU1SaWZLeUpySndVMk1aOTZL?=
 =?utf-8?B?d2xFczI4aTc1REo0LzdHZUdYcWF2UzRmZzNnSGdXV3hvYVhFck1YWGFnMUxV?=
 =?utf-8?B?ZTNMZlNGTEozNVIwUHFFMEUwMlpMSDlNd0kwdkVJa202SUNTRm5BVnV1dHVr?=
 =?utf-8?B?ZUFZNVZOMkNuS0ZYSUdUUUtQZ1VxcGVzdXVRdXk2b3hTTWt6dWNCSEwwekdp?=
 =?utf-8?B?eWh4UlU1K3hvOStVYTIxZ0NUSzlFdWhGK05EOVlhOTZ1bjR5eFphODE5ZjVI?=
 =?utf-8?B?ZU4rMlFlYWRkbyttRDZ2d0RIUW5Kb2htQnVRRjgrWGJQYTVveVA2MTFjNVVy?=
 =?utf-8?B?eFRBUGNjR3lpK3RISGx6MHh2ZVYrcnpadFhlYkU0MVpKWXE3ZjdGVEwxYnN3?=
 =?utf-8?B?WHU0dkV4NU5HVllpWVJ6bUw3eDB0QVVaRHBlSGNxTFp3QklYbVh4S25DU3Iz?=
 =?utf-8?B?cTlKNFRwOExtV1cyUVhaQ2o2UXVQZVovNDc0MTBaR05DcFdrVWFMbmJsckhO?=
 =?utf-8?B?amtTZlhqS0lMYkoxVmt3TEFybk1CNjBaeXVLdjQxa2J4VkpIUHRZL005TDh6?=
 =?utf-8?B?bHlFdVlTdVJna1grMm9JYnNZUGhHZFozM2hGSk5FRW92TkR5ek50RzZCTlFi?=
 =?utf-8?B?Y1k3aFdtVFZhcDhFbXVtVitPYWpWemhieHoyZXNZN3hmRm43Q1IwelVSZVNJ?=
 =?utf-8?B?Q2QrcjEwV1Zac04vNWpCbS9xajZicThyMGM2ODVxOGlyc0V3dU40aXVKYWdP?=
 =?utf-8?B?aG1iUHE2a0dmWTBIa0c5aTRMRE1kdmgySjBTYmUvNE9IanFmQUlqcFk5TXRL?=
 =?utf-8?B?bFhycVEvRlJIdlJjbWlqSllQOXh6OERrelU4eVlKZnZhOXhRZS9kQ1NYOVp3?=
 =?utf-8?B?YmZzbHRsWElMeElReTBRRGFBdzdoYko3YVRXL0VWNU4yd1Rpb1RaQ24vajFq?=
 =?utf-8?B?eUltZ0FBNy9zK0p1Snc1S1FyWWVZSUVEU0p2dDhGdzlkNjExOVdtaDFGTTRz?=
 =?utf-8?B?WEhNWENLNzJCSjZPRU91c2VYU3FLWFd3UVpZOHN1TStjbXpreFZTZkl5QnI1?=
 =?utf-8?B?Q2ozeVE1ME1aNEVaQ3F0YXc0RDNvLzVqTmU1SUgwb3BOa2oreEp1eXQwWVNJ?=
 =?utf-8?B?TkdDQlZmSnhKdUtyWmM4aVFkSk9nT2JRYVF1SUtkbzJyWld6ZStSV1FZeGlB?=
 =?utf-8?B?TU9Qd1RKYWYzUm45bFdmMW80SldwRi9heTNJNW5DVGdyWmRkRDJuMmc2SE5C?=
 =?utf-8?B?Rm0zZkI4RUZDZGpWQzM3ZHlnYkZDbzBqNVRSMTI4MGdyL2Qvc2FvekJ5aVlw?=
 =?utf-8?B?QVd5RU5yaHNUb2FJZ2lka0s4SXV0WVQ2ZTZLd3g2TXNoYnpjVU9UempJVVdm?=
 =?utf-8?B?N3d1U210Uit0WTBYUS9QN1p0dmNrbll2a1puS0N3TVhnOEEwdW9GYktLYmUz?=
 =?utf-8?B?ald3V09lcWU4Z1JJTDVBdnAxVXJkd2x5MGJYcXlCRno0WWZ4MUk2cE5GeFFz?=
 =?utf-8?B?Q0NycWZkVGhNdlo0SUNhWlFPYWdVNDQ2SWFCTFUxNCtHMTRIVVJMMWV2WE9m?=
 =?utf-8?B?QzRNbkVQdnprT0JWcmZFTmcySEJFbnBkTDZNNGhvWDg2bnIxUG03L1Q1cncv?=
 =?utf-8?B?RFI2QjFYUkRaaCtFSU84K2FuMTMwbTdYWFNacHByWitndnZqaVBoV1ZvbUt2?=
 =?utf-8?B?aFlYRkRKNVpiRkxOdGRFNVk3aGRqZ0tmQklzdEhzU1k5R0V3NVpqYkkrdjEz?=
 =?utf-8?B?dkp0VVBvV3Y5cE9VaHVseFNZa0I3WHpxcEpHeVhZZTlUUlp1RENnQlRjQTBF?=
 =?utf-8?B?UEtLN1Y4YW9BeUxORHl1R3RZd2VObktSalE2d3k3THNSNUN0cTVnUXRuN2o4?=
 =?utf-8?B?cjh2U0tzMkR1UDQ2a3VDME5JZ0JPcE5tTEVHQ1V2aWlmOTRsTFcwV3A2L0xy?=
 =?utf-8?B?UnB6VjRxcnBsWnNmbTQzSDhEem9HMDdnQW1vSWQ1SFRnSjJCOC9YMytNd1Rz?=
 =?utf-8?B?Mkp2VnpKbjZ5TTlnbFYzVk5MUW9FVzJ1RlZFdHg1czVZSUticU11SVpKNjlv?=
 =?utf-8?B?UXUrRmgwTXQ2cmp1allWdFFudHZxYjBHQmcrbjV1WFI0TnllSXFpNmFOb0Zu?=
 =?utf-8?B?bGJUZ1o2T1VNL0J6QnRmNE5STVRGY2tuUEVkU1VkbGkvUTdkMTNadmNEODhO?=
 =?utf-8?B?V0VEVHQzZVZXamQ1UmdEN3ZJSEV4ampNSUhYZFQ2ayt6MUlSOC8xeHFSS2FH?=
 =?utf-8?B?UTZZWit6WnRjWXpucFZpbGJQd0VRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <89D04B4105BDF74084BE3032259793AC@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4994.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: eace6f2b-1f31-4d6a-9319-08de17bf69db
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2025 14:20:01.5108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 59UewQ/FkytsinaXWtJJkks5tTFOud2PUwiicSkuJz8Mq8Pg8A+5v7RqmoE3sWOIsxWD/riOZ53LvLSFf2Q7h5CVPzbjUaicFcYulBLliZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7918

RGVhciBMaW51eCBSVCBFeHBlcnRzLA0KDQp0aGUgTGludXgga2VybmVsIGV4cG9zZXMgdHdvIHVz
ZXJzcGFjZSBpbnRlcmZhY2VzIHRvIGNvbnRyb2wgSVJRDQphZmZpbml0aWVzIGluIHRoZSBwcm9j
ZnMgWzFdLiBGaXJzdCwgL3Byb2MvaXJxL2RlZmF1bHRfc21wX2FmZmluaXR5DQpzcGVjaWZpZXMg
dGhlIGRlZmF1bHQgYWZmaW5pdHkgbWFzayB3aGljaCBnZXRzIGFwcGxpZWQgYXMgaW5pdGlhbA0K
YWZmaW5pdHkgbWFzayBmb3IgbmV3bHkgcmVnaXN0ZXJpbmcgSVJRcy4gU2Vjb25kLA0KL3Byb2Mv
aXJxLyR7SVJRX05PfS9zbXBfYWZmaW5pdHkgd2hpY2ggY2FuIGJlIHVzZWQgdG8gc3BlY2lmeSBh
bg0KYWZmaW5pdHkgbWFzayBmb3IgYSBnaXZlbiBJUlEuDQoNCkZvciB0dW5pbmcgdGhlIEkvTyBw
YXRoIG9mIFJUIGFwcGxpY2F0aW9ucyB3ZSB1c2UgdGhlIHNlY29uZCBpbnRlcmZhY2UNCnRvIHJl
bG9jYXRlIElSUXMgdG8gY29yZXMgZGVkaWNhdGVkIHRvIHJ1biBSVCBhcHBsaWNhdGlvbnMuIEhv
d2V2ZXIsIHdlDQpoYXZlIG9ic2VydmVkIHRoYXQgY2VydGFpbiBzaXR1YXRpb25zLCBzdWNoIGFz
IGludGVyZmFjZSBicmluZy11cCBvcg0KbG9hZGluZyBCUEYvWERQIHByb2dyYW1zLCBjYW4gY2F1
c2UgdGhlIElSUSBhZmZpbml0eSBtYXNrIHRvIGJlIGxvc3QuDQpTcGVjaWZpY2FsbHksIHNvbWUg
bmV0d29yayBkcml2ZXJzLCBwYXJ0aWN1bGFybHkgdGhvc2UgYmFzZWQgb24gc3RtbWFjLA0KaWdu
b3JlIHRoZSBJUlEgYWZmaW5pdHkgbWFzayBzZXQgZnJvbSB1c2Vyc3BhY2UgYW5kIG92ZXJ3cml0
ZSBpdCB3aXRoDQpkZWNpc2lvbnMgZnJvbSBJUlEgcmViYWxhbmNpbmcgWzJdLiBUaGlzIGRyaXZl
ciBiZWhhdmlvciBwcmV2ZW50cw0KY29uc2lzdGVudCBjb250cm9sIG9mIElSUSBhZmZpbml0aWVz
IGZyb20gdXNlcnNwYWNlLCBpbXBhY3RpbmcgdGhlDQp0dW5pbmcgb2YgdGhlIEkvTyBwYXRoIGZv
ciBSVCBhcHBsaWNhdGlvbnMuDQoNCkkgd291bGQgZ3JlYXRseSBhcHByZWNpYXRlIGFueSBjb21t
ZW50cyBvciBndWlkYW5jZSBvbiB0aGlzIGlzc3VlLg0KDQpCZXN0IHJlZ2FyZHMsDQpUb2JpYXMg
UHJlY2xpaw0KDQpbMV0gaHR0cHM6Ly9kb2NzLmtlcm5lbC5vcmcvY29yZS1hcGkvaXJxL2lycS1h
ZmZpbml0eS5odG1sDQpbMl0NCmh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2LjE3
LjQvc291cmNlL2RyaXZlcnMvbmV0L2V0aGVybmV0L3N0DQptaWNyby9zdG1tYWMvc3RtbWFjX21h
aW4uYyNMMzgzNQ0K
