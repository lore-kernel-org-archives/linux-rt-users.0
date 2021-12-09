Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD16C433F5
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 Dec 2021 09:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbhLIJXL (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 9 Dec 2021 04:23:11 -0500
Received: from mail-eopbgr10079.outbound.protection.outlook.com ([40.107.1.79]:7163
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232940AbhLIJXK (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 9 Dec 2021 04:23:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvfRUEUFk+Jc5l6Ty1IG04BKuCcCSatOKjpReQoJGWoqoX5Q+p+9yOlYZ4Dk+9OWVhMvq9sccK/lhKEX7xrJN+/iy772sh2gJ+qXG3pGSOXHVooFZPaveWT30fpz9eW8wjgN7qEBx4xeSJKSEN+af0jRhu6Ggrau4+m3mz26byiMEqem9P33SVEnq1uHqSnNHox/cLJtxBgS4J+JNdHS/02v3VYY4fvcXJ8cU+iuBUTolJehok79QqdN72LwUgkP5FDbyDpmlHai3L61pK/yA3WA3jyrF6Qp2gP4lsz8ne66XIflICoIFBO3SQW3c+EvbU9mHvLsjUKRlx1+Lfkykg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHEWInp3cBaj2WM+GBnFonbMnXFttqO+jmVQ9i14+mo=;
 b=EpepmZ8OjdU+pFGXlG3IyB5RWiAwbTIFWm7+pyx12FTtsgMlTjnasWV+KooHSbVI8p5al8igw9uGa12oyqyIUk4ZbIjchsjE64CTkl5ysBVd6caAJPP+NjVbm6Cy5BvZ5ol2JRPQL1o1UYW23daPWWrMH1UVo6ttxRnZJxdpRie5f2hrM4LwOUbtl1kew1vTPH2sRUtmkCYfwbREW1Q+oNR6QvmmH1f8eF3QxhdzA9f3+CdNfveHLqfk8jzXIo5u/T826ljhljhkoRMZukjgZD/3rI+YWlK2hJWQniKY0qTXm3ODnzu0vxFE7wo8vBK7RfbUqhAyVroZqhP6UbciQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sap.com; dmarc=pass action=none header.from=sap.com; dkim=pass
 header.d=sap.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHEWInp3cBaj2WM+GBnFonbMnXFttqO+jmVQ9i14+mo=;
 b=b7TQjlAo6k/5rtbczdSghFZne2n2t+EKugQMnLZi9whGzPlZbIZK5l//uF8rbpHT5seGxZlH58FwJcZ+cK6RLwWuIFMql0nDFhAkMatKz6Jm+m5EUuxB8mvzJ96kf8XtEW+zeYcBBKsBnpS5y89triEDGYqtJKn6QB0s6gD3eCnscaD15CNul1NgR8pfSjvdSM9UHqc5f8nFu4cc5ZZ4vaZA0/Lut0zVveg/S25ednCpgR3J7w7jEwh2gulohTAYJy/kLhY4o4siwa1eQ1b5p8n2s5NAKCX96OFEu8H2M4hKkrkJmGhaeNsI1tofy14shrK2YUDaKQKVlFCGL4nvaQ==
Received: from AM0PR02MB5859.eurprd02.prod.outlook.com (2603:10a6:208:18a::22)
 by AM9PR02MB7012.eurprd02.prod.outlook.com (2603:10a6:20b:262::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Thu, 9 Dec
 2021 09:19:35 +0000
Received: from AM0PR02MB5859.eurprd02.prod.outlook.com
 ([fe80::5f4:5895:622a:f47d]) by AM0PR02MB5859.eurprd02.prod.outlook.com
 ([fe80::5f4:5895:622a:f47d%7]) with mapi id 15.20.4778.013; Thu, 9 Dec 2021
 09:19:35 +0000
From:   "Riesop, Vincent" <v.riesop@sap.com>
To:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: Q: verify signature of 5.10.83-rt Patchset 
Thread-Topic: Q: verify signature of 5.10.83-rt Patchset 
Thread-Index: AQHX7N3iFz04E0NZOUOwr8ESgd7k/w==
Date:   Thu, 9 Dec 2021 09:19:35 +0000
Message-ID: <D966A34A-70D9-4CFA-9644-B9DC35841AB3@sap.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.20.0.1.32)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sap.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ac0e32f-afa0-4ea2-62ee-08d9baf504aa
x-ms-traffictypediagnostic: AM9PR02MB7012:EE_
x-microsoft-antispam-prvs: <AM9PR02MB70121FD475939AF2E98E52579D709@AM9PR02MB7012.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5FpeirKLkt/+43SlmtZiWhn/dUySXhf/yVWlPXsiZgwYNGwz+zEGUSsg8RLD7TYpj15LCtnhTap/o4F88pHEQWXcQlDbFcU7q/bL56T96yDrr/xVAFUXMC4EIbj3mSLfMNc/ywYbfXd68ifoIbHjokNhQtsgrINz3u0aOP6NOhKJigPiYUKaX+MzzBQKaBCEiyRVVlHiX70Pe/PAcoInRfnwII4MPnwgh70gjHOM+Zmqn4m/HplsmU7H9OU1D1hqztmZ7MMWarJo2MfLwid1TEYy0v/BmuD3FP6uMLQN4HVCZvh7gqHLoa0/8Y6QaxTrz1nDm+6rGA1tS3FX7phbAdx+XMOJtDVWjt/0n3J945IKPY2GoYY2Y47ksdRM8SGcRTWLFYk/WbY8PUzYdi8abTujiRL6vyxHvD5VpGV6jjUWQ5XWLXSimJl7lNmksm0M7gAWxVQ4UAoq66FTdgh82EbROvgNoNwUMaOQyNS2x6EGHXOFy+WhdZpXF8Q0Xkf0flplmdRP0or8WcE5K9KGYvpIcVB4uaYZ1TMKIdD41315sJ/KPR1SuB6+8CLlL50N/WRcWi9daYS827/ZvrAb0Orx3tRN6U+Q3tYZfJtgV603bNYCwxuvyJMYyFuBmK8zsMLtgEQ/vH1EpIdLkjrl2WaAgEQ4eQy6170HqFRS6lzsaKQOJx6U8+yU8EH193FZwopjOX8YfD1zFEMDbA1Djq4shaqM5VV+4lCn/1w9UEI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB5859.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(38100700002)(2616005)(4743002)(38070700005)(66476007)(5660300002)(316002)(66446008)(64756008)(186003)(6512007)(122000001)(66946007)(66556008)(8676002)(4744005)(2906002)(26005)(6486002)(76116006)(6506007)(82960400001)(91956017)(36756003)(508600001)(86362001)(6916009)(33656002)(83380400001)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NU5pZHZnbFpkRmNNZHJjcTE3NzZqdUZHQTdqcEVMSjIxc0U2TFlJOUoxa0RD?=
 =?utf-8?B?aUc2YU5VMUsrTmtZZkMvUlk2V085bzBLeTAxRjdXTWtwWUpXT3cxTHVKeGFJ?=
 =?utf-8?B?MjJMbmhtcThvOEI2QjVRUDJ0Mkpzd3QwcC9GZ3JZZjVyajZ1eWNnUHh1MExs?=
 =?utf-8?B?M2JRckJLL1V3YllzWm1BUUN6Z09KSjlmRUpRbVZONTUydHdxRU11M0NuaEha?=
 =?utf-8?B?M3FEMW93dE9MaC94c3QyVlB0MlpxQVU0YUhHNERXRTc4ekxyalJqME1jV3BU?=
 =?utf-8?B?cWRud0dsYUN3MzVjb2Nudk1XUFhXWlJMbmFIWUZjRGFXWHhRN0JYTGF5ZVhm?=
 =?utf-8?B?cTFjV0tLRmJEN0ZpUGVKYlBqb0VkQW1tYVA5blJqM0lzaFZBWFAvS1RMaWFO?=
 =?utf-8?B?dGdqREhGb1A0ZjBsbzRGeUV3cC9ScXQ3ODRNVUYyL1RHWWZpV3FSSGY1Ty9u?=
 =?utf-8?B?RUkrbUdxK1FaZTFyTkExa1U0T25TM2FQTU53S2xObzRGalV1RlpIZzN6QWR5?=
 =?utf-8?B?eVE3L09ZWVR6K1pNK202M09wVGtLMEMyNnkzVlQzRjd5b1AwT29iYnZFYk9p?=
 =?utf-8?B?b25UZzMvYnBEcDFaZnVwK204c1pYa3AveHJtSlBmd1pXU21TdXFYY1MyRG1a?=
 =?utf-8?B?c1JvWnovYXY5YXFIYXFtQ1VydE13Tk9IL0Q3VGc3cU9mMFp6aUdkSzI1L0VM?=
 =?utf-8?B?MGJlVmtZOTRqdlBzRytucHJjdzRoa0xJVFRsNFNPRFo5dHg4WU1xV0VaSVFa?=
 =?utf-8?B?OER3WGViUERId3BvWXFnUGN4Z2U5Um0vZEF1ekQrNUovblpRTllDc3RUZlpH?=
 =?utf-8?B?Q0FHK1dyK0hJZ2ZmbjJwSWdvN200STJCQXhwZXBVYUE0cFp1aWhWUWFBdUov?=
 =?utf-8?B?anBWRkF0cm45NHdnSU9YNW9oaHpiM282aEhLVXNyTll6ZlhtNDFuY0VRaVNJ?=
 =?utf-8?B?N1hMZFJmWXpKdkM5bWtwY3pQMnBhb2doVDRvbUVJZ2xVM3dtcnE3cTVEN2Fy?=
 =?utf-8?B?V29uR3ArUXhyMnJqR3NidjlqRHgwR3lpV2ljbWpXRzVIclRHWTkyNHFnbU9W?=
 =?utf-8?B?Nlgra25acHB5ZFNhc011L1dVemxwdDd3QkxhZjF1VCtZMVNGZDFFb3pzZ2N2?=
 =?utf-8?B?Rk5uSDlON2VJVDVpM1A0cnl0TGdrODJJZ1VZUzdSbGZBR1RxTGNYenhEcjV5?=
 =?utf-8?B?eFpoTEhBRGhrTEJKQStpQjZIaDdrM3RMT0RjRHNUYkZRdXRNakhabVpnVC9F?=
 =?utf-8?B?VzRwMHRCM3lXUmQ4OE5OcjlMb1cyU21pSGxRbnBWUDVLZC9CNTB1bEZJemIx?=
 =?utf-8?B?TGF2dE5nSmlWYitPNFR5b1FLeHU1QVJWMklwMlpBR1Q4QXFnZ1BhaE02MmJ6?=
 =?utf-8?B?WHhhNGxKazFvQmE3NDN2b2RvTGpKT2dOOUlaR2Frb2F1c09KZmovL2llS3ZU?=
 =?utf-8?B?ajgycDdIclY2SGJzSU53cVZzUUU5dVIxalQ2WDI4YnZVRk1XckJzbW5xNVlE?=
 =?utf-8?B?WDgzNFpEaGF4SkVyb0ZBYkVuaHhBTkEyaHB1Yiswc0FRRFVDMlRMbUZBTzBv?=
 =?utf-8?B?cERITXcxRVJzT3lkeE1HMm9DaklyZ3JpUS9JUmhyLzRRK1EvZFF0M1FOVmZL?=
 =?utf-8?B?OG9iTS9oVjJZSFdrbGFyUCs0eis3VURCcjRHUkRrS2JpcGJHSis1Q0pvQjUv?=
 =?utf-8?B?aVpTQ2plSUtoa0VWZG9DdGZLSk45S3F2RUJYd1lLYS9WYXdnTklTMVdvenFP?=
 =?utf-8?B?REpDUUFkSHF2TmovK1Radis0T0w4djRuaE5ZdDlGdFM4OFFwUC9sU20rWFp2?=
 =?utf-8?B?d25pTUFrWlJHUGErdDdkNDI5cE5EVTFINEJKS0F5cDVmSzgvdzBwYkhSUzN0?=
 =?utf-8?B?WTdJMms2ZEY0RzJNY0h2dUhDLzliMm5vUVpiZE5NWDBFbHo5TXR0YWl0R0xh?=
 =?utf-8?B?ZFRtaTFIdHZuUTdMMkRySWFYVHNDYTdOOWh0NkphQXE5T2FpSzZmeGpLV3RM?=
 =?utf-8?B?R1BZR0NtL2dwUHJOU0dlN2hla0NOSVNuaFZTVUpPbkRLTjR1TGRVNGhpNndJ?=
 =?utf-8?B?Y3RjcE4yYVlob3NNbnZmSTFRTGV5ZUpPcGlDVDN1WDA5VnlMN3RMdzZ1MHZt?=
 =?utf-8?B?NFlHSmRoUEZjWEJBRDJvckxqNzZvUjJEcG5sWTVmVFYrUVQxZVpuTm14Mm5L?=
 =?utf-8?Q?j/ZjnO8Pa9obuEqw5OIgLvc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0ECFB6FE4F3A9B4297C2CBDF5FA8E8D3@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sap.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB5859.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac0e32f-afa0-4ea2-62ee-08d9baf504aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2021 09:19:35.7196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 42f7676c-f455-423c-82f6-dc2d99791af7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pn+bB9yskdWxCCVC3IXzWvVK2bBx1/hSheuppgM1iAdwHZQtB7Oz7zGgaqFJaSJk0rqMiBlzGiP95wc2RtdZfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB7012
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

SGksDQoNCkkgd2FudCB0byBidWlsZCBhIDUuMTAuODMga2VybmVsIHdpdGggUlQgcGF0Y2hlcyBk
b3dubG9hZGVkIGZyb20gbWlycm9ycy5rZXJuZWwub3JnLg0KDQpCdXQgSSBhbSBub3QgYWJsZSB0
byBmaW5kIHRoZSBwdWJsaWMga2V5IGZvciBGMzk0QTQyM0Y4RTY3QzI2DQp3aGljaCBzZWVtcyB0
byBiZSB0aGUgcHVibGljIGtleSB1c2VkIHRvIGNyZWF0ZSB0aGUgc2lnbmF0dXJlIG9mIHBhdGNo
ZXMtNS4xMC44My1ydDU4LnRhci5zaWduDQooSSB0aGluayB0aGUgcHViIGtleSB1c2VkIGhlcmUg
aXMgZnJvbSBMdWlzIENsYXVkaW8gUi4gR29uw6dhbHZlcywgYnV0IEkgY2Fubm90IGZpbmQgaXQg
b24gdWJ1bnR1IG9yICBvcGVucGdwIGtleXNlcnZlcnMpDQoNClF1ZXN0aW9uIDE6IFdoZXJlIGNh
biBJIGdldCBhbiDigJxvZmZpY2lhbOKAnSBsaXN0IG9mIHB1YmxpYyBrZXlzIHVzZWQgdG8gY3Jl
YXRlIHRoZSBzaWduYXR1cmVzIGZvciB0aGUgUlQgcGF0Y2hlcz8NClF1ZXN0aW9uIDI6IFdoYXQg
aXMgdGhlIHByZWZlcnJlZCBrZXlzZXJ2ZXIgdG8gcmV0cmlldmUgdGhlIHB1YmxpYyBrZXlzPw0K
IA0KDQpUaGFua3MhDQpWaW5jZW50DQoNCg==
