Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010014.outbound.protection.outlook.com [52.101.69.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04E9416843
	for <linux-rt-users@vger.kernel.org>; Thu, 13 Aug 2026 06:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786603227; cv=fail; b=AAnUcIjxIFQi0ogeKkImMeQUvjhSoul9as60CNSX4JJWGm2DvKRZoyZKBoVZUpRcYfP8J72GZo0RVnOLxZWOGou5eBibJ33rGtYU9LLEESy0OoyY7/7e8lUQ0LDqAF5N+xNvBzm3hee+DhrNdYglO1rP27UFPoYq6sTQq9jjcqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786603227; c=relaxed/simple;
	bh=flIBVoUBjidxiWhe/xUuI4gMCXToSpi34HfZkj6Z0Rs=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xkq8fYM1VZpHl0CE8Ji0qxAk7qjXTO19wJ1YIJxKN/zMyZLxbu/gj2PWvItGAXGdYIb49OJ5noHVcO9qvT9xvdINpnzmiAzmz7M/ERrRUCSctCO9ZW5lqN15ZpoT+jfBZfDSo8w8qgnkOUUn0re+74Eg/X7b/UDUCC3fqZwnBIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=fobG0dFz; arc=fail smtp.client-ip=52.101.69.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="fobG0dFz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I218m06gMGarLFLb6rmGNbBwwMTH3E4hbyr+80Bo87UJzdmC0GGRLwoakmPLk3+Rg3z3JwSJQVIx5AE7di1W2n8TRqmjz+zBmZR6AR1I/YUqYrpHpKdEHm85zOhCcX3K13AInx+6NpkETmb66RFrCpoucusH1cdWgMteY61DLQNpLKpUAnG3qXFVXID0fSjmeS6k+/dgvPeUGIIjKjeIUuliMSOfRY+2Dts8bSJ9cnaeie6sZASwPzewow3x9YDxM2Dmfpq2in/vhyhR4ZKjur1/HLIcw1HNyj6UCvf3IeQFI4MLE4YdpFcAGlzjKW8ghb12JNp/13/v0rViUJANmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kejYj7avtXEjamVxmKoRKX55Lo6QxWfr5/IZKflbRY=;
 b=Z7oAiAIedzXMStwg+aMI0FvsBBx4Liq0FEUf1TZTEtk5zo3VnCs0dpJnWHWDImfSaLsbBQ7RXoIj1i8dgy21XMTyY58+bzfLR/a+6D3PV3Qc3BXocxYuABC3Barqpf9Cif+3EeaPf+3djlWWduLEutm1y07UrSNbeUeeRLFa9dapA7pOsWBIskelt71fGYGocYTnaIL4qq7MpTqeW8DviVfS0mEmGAAQozZFC9qXRML0cyEkcHUCDhl2sfNOwZj73+XJouDbo0m6dm9hb8M+YgPsFSgY/vUxXdHs3NOh7C4csSQvAUC7Zs3wPBBEAg1ow9wwxAFBMLYtoOmjSaX7oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kejYj7avtXEjamVxmKoRKX55Lo6QxWfr5/IZKflbRY=;
 b=fobG0dFzp1nhVG3smdLP4p/TALFbF2yVNPzAIGV3GL04JjncVpHQ8SN2qRprThCIwfXZ6ftlFtvBWGM+ZJmHJ6croYWMHjZU5hdOzUNJTHqwvQe0NMWvszCx7BIP0BwDyo2CrMyFpHDG24ztQMzxtjVaKOkD0AOedIDCmUglnEbJx9H/1E+0/uuFdhBMAL7sy9HEY8cwuN2dhhk/dmkwXP0RJFWYeGhQbkEu46rJZ3UORZ7FwdIu763VUXMvrQAbeddXW6JEdRr5pqVBevh5W1Jo2vDJwh7ntfcSWwdMpgdcdyvXm9QfwQgUX8/NOnMGwpouEyk0Zy0HRjp1jmqyDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB9111.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 06:40:14 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0315.012; Thu, 13 Aug 2026
 06:40:14 +0000
Message-ID: <642c722c-89c6-455f-be5a-ee865bf7ebaa@siemens.com>
Date: Thu, 13 Aug 2026 08:40:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: CFP Open for Real-Time Linux User Forum - October 6 at Open
 Source Summit Europe
From: Jan Kiszka <jan.kiszka@siemens.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Jan Altenberg <jan.altenberg@osadl.org>, Min Yu <myu@linuxfoundation.org>
References: <020538a3-4a09-4b16-a3f4-5bc09d65b5b1@siemens.com>
 <e077e665-0221-4bd6-81e3-c7df9f3dff8d@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 xsFNBGZY+hkBEACkdtFD81AUVtTVX+UEiUFs7ZQPQsdFpzVmr6R3D059f+lzr4Mlg6KKAcNZ
 uNUqthIkgLGWzKugodvkcCK8Wbyw+1vxcl4Lw56WezLsOTfu7oi7Z0vp1XkrLcM0tofTbClW
 xMA964mgUlBT2m/J/ybZd945D0wU57k/smGzDAxkpJgHBrYE/iJWcu46jkGZaLjK4xcMoBWB
 I6hW9Njxx3Ek0fpLO3876bszc8KjcHOulKreK+ezyJ01Hvbx85s68XWN6N2ulLGtk7E/sXlb
 79hylHy5QuU9mZdsRjjRGJb0H9Buzfuz0XrcwOTMJq7e7fbN0QakjivAXsmXim+s5dlKlZjr
 L3ILWte4ah7cGgqc06nFb5jOhnGnZwnKJlpuod3pc/BFaFGtVHvyoRgxJ9tmDZnjzMfu8YrA
 +MVv6muwbHnEAeh/f8e9O+oeouqTBzgcaWTq81IyS56/UD6U5GHet9Pz1MB15nnzVcyZXIoC
 roIhgCUkcl+5m2Z9G56bkiUcFq0IcACzjcRPWvwA09ZbRHXAK/ao/+vPAIMnU6OTx3ejsbHn
 oh6VpHD3tucIt+xA4/l3LlkZMt5FZjFdkZUuAVU6kBAwElNBCYcrrLYZBRkSGPGDGYZmXAW/
 VkNUVTJkRg6MGIeqZmpeoaV2xaIGHBSTDX8+b0c0hT/Bgzjv8QARAQABzSNKYW4gS2lzemth
 IDxqYW4ua2lzemthQHNpZW1lbnMuY29tPsLBlAQTAQoAPhYhBABMZH11cs99cr20+2mdhQqf
 QXvYBQJmWPvXAhsDBQkFo5qABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEGmdhQqfQXvY
 zPAP/jGiVJ2VgPcRWt2P8FbByfrJJAPCsos+SZpncRi7tl9yTEpS+t57h7myEKPdB3L+kxzg
 K3dt1UhYp4FeIHA3jpJYaFvD7kNZJZ1cU55QXrJI3xu/xfB6VhCs+VAUlt7XhOsOmTQqCpH7
 pRcZ5juxZCOxXG2fTQTQo0gfF5+PQwQYUp0NdTbVox5PTx5RK3KfPqmAJsBKdwEaIkuY9FbM
 9lGg8XBNzD2R/13cCd4hRrZDtyegrtocpBAruVqOZhsMb/h7Wd0TGoJ/zJr3w3WnDM08c+RA
 5LHMbiA29MXq1KxlnsYDfWB8ts3HIJ3ROBvagA20mbOm26ddeFjLdGcBTrzbHbzCReEtN++s
 gZneKsYiueFDTxXjUOJgp8JDdVPM+++axSMo2js8TwVefTfCYt0oWMEqlQqSqgQwIuzpRO6I
 ik7HAFq8fssy2cY8Imofbj77uKz0BNZC/1nGG1OI9cU2jHrqsn1i95KaS6fPu4EN6XP/Gi/O
 0DxND+HEyzVqhUJkvXUhTsOzgzWAvW9BlkKRiVizKM6PLsVm/XmeapGs4ir/U8OzKI+SM3R8
 VMW8eovWgXNUQ9F2vS1dHO8eRn2UqDKBZSo+qCRWLRtsqNzmU4N0zuGqZSaDCvkMwF6kIRkD
 ZkDjjYQtoftPGchLBTUzeUa2gfOr1T4xSQUHhPL8zsFNBGZY+hkBEADb5quW4M0eaWPIjqY6
 aC/vHCmpELmS/HMa5zlA0dWlxCPEjkchN8W4PB+NMOXFEJuKLLFs6+s5/KlNok/kGKg4fITf
 Vcd+BQd/YRks3qFifckU+kxoXpTc2bksTtLuiPkcyFmjBph/BGms35mvOA0OaEO6fQbauiHa
 QnYrgUQM+YD4uFoQOLnWTPmBjccoPuiJDafzLxwj4r+JH4fA/4zzDa5OFbfVq3ieYGqiBrtj
 tBFv5epVvGK1zoQ+Rc+h5+dCWPwC2i3cXTUVf0woepF8mUXFcNhY+Eh8vvh1lxfD35z2CJeY
 txMcA44Lp06kArpWDjGJddd+OTmUkFWeYtAdaCpj/GItuJcQZkaaTeiHqPPrbvXM361rtvaw
 XFUzUlvoW1Sb7/SeE/BtWoxkeZOgsqouXPTjlFLapvLu5g9MPNimjkYqukASq/+e8MMKP+EE
 v3BAFVFGvNE3UlNRh+ppBqBUZiqkzg4q2hfeTjnivgChzXlvfTx9M6BJmuDnYAho4BA6vRh4
 Dr7LYTLIwGjguIuuQcP2ENN+l32nidy154zCEp5/Rv4K8SYdVegrQ7rWiULgDz9VQWo2zAjo
 TgFKg3AE3ujDy4V2VndtkMRYpwwuilCDQ+Bpb5ixfbFyZ4oVGs6F3jhtWN5Uu43FhHSCqUv8
 FCzl44AyGulVYU7hTQARAQABwsF8BBgBCgAmFiEEAExkfXVyz31yvbT7aZ2FCp9Be9gFAmZY
 +hkCGwwFCQWjmoAACgkQaZ2FCp9Be9hN3g/8CdNqlOfBZGCFNZ8Kf4tpRpeN3TGmekGRpohU
 bBMvHYiWW8SvmCgEuBokS+Lx3pyPJQCYZDXLCq47gsLdnhVcQ2ZKNCrr9yhrj6kHxe1Sqv1S
 MhxD8dBqW6CFe/mbiK9wEMDIqys7L0Xy/lgCFxZswlBW3eU2Zacdo0fDzLiJm9I0C9iPZzkJ
 gITjoqsiIi/5c3eCY2s2OENL9VPXiH1GPQfHZ23ouiMf+ojVZ7kycLjz+nFr5A14w/B7uHjz
 uL6tnA+AtGCredDne66LSK3HD0vC7569sZ/j8kGKjlUtC+zm0j03iPI6gi8YeCn9b4F8sLpB
 lBdlqo9BB+uqoM6F8zMfIfDsqjB0r/q7WeJaI8NKfFwNOGPuo93N+WUyBi2yYCXMOgBUifm0
 T6Hbf3SHQpbA56wcKPWJqAC2iFaxNDowcJij9LtEqOlToCMtDBekDwchRvqrWN1mDXLg+av8
 qH4kDzsqKX8zzTzfAWFxrkXA/kFpR3JsMzNmvextkN2kOLCCHkym0zz5Y3vxaYtbXG2wTrqJ
 8WpkWIE8STUhQa9AkezgucXN7r6uSrzW8IQXxBInZwFIyBgM0f/fzyNqzThFT15QMrYUqhhW
 ZffO4PeNJOUYfXdH13A6rbU0y6xE7Okuoa01EqNi9yqyLA8gPgg/DhOpGtK8KokCsdYsTbk=
In-Reply-To: <e077e665-0221-4bd6-81e3-c7df9f3dff8d@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0225.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB9111:EE_
X-MS-Office365-Filtering-Correlation-Id: 33765b7f-97b8-47a1-10ba-08def905bb42
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|55112099003|56012099006|18002099003|22082099003|10067099003|5023799004|4143699003|11063799006|13003099007;
X-Microsoft-Antispam-Message-Info:
 NOQbax15i59vIkalm2boiJv/Zuo5prst+H/Cmslifg2Vqflt/NmLpHLJnsqcrkgywuYZx27an39N95NcxPC4qxCRirezzO8oKp6v4wawOtrBHouyRobKZWcpaaa1ibzc740yJqogqGp3H/A1hZ7cjEQAm3b82JKI0/qIlWbbRZBZDIuSdskpDgBQ5Mo2WCbu0ttsjKaS9paUEymteOZSA/n9zXcmpOHYFHZ1N4tVW1KHn2uNE/+/4tQhiCRfqFTJmKTea/G6LQ96/fYZtXd3ZyVxvJGzmVhuRsGCtrqezYC2L2C0RxIT1baKwb+twWsBNr/OqdlTN7CYAPjvcKVCzghuTquRyDL8QXfIVT3VtHISsF+Fug1QunDm7jM3ibOdjTIDhq/YQUDgbePw0JXCV8tQYWOhqOrfSwzruviBuxZKsHXWykUz88DlB+Y+PiS9UqezzzO3xtmJZm7UiK/sLjHrhYZWQryXQXf/4/X+f8zzN4dTNHnDnO2+kktcW6as65yz80L+sk+Ke3IGE6VbTn09tqrKaLwj0U/yMjKeg1Sg/TAwgg16FdTNquzmHehPip6o7muaOPwg6Nxu1Rq3Cztbgg0ms/H7yLuq3ZOOslc=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(55112099003)(56012099006)(18002099003)(22082099003)(10067099003)(5023799004)(4143699003)(11063799006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?V1RYVVN5TGM2ZU94SERFdnM0aWdpV09uUkVWNjgyVytFWFZmQmxxQXVGQlh6?=
 =?utf-8?B?U1RIaGVxRFpHZWdNSGhXME9JS0FWR0ZDZmc3bXlhSzJNR0N5N3NoTmFDT05u?=
 =?utf-8?B?Z2xxSmdtcy83VCtycTFYSHp2cEZ1UEZ5YWtUdWxONmtvcGNYUzV6dzZ3WmNk?=
 =?utf-8?B?S2RnSmRBQ25iM0lRRS9hVzVNaTkrcFU3aTNCcE9TUHhNUXVkRnlsbkNUUWVX?=
 =?utf-8?B?Unk2bEZNM2RRczc1TXkyc0ZoQmhzWUE0R3F5bkcyOWt3UFNHaE9TdHBpTUo0?=
 =?utf-8?B?RHY2MU82SkpBVnZ5cVg0ay9xQkJTK0FoNjkrTTVzeUs1UlJRYWpmTTIvWUlw?=
 =?utf-8?B?RjVtcjJ5WTNqemNaNHNWbGxJS1UzRVFkUU9taUhycWppRzM2Sk03T3ZHdy9D?=
 =?utf-8?B?UW51UnFGaGxRZ0ZIUnptT2htVHR0WFIxU0tTd2l4Q2Y1MVViVkFiSVRRR085?=
 =?utf-8?B?NWtDZDJRTjBydDF3QWp6M3FPbEd1L0lZQllSN2JKekRGaUNzeUxlNFVRUXFP?=
 =?utf-8?B?bHJsK2c5QlU5RVc3Mm95dENXM2VydmVENkEwVTU4aWFZTVdlcUc2TnhwNFFz?=
 =?utf-8?B?YmRkK0Vtb1JPenNEaDd2VCtNaC82SExUcjhuWGdOUU1yOW8rblFMbkRaQ3RG?=
 =?utf-8?B?Y3FocjdMaTFLN1Jad0w0a1d5NVk4cmYyUXluem15cUlDNkVVa1lsaWcxU2dF?=
 =?utf-8?B?SnNRQXJtRU4xaWZiNUxGVVQ1T0dPRjMzMzNUd1l6TWs4QVlXMEl3TWoxekV4?=
 =?utf-8?B?ZHJwVk8ycmZYQ1NQK0lnY0p0dDcvNC8yZGd2Z2kxZ3pwSHFmTHJQV2hPaXIw?=
 =?utf-8?B?R0E0V0JxcEhkeW81aWJCSEJVTnFHV1JyaXlhZ1AvYWlMQmFqTG5pV2hxelda?=
 =?utf-8?B?Vnlrclh4emNiK2o2RnJ5aEFuQjR0M2hyQVdyZm5sZUtjQjNlVnl1NU92b2FV?=
 =?utf-8?B?NFRnenY2d042OUNNT3FjODdHTU02WGFkYmw0SmcvbHNjQWxrZnkxTzgydEpn?=
 =?utf-8?B?NlkybkUwcUw5NE9vRDU4em9jMnZCdWFJcDBJbDc3YXhscFdFc2NqMlV5MGF3?=
 =?utf-8?B?eUU4bTJYRCtXWnE3ZDVNY0t0ZDBCRWl1MkVCblF2bmZjcXBIV1NBY09WYk1D?=
 =?utf-8?B?dUhxUzVXWG1IR3hxL2FLTXh6LzNqUURLcXB5dE1kWGF5Z2M4Ui83eDRKWUY2?=
 =?utf-8?B?bUEvVnhWZ3pkTnFlc0xMMDJyZW5GN3RwMkEycW9kS0d0aktNVEJYM1QxOEtV?=
 =?utf-8?B?UGNBSkRwK2ZySGRxUTh1Unhka08xMFNKRzNDNGdPdFZEeWdEcWYvMEtjL2Vt?=
 =?utf-8?B?MmhDRFZJWWNpazg0OVZFa2xqWUtwSXovL0NjNE5yQXJnVy9seVN3WFhraC82?=
 =?utf-8?B?UzAydXZ3aUR2VXl0VVk0ditFeksyOHZKMzlFYjVxNnhkU2VkR2NWVGsxS2dC?=
 =?utf-8?B?dnloUlBQYmlkdEVFWWdPb0NxdWtzZmZMQmlnNWl6TTJkcWNUWGp2cmJ0YXNQ?=
 =?utf-8?B?YzZ3dTl2WUJDZjZFTVFKVFVtWm5TeEtaYXA5RmN2OGk0STBELzZBdTNIN3Fj?=
 =?utf-8?B?NTJ3d0dNREQ5dEJzZlJsaUppV0I1S0lFVklyd2ZyVkIwTjFxK1dUZTRLQ3Za?=
 =?utf-8?B?QlRpTlp4UEV4VGE4bjJlTnJnbnVubVdybXI3bkZ3a2ZDSGcweFIrRFY0MWJt?=
 =?utf-8?B?am5wVkRhbzcxdEhSZW9lL2N1U0NBb2pqUDBncEZVK1lDcHphbmJRL3ZsTk1V?=
 =?utf-8?B?WUJtK3lrN244YW0rTUtUczgxNDk0R21qNW1lLzg5NjBIOEtJeTI3WDFSbm55?=
 =?utf-8?B?MW1nWjdRTCtKdUVzUzZuajhuTjdmRXZoc3RFU296Q1hScUZSbVdCeWJ1Qnh4?=
 =?utf-8?B?VDRjV1FlNnJRRExUZUdySGNxVjIvTUtpWFd6MExQVXZ5Yk1IYU0ycG5jU3ow?=
 =?utf-8?B?d2YyZGNhVXBNUVJpU2FWZWF4RThtYmRoaWZKRy9JUWp4ZXI5VnAvMDJEVWYr?=
 =?utf-8?B?a0R1NHV4TkZqSlExa25IR0pDTm5YeTJKZjJFbHVVSFlPMk5pVldPK0YvaWkz?=
 =?utf-8?B?WFZ3ZFRMaUhSSjd2RXE2RWtlQ1A0dytvZjVUV3cwRVRJYjNURWpnaEFxWFN5?=
 =?utf-8?B?ZTEzcUt0MEMxeVRWcUg5Q1ZhOENjQ0grcHBZV0xvZFNMUTBuOEVvRWRCZnJS?=
 =?utf-8?B?TVFWZUhpT3g5RWRaT0p1bW9PRkhNSEIvMS9RTEtSSExrQTI4bEg2dVlHSDFw?=
 =?utf-8?B?MGpPcDdSak1MWE5SaHFDb3BEZnFNNkVEcG9EQTNjUzJQTyttN0gwUVJTUU9i?=
 =?utf-8?B?MTFNRmViYktIS3N2eCtYbTVFcnJjVzFKejJHK0xSQzlEQXlBUTdYZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33765b7f-97b8-47a1-10ba-08def905bb42
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 06:40:14.6976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 346kir7DqwcpvTMeeaxAniq9za3qt8eR5LRZE185EDmT8X5qRsDVraC/YIYSK9oTXunfPlHNd1BTC82hse3Npg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB9111

Hi all,

Thank you to everyone who has submitted a session for the Real-Time
Linux User Forum
(https://realtime-linux.org/event/real-time-linux-user-forum/).

If you are interested but have not yet submitted, please ensure you
submit your talk by the end of this weekend, Sunday, August 16th.

We will review the submissions and build out the schedule next week.
Please let us know if you have any questions.

Regards,
Min, Jan, Jan

On 03.08.26 19:31, Jan Kiszka wrote:
> Hi all,
> 
> Just a quick reminder that we're organizing a 1/2 day Real-Time User
> Forum https://events.linuxfoundation.org/open-source-summit-europe/features/co-located-events/#real-time-linux-user-forum 
> on the afternoon of the day before the start of Open Source Summit 
> Europe in Prague and that the *CFP is open till Sunday, August 16th*. 
> 
> We welcome RTL users, developers, and tooling experts to submit a
> speaking proposal by using the Google Form here:
> https://forms.gle/iRK48ACWnMatihg59
> 
> Additional details about this event can be found on our website
> here https://realtime-linux.org/event/real-time-linux-user-forum/.
> 
> Please reach out to Jan Altenberg and Jan Kiszka and me if you have any
> questions. 
> 
> We would appreciate it  if you could spread the word about this event in
> your network.
> 
> Regards,
> Min, Jan, Kan
> 
> On 20.07.26 15:58, Jan Kiszka wrote:
>> RTL users,
>>
>> We're very excited to announce that the Real-Time Linux Project
>> https://realtime-linux.org/ is hosting the Real-Time Linux User Forum
>> https://events.linuxfoundation.org/open-source-summit-europe/features/co-located-events/#real-time-linux-user-forum on
>> Tuesday, October 6, 13:30–17:00, the day
>> before Open Source Summit Europe in Prague
>> https://events.linuxfoundation.org/open-source-summit-europe/.
>>
>> This 1/2 day User Forum is intended to bring together PREEMPT_RT
>> developers and tooling experts with users who are building products and
>> solutions with PREEMPT_RT. It is an opportunity for users to
>> share real-world experiences, and exchange ideas and collaborate with
>> developers on the challenges and opportunities shaping Real-Time Linux.
>>
>> We invite you to submit a speaking proposal highlighting
>> your user story, implementation experience, lessons learned, technical
>> challenges, best practices, or innovations related to Real-Time Linux by
>> using this form: https://forms.gle/iRK48ACWnMatihg59. Please note the
>> following timeline:
>>
>>   * Deadline for CFP submission: August 16th
>>   * Speaker notification: August 28
>>   * Schedule published: first week of September
>>
>> Please circulate the event and the CFP widely within your network and
>> community.
>>
>> We look forward to putting together a strong agenda with your support
>> and contributions, and seeing many of you at the event in October. 
>>
>> Thanks,
>> Min, Jan, Jan
> 

