Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012009.outbound.protection.outlook.com [52.101.71.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7734B5AE
	for <linux-rt-users@vger.kernel.org>; Mon, 10 Mar 2025 16:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741622829; cv=fail; b=NLVgs/rOxT83//dKa5YH81hA5eRKVT5Hh3nFyqemwzhZzRA5RH+9l9OQZqnn9StqcvIOivTyoQ3cJBFDS2TPbA17qXIRpr8chP3gg4x6UEvGzkOkFRagDRgWLh/U3PqPgkTOcEh5K2qIKTlEZvhyZXsnztxvAvU+rsLyEsZGQmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741622829; c=relaxed/simple;
	bh=7g0o95xibJNGcGpXV4fN3jViDEExMZZWMFF4wa7tcKc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sTe+L6MuESAQ65IUBNzaxHm3AiMGznH+Ak+nLSFoHcEAKYEsKOnhZgCd9sbtiSHUSifYcoKNITgaIl8bUsUQqT0CZxqMF3OrmhBt+PgVE7DI2O/KPEINkkVqYtRb6WrmP3l8oedi03Tp5gibY3f4VsOQdkhFLcOxQBc1YeQwA70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=bCIVrP75; arc=fail smtp.client-ip=52.101.71.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="bCIVrP75"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4d9RqNzwM/yAVfPjftpMsrK/I26TuMTzf2ddgkkvaexWKQQNkY2cY1Jniyv4esDyKkRXki4if7WaCwPxXBeA68lwim7iOlwPfK9OC/bmqdaoWzGlWOAcl2gNzD+u2LuhEI0jBdO4S5sE/VTHdpQBVkw0LYre906ybBBhTeURzwCfiwIZJgMFBn7snT9AWKh4GgDtHqY4rvw6Zw3s+r2vmmZOMzAOzaDpeGNaJggevPvEOHaDT1Uxx6fczVv/JFJD5CK4LGx5/uBi30QIyZcZg1QvXtqfPrEzxL8I21ARnGcRLwaeFqXkNzjsc8+40FtcD7PDqxVDBfEs4cgcdda4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7g0o95xibJNGcGpXV4fN3jViDEExMZZWMFF4wa7tcKc=;
 b=eMG2Q7uPIFr0InCZ/vrRTCqedzrfgRJI9tFv7cqJf0QdDYgneGe2W1ZEu2gnT/WMSW+M1Y9Z496VuH4h20LJbNHboBlBr9tC43REF6PCt6dxRYQ2I+5ltQ5BJ9VQTuLqQfjvqeuC1LrF5fj0+lDLt5jBOjx6nkq0PCJroQZAHj/YsMx/wLWLsIb7h4iXuT0lgGSf3BDD5qe8WCuVF3vrC+QEEW1uMiwoq1DAFdCAMMu+sotM5r8X4sQ2kQzDSxE5GGgqOsj5LsBstyihzgUGsT5VfhDjDGewHazEyKZTvRnLgqX9pvLt/PUH0vqi0cDarWgvMkYZmm5mJgbUUtAZVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7g0o95xibJNGcGpXV4fN3jViDEExMZZWMFF4wa7tcKc=;
 b=bCIVrP75/ooxtowomG5EYbKfWt3wIJjvl52xPAm4NLmyxVWH9ELDrt4yxknMAHNQfsKAgnjFE/PbhhvoUL2m3hrtQ2k1+bXY2/l7G/k27MzqESNR49uccbTnxiMhvmGmaPJJGMgI+aaluAAjJpQ+HL8nuPEH07AKUQkc+9s19qKHwn6q11qFWkkMFBQBhrmXXmJtdLXRAmXszX7LAp8PPrXHt8Kv4vE5iZlsE5idLkEjFS3YlzqXtm/lt/vvmWC/SL2Lc6ULfriv/DwVq9QRGYP3ovhVfb2eRbAtP9ovRA7ir//gWb9MpWAGQsVb1iKOrWDi6Udfo/1Nhag2Wj8DmQ==
Received: from AS2PR10MB6823.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5f6::12)
 by AM8PR10MB4017.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1ef::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 16:07:03 +0000
Received: from AS2PR10MB6823.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a4ec:4b8b:f70c:3a33]) by AS2PR10MB6823.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a4ec:4b8b:f70c:3a33%5]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 16:07:03 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
CC: "Bezdeka, Florian" <florian.bezdeka@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>, "bigeasy@linutronix.de" <bigeasy@linutronix.de>
Subject: NET_RX softirq work in ktimers
Thread-Topic: NET_RX softirq work in ktimers
Thread-Index: AQHbkdZ2r+trZz3OqEasmtyirteF4Q==
Date: Mon, 10 Mar 2025 16:07:03 +0000
Message-ID: <30a9c98bc11b40de720e1f7462302243f7c8ffb7.camel@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.55.3-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS2PR10MB6823:EE_|AM8PR10MB4017:EE_
x-ms-office365-filtering-correlation-id: 44d54a03-f2fa-47e6-6550-08dd5fed98e5
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WXJGbS8zKzIxQjJxMzZ5cmlmU21wK0x4WXFLVWxlS0k3RU9zN0RBa3A0V2Fk?=
 =?utf-8?B?V3hRc01KbjZWMVB6cXk1Unp3OEhDMVlsV3l0NGREUGtOd0IvSXd1WkN1SW1K?=
 =?utf-8?B?alFaMnJFUDhJU0FOOXdwYmpWTkVhd2ppVS9TY1g4YUZCUXVJNjE5TkxSVnJn?=
 =?utf-8?B?cVVXcERGZDRZVFJjeks4OC84VzJzbTEwd2ZLNlpqMitia0h1RDVKS1hCbmdW?=
 =?utf-8?B?dFBtL3MreW5ObWZuUk83NVprbDFndzR6aXdySVBzRmdhamJnQzNzZy9MWTUw?=
 =?utf-8?B?VFBra2pPYXVaeTJTY2tJZjFRWVl0ZDZqRm1RWElnYVhrWVdBT2wvZkdHZ3pm?=
 =?utf-8?B?Q2xsUE40U1hOMFRpVFA2MkJsTlM3ZExyNmhBY01ZaWY3c3pIM3VJNnpwRko5?=
 =?utf-8?B?ZEppRlptRGR1YUNQbXc3VndxYTI0aFZpaTd4bjhHYktsWHBMNklXWkhIMFFF?=
 =?utf-8?B?cjRrcEdaaUVqaWtoOEJGSWVsSC9wdnV3cG5zYUVNZ1h4NHgxNllzdjBRUmto?=
 =?utf-8?B?WTNNdmhqSWwwdEYycHA0UEJVVnk5cFo4QnIwTE9LMXVET3U2V2xmV2hWcVly?=
 =?utf-8?B?SUVvTzV6UVNSWThMenlqQWFTa3ZJVGxZaG9EaGxzNjZmYTgyVXk5VzZYWWJX?=
 =?utf-8?B?MHNZNnlVODQ2U0JsRjNXbWtsVG90Vmlsa3NyNllDa0hQcXNrQ2FXUmRBc1VJ?=
 =?utf-8?B?MFBoR3YxdTU3V21LMXFuVVVNazZvQTdwMzhadVlKRjAwYjgydFVFZzlISWx3?=
 =?utf-8?B?cFF6MG9ncWkxMjcwS3hTUWlSNEkzQVlEakNzM3ptYTRFNzV2eUJhdU0rcUhI?=
 =?utf-8?B?bEJ3Y0V3K3IwOEFDc3p2WmZHRUtJRkE0NjBORFlpbHNZMlNkYnZIQTB3azJK?=
 =?utf-8?B?QTdtYzBlZHdTemRLTU5RdWNmdWRYeUtSajl5WS9rQWlwZS9ya1hwYWdHdytO?=
 =?utf-8?B?STgwbklZaUE0R3NhQytub29HK05rZDl5RkdZdkdWUTl6MENieUMrcFRQZFp4?=
 =?utf-8?B?YTBwT1l2bVBpVmxKOUhFWlhKYTM1a0FqM1JKcUxBRXZqOGtYdDd2bmRXWjI3?=
 =?utf-8?B?Ui8vZjlGTGtTcXZWUXpaeXhiei9iYmtxck9USDZyQTJGaWN6V3lQTFZFVkNP?=
 =?utf-8?B?ZHV1VTk4NlRSYUZWQ2V2Z2ZmUVJZWlBqZ1ZNU0FWaC9uQW0wQkJRc0JoQ01K?=
 =?utf-8?B?VlF4em43S3VvK2NWMi9rTHI3L2IrSmd0OEtURUpEREdUa2p3M2dsTGZPQVd0?=
 =?utf-8?B?ZUtIcklYcVhuVzNYbW02Zk9zUDBwTDlGSTd6d2haY1Y1bEFjVmhSeWR0OVBt?=
 =?utf-8?B?ZVV1UW1hTm5mZFcxMFc1bmg4eXBLbmRGU0dWWXRnam1kNjNwRjBxMXJ1dnFG?=
 =?utf-8?B?WEYxRVREVFJUSDVFdnFLM0VxWitaVU1CSHpiNFhEeEFpZUtTQkhaU1QzQlBQ?=
 =?utf-8?B?MktoOW1KMVFxNDVHNW9SbUw3OTZtdmdqMmd1T3U2UU1iU1ZZVk93N25XVjVQ?=
 =?utf-8?B?OTVYTXBmZ0pPRVpkU282eVdwU3I0RlB3d1M5MGlQR3FXdW1MekswazVDZTBF?=
 =?utf-8?B?OU5GekE4WHdEVm1zZC9LUy9ORFEzdFJhVjFQeGJBVGJSc0pXV3FlaFk2ZHBl?=
 =?utf-8?B?aWl0YUdEdmVGQVkrUkN3bFdORW5GYkNkc2YwZ0NNZjhTdWM0VGRFMi8zUW5H?=
 =?utf-8?B?UHVwSmVXZVpXOVVOc2ZqNXd2eUdoYkJKU1dTcnpobkJBdjFLOEVsazZjUnVK?=
 =?utf-8?B?ZGMwZnh2a3M0MUlNajhRS3djZGs1UEVrc1ZHaUJFWkZ2eUZ6VlIzR3c4bnZl?=
 =?utf-8?B?cUlBdDlNekJjTkpLSEhBODJESU9EWDBNK0p2U3pYMCt4Kyt3OUtKWjJHVnA2?=
 =?utf-8?B?YXFSV1lJQkF6ZU1rMUExUkYrR2hGUzYraHgxd2NWL3ptcDhtT3AxM25XZWNL?=
 =?utf-8?Q?MHRPbobk0wtWZb/GnEveYlASPeMbeoXk?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6823.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TGM1SkFFcTVLYjZ3VjFtY2pZVFVDUm0wYWs2akg2Njk1UXQyTjVIWDJVMlNJ?=
 =?utf-8?B?T0J2YTM2Z2QwWWhpRWdMcWE3OGVYc2d2ZGRHM1NaaWhPQnl3SW1ZSzlRZTNX?=
 =?utf-8?B?eEtRa21VTVdvMEJNMzd1eVNXMDgxYjVaZW9jczdMNlBVdWc5SkFaL0Y3OFMz?=
 =?utf-8?B?R1drN3cvMVhoR1Qzb25LSmk4a1AyOFVzVTZrN2plMUdVcG5SRCtNSld2TG5U?=
 =?utf-8?B?MDJla0w4OWEyeHlxTlVkUFJSY2h6RU1XZE9OWEMwREVJWXA2eW9lckQrS3Nw?=
 =?utf-8?B?TitabHRqRW5wK2ZyVHhCcTRBY1pNaHlnM2tkTHdOTmFnbzRRcEV0aDNJL0JD?=
 =?utf-8?B?QkFYNjd2R1JiT0FYb29vSjlZd0t4OXZQMU5Wd0krVnVocVgzRDJCWjNmaGxD?=
 =?utf-8?B?VDRralBBNTdmVi9RUW54RXNTL1N0amk5RGVVdVpnL20vc04zMHE5WlhXeEFu?=
 =?utf-8?B?ekdxZ2c3cjVGS3p0MjhoVGdqdFJ4emprZTU0NVJhSkxvZ2JpZEU4NkZxSzZM?=
 =?utf-8?B?SnJUOHZLMnptUEt3bjk1OUJEa2hlWis3S3o3Kzk2T0ZQcjZ5Z0RkelJhbHFS?=
 =?utf-8?B?a3NHRVRTWGdodnZtQXhRbWtJb0R1dC9MUitVZ0JRdnVTb1YxdjNKTXdSMnJW?=
 =?utf-8?B?ZzRsRndJQkdUVElYT3RPY0MyeC82R0gzYzJLdUhGYmFrTFVhVHVQS0h3OHcv?=
 =?utf-8?B?NDdmMGhRU0E3RTBtS3U3TXlmeEdsdVU1bmFvV0NET1czck40VzRrWGRKUDRo?=
 =?utf-8?B?aE4rRXV4RzRyYWNlclRLSmZ4aEFvd1lLYzRKcXFxYjhJS1BUS09Pd2lJUGJy?=
 =?utf-8?B?MzU2amJIc2w5NTRuNEY0VDQzeXIzc3BUZHJRR05mY0ZWWStNaDZycFA2bnJr?=
 =?utf-8?B?eHZyVmFKNmZHanhuZE96bXZ2eVlCRmpKU284MTM3KzBIRnVJdFE1em96N1Zh?=
 =?utf-8?B?SzdnQlNRbHA2bGw2cXdaWWIvSkd5aVVFdGMxRnRCL0EraWJEY3ovdy9JLzBF?=
 =?utf-8?B?aElFUHdTeXE1bUtja2VVT0Q1UUxRQzBkNmV3b2ZMcks1cnpYKzBaUHBYZ1pL?=
 =?utf-8?B?TlBDV1VUWVZyVytPM2p1cS9NaStWdVgzTDRaYUl3SlEwK01UNDFoTkNNN3Ey?=
 =?utf-8?B?eHVqVkpORkxwNWVBcWVSekdwUUtaVWNORHBXSk01djVaQmp0d2N6V0llSU9G?=
 =?utf-8?B?dFpKS3lCOURNWXNtMmRuWGtvb1FkVGxSWXNsdXRqZ0E0VHV2TGNwZGp4THpx?=
 =?utf-8?B?MENQdkVLRzdpU21EZWJkd3lJUUhHK3hZdTQrWHE5azhBaW1wSnNYeDh6VFBS?=
 =?utf-8?B?NEU4TU5IUHZ4UGJKSFI1WmkzNEZYZEsrb1MvTEwvejRQWkJpNnoxMjFrb25n?=
 =?utf-8?B?QUwxYUYzOEU4MlZBRElhTHJiQ1Eyelp1MkpVem0wOEFoNGx3RU9oMFdCV3d0?=
 =?utf-8?B?bm16MkIvRGFIZkJZRVJoOGRhYlBDV0tMS2pwdThVODdPTWN3azRLTjRPTmZG?=
 =?utf-8?B?U1pIa3ZmaDQyYk9mV3prYVQ5d04wUmFmMlM1eXZqWWk1TzB2ZXpWMExKdldh?=
 =?utf-8?B?bCtkaHFicGF2dm1aSFQxTEpUTk5jV0NseWdXTTNrZUU4dlpGUFdMdFBQT2JN?=
 =?utf-8?B?T1JXR1Z2WHZ3TDJhdWtNSENkVkN4Q0c0WHdrMUlJS0piRDNBcW9NUHRLTmhT?=
 =?utf-8?B?ZWhDRFJQallMeFBuL3YyNDcwWEZOSFZ1Ri90SUJ5cmp2RXFnKzduSDFFQzRV?=
 =?utf-8?B?bEMrR1RlN2lkN1FvaDdSV3FvVi9zY0hrRkYxOGhCenphNjMwa0RuK2o4RENu?=
 =?utf-8?B?cVhkREJMd0FldXFhSkpxbE5ETTFzOTN4UGhkZ3p3QUFleUMyN3pzRTNhREV3?=
 =?utf-8?B?MDkxQlUzNmxScWJyaWNKQnRweTA0cWl3YkJrY1pHQkdEYmlQMGV6clRLeDhL?=
 =?utf-8?B?dmVZZERlL3NJZ3Y0NUZISjd1WmpVVHN3Q0FKL1VqOWpYL2hYK2FWNzR0THhp?=
 =?utf-8?B?Q3ByNlMwMHVSVTE4UGdLSmpHQnF6MzljQ01wdWxjNFduZytRUVJ1MFo3dTVJ?=
 =?utf-8?B?dEkrNHVKMDY0QU96eU5UV2RYRDR0VHhOUUpoSm14cnZsUzFKNnhLTUN2S3dU?=
 =?utf-8?B?RzdGWVFiaVRBc1d4QWRRNmpsRjY2UUgxS2xIVmV1UjZJcmlzZURuTEtiWHBm?=
 =?utf-8?Q?plGrDT1iqYMm9lvy0GwvpUw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <900E4E15326A234C94B761DEBAFE8558@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6823.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d54a03-f2fa-47e6-6550-08dd5fed98e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 16:07:03.3497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ap20/I2LxKH9WOaku/rxzCfBnxtYZFTI9V5UqFJJhrgb7AJJP0r+jDcjr/ViZoDCCExrs/D1vzFit/lWOJmbas4b24vlNcnCmC9IJFvlHUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4017

SGksDQoNCm9uIGEgNi4xLjkwLXJ0MzAgc3lzdGVtIHdlIG9jY2FzaW9uYWxseSBzZWUgTkVUX1JY
IHNvZnRpcnEgd29yayBiZWluZw0KZG9uZSBpbiB0aGUga3RpbWVycyB0aHJlYWQuIFRoaXMgY291
bGQgYmUgcmVsYXRlZCB0byBydW5uaW5nIGtzb2Z0aXJxZA0KYXQgYSBSVCBwcmlvcml0eSwgYnV0
IHRoaXMgYnkgaXRzZWxmIHNob3VsZCBub3QgYmUgcHJvYmxlbWF0aWMgYXMgUEkNCmJvb3N0aW5n
IGNhbiByZXN1bHQgaW4gdGhlIHNhbWUgcHJpb3JpdHkuDQoNCklzIHRoaXMgYWxyZWFkeSBhIGtu
b3duIGlzc3VlPw0KRG9lcyBpdCBvbmx5IHJlc3VsdCBpbiBkZWxheWVkIHRpbWVyIGhhbmRsaW5n
LCBvciBpcyBpdCBhbHNvDQpwcm9ibGVtYXRpYyBmcm9tIGEgZnVuY3Rpb25hbCBQb1Y/DQoNCkkg
cXVpY2tseSBjaGVja2VkIHRoZSBsaW51eC1uZXh0IHRyZWUsIGJ1dCBkaWQgbm90IGZpbmQgYW55
IGZpeGluZw0KY29tbWl0Lg0KDQpFeHRyYWN0IGZyb20gYW4gaXJxIHRyYWNlOg0KDQprdGltZXJz
LzEtMjkgWzAwMV0gLi4ucy4xMiAuLi4gc29mdGlycV9lbnRyeTogdmVjPTMgW2FjdGlvbj1ORVRf
UlhdDQprdGltZXJzLzQtNTMgWzAwNF0gLi4ucy4xMiAuLi4gc29mdGlycV9lbnRyeTogdmVjPTMg
W2FjdGlvbj1ORVRfUlhdDQprdGltZXJzLzQtNTMgWzAwNF0gLi4ucy4xMiAuLi4gc29mdGlycV9l
bnRyeTogdmVjPTMgW2FjdGlvbj1ORVRfUlhdDQoNCkJlc3QgcmVnYXJkcywNCkZlbGl4DQoNCi0t
IA0KU2llbWVucyBBRw0KTGludXggRXhwZXJ0IENlbnRlcg0KRnJpZWRyaWNoLUx1ZHdpZy1CYXVl
ci1TdHIuIDMNCjg1NzQ4IEdhcmNoaW5nLCBHZXJtYW55DQoNCg==
