Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2054.outbound.protection.outlook.com [40.107.20.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180AA1CAA6C
	for <linux-rt-users@vger.kernel.org>; Wed, 19 Feb 2025 08:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739954880; cv=fail; b=kZ2uGdUhSp31XIPSASRpALSdfNC3G7YitI3mLDi5ZuWX0xMDvWrL7JNhGlwyMbEgavhu4BMxl0pVdNjRHJFBX6DyLUKu5rz86XUXn1u9fzzX2ht/0Ui2kE0EpE2phUw8zty3yimoqV1tMbpP780AEJRKEOJWZo5WgKQGqJoMxpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739954880; c=relaxed/simple;
	bh=Ks+VZCkWiw0k3F8QqLv8a9vR2aQsXoyQ0SAnmrQPeEo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N3PmUB5zNphMwwOwLE5pXR1QJ9Cp9RjSmVKYz4Dlophzcyth3QCBgFURap1jjBX/LaEZ1LVnFy47jaOVn+SbNyndgqlrEtgyvcM7EiAvSwW0jAusRrlH4+KSVE5woh+owqvh6LNHkl4skqr28cpFwz+2bUMd8aZ/PXnnDwvV570=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=hPh30K2b; arc=fail smtp.client-ip=40.107.20.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="hPh30K2b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WUcZInPtkDPZSncvvmoKPm92u/mxzShYrDJm6e/BdDAFE4eXoX06laO06zX/IhZy6uX2InnFgmSd2aVNbbCtnt5ravFvnfVcJMb8dfPi1o6DUgp8oYEOXzzd5tzn1FuZHfBbNQhYTERQCxO4MA5S9ZqMjZvjHY5I/NgSPBoIVJodUzjhD2fh1i2aC/KX66jS6fXIiIVCBjgKt77oVgEXdIYEfpUIQb9JkVwCWByWLPpwcJOqdAP/RrjczsZo/ifG/Xh5KnhcDQdmg0rxCbxRsKqVhAwXjLFjmqRcKB+PO2awMPmXjLFFY+YijQuUE/YOVf0Cnx6B8EIudJpfNW8HPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ks+VZCkWiw0k3F8QqLv8a9vR2aQsXoyQ0SAnmrQPeEo=;
 b=k9RBZAp/ZzNvMnUk4BEiXI6Mx95GOJteFuXAOPZYFFhvktY/dbZQi1xhI+5h2QACcgxSnSvJRTG9DlgVjNOSkxy/zijmcZWcU5IzdbwL17SSMzA143nvVl+sowotU/KTqoschq3coOVmox2uMLtePGtcauA2RIyNjKcK83w4a1K0K/ZcA/avnRUIjqfx0A5eud3ZOLBdbvP3i6Awgf2jTI78hn9+4RlyC7DTnaMSuthKo6R7innXQXOvnRbCD7L0pNiMfqCMChbRl0jStMmCuZJkAwsbIOVgZbbOkb/8BSQAhu+5vq7g72aNRhAaq7qwCyLwp/IBQQXq5dz7eQUpIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ks+VZCkWiw0k3F8QqLv8a9vR2aQsXoyQ0SAnmrQPeEo=;
 b=hPh30K2bncwq4rIt+8INSfjA5K/EZ74gosqNQj90Lzs9SFjaN7xA6bwH29mwb3UZ6UmyxvnO8g4LFhmMElGryQbuWIZiEnJjmIUOmd6i4/AW6Bn3s3NqavwOMolN7Gvjmkxitw/fH9b85uxd7Xacrx5/TxyuqVXa3kF484+JRYxKAFEMEHAlp7mOrnMZR7ZHsl+Boj1Mejy5mtOIuQ49dy+gjGoWLG7Uzo8+H6JBpoJu0WIW9b/We510gwI9FihurNpqrG8cQYedIf2qL8yQCJLjyHwekLt7JNOGdt0l+6RBAEMHwwchVKA0zXdwAwLpnx6TbKEeFPAd/TQOxyTcVA==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by PAWPR10MB8187.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:391::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.12; Wed, 19 Feb
 2025 08:47:52 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe%7]) with mapi id 15.20.8466.009; Wed, 19 Feb 2025
 08:47:52 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "pavel@denx.de" <pavel@denx.de>, "linux-rt-users@vger.kernel.org"
	<linux-rt-users@vger.kernel.org>, "daniel.wagner@suse.com"
	<daniel.wagner@suse.com>, "tom.zanussi@linux.intel.com"
	<tom.zanussi@linux.intel.com>, "bigeasy@linutronix.de"
	<bigeasy@linutronix.de>, "williams@redhat.com" <williams@redhat.com>,
	"lgoncalv@redhat.com" <lgoncalv@redhat.com>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "C.Emde@osadl.org"
	<C.Emde@osadl.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"joseph.salisbury@oracle.com" <joseph.salisbury@oracle.com>,
	"jkacur@redhat.com" <jkacur@redhat.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
Subject: Re: [ANNOUNCE] 6.6.77-rt50
Thread-Topic: [ANNOUNCE] 6.6.77-rt50
Thread-Index: AQHbgqr2WMHbd1cNY0uMWV8xtTKgBg==
Date: Wed, 19 Feb 2025 08:47:52 +0000
Message-ID: <79b04ea5771ea19470a1fe72e32b651e510ddd3d.camel@siemens.com>
References: <173968881796.265269.4992139552085083465@demetrius>
In-Reply-To: <173968881796.265269.4992139552085083465@demetrius>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.55.2-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|PAWPR10MB8187:EE_
x-ms-office365-filtering-correlation-id: 8100e597-4c04-4b59-7ddb-08dd50c218e6
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?N3JTYnpNNDhvSkNkL2Vnc1RjdkVOdE1YTzNvRG9NbnpyaWVsTWFMZlBJUndv?=
 =?utf-8?B?NUFXUFVtb0RJdllXakI5YXZqMkU5OUlZekJaWkNaeDVzQjRrQ0xiMC9ISXlt?=
 =?utf-8?B?QVlXYld4L200Yk9paUNWMVVESUliZ1B0WFdsZm84Q3dJNDI2NzQ2eVRmOTN2?=
 =?utf-8?B?YTY1RGxabk0zbzZFendGSWtBWjB6KzhzZFd0UTVxM0hXdnNldjBKdkZob2xx?=
 =?utf-8?B?TW11Q3N0K1lrVjIzSUpBaDM1L1ZrM3owdnM5NkhxdG8zdnJMZnYwdlh5S2Uz?=
 =?utf-8?B?a0FCZDUzdEF4V0hieWVpbzZJTmZDaXIrbmdwdUo1cWwycm9aR20relJJVWNG?=
 =?utf-8?B?cGcrMko3c2VXaFRJcWVSYTZDckZGcTRkSzBvNHJmbXlYQWh3V0NKaGRqNVBh?=
 =?utf-8?B?ODZBMmtuMTg1TEtUWWpJT0ZoVmM2T2o2OUcxei9RT1dEQ2kyeVkyU2VwU3Vx?=
 =?utf-8?B?Ly8ySSs1QXVNbTl5VEl2cVhMTVpHRXN1am1xVEE1QlQ5SGNFeGZoK3F2NzMz?=
 =?utf-8?B?Q3lIUWVRWWtlSFFOSFluMnJOYzk0MmhzNjBvd3o0YUdXdlpidjh3aHNIMlpn?=
 =?utf-8?B?N1BBRStoNHIyMUNRMlBUZ2F0cm16TC9OcHVNM2ViZEZuTEZLSVFKaEhBWnFz?=
 =?utf-8?B?cG51aXFXcDgyMDVVVlZQSDJ0eURscjJEamdWVWFJbnNvVzFuRFBXM2hqYURa?=
 =?utf-8?B?ZnpGUElSVUYwMkp1ekVzMkNKODFkMGlocDhvKzlQQ2dRUkx0NVByNVg5RE5p?=
 =?utf-8?B?Q2J3Q3B1UFVoTkhUbWRqRy9qd0ZmbTg1RmpBRjNYR3UxRkRmN2luR0xUZkxV?=
 =?utf-8?B?cVBpZVFxTGRqaVZOa3BuVmdDckcxUjdOa1pkbVJINWJVT2VNcW5IWWZXTXJo?=
 =?utf-8?B?UG03azdtQi9ZYUFDN2R4WDVLZzZJcG5oWnhxWHJzMElyU2JqUC8xYzNkZlFV?=
 =?utf-8?B?c09EazFJMFR3SEFubVhVck12SEVvbmFLb3EyWmZLci9lb0EyWmhCSzNZOEFY?=
 =?utf-8?B?aWpIVDhiZVBRT0xnaDFSbXlYRmZIaWxGbWV1Tk1rWElIbkVnUkwyUkgxMXk4?=
 =?utf-8?B?b3pqcnpTOGJlV3JwQVlmb0NGUm8rcFkybGxkWUZ2bTg4VkUwalJIemJOOWpY?=
 =?utf-8?B?elRlbFlNeWZJaE1laEJqTmxKdi81Ukpydnc5OTJMQVFYdllWM0hPc2pWK2NT?=
 =?utf-8?B?WXcvYVN4a0tKYitiTjhEVlZxTzhTaXdhNUpMaE9venUwN2lQazdJRFFld00y?=
 =?utf-8?B?OUhsaFhaWndkRFAwdmc2eG5zR2ZNajQ0Vll1QzFjQWZyOVRFZWVxd1F5ZFNi?=
 =?utf-8?B?amlBWE9BRmxhdk05eVBBaXE5SG5GaDZoWWhHVnlaRGMrWE1aR1pSTzJaZTR2?=
 =?utf-8?B?ZnQwTXpwMkhEaFdrZ3ZEcFR4Q1RaNzgrdnN0Rk5PSXdqYUxBRFdDMFZWcEY4?=
 =?utf-8?B?amxlZlQ0K1JKby9sSFEyRXlDdWttaWNiRFRpeHRaeDA1NTNManhPTU4yOGxn?=
 =?utf-8?B?SlIzWFYwWnlDMDlFK3VoMFlwRmdHYUR1bjNLaDgvZmdpQktMaDRESnF5WkZJ?=
 =?utf-8?B?R2wzMVAvQWJwVlREQ1dweFgvbE5JSUZ1OEdyT1EzWEY4MzZaVkNnNjhDNGo1?=
 =?utf-8?B?S2d4QkM4cGpQcXY4RVg2U0hBRGNJbHUzVzB3dW84RmFWVTRSUWpxblE5dlln?=
 =?utf-8?B?ODFPVGxFZFlNWTFEWmRuYkdDTjMyRWI3YTVybmx5UXc5QzVwOVNSaHZHSzN4?=
 =?utf-8?B?QUpRZHROSjhtWUxGWGJUNGFUbWFZcDNPTG85NlNIYi8vakVMZi9UUlVZZDBa?=
 =?utf-8?B?TE1iS3IzbWNGQzJ4Nm9Jb0Z0d1JZSXNCaTZZMXlFV1ZYUVVGbStiYSttcGEz?=
 =?utf-8?B?eUkrekdML2lZZERTaFNkVVlJUjNZVjliWXhwQ252WWNQTUIyaDl0cEpjQUMz?=
 =?utf-8?Q?gSl9/fqQIjfzGFFyV9iwaQJKACvo8T/P?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?KytQMjAzZ2xFQnlaaVZwV0hrdk5HaTNMT3lmWmswdFVZR2xFbERMVHRpenJ6?=
 =?utf-8?B?SHZncGJ3UHFkNkxTdVRzUzJDN0RIei9MOEFXbUplMThEVGt5UnlpS1JPejk5?=
 =?utf-8?B?ZnpIcjdTZ1JPYlY2SUtORUdleDNvZUhNZE9jdkcybFFVRkNzajhOYjAyZTU4?=
 =?utf-8?B?Y1lGdjBuL0dTaVVpanhFMVdJaXBYWjZydHdCUjZiRFVSeFNhWUR0Qm13SUMx?=
 =?utf-8?B?K0o1SHRHQmR5a003U1hFUWlsd1lnQ2NWRFF6ZEJKN1hKUVRvYy9zTW9OK3h1?=
 =?utf-8?B?TVhJelJHb1p2K3VTb1ZuZjdMS2UrTzRNVlpkTmpyYVZUM3dtTmx5UDlob2No?=
 =?utf-8?B?bW15VTdCanIxNStQRHJzM0tGTVZURTZkVlZIQXpDWThqWW5mekpKTDdhS3hl?=
 =?utf-8?B?dSthdXRyUVZQT3ZOL0JnTXRpUERSeUJqWS9XZVJ4YmlPSVN4L1VEZU43d0pv?=
 =?utf-8?B?bjZFRjlSdUIwZGNnaDA2WmMxRGNHc01LSHlldWF4RnpyUWUwQXREN01LTXBN?=
 =?utf-8?B?cWVaN2JZeVV2NGQwbm1WMUdWN3hpbWxDQ2V3am5HZGZTMUhuT016ZTVIcGFv?=
 =?utf-8?B?VWplSHRvT0VMcTE1VmtIV3FuZ1d6VVphUFhDb1lpWkw2WFFzbldFNW5pTm55?=
 =?utf-8?B?YlkyQTR3SEhDUnlnRHg5YjVoU2lqcTE3cGZkemtYWExXektsMTdzeEYxaXMw?=
 =?utf-8?B?Y0RRUmJlTCtsMW9YdWdnZW93OUpsenlSZ1dObUFPeW1yVVNJNExqMUcreWNB?=
 =?utf-8?B?bW5DOHkxOXBldnVXdjdEVUYzM1BoZFNDTW9YZlQwU3lzREZvRllDUlJHZDRt?=
 =?utf-8?B?bG9SaUM2NTJaWUQ4d0dIT2Zodnl1TnJIM3ZTa3ZNeUxTdU1WNWZxSFdYVjNP?=
 =?utf-8?B?cjhCTHZJTzlIbWM2cFFYeUVBUnBTRGJlWXh2NmtCVmJBMWlmQUhlblRqRk5V?=
 =?utf-8?B?bHRUUWJFZHZzOVFDOGEreWRUeS9mR0gvTmJmZFZKVXppQ284KzRvanExS2Qw?=
 =?utf-8?B?Y3NMV2lsb2dBL0lCd3Bzb1FJWGJWcVFEMEpGVnpzUlV0S01GMVozWlFXeFNI?=
 =?utf-8?B?cmJNMmlmazNoNXVENGZQSnJsZ1dCODVpTldhd3lDc2JiWFhQSmhTdDNxdkM5?=
 =?utf-8?B?MnRQUjR6YmVtMFppMHcyOUZJQmtWeUFIM3IxQWVSZVdTZnJ4QVpOMUs1Uis4?=
 =?utf-8?B?TC9wRUhOTldqdnRnbHhROEpYVEd3ejJJVER3LytXY20xZWFzeGFOUUQ0d1d2?=
 =?utf-8?B?RWZROUFsb1FuWHVZdVc0YUJQdDdKWXo5UWZhVzZ0eVlhTWlnQUo3eW1LcnFK?=
 =?utf-8?B?U2kvWGRGTVVJam9YYkw0VHRtZzhmTHEzTmh4ck5NTDdyTzczaWVpbXhJalB6?=
 =?utf-8?B?NW1MdWV2RW1qZjVQTUsxL3prQTI4SSsyQkloN2swdzBTMzhXOE0xeDJhMzN2?=
 =?utf-8?B?eDk5WE1kVDBMbW9SWVlyUzlFVHBxZ1MxeWZXRW9jOTJFUHJFOGdxdUdiUlVs?=
 =?utf-8?B?TS9lalNzSlJHcGlFdlFuMlhPUkg0QnR5MnNOOHIrY1htQjd4Z0tzWkgxTFhp?=
 =?utf-8?B?a2J0VHpTMGZVUndDTkxvcVowRk1EekxPYU8vdVpnQ25VdjZLNjJjVXA2UDFC?=
 =?utf-8?B?VU5oelhwNXZweXcwTEg5ZjM2dUYrYmRYQzlPRDM1KytRUUd2RkQ0MDFHUlZF?=
 =?utf-8?B?ME9QUmk4ekpBS3ZqR0ljd2FITzc3aVpxTEJWVnVsT2RLRForUUt2U3BidlFH?=
 =?utf-8?B?OVVlTzhIc1dINERWVHBWand5QnlZWDQxSEJRakVZcm43TlpXTXY5UG54aHlM?=
 =?utf-8?B?cWc3WHRGOUJiWmtVTUFNVEI5YWFDUkhTV2tOcVd6SldIQWlwWlQydXlneTVQ?=
 =?utf-8?B?MWJTU3Fia3lJMWZYUTU5L1VhVlBpVEdCdDFuMGFidWZ3ZjBCN1BDcno3WmhO?=
 =?utf-8?B?MGZjVUdvbUhqQnRhSThXS3lKbjZ2ZHc3RGhNNDFrSFRXYzlRT1BQNnBwRUg1?=
 =?utf-8?B?bjVkSUhacW4raFRkTTRybHVsOFFXMkowWDhwdlJpREE0RHBoTExVMGNUK1U3?=
 =?utf-8?B?TitEYU1WTHNnWFBxcDhsSDRTWVVFQlY0NUE0WEZtKytmL0VFaUt5bG1kbE80?=
 =?utf-8?B?Qnd2c0xYd1diVmJrYWhUZnNJOHkxYXJweW8vWjlScEZiTFllRVV4dVpwb09h?=
 =?utf-8?Q?hxLwZw1tqL+vKaFxp//ZDNs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A4D919ECE3523428F105ACD45346F7A@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8100e597-4c04-4b59-7ddb-08dd50c218e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 08:47:52.7295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kRGoamJpWF8qiM0TSGj12NUJwM6UnegYw7AnH7OywMsNLzMIoiqYv9hGrusd/iOa37Ehn/Y9A3uw6F/TCLQXgt0J/PZ37oM6Rk93LEgNZW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8187

T24gU3VuLCAyMDI1LTAyLTE2IGF0IDA2OjUzICswMDAwLCBDbGFyayBXaWxsaWFtcyB3cm90ZToN
Cj4gSGVsbG8gUlQtbGlzdCENCj4gDQo+IEknbSBwbGVhc2VkIHRvIGFubm91bmNlIHRoZSA2LjYu
NzctcnQ1MCBzdGFibGUgcmVsZWFzZS4NCg0KSGksDQoNCkkgbm90aWNlZCB0aGF0IHRoZSA2LjYu
eS1ydCBhbm5vdW5jZW1lbnRzIGFyZSBvbmx5IHNlbnQgdG8gdGhlIGxpbnV4LQ0KcnQtdXNlcnMg
TUwgYnV0IG5vdCB0byB0aGUgc3RhYmxlLXJ0IE1MLiBTb21lIG90aGVyIGFubm91bmNlbWVudHMg
bGlrZQ0KNS4xMC55LXJ0IGFyZSBzZW50IHRvIHN0YWJsZS1ydCBhcyB3ZWxsLg0KDQpJcyB0aGlz
IGRpZmZlcmVuY2UgaW50ZW50aW9uYWw/DQoNCkJlc3QgcmVnYXJkcywNCkZlbGl4DQoNCj4gDQo+
IFlvdSBjYW4gZ2V0IHRoaXMgcmVsZWFzZSB2aWEgdGhlIGdpdCB0cmVlIGF0Og0KPiANCj4gwqAg
Z2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3J0L2xpbnV4LXN0
YWJsZS0NCj4gcnQuZ2l0DQo+IA0KPiDCoCBicmFuY2g6IHY2LjYtcnQNCj4gwqAgSGVhZCBTSEEx
OiA5MGUwMDQ4ZjZiYTU2YjI5ZTE5NTA2YTlhMjEzNzkwY2M5NTNmZGY2DQo+IA0KPiBPciB0byBi
dWlsZCA2LjYuNzctcnQ1MCBkaXJlY3RseSwgdGhlIGZvbGxvd2luZyBwYXRjaGVzIHNob3VsZCBi
ZQ0KPiBhcHBsaWVkOg0KPiANCj4gwqAgaHR0cHM6Ly93d3cua2VybmVsLm9yZy9wdWIvbGludXgv
a2VybmVsL3Y2LngvbGludXgtNi42LnRhci54eg0KPiANCj4gwqAgaHR0cHM6Ly93d3cua2VybmVs
Lm9yZy9wdWIvbGludXgva2VybmVsL3Y2LngvcGF0Y2gtNi42Ljc3Lnh6DQo+IA0KPiDCoA0KPiBo
dHRwczovL3d3dy5rZXJuZWwub3JnL3B1Yi9saW51eC9rZXJuZWwvcHJvamVjdHMvcnQvNi42L3Bh
dGNoLTYuNi43Ny1ydDUwLnBhdGNoLnh6DQo+IA0KPiANCj4gRW5qb3khDQo+IENsYXJrDQoNCi0t
IA0KU2llbWVucyBBRw0KTGludXggRXhwZXJ0IENlbnRlcg0KRnJpZWRyaWNoLUx1ZHdpZy1CYXVl
ci1TdHIuIDMNCjg1NzQ4IEdhcmNoaW5nLCBHZXJtYW55DQoNCg0K
