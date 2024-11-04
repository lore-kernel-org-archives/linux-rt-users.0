Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEFA2AF0E;
	Mon,  4 Nov 2024 13:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730728402; cv=fail; b=TwVWqHTWtTTCg2/6/bWyN0+9q2OFnh/BLm4tDwzzM8gEqNXoXpzS1TgrqoR6QFvToE1PUrZ0lySbV//DGhcoBhJQEVGR4WcY+LU0v54db/udvGJfd/gouLbokhxnYrPqkX5QXHdtxXpxPQZHWkm71uJBMos2sYfmFoYOb6kk1uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730728402; c=relaxed/simple;
	bh=xXBJuo8+HDkGa28Ba4qdL8RpOCb2/c3KH4pYuqA0ZNM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T1ssn6Sgm29MLkvsKQTeSUKKM/m6mjeejUPUDpbcf0u7jVFAYgkRYALoh9CPurJoXxJaoEcVgvvjxTpp5FbLsDRQHUHoS4gim1TQIR9o9/UOecW8lKqvgzpRURko2zKcU7dKFcwyzs+PtUI5GpcvI38MYGKFmDoNhAv3Yx3Tpo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iHDT4PEl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Q4PmZztw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iHDT4PEl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Q4PmZztw"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4DOPgW018877;
	Mon, 4 Nov 2024 13:53:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=mBSOeSk81pxqKhOtczAuwZFREEOcuFeURhqyOdgiPUM=; b=
	iHDT4PEl9grhm/r4QiZTRYposIDBRUIi/TOAUeXreRUqu1vn2xzyxJ9eSsCB3vXD
	ngqvQihCDygCTus3ezDVKFSwCpf2C6i4o9F6KhuArDCiWT2ukmhATd+26OuYVgZQ
	oh2AI5RJfuUeu0bgOZ/jtu+MnEDbBgp0kFnRx2Wf0/GghMSOpNtd82zU0BIB4T85
	XONhaO0Feo7To5eo33PK7Rs7KVFlrWoXgJDX4cdsr4kVOZfM3xHQjQL5oK7YYrQ+
	dATkvq5XmRjJxq1fY46mQrcVXa2G4w4SHnQWiK5/1y8d4tcmpPRNDM4m+Eu2GEBF
	qNRLHeR2RJU5Rf5WySu7Qg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nav22r6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Nov 2024 13:53:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4C59HN031413;
	Mon, 4 Nov 2024 13:53:14 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2045.outbound.protection.outlook.com [104.47.57.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42nah5gp3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Nov 2024 13:53:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ljmyiWpAZbSC0QotYDZjsDoLO+y+FeSroPgGn8XjTjiH6jBCuoTlGrAmn2xl4zmPsf7RcRY0Dfl1HviNKzy6MnXVLGmkTO/YRYG1a08sMjQ+kfcYjsfWdWuiCSlVSWMEiTIum+sWija+KhTXZM1NN7H+6bN0/8oIlPhSZD1arOBFu0lrnTu+OO8u4rpjEfx8uVs4eqiGiaUspsTzIuOORUK8AShqOv9LCdSx8ST1LP2V9EFSCdoPVnveJXcJYn/9KnPNOmDhoWrKthYxS50m4mTjTVpXbDHay2ObKB9nNbY6k5U22VZToSSDmMQr1rROOgkrFQeCD+8dL85nlZPl+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mBSOeSk81pxqKhOtczAuwZFREEOcuFeURhqyOdgiPUM=;
 b=W+HoaF5zb1Z/2Jtzf3qRh+9APekYtw2m0PVmlIOfZqYe8TWzfFNTUzxlaazZZF3INDq3kp1619af01h6HG1Jvvz9qUZaUpsLBSN7/Bo2elxGGpJVFvUcl22BIAfXHzCqy/MYBdtzarJaPnfqfqNQgnQcTspP/+s7eTm7QwsmF7J6jzHFClQRnrba/vMfjh0Ctbh0Vd59J4tKPU1TK4o0FpxpodrfpXD6aGOA/aM3DMW8Yt9uNRgSOcsJo7vjHQqpfdalr7ZgDVN3V8rWFmeo04f/wIwkET2AuNkJyucFSDmx5B3IkQrUavQ5G+ICDdhHE/l3w+BnjpzvCcjndmLAQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBSOeSk81pxqKhOtczAuwZFREEOcuFeURhqyOdgiPUM=;
 b=Q4PmZztwlGa5ga20iCn6NhGgwcOrqzu4jSI+yuzKKcTt6fBdEgKYdlYOC34F59hD4Qw/q6725n5rWzFFLMivHB8H5nOFYThO/4ozzDn7A8f6J6Dc8Fy01sDxg8QtKnOYrgxTp7nu4XhNm6XIiImkCzPCBK1kfJUV+cQWZGSnP18=
Received: from DM6PR10MB3881.namprd10.prod.outlook.com (2603:10b6:5:1fe::23)
 by PH7PR10MB7729.namprd10.prod.outlook.com (2603:10b6:510:30d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 13:53:11 +0000
Received: from DM6PR10MB3881.namprd10.prod.outlook.com
 ([fe80::9c40:1c28:9d29:6d9c]) by DM6PR10MB3881.namprd10.prod.outlook.com
 ([fe80::9c40:1c28:9d29:6d9c%4]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 13:53:11 +0000
Message-ID: <6aadadc1-63f3-4300-9ceb-0475e0203ea7@oracle.com>
Date: Mon, 4 Nov 2024 08:53:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: Linux 5.15-rt still misses commit "NFSD: Fix
 NFSv4's PUTPUBFH operation"
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Cedric Blancher <cedric.blancher@gmail.com>
Cc: Joseph Salisbury <jsalisbury@kernel.org>,
        Dan Shelton <dan.f.shelton@gmail.com>,
        Martin Wege
 <martin.l.wege@gmail.com>, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
References: <CALXu0Udop9Qx_N8KwScmGk+j3NrfDry1r-Fk=5bc+9EXsfnB=w@mail.gmail.com>
 <20241104132412.dFx8w7ZH@linutronix.de>
Content-Language: en-US, en-AG
From: Joseph Salisbury <joseph.salisbury@oracle.com>
In-Reply-To: <20241104132412.dFx8w7ZH@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR16CA0034.namprd16.prod.outlook.com
 (2603:10b6:208:134::47) To DM6PR10MB3881.namprd10.prod.outlook.com
 (2603:10b6:5:1fe::23)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3881:EE_|PH7PR10MB7729:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ef63272-f682-47a2-6a81-08dcfcd80526
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWlJQzNDVE1yRGlvc0VKRnZsQmJwVkltbll6Ym1qeVZ4aHhDUEEyNnBRdnZk?=
 =?utf-8?B?UllrZk1XRWkvelcxVmQxcnJ6T2YwOEEwSVRabjZsTkQwMXF1QlhodWJrZGNE?=
 =?utf-8?B?amN0QnJ0a2hwSGJRWUhvaTloTGtqMDYrWmMzbXNxcmFpNC9Na1hsM2lLbC8v?=
 =?utf-8?B?M0xzaEdRYTJuNXZWTlIrTENzTmRSczJYdFBtVDdyL1crcktvbk52VGd1V0pw?=
 =?utf-8?B?QlpPNUdjU3YyUlMvRHhmVDlXekdwckdjUG4xQkgzWCt2MXVNcVQ5L2Q4R0xy?=
 =?utf-8?B?YlpyUzVSYW5VWVJjTFZRQ256cU9WMmYyeVIzR01qN0JiQ29zanE3NmhzeUYr?=
 =?utf-8?B?cWhqclFCQTR1QkpZem5Yd3NKbzJ2WGdKMWpveEhaVVlNQkk5TVpPdVVLWlUv?=
 =?utf-8?B?em53SlBIY0kzQVdDSHJYeFo4aDJoTFJqRzJma0d3L3FXeENqYjRDM0Z4Mkgx?=
 =?utf-8?B?RmUwdHlSVWlJTU51RDlsaTQvbDFvQVRHdDVnODRzSzZWcm9ZVTJ2NVZmM2xK?=
 =?utf-8?B?bUtxZjdxVUV3OVhHL0F0SmxzeWgwVDRZbHlscXl4NlZYQ1d0ZGZBejhyQ05o?=
 =?utf-8?B?MWF3RndKTjY4MGJxbzJVYjU2RjExaWpsZ3dTajVaMkxHcUFnbUJZY3BpQjI5?=
 =?utf-8?B?MjBzcnlsZ1JVcDRNWHFucWRMbUxBRDAyMWdyRUpRSEpPajk0SS9NTkNlYVp1?=
 =?utf-8?B?VmFhblpXMzJUZ1FSOGd6cU1BRko5QmxaTGFjS0tJNDVPYXlUQ0Urb2lscXFn?=
 =?utf-8?B?UFpXcmFScVF2RWx6SEhqM2JCVnFvZ29nZktWRXIrcE96VVhiM0JXcWZWMExT?=
 =?utf-8?B?Y3NVbThzYWxYMlZVNXI3SW5oWnNiUG14cE1ad0VCZmhGVGlqV2hxdFI2RDRV?=
 =?utf-8?B?NmQweWY5WlY5N1NZb1lKZXhzMFlZWDdmam5NTlVqMWM1VkUxUGU0a1Z3bTlu?=
 =?utf-8?B?akZJS011cnhVVmdZUWV0MkFQN0d3QVdkZFh6eXIxVldKRWRrekpMSUF2L0lQ?=
 =?utf-8?B?U2ZYeWNhTC9lbHJkNFhJQjVvMnhVZUpiRjhnZUhaRzF0LzNEL1JWS0IvaENV?=
 =?utf-8?B?WFl6NjdKVEdtMFFWTDByYjUvRU5kMzdiTk5XV3ZJaWxsK3VMaUxKTElJZVhL?=
 =?utf-8?B?bmNia3d3UEdNVWw0RkpLcWp5K1VIYndIcFFRVVZsYlZHVkVVWVRzUU5hWG1P?=
 =?utf-8?B?VGg3VUdEUGRhanp3dTFWRllTL0dBeTc5bW52Wm8yV25GZVd4NVhuZGZoMUpw?=
 =?utf-8?B?S1BmeDJ2NzNjK3d4VXdLVndYMnZMNnNRTUE4dVpHUzc4NkZWZkZHUnA3S0E5?=
 =?utf-8?B?K2F6NXptU3JzbFNkbFhIVUM5M1pXUi9FNlg2eVFpZXd0OVNoVDlvN3FyUStV?=
 =?utf-8?B?UHpuY1AxbGt2K0V0MU85QUd0Vlg0TmVGaVczd2RmL0FXSWlVWkJTRElQWkpD?=
 =?utf-8?B?WmdqVzFRRG9jZFBSanA2RG5UVFgxTXRiMktKRVRmVG9pSExKc1FkZkk1ak1K?=
 =?utf-8?B?UUo3aGhHR0pxNUNQKzlUQVJyVzlvRHorUXNROE9YejVKSnROalI1bkQzcDFL?=
 =?utf-8?B?Vnk4dFhDMGd0MDZQQnljeFBqZTdHbTZBUVRFaFY3NmlSTHRVbGJxODErc2FV?=
 =?utf-8?B?UGRuSHRSSHlSVG5FQXdWMzBqVDNzekNSb3N2d1FUSTR6YTFwSFBCRndTbHdD?=
 =?utf-8?B?T1BJN1FVeDMrT1hIODVsUUJydXZWbFRBOEI4NWxNTUNBSjhkN3Rrc3JoUHIz?=
 =?utf-8?Q?pnsDf3T96rKLNchnj2S8LlDawLrJIx/XawzGg4k?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3881.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFdVNmQyNHg5OTZXcW1Yemd5eHdRSEtiOXhuV2htL0wvQkpoeDhIWjBvdkNj?=
 =?utf-8?B?a0FXVGVDSjdVWmp2Z2diWWVqRDB0Zmp1YzlobUV2RjQxdGJQalVqK2pnZDNy?=
 =?utf-8?B?V3luWVRtbXRXR1pEY0tvRUE5ZUhUOWE3M3VYdkt2dURnb0c4ZXZEVDhBVjdY?=
 =?utf-8?B?Zm5DejNHY1I5MXAybDQzRzUvZkpkRTlQa01Ob2FENzVhaVZVWTl2RWdKV0g0?=
 =?utf-8?B?cy9JSGRlRzZJWEVCYTZtSXVHVkFYVTRBTWdJRkgzamVkcDYzaEk3dVFOS0Vw?=
 =?utf-8?B?b0FKcUNSK1ZqZlR5UE1YNEl2dEcyVWZ6UzM2SVAwQUtHOSt5ZzlZTHVsZGdH?=
 =?utf-8?B?b0swSnZWUjFwSjZsRGRNUk5QVDhJczUraVFodkJPRkxaVTBNTFFiQVY0ZzIv?=
 =?utf-8?B?Tk5RRWU2ZFdlQjZLdDdYdWsxc2RjMkJGL0RSRzNvQmMyS1VpODl2WG9jbmZw?=
 =?utf-8?B?VnV4ZS95YXhDemdNaWhGcnVIWDF3V2dhYm1ZeXpXaDdmRnFIc2xsN1JKSy9a?=
 =?utf-8?B?SG55ZW9sb01Pa2QrQkpyVmRuNSt4VW9uYUNvTmdRc1ViZmR0djEzUmZWZHpo?=
 =?utf-8?B?ZWxrYmoxZlhETXE5WlgrWG53Y1Jsb21sa1Q3QWhpeVdEYjZFQmNLRkxwdEFk?=
 =?utf-8?B?ck1lWVRYS0ZpcDE2VDB6Z0ZKTVJmN1Z4UXovN2xuTFBrZXZWSVpkczFCQkFM?=
 =?utf-8?B?UHdRMUpra2ZKQTF6REU3dUdZbk1VY3hXaDh3MmZVbERBVkFETldGNGQ4b0xQ?=
 =?utf-8?B?NjRjN1VaTHMrQ2orUkdvT2RzVFZMZ29iSkJRd0xCMzdybG1TcEVxY2dKU0gx?=
 =?utf-8?B?NzlUazk2YW5BYXJXMjdMOUlYS3Npa0t4OXM2dUNFTFZ1UDhCcmhOSG51SS8v?=
 =?utf-8?B?ZjZKTThWMUdONHVzaVFreDF6ZHNGYTNIaS9nbWwyUTdTSHFqU0pyVmdOK2VI?=
 =?utf-8?B?bXU2Zkc5QVU2YVhxMG05Z0xCd1R0aEFRanhhSThYeSs4QmJzMHZhblowZ0pw?=
 =?utf-8?B?YUVaaFVtTVhOYU9xYWY2eXZlb0tielBlU2NWMkRQK1Z6WmFDVTRySUlKd3JT?=
 =?utf-8?B?clJWOHhlY0hLWjZUNHlic3VsaFk5akZCMUJhcXNuR2dZbWt4NEI2SmdoNDU4?=
 =?utf-8?B?YkdQa1A3b0Z6SFpXZ0tlMWpaV3RmNlBaNjBXa3pSVlp6NXRpQ2NkWEgyQ25h?=
 =?utf-8?B?VzdZd3Yya0JtU2FpQlZwZTh0WEc1ZGdHOG5mNkd2UkZJWGtGUU5kSVVrQTdv?=
 =?utf-8?B?RDl0NkxVTE1pTTJEUDJ3c3NsTVRvQklsZ25pbmlwTlVpMCsyb2dnWk1jamo0?=
 =?utf-8?B?V0JZZlVsUHFwdVpFN3lGVno4Q2swVUQvN1dDbGdqZk12TzF5ZWpvaXRvZjNJ?=
 =?utf-8?B?dGdUVU1HWDdtbThVOW1sOUFxN0pkcjR2c1dvWXBMUi9Ybm4ybTI0RXJ3eUFy?=
 =?utf-8?B?V3oxTFNPWkhjYVlVK05rNTEwUHRFazJYbmFaWTNOdHo0cE5KcXlwYXpzbGtL?=
 =?utf-8?B?dTZSNVRuRkl0eE04OEcrRmhoWTAxVUJsRngyWVpTYXl4MWlOQ040SkovU3Za?=
 =?utf-8?B?UFNubkozWDBiRlNSUytMT3NQNzdpYVYxNzlUZGZIK2RXR3NTU2svRFB6dUUx?=
 =?utf-8?B?V3lYeXpZUkxkMWZWUWV0bTNpMTk4QUkyQTlnTDFOVTZKQTlGSjZDMHNHS0Np?=
 =?utf-8?B?NXpNK1BpM1BmOUhZUDAzVEV4ckNtWUJ3ekpxQ01XVW51Rjg3Y3BMb1JMUkVo?=
 =?utf-8?B?WlRoeElhbHNlVFVaOGp0QkFsOTU4WGJ5YTJXY3NjS1ZUV1hkVERnTW4vQ0tx?=
 =?utf-8?B?dmU2MmYxU0NNNHA5VEtFdlhyYU5iajVzMExWZXdQYVh0NnA3TzU4VEdRRnR1?=
 =?utf-8?B?K2QwdHE2V05kMVI5UUxZc3huNzg4anM2cDB5b0NzWFVGcTVzaTZjcXVjY21u?=
 =?utf-8?B?bXU2cTF4Mlg2SXFlN2dUS2NLQXZNbWZPWExkYWgwa3F2QjFJMGwyVSs4UVMv?=
 =?utf-8?B?elExbEthZEIvNEllZG50eEZnRGQvQS9FbzIwdTFBQU12ZkJTTmxBWG4wektj?=
 =?utf-8?B?YWhVT04xZnpReEp3ajdUOGVleXFlN1JFTFBkdU4zcGY2M3dmZHhSVTY5Q2VZ?=
 =?utf-8?B?eGRRY0JwM0JGSXFMVk5kZXZtWkhyWi9BMjcrNjhWaWQ0UFVYMlowSXU4ZTZw?=
 =?utf-8?B?bWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	C2VxgegGDRiJKfEh1ucqb5qoxOT/UdeR+81gZcMPCt6GboFbv2vOWswv7llc40ClfAR339oImKTqkgL0ZedGZhHyl9XqxdFBmwpFAcEYm4cYiJu4ydShhd5bZG2KtI6BJ/cunSFRR1HbhqmpxQrleshlZGBBopBQ+New5EZ5fl0cahUnxhWj913l7ReWO0ObRzn4enTeaUBrJIhFVaFxZmnf97d5QGejFL7KDeuBFcOubHPOcnbxff8pBHarWKcHN9ZAjWKdrVa0vofhr2g0DZ7x6CVLRQH3g2kGKfpvTlydH1npwwIbt2ufKI1RuygTf/nRxH9fhXALVvVLGg4VfiK/X0b509LUUkYDeQmSH1fD/x7SQr9TQ/nKAgyW/SHeOfPhuFFZ6xYLpV6gzR1VpkpJ7y9jebvHTrC4mRHhnHnCfdHN0y4ycB7uPAv69MeFdoPBC85t8uKXDSEHcjBJlgRd9N/LE9IxkpuTm7DoifcX7epp2mhpoN35Y8ALrLHY2y/wDsZg3jHgIPDmm65pg+c0r+qI558fHRSL0oKhGUuaDvOuaXQNHJbOl2LMyKKBEbxcgnfSogmHOa1b9eP7HMYLkMxiVRPW9Yk0oBSH46E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef63272-f682-47a2-6a81-08dcfcd80526
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3881.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 13:53:11.0639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AviPNMsLTK+ygXwmbwnQwV10DQ2Sn/VKaQfyHZHXUO9ZOjirpUU6Ke0En1lx9/r6CANmyNpTu9ucdhEqnvANRMTlWr87ogZDqaE8Ovf3YjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7729
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-04_11,2024-11-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411040121
X-Proofpoint-GUID: Nf6LIoCFlq-z5klV_55mUf1lFQCswO6Q
X-Proofpoint-ORIG-GUID: Nf6LIoCFlq-z5klV_55mUf1lFQCswO6Q




On 11/4/24 08:24, Sebastian Andrzej Siewior wrote:
> On 2024-11-04 13:01:42 [+0100], Cedric Blancher wrote:
>> Good lunchtime!
> Hi,
>
>> Linux 5.15-rt in linux-stable-rt.git still misses commit "NFSD: Fix
>> NFSv4's PUTPUBFH operation":
>> Title: "NFSD: Fix NFSv4's PUTPUBFH operation"
>> commit 202f39039a11402dcbcd5fece8d9fa6be83f49ae upstream.
>>
>> Could you please add this missing commit to the 5.15-RT branch in
>> linux-stable-rt.git? Thank you!
>>
>> References:
>> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v5.15.170&id=2f8f226f4d56fae0fabec23cf0af82c43cb4dce0__;!!ACWV5N9M2RV99hQ!J_i5oEOgM6dLLOAkgjiM9ncalWBDCr_5-CaHZBZI8r2RU3TtvlTNnrOBlTBiS6Z0M3ETfv4emw1N632COpow2bNbsDE$
> The v5.15-RT series is based on v5.15.167. The 170 minor release is from
> 2024-11-01. The commit will be picked as part of the update to 170.
>
> There is v5.15.167-rt80-rc1 is preparation, I guess 170 will be next.
What Sebastian says is correct. v5.15.167-rc80-rc1 is out for testing.  
This version has a release candidate, since it introduces a new patch: 
4a1d3acd6ea8 ("netfilter: nft_counter: Use u64_stats_t for statistic.").

Version v5.15.167-rc80 should be released the end of this week. 
Currently v5.15.170 is the latest stable release.  I should be releasing 
v5.15.170-rc81 next week (Or whichever is the latest stable release is, 
if a newer than 170 one comes out prior to my release).

>
>> Ced
> Sebastian

