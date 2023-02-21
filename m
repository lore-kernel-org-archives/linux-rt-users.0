Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BA0C64EC4
	for <linux-rt-users@archiver.kernel.org>; Tue, 21 Feb 2023 12:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbjBUMi1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 21 Feb 2023 07:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbjBUMiZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 21 Feb 2023 07:38:25 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2077.outbound.protection.outlook.com [40.107.105.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2355916313
        for <linux-rt-users@vger.kernel.org>; Tue, 21 Feb 2023 04:38:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TzV4ofc0P+g8kn2ec7dBYktg7p999vcYQdwNYgeWDC+AnQIl4zefayUEgiCwQWWKeN3vLsF8V4JjwEQb2K4gSXljHYy90+r8ctTZmuZAIORzenPjYxSZ3EXd4h0kf0aAJWVri2lM5Mio4tFC5qAoKbebh0xZN1kC6Qu4Ty3oAerOk0Fd2wsGFgvDUHHiaxJVI4h02pX89kxcHst1qz+E+WKU75XwIMu+PXuMwFgwlQIa1flgUfJnoNl/8N79aLH1kPxIFQhQkCKg4p9y05y18NsETDTBjKT/JBOHfs2BjQ523NlfBRUiDgDqFg6oNSrKR17BMJy+6eR6d8b6OoLGZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VHtt6rwiXsfhH6/gIRV4fIyATPE5KsyqDfEKCbOu+bQ=;
 b=Kri6N/4t9Y5gx04FWBPLBHhiwuZTdbzZeFn9hKmgcUosXRvCkUGcmaSU0Wx2xPLw3mKCzAi4Je31UMUlGhFJuG6kp2jF5qf1nIMiUWuupINxZzDax5oHssJFixojrZfFQvETadRPuqQI0Ts1ORxBbHY6qwQAw7+hdD6v7I1saKeEPrV1vtb+q46f4GqtAYULIrxm7caB7CnhXQUhB8MMq7F2HA+RUQtwJpHm87kAfhsKzxxeAgMZP35oIrSbVJcHhhEfOPS7qiV+jBGISzuRo3DD2MoCtupw+Znb2ShsPUXYBAva4uYELn3h8/Fw2Fu4Mcdb4ZysA8HGAuaj8LtMAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hms-networks.com; dmarc=pass action=none
 header.from=hms-networks.com; dkim=pass header.d=hms-networks.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hms-networks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHtt6rwiXsfhH6/gIRV4fIyATPE5KsyqDfEKCbOu+bQ=;
 b=h53pfQ1B3a85hNR4VVJ5ygwscoYVb9P11uqv6qT9/uVivJTMpGuvB6luXbWKOxYxSlSbGkyDgnErejEHG5Yn2DQWL/AwBOpryCJa5vyhITbvX+t6xTRr7nsctN1kLnNW4t7Mb534YIl8YyJUZ9lG4uB00GybsZKWbfJiixlp/re0umT0guAgNI0zYUvWAT2t4QnX0NPpD4+p4fSGONbph5z1KRH9wJYXaS0erjE7I5XLWvOKyGWSSPW3up4im81LpcZEFIl1o/HRR7ocOQzOa3Ge5L2STQJfb3K7FBsd1XD756T7c2BcyrGx6Vtuevc3mY1bWsxdRBxF0COgLuUmJA==
Received: from AM5PR10MB1620.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:206:1d::23)
 by AS8PR10MB7683.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:634::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Tue, 21 Feb
 2023 12:38:20 +0000
Received: from AM5PR10MB1620.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6daa:d5d3:8e44:2b3e]) by AM5PR10MB1620.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6daa:d5d3:8e44:2b3e%7]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 12:38:20 +0000
From:   =?iso-8859-1?Q?Andr=E9_Pribil?= <Andre.Pribil@hms-networks.com>
To:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
CC:     John Ogness <john.ogness@linutronix.de>
Subject: printk: console output corrupted
Thread-Topic: printk: console output corrupted
Thread-Index: AdlF7NJjEgsDT7GFTPOhv08khj/Agg==
Date:   Tue, 21 Feb 2023 12:38:20 +0000
Message-ID: <AM5PR10MB162013648CCFDDDC4EE42A3CBDA59@AM5PR10MB1620.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hms-networks.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR10MB1620:EE_|AS8PR10MB7683:EE_
x-ms-office365-filtering-correlation-id: d266e746-2a96-4535-5794-08db140883e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: krZ4OiwmGYjjbMp5HoAb++3Lc42hpCM01P57yeU92/S1zrmV2sJGWycuSUOpVHII2gATXFkLnEbVDFpFCx1JqdE0ADUxJBD0XeD1027Rc3fCk4Hvs4UPmeVOuuEzDtnXT0Lc6PxmBFGGH5mq8TytTtwSBR3SThVyJfjf2hC2tvHJ4rdz/42jsHHRAXWHYUXl6FYnw5Eg4XvPqw7Ff1GYn00ENbZeCn5eGtsluV7jTNZs5mu8HlyyV1igNQ39icYkMELilS18Yqvk9sp9CoH40Fjab02s4eCuSYPxVlPg9FJJiWCFSQrhu6cSIc5lNxcPcmmo7Iay1BM6xQXYcaa6+mRWmXNxeu9ZIviP4T/6eLWvzBaTM4L4UP5ZphCp3IZHBoOdAPtfkIWD5XbRj3WZXOWER5zG38eMCgC55D4ChoBnEOswVCHlYS7BenxNR74lSa06+A0zp95Xxet+NPYg81VvfTfcWrdLRc5gmiP3efxIw0oRof0vlhPij+TArYHgF5J7xDfwSDueyMS0URYE1oFgvO5eAcujKpwvb8ouzY+6cBVzz2EDEmokXM7ZIdo72HCQBQARYu30lSVOPDSPp0c7QYXa3BxSLxLq8DyS+9xm66pCBQMi0hjMIu0n76JF629Knx8ayq+VCreteRvNgc5i+9XqM8+bl1SdQSfoYpLRxS3R/SPoFZHF+11HWcA2bvY2wunJ9Q2wX9MNsfl2q1bS2ipGYEQLxdnVFGQov1QqL5/alvdY6ku2vMfFKrBL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR10MB1620.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39850400004)(366004)(396003)(376002)(346002)(136003)(451199018)(186003)(26005)(9686003)(38070700005)(6506007)(2906002)(86362001)(38100700002)(122000001)(33656002)(71200400001)(7696005)(5660300002)(8936002)(66556008)(52536014)(41300700001)(6916009)(4326008)(8676002)(66476007)(66946007)(66446008)(76116006)(478600001)(64756008)(55016003)(83380400001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?syDu9Fe9EXMplJHSHKkn5yHalchUm8qaXPydCrP1goU+Y+ElAw/iSrRRWV?=
 =?iso-8859-1?Q?vjNLV6XQM1B1CLcWimBOZgQwSYwYFK7C2qEmhelFzm4Bsn9yax8lpRVFrw?=
 =?iso-8859-1?Q?SCn2OJxxhtN7Q+Z0cmxcfCC82Y/ElM5eBe44tk75Bezapk2K1080ZZ+e+P?=
 =?iso-8859-1?Q?J2oD6+AjwrSIE1bg1U+1Oejw0CfctWM588/KM0GHlsJMuzCNT7uj59r52H?=
 =?iso-8859-1?Q?sV4Xh8oogvacFFmto+XdQ41oQHOZ3QJUYAORl5jUssPqNyh3XJEGGWMGb9?=
 =?iso-8859-1?Q?07wLfqU5KyMJPl7cX6UTzf6Q4RE+6ArK+89ZBHv1JQodW4Hson16EioaSN?=
 =?iso-8859-1?Q?X5i/y5X4GvSe6UbZNbRJ8dlItCG2QY/YFoG2XtyNXNd3isIA6JJmPHRQPD?=
 =?iso-8859-1?Q?uslvdPbX6y6agKDHLfD3bZRk2Fqmu9E6CWsVZMx4jUEVhWQS8bjUXtM+Du?=
 =?iso-8859-1?Q?EsjD38I+dQU26azTHqXlg9J8euKnhpn39CzEKibvDo0IghOP/+CX5sz8a2?=
 =?iso-8859-1?Q?XpTvVUn4CepNO0oi6CsyVBDv+a9tF/8ZoQ8BhWume3uYEgfk4EqmeqpHyL?=
 =?iso-8859-1?Q?1IgmZGoDYZCPGvhE/+vY+NNAibi+WeR/7Dn2dnq4SRn0gZxb7aftuol+Ji?=
 =?iso-8859-1?Q?Tgm2+GeM+YxZJ2pfctbsCm0BupxRCRp0L3t80vJvCZpA2yjJiIkLujkKy+?=
 =?iso-8859-1?Q?4CPVgPNinzLzTgSpdcpfU/ebwinDw1pIvMpt9I5pkK16Oid/3m83xuPJ0c?=
 =?iso-8859-1?Q?nGDiw2mLfqY2TwRYc7gNTESj4Vxem5zRcZgcmn0Ce6+yEFrJWyHvfefDTg?=
 =?iso-8859-1?Q?qfGohvvZoLkQsUmlbrQmOtdzASqx8bC9Mznlsl/DIUe9SWl0n/asMg2/xe?=
 =?iso-8859-1?Q?I38gI+faq1pvRLCekTS7lN8jRKnAjer8YVPJ0K7PzlfU66D3F9/16z2IJT?=
 =?iso-8859-1?Q?mKnPXDHr6EsEh7asskqyA9QhZQBmonDJpBLeI1jTNS5P1iOl1avk5wXcEs?=
 =?iso-8859-1?Q?cTuPpmUsPa79A155l0tpAyXJSBkYYKcDxPLLTTmcDB6paDR38jAVxWuNfx?=
 =?iso-8859-1?Q?DGF3wEmcB0ayOIl8JhO9XKp5RYRqOu0+vP4gIizhVyOAuIdsVM47QYM9cl?=
 =?iso-8859-1?Q?fMpufCOGcrGNJlGYgzsTqieseJ2LuMfObGaPnKKzbzWKCqvq7YALHq5FrV?=
 =?iso-8859-1?Q?txfuFLWvp08eHzKZfh+UF1AOG61HD/+Uvosg/KUDCBCUkeSwL/Hvb0Sj/p?=
 =?iso-8859-1?Q?6+iH/7EQrf3hnBy/UiTBSvBR6hnSuR9WnSaMzTcQ7YOY9FO9OyzjtoKLLm?=
 =?iso-8859-1?Q?9eu1MLcmiVSEuIdxoG5DE8mu9ptfafeNtIDKDpVfExF4P1FNh1ZmbP6aSg?=
 =?iso-8859-1?Q?uBncxOGIykUpa2WuFcfkVv8w+JSv13xrrsl+HDqnJbcerBy5w/Fdq/ZRin?=
 =?iso-8859-1?Q?bGG6w6kqCUIEEUsBB4fAi1j+/9DRpVuI0Fh2IfH5GgQKhtalR/uYc22uri?=
 =?iso-8859-1?Q?1U3j2GXLgduNAVAbb+a7JIW9okPUaD2Nx3iWaIfBqNrG1LfDvjd9U1kDkn?=
 =?iso-8859-1?Q?a+KDFJGZ5qdpxODD/NRsAnMTDVvMNKdiqklO+K/V/BMx6hAiu6ygbOMmPL?=
 =?iso-8859-1?Q?JvYzNYWM71Lik=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: hms-networks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM5PR10MB1620.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d266e746-2a96-4535-5794-08db140883e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2023 12:38:20.8171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7c1590-4488-4e42-bc9c-15218f8ac994
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ovDSFD4zaUsuwC/Uy8DRFxQIOt4kZIeBA/62KBpojYo/0ET/MtGJsOkwcORPzXMB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7683
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

I'm using a IMX8MP board with kernel 5.10.165-rt81. UART3 is used as the co=
nsole device.
When the device boots the serial outputs on this UART get corrupted at some=
 point.
It looks like only one line is corrupted. However, this line often confuses=
 my terminal, so that
the lines behind are also not shown correctly. A reset of the terminal fixe=
s that.

I could not figure out why this happens, yet. I only know that the issue do=
es not occur
when I remove the preempt-rt patch or when I specify the "maxcpus=3D1" kern=
el command=20
line parameter. I also tried to enable/disable the "earlycon" setting, but =
this seem to only=20
change the time when this happens during the boot messages.=20

When the boot messages are afterwards displayed with "dmesg", they do not c=
ontain
corrupted characters. Therefore, I assume that the corruption occurs at the=
 UART level.
Maybe some lock issue and therefore some concurrent access to the UART regi=
sters?

I don't know how to further trace this. Any help is appreciated.

Thanks,
Andre


