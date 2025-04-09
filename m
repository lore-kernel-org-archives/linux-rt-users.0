Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2045.outbound.protection.outlook.com [40.107.20.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2A81DF26F;
	Wed,  9 Apr 2025 06:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744180911; cv=fail; b=NKDXq3hOX9g0qR+W4Q2naStf9PgQLp+qxgjdmE6qpIzq3QlhD0cZLt6fY4qWDLS32TQ+21R9CDC1DYtAOhqP1LoO+t4o+bF4uZG8lSwz6I5cnhHLg/ELUeSMHjQTtthtbHKjxlZepLDEtSIk6UhzqC7rHR+6gluJ4LtCveqQlVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744180911; c=relaxed/simple;
	bh=TjW+irL1jPnK1rfBsMnd8rbZAOU3UGDMYs+V6ZECnFs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sYUKCcOhs13hKUB6CbM6n+1isQvfDDwEDzO9OWffdjyzB98jz5UaaD2oF+TAgJevgdcmUjVLX4QyXA3t+zNBSj4Eu59HHDZkNAfjkMmIN1WDTdX7QkCYEd321OhJV7AyQ6mogCM8CSAxx5dx8kEwxR2nCpraRA3YdjkkBsO6ygc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=fv20wHrD; arc=fail smtp.client-ip=40.107.20.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="fv20wHrD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W5WayNf1xIfhEKdZoMXrIovHiTn/8UYTKCJGINhGdqH8R8YFV7IHnRGT9dyodeGFQ7JqmX85Aprwa4myKZtZDlEkp9J1w1Z8dUkefNP3yqISs75LFQYNeLGvh4mj8aICQWroDUrKzEMifdAxXn7v6iNt4LMZxREHTp9dLPiaQCkvhtGutcnWrKHhC+i/d99z3HO+txz++sKAz4ODeSF7SKC7hqTHfygELUBMBvwK73ewa9lElCn8619DeuC5RbXUCR72ZW3bF4mZaUzUlq110iYdcSHsB/jD1ct9GrSRt86De5IlyDU9SeXO5MvDP15ap63+FpGrJEsteVSugAJk5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tK+pCrP5vAOps+i1Te7kR90r21i/M6mso8g37Wp7WTQ=;
 b=eaOxca7CbgIn2xBapy48rnMeT43lWgLPFK/ZD5i2Xf93OFco70qdUOHozjzBepUqlqktqRc+WOF4e+Q4733D3J8DqN7eS/B2GycIb6v7WiR14G6b3CxmPK2fCAx8gUi1mlcG6+cZ1gQklyGwIUgDpG6q78LlgW0hiIDvDeFtSZzzypbUluvEgA+ZyTNhfevmsQqSQlyI5azr8PA+yTQccCIyYwDesjAmk3rSbmJdcLp5C8ylqqbiTG2EpvTQq8fuyxAnkXNQmT/zwdDnT6EkqYdNUUxMaz/CP2EAmzBCxk50FRhnijf22DjG2anGad+gTic5BafW/5s39+yRe/xqgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tK+pCrP5vAOps+i1Te7kR90r21i/M6mso8g37Wp7WTQ=;
 b=fv20wHrD1a7DHfjKbzz5nE8TpUC5BaBM7ZLBNbdSaYbl7LdKLQfXy7Z7MeHE4uem6JFAS9/oqtnR9NMxYcHa3uS+Ac7WIKrxHGO++M1xcc7taZex3ImxJMj5zkV+2qvlASGyLEZd/IPckRYuA0BkeiHD98am0CqZKOtgS+VvMV5pjLvZU+8CUvyPoANlCUH6sYxuytPBywausqnaP1/QHSGDEEpJRYllRM9rOA6Tf8gUbSMRIElap8knSkBQZsxjFoGqKFbEbBqMyTUeo8J+2aLNihTlr7Z5SR3gp5xjsUMxdvytVKYpM0dwHyDvyhSmDP0fy3fh23XoPzq53oZRsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB8573.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Wed, 9 Apr
 2025 06:41:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8606.029; Wed, 9 Apr 2025
 06:41:45 +0000
Message-ID: <3f7b7ce1-6dd4-4a4e-9789-4c0cbde057bd@siemens.com>
Date: Wed, 9 Apr 2025 08:41:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RT BUG] Stall caused by eventpoll, rwlocks and CFS bandwidth
 controller
To: Valentin Schneider <vschneid@redhat.com>, linux-rt-users@vger.kernel.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org, kprateek.nayak@amd.com
Cc: Thomas Gleixner <tglx@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>,
 Clark Williams <williams@redhat.com>,
 "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
 Andreas Ziegler <ziegler.andreas@siemens.com>,
 Felix Moessbauer <felix.moessbauer@siemens.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
References: <xhsmhttqvnall.mognet@vschneid.remote.csb>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <xhsmhttqvnall.mognet@vschneid.remote.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0308.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: 5046b486-46f4-4a0b-8197-08dd773198b2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGIwK0RDSGJWVjRtSnpraXdiUnAxYlFEamhMQ0VqZFI0WktIc3MyN2g2TXAr?=
 =?utf-8?B?TjcxNE9wKzg0cWVxcVBSemVkbjRKSks4WmYzTEYrRUFzbC9CYzNuQ09IMEdi?=
 =?utf-8?B?THJ3VmRUWThIeDM2ci8vNnRJeUlib3pMOHp0UkZ3S1lLd1RiMnRGTU9hVFA4?=
 =?utf-8?B?NUJ2enp3Y05oaThRL3VvRVJIdFo1NHc1N0ViOE5kUUVFbzVtQlVLS2ZobndB?=
 =?utf-8?B?ZThnRmxyVmRZUGJxQ1BWckZjNWJ4VWkrQWNGUURzTzJUdE53bFN3VUNyb3VV?=
 =?utf-8?B?VCsvODMzc213MGRKa1ljaW9SNnpvbEFTazhxMHhnZUtsQVRXV1JzOHhmRWJZ?=
 =?utf-8?B?dzhqT3prSldwM3Flc0dqbFN2NTlqRTM4T2lDU1VCN1JiWjNDc2hsNjFuOURw?=
 =?utf-8?B?MUswcnpRYnRTUHJZZitnVFEyenlUaVZmWXRHdUNnSGhQazZlWjQvSGdQMTVN?=
 =?utf-8?B?bkFTb0V5VFp5SElQRkJUNWxEa3ZPN0dsU3hBM3RGUmtMdUo2M3dFQ1FPaTFa?=
 =?utf-8?B?NWkyMW1qMGhnMk04K09NN2psTWIyMkdWRUE3M0VxNUxOMHZlSVBNaDBQOE9D?=
 =?utf-8?B?RjM5bE9TWGRJUGg5bkZPdzFyREE4dHJ5aTBVdHM4WC9jcjA0ZEdId1crM3Bi?=
 =?utf-8?B?NG1xMWxES25sUDRqNW1jSytUSEFNMXVWYnFKQ2ZEQjdKNW5jMkI2WmN2TkNv?=
 =?utf-8?B?d2ZmU2ZzNzk3VFNVZDRJWXRPMk83N3F2VEVNMXFDV0FJK1pOVmJJcnFVYWhs?=
 =?utf-8?B?dDlNWlpPTHhaRDl2Wk1wUkhST0hpZTJWNGw5bmdnVkJoVGlNNWlPTjB0LzV5?=
 =?utf-8?B?U0FZRElpcTVBWVdrZ0kwV1RIbWZUOVdxeUJaT0EvRHhsODl2R3FLaE1jNDBB?=
 =?utf-8?B?OE1CWXo2NmlvcGdPaUQ0RDBwWXpaSzd3VVk5RkoxY2NhY0owQjc1SzEwbXp1?=
 =?utf-8?B?MnpCRTIxS3gxVnkvcmRlTDBuVjJhbG9IM2dqN0xMZDVmdUhwbTkyWjRaZjg5?=
 =?utf-8?B?ZnFNTXdYTWYreG5QN1FIZUczU2NHb1FqU0FJVkRNekhSaVFmbE82RWRaWDMz?=
 =?utf-8?B?L2pxK0xYS1FrM2N1R2RNTXJIbGxZd3ZOcjM0Q1FmcFNwekJkL0JTNzM3T0hn?=
 =?utf-8?B?dGRWMmdmSnEycXJtbG0rYkowR1ZmeXFMb24wdTlIUzNNVEZNeVF3RnBUQk55?=
 =?utf-8?B?d0ZONVJMQ1pncE81YktXZ2pQQ3NoOWJOdkFRbWtvdDVENm94YlZCenJ6Y2Iw?=
 =?utf-8?B?dzBwNmlYanVJcHNmd3hESG1QQXhiV0RncktvQkg5UENlOE14OFZsZGVRUllS?=
 =?utf-8?B?OTFUMzlWZFh2R29GOFJUZ3Fnc1ZQUklublJLd3gxcHY0VWtKbWt5UkhoR3Rj?=
 =?utf-8?B?U2RrRmRBQ3dHMVQvd2lTMEl3Tzc0RWtrTFlxWmZLeFhFM1JRTnlYL3JpY0pV?=
 =?utf-8?B?S1lMUHJHa2RvdlZqb3k4SkpvUG95OG1HOUNRNTdhQkcxVHN1Q0VjQ3d3YUNq?=
 =?utf-8?B?LzIvVzN5OVVrUjV3TkljMGFZM3F1Z2pnRlA3SkVaTkxxQjZ1N2FvUVhiQ2dS?=
 =?utf-8?B?NC85NnZNRWdJMlBwRllTS3ZjTWVuMU9SVEJnRWVnYlF1NEp5VWFzOXdyQ2w2?=
 =?utf-8?B?UmUwcnNYUUsrYmVib1crYTRwWXRVL1ZOWE1sZDlwSUk1dVRIL1RKYlovcVFK?=
 =?utf-8?B?OVJZYjFHems4SVloOHgrZGRZUDBGbEtrbDlnV0tFMlllUkVvZ3hkMktJRUdn?=
 =?utf-8?B?T0ZzK3J0a2c2UkZjVnErVVBHb25EUkVxSzFOZmNweHpYVW5XYVdVWWxySXVJ?=
 =?utf-8?B?cEs3U0xCR1ozTzB4RGRrb1JjM3FJQm83QlJiZVZLcDJmdzkrL0o2eVpzTkZY?=
 =?utf-8?B?VWdEa0lodWsyQmcvQVRvdm5kYjZqZ1kyTHBqSW4rTTk5c25FVGJzOGI4SHQ4?=
 =?utf-8?Q?QyCV0/FqmqM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzVkNkY2ei9JZXhrUTI1MlIwWmhRN215ZjFwZXQ0WkwvNnBaNDBTYVdZS3F2?=
 =?utf-8?B?OEx1SGM1ck9ON3M5QXlNYUUzUXV0ZXlFVWVyMUJxTHp2ek0zamNYSENCNlRE?=
 =?utf-8?B?SlRHZVpCcC9NTXR5ZkExSEtiNnhIRDY5UWpqZ3NkVndERUNsMUNoS3NZL0ox?=
 =?utf-8?B?SUR4WERxT1hvbUNYMk1aTzhMUFlVU3JTRCtBUmFCRkE0d2NUU1RJN2N3ei9h?=
 =?utf-8?B?cFJVVTZPeVFlUDFGM3YybDNQTHQ4MUJqMzlURnJzVE5jcHpTNnRaTVB2cmU0?=
 =?utf-8?B?Wld6bHJwQnRZcXdIVFdGb0hQRndMbkdhMkp0cEVKWStUbE5sSGlhY0ludUFO?=
 =?utf-8?B?T0hoZTV3Lyt0aC9tVERtSXFUaVF5K3NlUkxGcEJNVmpOQVRpUHh3UThOOFk3?=
 =?utf-8?B?VkhJa0F6TzByWTRxR1VjNlhvcllIa2JvODh3Um9HMUwyRnFUbEE3MmlLdEhU?=
 =?utf-8?B?Ym5haG9aRTFIOHlqdklvYllLTkxYRDA2TGVHZkRWekgvZkgyY2NjTSt0cUNX?=
 =?utf-8?B?TysvNUNnTHZrdTUyYUpacmF1SUh2N2wxMTFWMUszRHpNZzU0b3laR0I2UVhP?=
 =?utf-8?B?aExoeEN0QjZ2NVh0Z0RIbU9YcVJxQ3NwaXh3YXA3SDNBUnMwNHhUdWhUUXFP?=
 =?utf-8?B?S3RPMitjRkJ5ejBzSDAzQnZBWGE3Q044YS9nY1JxTEFzeDJaOWs5UEh4UnBz?=
 =?utf-8?B?VWZWenRabnhSRlhPbGFKUHcvNXplMVUwTk91ZkZ0ckp6MERFcEFvTHZUUFhi?=
 =?utf-8?B?ZnBCZlVDNzRRSzdRVHF1MGp2d1ZaR0FoMXJ5QVU1MlJrVko2NVpTUkgwNy9r?=
 =?utf-8?B?ZlBtR2NxREFTaHRTWFNOd0NBWS8wd09CWUIxM216Tjc1bVJwa01WQy9QOGsw?=
 =?utf-8?B?RlUzUytCMEVMWTY0SGF6WUdVZGo2MTVrUkVuQ2UxY3FNMU91bTgwa1orSnVs?=
 =?utf-8?B?Umh4d3h5SUd6RWV3aHBPa2tEcVVSZ2VLQ0ZiSFc3bjc3dzI3cjZDUVlCMFEw?=
 =?utf-8?B?LzFlTVRoRUNENmRTMHpZYjhqL0xiekM5R2YxZFp3blA0ZDduanY0MWI4K3E0?=
 =?utf-8?B?L3VKdnFtdjdxQkNoT2RSSXlWYU1LazhtdVNSVURIYlBJYWtIeTlIMlA1MEI1?=
 =?utf-8?B?NGVrTndyMTFycGFuSUdteE9pc253dFZMSC9IZUJRZk9lWk53Q3drdXk4U1c3?=
 =?utf-8?B?Uno2bFN3UnVlcklBWU5DbmEwSU45WjNUdVZQMUp4L0ppRWpLZUFYQjZTRzkx?=
 =?utf-8?B?bXA5L256aUZZQUk0WHdYWVc3Z0pNUXRFSkVvUnVZdW5GdTJXblJUMGFySlhZ?=
 =?utf-8?B?RTVXa2lJSmt0bkVJakc5akRDYzVaejVxYVFUZ3pEVCtLMGw2WkFQM3cvU3hY?=
 =?utf-8?B?elhYQ2xQclM5aDVORWJZZWU5bTZ2TTZyY0hNK2Vta1dSQytocGZWUk4zR2FL?=
 =?utf-8?B?ME02ZkJ6QkFBMStHZXB5VlJCRmNWRy9uMmZGSURSUTNUMWVBd3pUVGFHTmdS?=
 =?utf-8?B?WUgyalpxYXl2SDgzT05OWkJ2aDNrRFRUaTJlRUl0NEdsaXMvTkFqOXRvZHQ0?=
 =?utf-8?B?QytXM285U0x6UU9PcFMxZWs4N2VlWGFmWFNsWUdFLzAvRzZaMjh4dDNDMFdi?=
 =?utf-8?B?K3pmUXQ5ak11WWliTGdsaE5yMVNBL1JQZmZxMDRoejgvakZMRkY0WFFibkJV?=
 =?utf-8?B?c0tHVFZNb210SnN1K0VseC8rTWJZYi96TUxhclVlUnpzdHNQaElXNW1nNkk2?=
 =?utf-8?B?dWF6T3lkMUIwWlJmUFcrU0hnNUJVcWhyLzFySkVSK1ZDMXdnWEpUcjhXanhp?=
 =?utf-8?B?NG56RjBwYW9tTkJGM0lWbDZrZkZrNXBWNEJSOFRtSDlQcnp5WHMvbXB4UTlO?=
 =?utf-8?B?c3hwWFVnTlpBUmN0bW5UdjVnMEtMVjZtMTc5OTZaUFQ3YTZIZDVMaHNNY0xN?=
 =?utf-8?B?OEVGaU9iUjkzVUdqRFVUblkvWkROUXErVE0wWmRaSVdxNHFUMW95bmlrSFEy?=
 =?utf-8?B?U1BsaVNiMUcvME40dFhIVGFsVXFycmg1RTAxaHI5azVLZ1dJVUUySmxpNEJ3?=
 =?utf-8?B?Q2xJTnJ3N1VhTFA2QXNuRWJidUMyQUtVbjNhQ2Y2Sk9mM1ZPL05NUEt6Umor?=
 =?utf-8?Q?7wTOT/5BbyrP5MtfQknkjE4/H?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5046b486-46f4-4a0b-8197-08dd773198b2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 06:41:45.7062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H2AqezsA+YpZvnfR3bokV7d9P3l5Ke59Ykw1Di76DiKg1THIZzm3oDGSPL5Pz5kJzRLjwuTGr6RHzdOMGQ32SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8573

On 12.10.23 17:07, Valentin Schneider wrote:
> Hi folks,
> 
> We've had reports of stalls happening on our v6.0-ish frankenkernels, and while
> we haven't been able to come out with a reproducer (yet), I don't see anything
> upstream that would prevent them from happening. 
> 
> The setup involves eventpoll, CFS bandwidth controller and timer
> expiry, and the sequence looks as follows (time-ordered):
> 
> p_read (on CPUn, CFS with bandwidth controller active)
> ======
> 
> ep_poll_callback()
>   read_lock_irqsave()
>   ...
>   try_to_wake_up() <- enqueue causes an update_curr() + sets need_resched
>                       due to having no more runtime
>     preempt_enable()
>       preempt_schedule() <- switch out due to p_read being now throttled
> 
> p_write
> =======
> 
> ep_poll()
>   write_lock_irq() <- blocks due to having active readers (p_read)
> 
> ktimers/n
> =========
> 
> timerfd_tmrproc()
> `\
>   ep_poll_callback()
>   `\
>     read_lock_irqsave() <- blocks due to having active writer (p_write)
> 
> 
> From this point we have a circular dependency:
> 
>   p_read -> ktimers/n (to replenish runtime of p_read)
>   ktimers/n -> p_write (to let ktimers/n acquire the readlock)
>   p_write -> p_read (to let p_write acquire the writelock)
> 
> IIUC reverting
>   286deb7ec03d ("locking/rwbase: Mitigate indefinite writer starvation")
> should unblock this as the ktimers/n thread wouldn't block, but then we're back
> to having the indefinite starvation so I wouldn't necessarily call this a win.
> 
> Two options I'm seeing:
> - Prevent p_read from being preempted when it's doing the wakeups under the
>   readlock (icky)
> - Prevent ktimers / ksoftirqd (*) from running the wakeups that have
>   ep_poll_callback() as a wait_queue_entry callback. Punting that to e.g. a
>   kworker /should/ do.
> 
> (*) It's not just timerfd, I've also seen it via net::sock_def_readable -
> it should be anything that's pollable.
> 
> I'm still scratching my head on this, so any suggestions/comments welcome!
> 

We are hunting for quite some time sporadic lock-ups or RT systems, 
first only in the field (sigh), now finally also in the lab. Those have 
a fairly high overlap with what was described here. Our baselines so 
far: 6.1-rt, Debian and vanilla. We are currently preparing experiments 
with latest mainline.

While this thread remained silent afterwards, we have found [1][2][3] as 
apparently related. But this means we are still with this RT bug, even 
in latest 6.15-rc1?

Jan

[1] https://lore.kernel.org/lkml/20231030145104.4107573-1-vschneid@redhat.com/
[2] https://lore.kernel.org/lkml/20240202080920.3337862-1-vschneid@redhat.com/
[3] https://lore.kernel.org/lkml/20250220093257.9380-1-kprateek.nayak@amd.com/

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
