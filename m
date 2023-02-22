Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D577BC61DA4
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 Feb 2023 10:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjBVKxX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 22 Feb 2023 05:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjBVKxW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 22 Feb 2023 05:53:22 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2049.outbound.protection.outlook.com [40.107.15.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BC137B43
        for <linux-rt-users@vger.kernel.org>; Wed, 22 Feb 2023 02:53:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cwb6nFaq/X+3i0axWzO2chHsXR//68wMfd/uGM2RVlQkBgqVC7NsIlNQWBZMWbAxDOg3wbNYp9bU2UWLbdzbeBajmI0qpFOjM3siMk7bf4egNWFuOquh8ucG+WFnoNdSHV7nmW600lnjTocX101ez8seOzjg5Nimgn6nul7BZaAViPIUV7fkgGwBficCx2gSg7OTAFTkm9qeVYQrcCZBk1PsghO57kLLAwz3ZEaxoCKmXdOjH9Ya07h3QKHidn961rddzhhX5NnNyecsmJIuIZRYcXhfo9BtNRmMy1aMapjko2HQfeJVKhs6TDfT4RZf2LS4d0cAzOaJh2T1TMlxTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOZyiVcr3a2sKd/agUEICu1BqFxBsAdMxjknxpzf0Es=;
 b=HsgFMxvo41wddciy7wOdl/ynJlKq2WXmZrdiQy/VpkYP7lYXCTe9D/L9R2ct3jTep//LDj6UEYVuY2Kc3bv4aRPB1sxkqQnNwO9a3qsrBLssdioeGH4/YwQDrLZR5Q3d4rScWvZpXR1YNhKV7EPCrKuHQ4+qL2jEo+OrUeysjW+o3rSf6jmyR0MTGZ8eAeNCHHXJWR6cTd6gg3zjXSz2DN/vzt4DZ8iOlEY87htaB3Jw8P4B3kyaeJyMVt+jbONtUN2ec/Ua2oI53I7p5VWLvst7GIXIC9pGS2rYjcDQ4zZnWN5DW37HaM1TC2Ag2yvUYpGMvzLdJFY6l3ae62s1cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hms-networks.com; dmarc=pass action=none
 header.from=hms-networks.com; dkim=pass header.d=hms-networks.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hms-networks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOZyiVcr3a2sKd/agUEICu1BqFxBsAdMxjknxpzf0Es=;
 b=q795bDCotMOwDXCcCWtLyaSPeCAAyJp65mXB8ghEsDovKZV3VuQy1ng/A8NclWl1kACgLvuH0bSBM7ClxbM2ddKuAvtQJdGbXl155qhv9RtXZBJ7cqm1u7hil/DoyNuX0OKp7CBz00MBnviEH+Tbg67OWN8aikONFIhlZkHt+K4Asu6fFl5D1UqdTqIIKn622Ox/ehAFm5oisBjUlTBLoa/bWDEPFz4MZ3fty9E26CcYyzsdwCt+jiR1oSK4zatFen+y0ftRmLoPOXfBeBH1xo5Froox/IcutFl3Ji2YhpieNNUjICQuUNDRoLkKe1LrUGSdLQVNytsg8NX8kXpJxg==
Received: from AM5PR10MB1620.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:206:1d::23)
 by DU0PR10MB7333.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:447::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Wed, 22 Feb
 2023 10:53:17 +0000
Received: from AM5PR10MB1620.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6daa:d5d3:8e44:2b3e]) by AM5PR10MB1620.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6daa:d5d3:8e44:2b3e%7]) with mapi id 15.20.6134.018; Wed, 22 Feb 2023
 10:53:17 +0000
From:   =?utf-8?B?QW5kcsOpIFByaWJpbA==?= <Andre.Pribil@hms-networks.com>
To:     John Ogness <john.ogness@linutronix.de>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: RE: [PATCH] printk/console: Enable console kthreads only when there
 is no boot console left
Thread-Topic: [PATCH] printk/console: Enable console kthreads only when there
 is no boot console left
Thread-Index: AQHZRg/hPmOt9aMXPUu8taZ8CBlV867ayUDA
Date:   Wed, 22 Feb 2023 10:53:16 +0000
Message-ID: <AM5PR10MB1620492AB35480761F4F273CBDAA9@AM5PR10MB1620.EURPRD10.PROD.OUTLOOK.COM>
References: <AM5PR10MB162013648CCFDDDC4EE42A3CBDA59@AM5PR10MB1620.EURPRD10.PROD.OUTLOOK.COM>
 <87bklnro9j.fsf@jogness.linutronix.de> <878rgrro4z.fsf@jogness.linutronix.de>
In-Reply-To: <878rgrro4z.fsf@jogness.linutronix.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hms-networks.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR10MB1620:EE_|DU0PR10MB7333:EE_
x-ms-office365-filtering-correlation-id: c26337e4-2d6d-496a-51e4-08db14c300e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N2PCT8Nc+R30rjyupbLInbbtj5rxzdSHjcUKANsfmpzFdg+GOvrPERH+EFTwbUSt78eoaOjobEXVXnwJ1lClgszbucUhksIv6cmEunHTZ78AlESg/cOV2m8NvIU6oCnP2hQstbEFx5hBYtMUVB3o6u9rHwalEEZw9o7pu6B8LR8xFYw/KSpYrRDcIA0EPpUfSP55foOhLRtT8+TEpTPwCrxS30Rb38Bt3KMlV6SjXdH6vwyoHD+QQI04HrYfKQzAg6zcZMFwyVBDdQhwLXOCrYKXOiPzLG3/sHKiyq8+mWFnw+Qp8U7cGMY+8gCXGiwXJ9dntXOtLKWpzuLG9+f+8AIU1oLSts7Vr1DQTvE7dElHMS/a+4XC5HVUYjbhIczIxc1a9yEGaugdGeP+yg+fd4Wfdz3RsTpN9DHJ+A2H3JgMsXCthlY7UXnb1KyZkfwpkRNyHq02sG9qX3SanlQkLILSlnCLl+0ndB1E2LtPbOeYNLWe9719YzaJUbs5NI4TVsvyDNO+MaS9MULIrvktg5t8U1FiIaAfA6dn4IwwXI0e5RGqwUH+yxkQovbV6DGVHC8VtwHhLwiY6fuAH1hvXE4RU+FlTmaSGXA/l6ukVbZyj8HIUvNlsizYRhRqvgbp6l6M/tGOoFShuU9fL2bjaGVG/cVqxECrlN5MCd6ZAFTSso/+YRlZ3ilZ95ndmMUuEnYflU+Xy0V52fD23o31YQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR10MB1620.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(396003)(346002)(39850400004)(376002)(451199018)(9686003)(85182001)(122000001)(38100700002)(6506007)(55016003)(38070700005)(316002)(110136005)(66446008)(2906002)(66476007)(71200400001)(478600001)(8676002)(26005)(66946007)(186003)(76116006)(66556008)(64756008)(8936002)(83380400001)(4744005)(5660300002)(52536014)(7696005)(86362001)(33656002)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGptNFUvTUlUUGdyVUR4ZmpjMXJDWE5DMVRKOGEwbUNsRWVBd0RkV3IwVUkv?=
 =?utf-8?B?bGJYL2tnODE1ejRPb2lwWFpzaG1GeXlsMkprVUJsWitxZWVUUmZZeG9ILzZP?=
 =?utf-8?B?WFh3L1ZScWNLbjlFVU56bjVld0dMbm13c3RVb2ZUaEFvcEVycDJFc05mZVZO?=
 =?utf-8?B?MDR5dW9xRS9wUEVqZTVsQ2g1VHlKVjVqSDhVRUZ3ZWRybmQwL21QOFpSOFl0?=
 =?utf-8?B?QVdpSFNOMkJuMW9NWlczSGpyL0xWWHN0UXhvZzkzR0MyOEMwVXFXenBDWGhk?=
 =?utf-8?B?NWlPK1RiTTM0MkVOYVo3UzRiRUg2Y0locEZBaTlXc2pWckk3eFNhbFhWK0Nq?=
 =?utf-8?B?aGtobHlyU0p4ejk0K0hpbjF2b1BCQU1QS2Jsemh4Z2I4R29NL2h6NTJGYmZZ?=
 =?utf-8?B?WGhjMnRoUVBla1dWZSs0YWNiUmNyQU15d1hKTE1JTVltSHFhQlU4VUUxQmRM?=
 =?utf-8?B?dExJU0Q3NzBFUFovT1pwK0c3NnkxWGR3N1Q4Z3d1cEtSN2NNUzhXWG83R1pH?=
 =?utf-8?B?aXloSUNTWU9iMG5TeHppS25ZYmxIYnV2enVjZWI4bUhZZnJ4SWVrN1VwOVc2?=
 =?utf-8?B?R2pXZENUQmdqWUlGK3J0RFlmZlJNZG1qc2VkMTRQMG5BU3ZGRFRIcDNvaWFo?=
 =?utf-8?B?OEUxWUVQblZhQ25QQ2s0Q2F1MTdGM21zNVcrZjlVaXdwUUFiOHU0ZFJMUVlm?=
 =?utf-8?B?Ylg0emdpSUdZcGdEK3pQYWhPc2ZkcFVjZjNEVi9nY2xRdlZxSW5kdlVwNUtw?=
 =?utf-8?B?cDRZWmpDN1JOTTJJblFtTEtHbmJvRU92YVllM3Z1U1RKZzJRVGxZckFGREVh?=
 =?utf-8?B?RUhjeUp0Sy96Slkvc2tKQldPQytHSUQ2SmE0aTNyaDNvVUZUWi9JOFdVNEpB?=
 =?utf-8?B?VU1nd1BOYkFlN2hMVUFlODZBSE5hOHdWSjhyNXFlallBM000OFhVeU53b1Va?=
 =?utf-8?B?aXdERjN2NnBlc3lJSGt6ZHJndDZ1NElFeGVibnRSbFNTcWxkVUVBRnF2YXgw?=
 =?utf-8?B?c3BMM3ZwSnFraTduWVVwWnlwQ0NOeEtwYXV5VzFsSXZoNFVLbXM4SkloZk0w?=
 =?utf-8?B?Q1lxelhmZHQ5UmJISXpTV0NKUVh1amE0L3FMSHZEb3VPT1QzMWxUVWRaS0Nv?=
 =?utf-8?B?VHQvY0RHMDBRZTBhZ3hzL3doTUJDZXFmVnRVMmZqOEUrckFuQkZKUlRlRTZZ?=
 =?utf-8?B?SEt4RmtlOUM5NVlIUzdHa1htb2ovOTg0cWc1UUpYOHNPU2g4bHdvTU9NZFVz?=
 =?utf-8?B?UHFpVmRMRWJCY3VTc21PbXBnMCtydzRmRWw1YXpyR082WlJ2L2lXNVpUYVNU?=
 =?utf-8?B?WlR1akxEYWIwWXg3dklLMEJtTXF5elMwZS9zQ0xQV2FuM1ptS1pCNUhoNGlN?=
 =?utf-8?B?MnRPTkZVbCtEYUpJdDlFREtEaWt1bVc3ZUd5Z2JaWUYrSEt4a08vUE1kS3Av?=
 =?utf-8?B?anJhRHQ1OVdEVjNkd29uU2ZURXdVQWl3cVY2Y1RwUW9YNWpncTZuOUZLRWda?=
 =?utf-8?B?Z3dmd1lTMGh4K2s4T0lmSDFUK3MrN0gyNC9iR3pycHZ0VGwyamJJek5LMUkx?=
 =?utf-8?B?amRubGVOY0g1a09EUk1ydTExdjBpeUtDMEZTT0ZpbWdkcTE1bG9QaFBDZEhz?=
 =?utf-8?B?RTFsTVNFZ2N2ZC9zQ3lmdk91WHp6TDY3dW81UDNCdG9tQUg0SGxyVEtURlR2?=
 =?utf-8?B?RDh5dXExWGJvV1ExWnVrclBWMS9PcTlLZUxJdUdTSjArNXEyWmtjYTRRSTdT?=
 =?utf-8?B?di9STUhJb0c5NDF5VTVaM1FCUmRURVFrM1RtRVYzR2d5T1l5Yys0Njd0QkJK?=
 =?utf-8?B?dFByakVHTFRLQ2o3OVN3bTRRcFNMd3lRM01pdlpaa0lJaFdrMXNkc2hSazdJ?=
 =?utf-8?B?OENDR2JKdk1uTmhyWk9QcllkSk1oK2ZrenhvRDVOQ0I4RjNwZm9sb0ZESllK?=
 =?utf-8?B?ZDMwUCs3OG00YXZTQ2c2Q2NFV2VaYkErZVpTeXUxbWpnT1VlSnh1MFlTWkk5?=
 =?utf-8?B?WVVrQmsxb2c1d3RwSklvSnJIbytjb0FkTUlYMndYbXVVNlRlMVlRTmVVUzZZ?=
 =?utf-8?B?bkhUUVNEelFSak5VYktXWU4wK2Y0TVdHTkx3ZHFoOStmVVhseTFGTXdNd1Q2?=
 =?utf-8?Q?ETZw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hms-networks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM5PR10MB1620.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c26337e4-2d6d-496a-51e4-08db14c300e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2023 10:53:16.8704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7c1590-4488-4e42-bc9c-15218f8ac994
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sqBraGSIO/DvjxcEie+vh1Tu/+i+6TGGqZOfPecmtAuvectSPEObZs1Zjo5xtnrB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7333
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

SGkgSm9obiwNCg0KT24gMjAyMy0wMi0yMSwgSm9obiBPZ25lc3MgPGpvaG4ub2duZXNzQGxpbnV0
cm9uaXguZGU+IHdyb3RlOg0KPiBUaGUgY29uc29sZSBrdGhyZWFkcyB1bmNvdmVyZWQgc2V2ZXJh
bCByYWNlcyBpbiBjb25zb2xlIGRyaXZlcnMuDQo+IEFsbCBwcm9ibGVtcyB3ZXJlIGluIHNpdHVh
dGlvbiB3aGVuIGEgY29uc29sZSB3YXMgYmVpbmcgcHJvcGVybHkNCj4gaW5pdGlhbGl6ZWQgYW5k
IHJlZ2lzdGVyZWQgd2hpbGUgYW4gZWFybHkgY29uc29sZSwgdXNpbmcgdGhlIHNhbWUNCj4gcG9y
dCwgd2FzIGJlaW5nIHVzZWQuDQo+DQo+IFRoZXNlIHByb2JsZW1zIGFyZSBwcmV0dHkgaGFyZCB0
byBkZWJ1ZyBiZWNhdXNlIHRoZXkgb2Z0ZW4gcmVzdWx0DQo+IGludG8gc2lsZW50IGJvb3QgY3Jh
c2hlcy4gSXQgd291bGQgYmUgbmljZSB0byBmaXggdGhlbSBidXQgaXQNCj4gbG9va3MgbGlrZSBh
IGNhbiBvZiB3b3Jtcy4NCj4NCj4gUHJldmVudCB0aGVzZSBwcm9ibGVtcyBieSBkZWxheWluZyB0
aGUgdXNlIG9mIGNvbnNvbGUga3RocmVhZHMNCj4gYWZ0ZXIgYWxsIGVhcmx5IGNvbnNvbGVzIGFy
ZSBnb25lLiBJdCBtaWdodCBsYXRlciBiZSBvcHRpbWl6ZWQuDQo+IEJ1dCBsZXQncyBjbG9zZSB0
aGlzIGNhbiBvZiB3b3JtcyB3aXRoIGEgYmlnIGhhbW1lciBmb3Igbm93DQo+IHNvIHRoYXQgdGhl
eSBkbyBub3QgYnJlYWsgZmlyc3QgaW1wcmVzc2lvbiBvbiB0aGUga3RocmVhZHMNCj4gdGhhdCBz
b2x2ZSBvdGhlciByZWFsIHByb2JsZW1zLg0KDQpUaGFua3MgYSBsb3QgZm9yIHRoZSBwYXRjaC4N
CkkgbmVlZGVkIHRvIGNoYW5nZSBhIGxpbmUgaW4gdGhlIHBhdGNoIHRvIG1ha2UgaXQgY29tcGls
ZS4NClJlbmFtZWQgdGhlIGNhbGwgdG8gcHJpbnRrX3N0YXJ0X2t0aHJlYWQgdG8gc3RhcnRfcHJp
bnRrX2t0aHJlYWQuDQpIb3dldmVyLCB1bmZvcnR1bmF0ZWx5IHRoaXMgcGF0Y2ggZG9lcyBub3Qg
Zml4IHRoZSBwcm9ibGVtIGZvciBtZS4NCkkgc3RpbGwgc2VlIHRoZSBnYXJiYWdlIGNoYXJhY3Rl
cnMgd2hlbiBib290aW5nLg0KDQpBbmRyZQ0K
