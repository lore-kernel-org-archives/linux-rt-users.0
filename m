Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F80263F46;
	Wed,  9 Apr 2025 13:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744206123; cv=fail; b=WoMSagR4qTxO92lNFimKlbg35kflMV9vcfimog1uYAPiDAdV997uiIOQGX8RvoIG9xXe4rzgOjkGzqVYuixdmFyoJn9eA+KnIUkt0adgzwLAY3zC4f/8pozY7irxFK89j+273cl86NvTUVWv1j1h8rD9aymY059xEU6Jai6oA88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744206123; c=relaxed/simple;
	bh=+5gVtnj0LtuWp77fZvMaP1lUPQG5PtYh5tL+JCv+IbE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qOh7SR3TP2nv4eXWgTo0linjuykVrr7j1gQcubK3Ce1uyiai17oM7oKy15YKXBhqxOFmwkZFH4e11XOrG7Nwp3Bi/Ilx8MDk98prbuWh03ihS9a6XhbSTSgXhv6kP3d0AjjLygSmiP/fNQ5koPHpR3MAIFXaXg9rippsldT6JXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=mCQyzIvs; arc=fail smtp.client-ip=40.107.21.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="mCQyzIvs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U90Pc7mmUUIYjXkJII1hGZ1Ol/63yj2JQ9hNYikhhnZInZO3z4XOhE67Tep8FEyCPHgeY7Rz/SMYoV/jia8cxbS/m0nykW6VKkxQuB1ZyfvsQy+sr9ma07ZxYbjDUKTqHUeGAPukaBYobczSFHi5W0F2yb1X8oP9Fg6OFPOVb8NJ2dMm8IpkCxgNXEjZfrETZrbjH/mU3vePtm+jjX5ydOVvdJsimmq4mbSoHb2AbKUwBxKoNIR3y3ZzOpJeizcy0svAp54SfLmk+wYMxLhBq+DKXOcX8u3Ap//bVFRvg9AvfxjuQfTD15hLyTj9CSWxhdMwAs4DoZyZvkx0QmZxDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKcK1G4p4v658HEggsWVBLsD66Dob6mfe9kM9QU5i0A=;
 b=wfYZd1rlHnEaa0dZ7vjKvHOgomhtCxnyfKS9gmYYNbvEocVCvB471aADeSUZ6BqZcQfNKZb90k9FQIdOVVNBjd/e+ZwfK00QF0cEKJdE60TVgyE1zcOhkqJ/YW+CXt/Cp3fxol/LwPndecUkMo3H7L6oP1Mm/vkCj4JNEjmUgZMFDrWdS6jNGH1PLrK4+EG0u3DUqav7xFA81cdN5mD9LnmVTMhnc5zNpBN/aHSynPX5/I2z1RbDZgS1SuMPL7nIavmYsSOXJS27X0+N9lIVQFmxitDF9Zpi3t3Ln6rUHclji5XS5NKft7PKbAvO8Kh6hnMatYNCi+xjYlje0kEbiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKcK1G4p4v658HEggsWVBLsD66Dob6mfe9kM9QU5i0A=;
 b=mCQyzIvsQO//fQmg4gtQmJH6U6fPjBpyXoMAtdvWGydoi3sljLXCWK3zAs7f1dq4XwbeOfCd4t4VCN7oVBoYF+IsvIFGwQ+q5dUH50ZbncTCRr0DtREiVNzR+8hSzbCtPbAUQB6STcObl1kZmoz3juvOmK3WXwcjrFmD268m/d5H9HJ4NFGEP79iP2l6xo9Q/b9HIY/Tjdm9CQvdC/vmjGo2llZ2yaDMU2WfFiW2BVTV/RXimwk+wRXgKWmS6KFTRchVb9H80UKchQO4ZlrOH/BIcCGTqgCWLsWVnZzXjF3PYrnl107yXNhNHzOFJ324HdORLW0Yz4eMxGB4K69TqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB8792.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:234::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Wed, 9 Apr
 2025 13:41:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8606.029; Wed, 9 Apr 2025
 13:41:56 +0000
Message-ID: <be4fa21d-0b96-45de-ac5e-bdb54bee335e@siemens.com>
Date: Wed, 9 Apr 2025 15:41:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RT BUG] Stall caused by eventpoll, rwlocks and CFS bandwidth
 controller
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Valentin Schneider <vschneid@redhat.com>, linux-rt-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, kprateek.nayak@amd.com,
 Thomas Gleixner <tglx@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>,
 Clark Williams <williams@redhat.com>,
 "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
 Andreas Ziegler <ziegler.andreas@siemens.com>,
 Felix Moessbauer <felix.moessbauer@siemens.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
References: <xhsmhttqvnall.mognet@vschneid.remote.csb>
 <3f7b7ce1-6dd4-4a4e-9789-4c0cbde057bd@siemens.com>
 <20250409132149.rFrzBCrP@linutronix.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250409132149.rFrzBCrP@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0597.namprd03.prod.outlook.com
 (2603:10b6:408:10d::32) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB8792:EE_
X-MS-Office365-Filtering-Correlation-Id: e2191ead-b078-4464-860b-08dd776c4ba1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RFdQUFlZNmVORHRVRE9BSVdWMlUzN2kxRDZJTFZjMVYvWU55Yk43U0k0Slc3?=
 =?utf-8?B?VXZwUWoyZWZBaGNjRzV6UEMrWlRodzg1MEIya1RVazZ0emY2cDh0UzcxSFRQ?=
 =?utf-8?B?dHUwa2xsWmNWNXZEdWE1ekFLd3JLNDFqT0dWSDUrTFZ2dlkzS1NHeDhCdjYw?=
 =?utf-8?B?d2dhL1ByVUhpS0dJRjVYdEQzTmRMRGhCWDdrS0g2amgrRjByUUpBS1J2NVBr?=
 =?utf-8?B?eDRkSjB1eFpyT1dxUFM3NFVSMTNDWjNrSE9RdHdsTDFBVkMzVHZFczdrV3Jn?=
 =?utf-8?B?NHpJMEdKcUR5SFlUU1ovdnBJMVJ5Z1FKdkNSVDBma0JTY2tXTHBuQUlWOW16?=
 =?utf-8?B?eFVJN1lTL01wWTF1cjQxS3o0eFdSUUNKcHFzaEJ3dkZGeXh3anNpYWluL005?=
 =?utf-8?B?RjV6ZUYyOU53UWo5Q0gzUzRzOFc0eE1uVEFuZktYcDJpbkNFdDZkaWM2UWdF?=
 =?utf-8?B?YU4xR2ZFWHJhRGVuMDR4VzBReXo2WnRjKzA0Q0tBNVY2SUZkak8vOVRxM0hj?=
 =?utf-8?B?NHFRa1FzM3V0cFRpdlJ6ckJlY0pBbkswSnZjZ2JUdG4vME1hVCtTWWh2ZXAv?=
 =?utf-8?B?b2t1ajk4ZCtIK1BNc2dOTCtadCtiUHpWa0NCWEY1RFhNZ2NVR2xrUWNJNmNS?=
 =?utf-8?B?dkVoQVZrL0w3UXgvcFRqU2g2WXdtdGpOVWgrM0pIREJ2emhzUzdZTUNHUkU5?=
 =?utf-8?B?VFpSSHRmYkRmL3YyWkY1OGtKZWJDZVBIRW0vVnAwWnFzcUl2NG4vc3dxejRP?=
 =?utf-8?B?UEZUaXpYaDdORWl1UTArVjFVcEYwUVA0YVpWT1M1eUo1SU5NaUVoT2N3ZWpa?=
 =?utf-8?B?eG52d1RqQWxFSEQ5UXEvNzVWMC9BUlZyK2dpaEVtUFp0Y1MyaXhuOVQyYzE0?=
 =?utf-8?B?Wk41RitoQXR5TEZqM1VXa3QyZVQ0ekZ0cjJUVUpVVjNXV1BoenZoKzlyQjhL?=
 =?utf-8?B?eWROdGlTTG10b3BZdDVVS1N1MTVzOXZjZ0xaRHdMR0pabWtRMmowREEwNU9Z?=
 =?utf-8?B?MTJMbjlzVHFkNzdTUnZaU1l4dy9OZUxtOHRBaDlRbFpYOE9rVzhucXlYNXRP?=
 =?utf-8?B?MW5WZk9TbkNxMmIzN0JQZWx0SklLN3VsUUd3bWhwd2dJU3NIZklrUU91RFdo?=
 =?utf-8?B?S3A3WlU5U0gzeEw1Q2U1SEE2YnN2UGVOSVlPSkliZTlETlJ0cWNOVUJjOGxR?=
 =?utf-8?B?TXo4UWY1QmF5THJwblpPN2dwMSs1SkljM3lyTG9TcEJNOXpXaVRCeTFDL01B?=
 =?utf-8?B?RDJoVy9TTjBZWGZHSnh1TUtXQ2F3eVFqM2oreEhOQlFXdmE2dmRwWSsvLzJx?=
 =?utf-8?B?QXpNVmJ4ZUUrcE5jVUhhWGdjUkFzVUQxWDBYeTR3djhYK29wNXZYVzhMTU5S?=
 =?utf-8?B?Umg3ZXlWWU9vNkN0NVpGbzBDZWtyQWV2aGE4ZitlMVlRdEd1dm1RdFA0T3F2?=
 =?utf-8?B?VlExb1EzMEpVR2dsV2RMSlYyeEpGVmF1UDFLSDE5T3JpbUxGWDNhUXBhSEts?=
 =?utf-8?B?ejcrdUR0ZVg3WWswcFpDbFNPWGdHYVlLcXVaNVI3VTgxMFJGUkp3SjVvRVFs?=
 =?utf-8?B?YjhzWkx1bG82aCt0am5IM0VEdEtHMzFFejhHWUdoSFY2N0VvSFdkRG1adEJq?=
 =?utf-8?B?OVdiOFJ0alBDMHplYWIwYkUydEpGNy9VbUQweVpaOFBaRWp6c3NaSUc3eDFR?=
 =?utf-8?B?VmtIZnV6bUorbzc0N3RqRHE2eWd2VlpKQzNpVFhraDJtQ0xIdkNzd2luZGJ2?=
 =?utf-8?B?NWxwVXlIaFdjd3NvdkdSQjBMVmlpYktuNHNpaS81aDlBV2lOU2V1anQzVG1H?=
 =?utf-8?B?OThtSUdiSTRhdXdMS0RPWnc2YnNvUzgxWEFWa3RZbmp1L0wzckQrQ0ZrN29H?=
 =?utf-8?B?VHNuN3FKS3RYWmtuK2h2cE0yUTNJcUFLVlFXOC9QKzVtczBoRXpob0hjaXlO?=
 =?utf-8?Q?HDLlVsQOxss=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzlWcEVQU0FuOHlsYXhTekhqS1laNHNlT01kUkdGMXRVZlNzNXBNNjVrYU13?=
 =?utf-8?B?R3I5V2MzaUJOQmNWRnVsdkR1TWVKMndaSU14ZGdaNHFNbk1nQ2h6R0s4a25z?=
 =?utf-8?B?enhHYlJJNHRxVEFBSGhCaVdqT01ndFc4R05HZElyOVFqL3B5VEtHOTVDdmVM?=
 =?utf-8?B?YUk5OEpqQmxkcGZaWHlHVU10SkdvTlVsb1Rpd1dFcjY2UkpCNHludStKR3Z4?=
 =?utf-8?B?R0I4K1M0TjVXQlk0L1l6cXQzTTFTY29pQmhxLzJuZis0S3BLTWxmYk9zTEN6?=
 =?utf-8?B?MTVtWGlxODM3L3Z3OUhjOUxTQVE0NUVVNnF5NjJ3Ym1aVVVnamx2V2RmZUF1?=
 =?utf-8?B?QmdHdmZ2MjhORlBDTHlXNmdVMjNlRFBMK2p4ckR5VDdQVHEzNTNrT2QxZml4?=
 =?utf-8?B?UU9xdXVlL2lpcE0wVFNVZmNSN1BDWUhOejNrc3RTZXNxazhuZklQeUxDZ0ZC?=
 =?utf-8?B?MllQUkpvSmZnZGhoendSazltbTlIaDh4RmloVlRLUGlBY1ZkZ2gwbnVQWUEr?=
 =?utf-8?B?eGhWNloxTUJLYmRHcjl5bW1mb1Vxa3ZyV2N6ZUFLNnNYMDJPYjZrQ3NsMTFO?=
 =?utf-8?B?bDNRL0R3UC92b2JqRENKODVhYlVneWx2SGFueUVHRTI0Qlh2NU9rQUFZbVc0?=
 =?utf-8?B?MEVjclVaQ1M2Z2c5N2kxUjdUUFRZYnk0T1hqT1dMZW5aaCtlWFlVZXFkQzM0?=
 =?utf-8?B?eFN6NDVtZWJxTGcxQjFhcm9UbFE4R1ZVZy9OYWJid3I5MzRteTgwR3k4bVgy?=
 =?utf-8?B?blhMMFBQT3IzRWxtc2V6c3RvSEt4QzR1WkNVQUlIZS9aZFR4WjZob1o1QmEy?=
 =?utf-8?B?YnUzbnZWSk56RjllWkowZjJVY0RDRG9VNlNubW8yUWlITkVYWWhDWHVKeldT?=
 =?utf-8?B?cmx0dUJvWEhmZE1VUElybkluSlc2V0dYS2RBV3U1SDdMMkhEZ0Fkc1BIVVgx?=
 =?utf-8?B?VzJlNEcrRFlmWXhZSkxXNTl4eUI4N090TmxhMWhTbVlDV3BoZjhzTlhmYlcr?=
 =?utf-8?B?RG9vUU5ZVDNpdU5GM2pEeXFIN1hqY21XMWs4OG1PczF2cTVtYms2UzdHQjVR?=
 =?utf-8?B?aks3TjFaYU1ZNHlIQXhEWHdHTVJLL2xqck9QazI2N0RKdGl2VGJXbkNOOXRr?=
 =?utf-8?B?eXpkLzdYYU4xZCtOc05iN0o4MEVZcDZRNlFPdnFtR0p3N3kwQlpiL2k4b1dV?=
 =?utf-8?B?SEk0TlVybU1LK05uU3B1WTZ4a2J1RHJXZGRvTCtwSDZILzJsOG9peEtRVlgv?=
 =?utf-8?B?VW1TaEYrU00yVC9oT1N2c1k3NEVWb1hXaURSaXJRV3Q2Nk1JRk01UHZQNk9F?=
 =?utf-8?B?NW10Q05PdjBEYW4vOHdlWlRWdGg2ZHRUS2c2bzdKTjRuOGgxOTV0Mms4SjFT?=
 =?utf-8?B?SE5nYitaamd6TWx1ZVAveWw4bkVhVk10VXRzbmtwSHMvR3VBZjBXMC9vblVo?=
 =?utf-8?B?NVIvTDEvSzJYdEdyNjFiQ1poayt6K1RSZnM4S3lXRFdEempwcDV4cGd3YnNE?=
 =?utf-8?B?R3AxdnQrRk94QjlQN3ZEQkozL0lsandoc1kzWU0vemY3TE0vZ0xuSWR2WUIy?=
 =?utf-8?B?SStnL2hHYkU4dW5FbTU4VXpDU0Z2RzFPdWVBU09SRnZCOUFhWElRWEpteklm?=
 =?utf-8?B?RDJhV0NnUE51ditqY2xoMkZjTk1LV1BlejNmTW9IY2xiRFhrSGd0SFhhZmQ2?=
 =?utf-8?B?VEhHa3pvcjByVUxPL2xScEo1UU9yOGk5d3pENEVqbGRZUTZCRDJINDJSYXRx?=
 =?utf-8?B?aXBrL0UvdmhEYmRRRVl1c3dSWDRFS1JEK05PNHNpVHE3YjkwRVZsRTUxM1lM?=
 =?utf-8?B?UTZvcmIyaXRDWGxIMmpKL2E1dHhJV3NHY1J2Ymk5UmVHZGRRckVzTTM5MEI2?=
 =?utf-8?B?L0V2dVZPdHNGbUc2UEJ3NHkxempqVkkxRTc4ZkcxU2gxM0VXYStXd2Zmbmh0?=
 =?utf-8?B?Zmp5cTJhbnI1ZnUzTTJlMExzR25Oc2FLNWZqTXdYRUg2VU5kTmJJMHppUncv?=
 =?utf-8?B?OExRMEFrYm1ZamI4bVF3c2dibVcyNzJQWVdoTFFOUDBxQ3hySElFdk9vY0NC?=
 =?utf-8?B?dFZpOVVtdHR6T3pFQzl0L3Z6L1Vxb3dUb0tGZFNlSDBVZk9MTDBKcUlZRFVr?=
 =?utf-8?B?UzNLY3VaWEJRcXFqMS93MjljN3JXSnAzeW11QkZkd2t3bjNnR0c5Nk5yWDlo?=
 =?utf-8?B?Z2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2191ead-b078-4464-860b-08dd776c4ba1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 13:41:56.7352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nZPUrJlRQO2/Wf+jQ+URahtvO40/enUHdn2aXwgoSCDp+FbvPlxIPRoh47aXFJ1VbF4XY/gG7vcJmwKxzFdrsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8792

On 09.04.25 15:21, Sebastian Andrzej Siewior wrote:
> On 2025-04-09 08:41:44 [+0200], Jan Kiszka wrote:
>> We are hunting for quite some time sporadic lock-ups or RT systems, 
>> first only in the field (sigh), now finally also in the lab. Those have 
>> a fairly high overlap with what was described here. Our baselines so 
>> far: 6.1-rt, Debian and vanilla. We are currently preparing experiments 
>> with latest mainline.
>>
>> While this thread remained silent afterwards, we have found [1][2][3] as 
>> apparently related. But this means we are still with this RT bug, even 
>> in latest 6.15-rc1?
> 
> Not sure the commits are related. The problem here is that RW locks are
> not really real time friendly. Frederick had a simple fix to it
> 	https://lore.kernel.org/all/20210825132754.GA895675@lothringen/
> 
> but yeah. The alternative, which I didn't look into, would be to replace
> the reader side with RCU so we would just have the writer lock. That
> mean we need to RW lock because of performance…
> 

We know that epoll is not a good idea for RT programs. However, our
problem is that already non-RT programs manage to lock up an RT-enabled
system.

We are currently collecting more data to show what we are seeing, plus
will try out the latest patches on the latest kernels.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
