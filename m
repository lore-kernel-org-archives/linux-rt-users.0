Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15DDC61DA4
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 Feb 2023 14:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbjBVOfz (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 22 Feb 2023 09:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjBVOfx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 22 Feb 2023 09:35:53 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931593B0CE
        for <linux-rt-users@vger.kernel.org>; Wed, 22 Feb 2023 06:35:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qk4UNXirWjf2SKR5GHBDYRXWsTM2eggxiUD7+OsgyiwTzH3z4vtABVI1lPaRyw+j5+2yAWm1l0pSOnPYq5KHdpYmAD5LZ9lcGzrB/NYdncSwQX0IEsWW3Y5mkTCaWFxSZE+vHQS/Fpiav2OZL0ULK5sjpCmeEROZRZLcz+pGiPf29pCT3k17010F3t/dCgoB+ZNPwC8v+/SQojYjWm0HzNYpvmU3GQks7vZGArHY/7s33spEYzg/MgEePpQB7LnIRmvctE97+36T0WJQ9AaN57Fnc+TZJUlNXPcSQB0qoHGVSxYz9fxHSSOw6WHHV070Wcaz0o9UAdrAeGzYRW3NaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gPsw6XPrIsXyRjGalmSdEQXXNpMn2YKsI3wP3kX4V6g=;
 b=R+Pd/SLYNcI8+Pp/j6C5gmfUZ9dUBbFm4vMoE30o+PeBeuUz1s9fgS4v1AwoHZZnqvhf1AsVJL/cd72DUCU7OMQtd6JDdZAm5WSVhwc8U8vRLmHr+/87MVI+5Q3Av/DlMgvNqyDw3SKQXO/5eYL5zwtxEeBNtEGcf7Xn+7ThmOEuprw1FaPyoLRaLI97YOO7C96vrdXJjoBCZQb+jP1kY5LWkygGThVF9pcUjJmydaWmywKzDrdfPnpUKPAWf4IC84LRe+B5ripFjX9bMuvStgUxJxpE2vGICgGS9XppXBY/v84i42aM2O6mP8cClI3N3CRSVOOK45u/877IER33Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hms-networks.com; dmarc=pass action=none
 header.from=hms-networks.com; dkim=pass header.d=hms-networks.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hms-networks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPsw6XPrIsXyRjGalmSdEQXXNpMn2YKsI3wP3kX4V6g=;
 b=rLjj426f68AK77oobUqoMd6HLcJl+ljNMGTpFMmJUhfREny7Rgzb7rfasJ9DfF6njZaGEoui+BG1lc3ppX6RCX/9C9vANUclJZTWDMrMi1M3i6HQWBi8YqJ4dw6JuNRr9WANxBoTugiyS2GA/qtXXTyqfvdWyFKzlMCheG0rjlyM63lwbat2xXmlg9cilkxGSssUgBxgFe+qCer1QaFOQCabxdVbSTcYLdQ7xvYZ2AgAkUCLnagROayDBgosgMFdv/72wsmWEie2CM5WefgMv9x3dwxg9EyYgZ3+XK/YHKX8bTbEhsPYX+9clRYEkZui5IzGiUMZMTgPo7T1DhEG/A==
Received: from AM5PR10MB1620.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:206:1d::23)
 by AS8PR10MB7304.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:614::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Wed, 22 Feb
 2023 14:35:40 +0000
Received: from AM5PR10MB1620.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6daa:d5d3:8e44:2b3e]) by AM5PR10MB1620.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6daa:d5d3:8e44:2b3e%7]) with mapi id 15.20.6134.018; Wed, 22 Feb 2023
 14:35:40 +0000
From:   =?utf-8?B?QW5kcsOpIFByaWJpbA==?= <Andre.Pribil@hms-networks.com>
To:     John Ogness <john.ogness@linutronix.de>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: RE: [PATCH] printk/console: Enable console kthreads only when there
 is no boot console left
Thread-Topic: [PATCH] printk/console: Enable console kthreads only when there
 is no boot console left
Thread-Index: AQHZRg/hPmOt9aMXPUu8taZ8CBlV867ayUDAgAA9cZA=
Date:   Wed, 22 Feb 2023 14:35:40 +0000
Message-ID: <AM5PR10MB162067C2D7F2A11A1AA950FEBDAA9@AM5PR10MB1620.EURPRD10.PROD.OUTLOOK.COM>
References: <AM5PR10MB162013648CCFDDDC4EE42A3CBDA59@AM5PR10MB1620.EURPRD10.PROD.OUTLOOK.COM>
 <87bklnro9j.fsf@jogness.linutronix.de> <878rgrro4z.fsf@jogness.linutronix.de>
 <AM5PR10MB1620492AB35480761F4F273CBDAA9@AM5PR10MB1620.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <AM5PR10MB1620492AB35480761F4F273CBDAA9@AM5PR10MB1620.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hms-networks.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR10MB1620:EE_|AS8PR10MB7304:EE_
x-ms-office365-filtering-correlation-id: f2412b96-74ca-424c-1070-08db14e21250
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2r7QMPMU8ovMmaKJI2sxWA44S9K62JH3MFZP/htYyQ70+PGuhJVGeQos4vnr61RWtcSfsr+kPKOuQDVQWbnNzPvUEKaWCcPqWotUtbvNBoBINpvBgOx8WQfd+r4uPkOiGLHBJyScmiX4tLUQVdQfHOg+m6CFcUUNy93DiuzgHCudQcm+PIRIvpwPdnxQcf7Fh7csbGzQMd6/wWzIEIZ/BC6/d/XK0HLOpmejgAwxZ4zPxG86HWEoYQALivaVWFWcQfIuR1NedZmrG5nl8IgbznhDzADa/ylDJ5fYSYdva5sI+wzH/zVgRy7fjOW23z3p78s5iJMkp/TGtoe24jP5z5AMnuE/5Y18JtqKs49oI3cH9Aq0Dx4TTBa0a0C0nqFs/Y1tWHB+BJ3v9z3PJBRCaNxx7HHbaH6qfLXGdVS51IRRAfB/+2LNdTkl3/c5r62nEq/UYCufgG1J2wV1j2/PHRiDFK2fkX4rFj3YlxckCCfGmgKJ0HNXxmhRoMXGLySHQxo+S8n9Q17KTFOd3CapcVkLxU+qZ7c0W+q984YdDSi+vAzwdSG+dPZFgYXG8zcwWpF+l1XCsJLDMzh16tglGVn7K2Med89H2WGZjXJOFzy7UUpnJp22sHCZWRbqNGQu5XyMAETVHfLS270vrCktXgKW8vI6MNqZUt9USuVMzlkLej2jtRAGVHGtsCcpRr/kJpnQESiYR06p3KPImOIt1A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR10MB1620.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(346002)(39850400004)(136003)(376002)(451199018)(122000001)(38100700002)(86362001)(85182001)(33656002)(38070700005)(52536014)(5660300002)(41300700001)(2906002)(4744005)(26005)(186003)(55016003)(9686003)(2940100002)(6506007)(316002)(110136005)(66556008)(66476007)(66946007)(71200400001)(8676002)(7696005)(478600001)(64756008)(76116006)(66446008)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z21NKytqVFhiV2VzdHhwMElRREd5ejYrTkVJS252L1JRM0NiVnBLdG5GeEdo?=
 =?utf-8?B?OWR1b3lJaDg2RzVxWVJFN1ZUb3U1TGgzQlhyeEN4ek5NMklJQWFIWmpmV3Vq?=
 =?utf-8?B?WFJRdTlPS29BWG9CSUZmMnVzQWhqS2VBL3NhTmlXVTdsMURzZnlPekFoZkRJ?=
 =?utf-8?B?NW5HNWxaTVF2aDY1Mmt0b2JRMW82RlVUUEZxMzhSM2oyTjBGSlhnVEJ4M3RH?=
 =?utf-8?B?STRwTi8vdEZUaXpVZHduYXo5R1lFNEJnNTl6bCtPNTRGZVhvLytoZ1V2alVy?=
 =?utf-8?B?SDVzYWcweThaYXZlNDdnOHg3Q0hDemxzdVhuMDNOeUVBZzBlaWVvaURyMGxE?=
 =?utf-8?B?eldONnRRN3ByOGFBR0todzA2d3RqdlhNdWV3S3VoSktBTHg4OWtnR3JsTzVh?=
 =?utf-8?B?RmJJd1FkdjdobEFWeFVuVWF3aS9rcyt4MHZWTnhjdGlXT2NMSm9SWTVmU1V2?=
 =?utf-8?B?LzdGODkxdkhXeUw4UHROaGUxZ3cxQzQwdm1hU1VwYlMyVjNlQjladzU0WVZD?=
 =?utf-8?B?ZkhNTWc4SnNqM3NWZFBsVTMxbjRndnpYcWk2bEd2a1VLbHN3cVdzdk9sVnlX?=
 =?utf-8?B?Nys5Y3Yrbm9jcDlHaVo1dDRPZGtGc016U2FLdmhJQm5zOWR5ampuS05rMzFr?=
 =?utf-8?B?akZIOUMrbkpxa1N4eG1aYXh0SithdWd1dDVORVZiNTluWVpBQnhSVm5mNjQ1?=
 =?utf-8?B?MFlQUjFIODdDU2M3aFNVSG1TanMxUnRiT2RRaW96Q0xDakpFREZGWTYyRmJn?=
 =?utf-8?B?LzloUGdQSC9ZWk1sNlVNc0NSTWxzMk9hMXp1d3RpNS9uNE5iK3RZV05BSmF3?=
 =?utf-8?B?dTNyNXEzSjRFL3hmeTFBUUd0cnYwUEZTa01WK2cwSm02S0dTem82OVpjZTlH?=
 =?utf-8?B?emZ4RmRmMGt6UllkQ1Q4NEZkcERkRTBUNXBMemNXWWsveXpDbks5bWloUnow?=
 =?utf-8?B?a3N1blcrWmZpQzErL1BpeVFzZ3B4WEoyaXAxSGhieHZieTVXQ0pVUGgvMEVX?=
 =?utf-8?B?eXQ2NG5sSmNCWkFteEFPaHlPZnZVTXIyTkNJRVo0dmkxV1pDejM4aU82azFO?=
 =?utf-8?B?TVlESzVNcVM5NjdUT01TVWlBYU9DL0IzcUZjbGg3YmlCWFExRVZiL1RzRThD?=
 =?utf-8?B?R2tDNm5NdTBFWGRLSlNQTVZlYW9Wa0hEZnpqdE1XMVdsSEJMQlNxVTJmMUpC?=
 =?utf-8?B?WTAvSzZiQk9KdU9MTFFUS2RJV28vajdvait3cTZUSzc0Z2d0YmZPS0h6dHYy?=
 =?utf-8?B?K09hYkhkbzZHaXUxbkwyalFubFEvcjVoWk94bXcrSStwS1U4SUJyejdrQXNU?=
 =?utf-8?B?Q0VERjZFR0QzeHRDMjl0UHpwNUJyUFFlTGkrN3RKMDBwVTB4aVVLME5CNlV1?=
 =?utf-8?B?d29KczFRUzFyZWpXeS9DYnhyUWIzT01USE8xNitBVlpnTGN1OVliR1hjQ3Nl?=
 =?utf-8?B?YTNIRFpMNXd1dWV6OXgvb0ovTDNDeE8vb3JsMVZqcm5oc1B5SW8xRG9qNmtX?=
 =?utf-8?B?MVppMkxWUEpnRndqV0hhNGJHTnVkbEdBVURJVjBlUFc4LzRFa2laWis4YTVy?=
 =?utf-8?B?OVVnbUIxQWp6MWl0b0NyVlpwMXpHL0h5TE1uUXlZMVRMWVg2NzFxVDRRbGNt?=
 =?utf-8?B?VFR1OTBpVlBPVXNVcVRIdkhUNXhJbjhpeWE5c1oweitoQTBxWTNuQnkwdSt3?=
 =?utf-8?B?L3NmcnVRK0syWExSbURBL3BDYjR6cnNtTE45anVMTDZNQ1RJRnVIZjl4dDY3?=
 =?utf-8?B?Szl3WTIySytOSnZIbjhkVE1LT3ZCdDlKVituOXIrOHpxYlJmZS82R1BpbUhZ?=
 =?utf-8?B?Q0tMdjlTOGticTNWK3ZkRFFnN3E5UzRpMEhwSWFvZm1XS2pOTDAxdDFwSzR2?=
 =?utf-8?B?cWpnbGprWFlrVjdoQktuWlNSdGF2azNqaHVRT1BocVIzYXBZcWVnZC8xUjVW?=
 =?utf-8?B?S21DRHMxeXpUUHFXTmdGdEhIVW5zVmNaVCs1WHpUTFJxR3pybzM3TGtMUS83?=
 =?utf-8?B?cTZrZlI1R1M2NTRuWEtjd1dUcUJ3Y2lYZmFnZllEZ290OGJ5QTlJdjY1di8y?=
 =?utf-8?B?SXZyNkdRb0VldSt2cHdPOEgxT1NNaWRCTno5d3FORm9KMTJJWmx3STFONzFH?=
 =?utf-8?Q?t+KQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hms-networks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM5PR10MB1620.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f2412b96-74ca-424c-1070-08db14e21250
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2023 14:35:40.5146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7c1590-4488-4e42-bc9c-15218f8ac994
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s1OZ+6Hb6DCe1sXmFQ4jaj4xHnukuDkWhTlqx2W4r/EyK2ymz4PYrVdUR8UN6vWf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7304
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

SGkgSm9obiwNCg0KaGVyZSBpcyBzb21lIGZ1cnRoZXIgaW5mb3JtYXRpb24gYWJvdXQgdGhlIGlz
c3VlLiANCg0KTm90IHN1cmUgaWYgdGhpcyBpcyBqdXN0IGEgY29pbmNpZGVuY2UsIGJ1dCBJIGZv
dW5kIHRoZSBmb2xsb3dpbmcgd29ya2Fyb3VuZCBmb3IgbWU6DQpJIGhhZCBhICJzdGRvdXQtcGF0
aCA9ICZ1YXJ0MzsiIHNldHRpbmcgaW4gdGhlIGRldmljZS10cmVlIGFuZCBhICJjb25zb2xlPXR0
eW14YzIsMTE1MjAwIiANCmtlcm5lbCBjb21tYW5kIGxpbmUgcGFyYW1ldGVyIGF0IHRoZSBzYW1l
IHRpbWUuIElmIEkgcmVtb3ZlIHRoZSAiY29uc29sZSIgY29tbWFuZCBsaW5lDQpwYXJhbWV0ZXIs
IHRoZW4gSSBkb24ndCBzZWUgdGhpcyBjb3JydXB0aW9uIGFueW1vcmUuIA0KDQpBbmRyZQ0K
