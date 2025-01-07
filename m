Received: from mx0b-000e8d01.pphosted.com (mx0b-000e8d01.pphosted.com [148.163.143.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6662594A9;
	Tue,  7 Jan 2025 18:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736274706; cv=fail; b=rbsuhCmwvb5y/UIQJIW85NWOEg4wx9rndgqhjzQnj4uzsQp0d0TJifLE0nW8T+MNMcb3Zv/tQCGxqIEgRFZR+hcMJjTyu8NT5uv1+Vx6e5Ep/LDyYN558s5dap5z8LL9xpZPC93FUbtcNPl10Sxs7qu3VaTwvw4JRuloXBnOk94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736274706; c=relaxed/simple;
	bh=qz1EW9at4/mSYg4pAzuWEeOKCnxCie9CyNmZZlZTySE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RKDeQw7ns1j5bdEv2fXSYaHYbcgXhUJD+fIhMqjd83sDWJCdFegGgeo/MlsGw1julsVRWLxx3FG1+JowzbbdYdUSISI1druvii1DJ01Dhsa5yMMpKIwxHHpAKu178LLlSBY8ubX/ebvWHFuuTiNtXQlM0gP4/+OfUONLIpSwNMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=selinc.com; spf=pass smtp.mailfrom=selinc.com; dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b=yA8+AYiW; dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b=FObUpDH9; arc=fail smtp.client-ip=148.163.143.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=selinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=selinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b="yA8+AYiW";
	dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b="FObUpDH9"
Received: from pps.filterd (m0136174.ppops.net [127.0.0.1])
	by mx0b-000e8d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507G2Vsg023368;
	Tue, 7 Jan 2025 10:13:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=sel1; bh=qz1EW
	9at4/mSYg4pAzuWEeOKCnxCie9CyNmZZlZTySE=; b=yA8+AYiWD11f0MFlk449t
	d1MOaTuCR+h2LBpW9P1/lwz2yYalbejdPlYEXV36hfzC1AH/7KCwn487QBVz5F2s
	QhKEVCfr3shA0pc7UsPdSKCNqCOKsCiHb3ZHFOC01W6GK87XKBIZkqpNNWiOiipU
	X2xZUPqbJj/JMhXqVmC7h/H5ire+IsYI5zXolImd35RFyMyOTv3EvcbUl/uF7ln7
	O2MdiumAuuWrgJOUTt5fJ/YMX3BfWy78gziHEHP/FQxFyJYNtyE93mSN74yox6Xg
	pupNZOYVY6IVK0JWlfiMaJwlPAngx0nKmCxwqLd/z0EzE2BbwczKS44x+xDZxl88
	Q==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	by mx0b-000e8d01.pphosted.com (PPS) with ESMTPS id 4417e9g3pv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Jan 2025 10:13:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yMglWlJAJW5+X5Yd4TgwmUxNjrbMlGmPFgy8pL1Mxcr2OPwKPYQbIvsXlwXE17u3McFLbtWHd0m953ZPjWfoScb8+KozycMoYhP5rQI4/H4iBkoPKgp5XRWLgUTt9t3TlWO14VK4f8vJ3wQiCOLFM3F4iNhPvzkptVa0PXUinZELc9swHqlY34dZQnfSA0CxTavb5o9C/s025oQihAodHQheRV4JyfgZGHkevTVD0/YTI1+ucQLjJ1KXb4eVZP0O3oyNcj/xO8pohmVpru4CAq8lePd8/IZ2yL8/zZCFgad2/ZIjDxbaGMLW8rEykq8h1L1hHwmt6JQniKzd9sBEWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qz1EW9at4/mSYg4pAzuWEeOKCnxCie9CyNmZZlZTySE=;
 b=nD6Ief59YWhPzwsL3uCmyxMLLzWQQkn3vQym3Rhj81stuo9UvbooYgD44VHpQS1as31C/CFtJ/drg5cZ4prAwpt13nRiJZBOcdnl/rE/5nPPI4ifDXtIMpQQNwvSRq1plaEpIF+msuHZQ04btxY2o9bYtMqcIudRrmcIPTHK4fiUUgVI8v1BtaHXDGAfCzxSf1zcBFGszS1coTSAYb7b3wjTBdd08mH5UywWAflwYqkGI52dkaTvLET0Jna7/LNbFQNbjL2XKlfuI+X+PtOuKXQIlZNC1Ima+NlepzJcXED3rl/z234eL93Mt2tMnAPwHRyQoQSNw5bFVWiyWNFqIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=selinc.com; dmarc=pass action=none header.from=selinc.com;
 dkim=pass header.d=selinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qz1EW9at4/mSYg4pAzuWEeOKCnxCie9CyNmZZlZTySE=;
 b=FObUpDH9q3X1r5gn6fRSY0tceiN06XUwWzHwt44VMM0qVCgXaBwO4bOWOLCEFwek2kbGwIMYOCeGifzr5315IFmNwwmRwFA0ZSkMYqak2I0G8tr1wkPdMlxOK0Tx77R98IoEcB+NZ83lTX/yiXfvq2zrp1OVuJkUsksU5w5OQUODccezkxQdH9/KEBPKntpSZPJWR5t96TXFtX/DCIpTFNe6LqtjNDe1vINAqiVcGrIExkZeNGorffV2VOLzFwSlBsuzBBWd9/qu6sDB6iBw12Z40anE74DECmq+olrccF1zwEqq7yY0b0PLPba9Y31ddiONNnhw6bC6Rx2aQpb0Hw==
Received: from SJ2PR22MB3822.namprd22.prod.outlook.com (2603:10b6:a03:4f9::18)
 by SN4PR22MB2839.namprd22.prod.outlook.com (2603:10b6:806:206::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 18:13:07 +0000
Received: from SJ2PR22MB3822.namprd22.prod.outlook.com
 ([fe80::216a:eac:870a:8f4b]) by SJ2PR22MB3822.namprd22.prod.outlook.com
 ([fe80::216a:eac:870a:8f4b%3]) with mapi id 15.20.8335.010; Tue, 7 Jan 2025
 18:13:07 +0000
From: Robert Joslyn <robert_joslyn@selinc.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "rostedt@goodmis.org"
	<rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: RE: [PATCH] powerpc: Allow scheduling of IRQ with PREEMPT_RT
Thread-Topic: [PATCH] powerpc: Allow scheduling of IRQ with PREEMPT_RT
Thread-Index: AQHbV8o+5QBkEbRjDEWM0suiKTr7tbMLRq8AgAAUwACAADwtMA==
Date: Tue, 7 Jan 2025 18:13:07 +0000
Message-ID:
 <SJ2PR22MB3822B4550212A2418187A075E5112@SJ2PR22MB3822.namprd22.prod.outlook.com>
References: <20241226191238.2559880-1-robert_joslyn@selinc.com>
 <20250107115606.q67--i0f@linutronix.de>
 <da4d15ce-eabb-4c8c-bc8b-cee75f9993bd@linux.ibm.com>
In-Reply-To: <da4d15ce-eabb-4c8c-bc8b-cee75f9993bd@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR22MB3822:EE_|SN4PR22MB2839:EE_
x-ms-office365-filtering-correlation-id: 08013836-1e84-425d-0bda-08dd2f46ef9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?G8MAzx7Vr+2qjCmN1qJqU52my9ydvx6PPfoNVwpSSh89konTuIjycxeCiWxe?=
 =?us-ascii?Q?b2uPKSq+NYtYMw4IA5I5w/srAD6UbF7Tq0ZDelBXFcNxymL/Fl58TibDzEIz?=
 =?us-ascii?Q?z1y57vft8Ne3kyvjql3/94LTClFt1ib76MHeNXRkBFODaAb50+05nBpZ+aYs?=
 =?us-ascii?Q?BqLrIITIbKlEh8hHiA5dkL0x11zBGmRDtUW7inOA2p66pm7fsalfsFbNO9rZ?=
 =?us-ascii?Q?zcSDXjmd66Oj90KX/xcI3KiCTKeOnj06kQ+fSdYOJ1X/ack5glWjUQJo9zR0?=
 =?us-ascii?Q?UGBEpM2DCquw9zCqE3E+qVDouCObrBh9roD2QwtbBE+19QSZ+FgyONVOgVS2?=
 =?us-ascii?Q?N5KH2I7AsGx+cOLjsKJHQWEZJYPT3aYYligug2IMW7/P+GUw0MlH4jJd8YgN?=
 =?us-ascii?Q?irXMuglLNHsb7rZAWKoGKQWzw7D673niFFPFm9+mhc7HOMn2gy7ZTZ5yNrpk?=
 =?us-ascii?Q?tWSygyW+a7WrxooQY0gmg9c51TmAYC7Du87tSWQATeeO97jOGUsuyY5UvsXl?=
 =?us-ascii?Q?Qp2BJ4icLHbr1Kr3fhNfkJpNEnj0wkpgeHdPRWn/4NezwVd+fkWcWhfe1cPT?=
 =?us-ascii?Q?eWFT6Oe2npqAyTMubqYCnr25QujBL9EffeA0AW1rerfhmuXziqvdJfzawdhT?=
 =?us-ascii?Q?/Z36rdZRx8EvLVAsUmPNLy5tNoULsm5VOA7zb++EyBT5MBYoHdpMxuFLfyii?=
 =?us-ascii?Q?n5VQTPWwQjecJB4jH5hei2i83wxhHP6MfDaNP2+GsrsmhjUoDEz/5roAzQEG?=
 =?us-ascii?Q?MarLwkgeZThsyR/7x+XrJ18BrTQkR/wGzOmZVatZTKHb0DK1pqNUcUtW2WLZ?=
 =?us-ascii?Q?rTxDSMXtCfd7vSTkbVXJG5O+2gLIa+IPYTRpE4PCoQB2yR45sQsy5AQvQHuy?=
 =?us-ascii?Q?ydj3Pu458C3og+NUbBazJ48gYx64dXeedbztHY5GgCdCYArBELgr8c/g02Ln?=
 =?us-ascii?Q?RElFfLA30FfsIdijRy6W323kW7Ij3wwBp8hKqOEabvu0T/1XhlVUBX8lkMLV?=
 =?us-ascii?Q?xQ8wdlIAjrPr+/m8nVvLF1FO/zjYDgbNZA1QVgfh269Q85A2uUINMGAFfpd8?=
 =?us-ascii?Q?WdNqD3QUw/xEJXET08X2Ryh0OQ1zwF/qO811VHmEGBZzI2fE7ZGv8BoEV9rW?=
 =?us-ascii?Q?4cPSTriOXJjvYH+hPhNTjOyYjhaf9M8lEJz0CUvugMaLNIWkusKslF+deZP7?=
 =?us-ascii?Q?huU7yKh2q900+DlB4Byo1aMHqdY6iElCYYfl69h9qxFTuKmIXzB47/M8hOJB?=
 =?us-ascii?Q?huUi2XV/sHdfV8l4JikEjDoThTxUgfDC/fSJe0/WTyJ+jjVFXS/JS1WpphEP?=
 =?us-ascii?Q?jOqFE1DRSs3Fi7Eu05w2V6McG4WyQWE4bd0Tf3zK/NzlzHKqxTPYroGa5kAm?=
 =?us-ascii?Q?Akm/tSteYNWZD/AA00hap+H+NWWRzALOz/i7aqVa//MWBj5pKA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR22MB3822.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZWeY6R1k9J1C4T7aLVcXtgniflXmwtreTzpf5Xk75CeofN9vQipJo0o1vjMN?=
 =?us-ascii?Q?KD3ExyGjpE4UwDdvGMW9073twkJVEU1MlicJK0+UR9hNOBKDlWLeKomQ/qj3?=
 =?us-ascii?Q?h4hnovZnfcNilAjSTohk6vkbrnUdKygOgkY4UdA+G9CM2SK/M2ye3qJO3aja?=
 =?us-ascii?Q?PosipmP9tB1YcgWbPuMo7+F/nvHcBq04Obj9Z2o8AgZD2jOQkvP9HXngSJ4X?=
 =?us-ascii?Q?lH/gn5bdopHavWYh8ZYAAmB/jeEzsILYymJwj9UUj5lRLwyFj1PB4/8ddiP1?=
 =?us-ascii?Q?hI3bCBz3Jujgh9519Bh1pcszFx29MVeQC78Ckwx4CqqUMAKpKvdluL/H5umv?=
 =?us-ascii?Q?K0qdbDmyR2kFuAFco79pkfgixl3FFfmDe1VyZb9WJ5JoBLJTobttOXjwKztp?=
 =?us-ascii?Q?2O+0fXP/H2nr3nXHVGp5Es5oLj0ByZQsMD/aAtTRbfm/vPyBC7kfzx/PhMEf?=
 =?us-ascii?Q?0z9rL3c93BDWaPJTr+sz3QFihvstVbgiq+V4ZPycWSDWnGlWvMtR2giGXd0E?=
 =?us-ascii?Q?9y+pADjkw+vmjxivRPE372t56+PKU6reGOh2f7Pmw/YoJgWjzAEVs2wpHbQ7?=
 =?us-ascii?Q?k+rV9DuBxIWLU2IzcM0vlcQx6HSccz42Ekf1qxMhSTSAfG/DskAiXsv1gtIP?=
 =?us-ascii?Q?T7arLeEPgEncn76hzSSn2BQmvoAcwrBPTsLlWX891oJfobVR71YPZTtxDZ/U?=
 =?us-ascii?Q?SuAaxoGteEHr8qEoo4zumdhtTWZuCWU7g6XL6RO0HLu/iSGOLAnvt6rpqBdy?=
 =?us-ascii?Q?fojyevmLvRXksY2IwxQYuISiTYDFI/I4ru+jcGNU4fJPQyZ6AcGRgPBvKFWy?=
 =?us-ascii?Q?0Q/sR9iIpCUHnYaPO7BmbXUcmGKz6L2YBVmhwftPcxVD8iWwZV/DcPxuGwWy?=
 =?us-ascii?Q?VWIDTiZcxdG8kwFUSu9CT2MoAQkjJDhGy+MC9nQ48dcP1moxmsX185yULNvJ?=
 =?us-ascii?Q?RAbiI41HQqd9eLphtgyDlIrf29vSsZQE/RH+EpeR+PMOciNcWsODTe5Qa0SX?=
 =?us-ascii?Q?toXiCRV0GohIsWTSV/IUrEozfsv7OVIy78ZvfiytXvv64NxklcGAD//KY83O?=
 =?us-ascii?Q?/fYWLlQ4CYG8H+a+fMOf6q0E62N4NjO6QXL1HKlYNNKYeH8gytpll+nBRVV6?=
 =?us-ascii?Q?jsS6aCw6wa5q8sIL/1PTM4dmgW78Hh4BEmNN16cLiEvEnQQbmynR6ce6MslV?=
 =?us-ascii?Q?t8k3ygLLQS7/SSyaW+E19LwBIEx+HDR9nY1Jpar/6kSc8DJ0IueZgCMRm61p?=
 =?us-ascii?Q?tR/et5V6AAOgnGPmVxtt94yMP5/1RV0N2IhOhzt1uXiA+rnuqM0QlZfWF7Xq?=
 =?us-ascii?Q?bEaqemTJkMS5rFqSbx1ITS0bUY2rNZxnb1ObnNLWEQVwn2fLh9FEKagwIHii?=
 =?us-ascii?Q?S66D/SfAWLItxkMFBLL4zaaeND4V7nKZL9xGDETiAEUYizrgOoS88pRuvPe7?=
 =?us-ascii?Q?fg7OlpsmUmk0xIxxa/xZ8eawR/5kj1OB/B7iqbAVOH/xR7oplzjQUm2wSqWq?=
 =?us-ascii?Q?vGEfCjdzZHAkqRPPROPy+fmHssVXaj29X5FVZYCwE47DOX1iR0/y4v56Iwh+?=
 =?us-ascii?Q?YcnwGkinmBhaQGRHQwtEpb9q1AUhQZYb+fBqvOuY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: selinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR22MB3822.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08013836-1e84-425d-0bda-08dd2f46ef9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2025 18:13:07.0579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 12381f30-10fe-4e2c-aa3a-5e03ebeb59ec
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cV52DyB0/ou3JHlZWgBf1OPf9t9j3xXsieuTpPSkDYGdS/3rVJfpdGuMy0+D2hnEDM4WrNXJPzEj/ApyhS7O6L72lBTK08+gegDj1xA0XtM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR22MB2839
X-Proofpoint-ORIG-GUID: qcWVPhINMPTnSTwRZri542zhWMN0NTL8
X-Proofpoint-GUID: qcWVPhINMPTnSTwRZri542zhWMN0NTL8
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxscore=0 clxscore=1011 suspectscore=0 priorityscore=1501
 mlxlogscore=696 lowpriorityscore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501070150

> -----Original Message-----
> From: Shrikanth Hegde <sshegde@linux.ibm.com>
> Sent: Tuesday, January 7, 2025 5:10 AM
> To: Robert Joslyn <robert_joslyn@selinc.com>
> Cc: linux-kernel@vger.kernel.org; linux-rt-users@vger.kernel.org;
> tglx@linutronix.de; rostedt@goodmis.org; Sebastian Andrzej Siewior
> <bigeasy@linutronix.de>
> Subject: Re: [PATCH] powerpc: Allow scheduling of IRQ with PREEMPT_RT
>=20
> [Caution - External]
>=20
> On 1/7/25 17:26, Sebastian Andrzej Siewior wrote:
> > On 2024-12-26 11:12:38 [-0800], Robert Joslyn wrote:
> >> This branch is needed to allow preemptible IRQs to be scheduled,
> >> otherwise the kernel hangs during boot on my e300 based platforms.
> >> This branch is needed for both CONFIG_PREEMPT and
> CONFIG_PREEMPT_RT,
>=20
> Hi Robert.
>=20
> Are you running with preempt=3Dfull or enabled preempt_rt ?
> rt is yet to be supported on powerpc. are you having it enabled out of tr=
ee?

I'm running PREEMPT_RT using the out of tree patches on 6.6.58-rt45:
https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/

I haven't tried using the mainline kernel, since as you said, it doesn't ha=
ve powerpc support for PREEMPT_RT yet.

>=20
> Also, I have sent out patch to enable dynamic preemption. It uses
> preempt_model_preemptible.
> I think it should work for you as well. If you could give that a try and =
ensure it
> works, it would be great.
> https://urldefense.com/v3/__https://lore.kernel.org/all/20250106051919.5
> 5020-2-
> sshegde@linux.ibm.com/__;!!O7uE89YCNVw!IDeomstGeuiEZi9FmLHH8C2xo
> PPo_ewL-
> k2kiQ9CmVID35U4J_v3Dkafjo3RnS9ygPoUZWwyyp91SP2euRkKArk$

Does the dynamic preemption support let me enable the same functionality as=
 PREEMPT_RT with the out of tree patches? I can test it out either way.

Thanks,
Robert
