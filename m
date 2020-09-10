Return-Path: <SRS0=yywu=CT=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E827C43461
	for <linux-rt-users@archiver.kernel.org>; Thu, 10 Sep 2020 02:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6D5D20C09
	for <linux-rt-users@archiver.kernel.org>; Thu, 10 Sep 2020 02:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UarEVr9n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgIJCdF (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Sep 2020 22:33:05 -0400
Received: from mail-eopbgr80075.outbound.protection.outlook.com ([40.107.8.75]:29869
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730634AbgIJCax (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Sep 2020 22:30:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/pXSkcIM6rWD+kcch0H70nPFz3Dk7uB4myO99Py/momFS01tqmXPAVVOA7izdakNuAGA9axIjH5MAi9CinbfhapCP+XdSe/RKoh9VV1PxmcEA+EPuzuDxkIq1uGb1OS1AJUn6TjRduQBO3mjuUUP0Ij7afQqlNACf1uptZoPI9Fgs6j6NeCiyfJoLCG44FZU8ps2LRob4RtkQmyh9LC4y5EcgiRC0KFsK2jP3Ftc9y/tSLsKmD8k/+7eQsh+x/YL6yn2xFMps4PY3FmXZCEHjkI7Jt9lMM/9YHYFlkQ90nU/AVQZvEcrmC6vUFihIbR7vHlpzFda0oeSasXmZNZwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ragtvvEZhMhTHcnUyly5YrqrUbVOsN5Ae3DkGYSbKfg=;
 b=Rkn9b8UKZIbaUqB5+ExCaxRSgtfom9iZTiVt30BIpLu1SPgX4Bg4mAwn8/FfKOvNhWbw5852m+i5VZokCeEavMDi4CzPTl0D2sYvhbQRs1h5i3IbAZKcnioEGwb6vMFBT7EEG5U2cGS26I5Etna/dL6L4pvwKPQC19npsX+hq2HkhtBbhc3k/Nl5QEIO7qrsMwmxEnlEs/G955mUJKAq7YuMqPsHzG/gYrYAvuHhgeTbF/NJfkmJJCrY04lLzP1eEwIQV3lbb/VsnTlOs6/Z5JI/U0Px1gpj5eiQh2X9H/zAFvpi22R8/Qk/iIe1hXexHmcoIgI5q3c7GOSolsgX7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ragtvvEZhMhTHcnUyly5YrqrUbVOsN5Ae3DkGYSbKfg=;
 b=UarEVr9noXEqyXeHF8LE/6DdNVXsZ6xFc7ezfRshU7W/yMXtDpcYeRPSMKuaanQ3T+C6GvYB5YXbmqwQcoX5vBLBAHKgdvplED1RwJYM1CTXW9jZ7RspZb6OjzaytSgn3I9dBx20n2CGsZl9+OLBdxkGsiMpoBDzyOSyE0dzX2A=
Received: from AM0PR04MB4772.eurprd04.prod.outlook.com (2603:10a6:208:c2::17)
 by AM0PR04MB3954.eurprd04.prod.outlook.com (2603:10a6:208:63::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 02:30:49 +0000
Received: from AM0PR04MB4772.eurprd04.prod.outlook.com
 ([fe80::b00e:440a:6ac6:b3c4]) by AM0PR04MB4772.eurprd04.prod.outlook.com
 ([fe80::b00e:440a:6ac6:b3c4%3]) with mapi id 15.20.3370.016; Thu, 10 Sep 2020
 02:30:49 +0000
From:   Jiafei Pan <jiafei.pan@nxp.com>
To:     Jiafei Pan <jiafei.pan@nxp.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "romain.perier@gmail.com" <romain.perier@gmail.com>,
        "will@kernel.org" <will@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Jiafei Pan <jiafei.pan@nxp.com>
Subject: RE: [PATCH v2] softirq: add irq off checking for
 __raise_softirq_irqoff
Thread-Topic: [PATCH v2] softirq: add irq off checking for
 __raise_softirq_irqoff
Thread-Index: AQHWcfgudE7i05P+bEWkZs6dF3c1EqlhT3yg
Date:   Thu, 10 Sep 2020 02:30:49 +0000
Message-ID: <AM0PR04MB4772CDBA2B752409916D69AE8A270@AM0PR04MB4772.eurprd04.prod.outlook.com>
References: <20200814045522.45719-1-Jiafei.Pan@nxp.com>
In-Reply-To: <20200814045522.45719-1-Jiafei.Pan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8156b475-48ea-4903-77cc-08d855318807
x-ms-traffictypediagnostic: AM0PR04MB3954:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB3954AB330521FEC90F4C18D08A270@AM0PR04MB3954.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l9V0OsSU9rDP0Tvq7O+yz7EkKkvGGuzgQs+pdqxtKZBBSQdzZEaVbe/4xLIALkX9NZcS7ePK0AFwsr7JIdMG1l8z1lxmxXWHQ9J9/0ifcN9/sMyzXcE7y0o98SZQGz1drjmrgnWjzOH7n0F55Z4OYal78nSuHtpnfNn+9WIwFBO4RuZdb6xo3GxEgrCCkwfQnSLLyK2zM0tzZqxFByTONGVR8fwe7qkL1Ock26qKxckXP9oRqy8vfOPk+KWZvuyDKayUJUGsgEpPUFP4iSG8Sc3DlbKcAkU9fY/ujA/5BFLXMpkcadp2FtSzkY1GQHCkbPaM9tUzFULUALNmRvF2vw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4772.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(66556008)(66446008)(76116006)(66946007)(66476007)(64756008)(8936002)(33656002)(44832011)(5660300002)(71200400001)(83380400001)(316002)(52536014)(7696005)(53546011)(26005)(186003)(2906002)(9686003)(55016002)(8676002)(86362001)(4326008)(6506007)(54906003)(478600001)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 6fjLStTioXN3AYXa8qGYWNy3vicQEP2G7YNoAtwMKlcmrvOsSNsWjD/AuqHA4Jd7KXZb1XeYXtPJJQEX5H4XWmU99W/jnu1QSSsUrYe5f6msPFQPKZsIoilepl3fS7/N6efs48dxheVDcaGbxj2e08a/HskXIrGrlD02XS3TxebZY96R//uq8CQ0YjskOGHsMiZz0aSgOZYDtJi45UVBoMpEVbSpf+o4BWahsPP1gXylXdDQN/3ZBZt0JQ3qrgvLKd3EyAyeCxRP0iivYRyyXZj50tcnq2qbmA2dKLuraQEfLchJHq9VACdr512ZD7dAIcn0OPgVA/QzHqM8Y8bqxzA7P9CmI9aXhCVmdJbalhq1EPbV3u6rnKPk0xNPgZyzfTVykHj1gARII6m+RSqlRC41zNuTPFPcRpE8dCoP8mWwYu23fNk7NUBoR2QM1HlqRKkxjeME4kYkixRx91VNmD/1f2IDYoPC2qZTeoZ6jDuVBkbO+Mq9mlj7Vis5D9xZqVJJ+Il0q8BInO7V05+9sO22enFk7MY/90KBEAvbtGs97EXQrqcDPq7WfAxZwadDy4Ia2N0UXcf/qyLV5p/5ya+1Md3ke99q2p5C/9b1XX+EZx7PnSYceTk0q6RsIGWhNAlaTLY1vZ3WIp4m8aIwTg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4772.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8156b475-48ea-4903-77cc-08d855318807
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2020 02:30:49.4955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fm8M4VtfYhkWY2r5SpqbOLuF6PpkK4lxc9jz0A1/0KaRhBFIFOtPQjInVLrxpfd49dlQqgzVmp2Y7p86rJChww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB3954
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

@Thomas Gleixner, any more comments for v2 patch? Can we merge it? Thanks.

Best Regards,
Jiafei.

> -----Original Message-----
> From: Jiafei Pan <Jiafei.Pan@nxp.com>
> Sent: Friday, August 14, 2020 12:55 PM
> To: peterz@infradead.org; mingo@kernel.org; tglx@linutronix.de;
> rostedt@goodmis.org; romain.perier@gmail.com; will@kernel.org
> Cc: linux-kernel@vger.kernel.org; linux-rt-users@vger.kernel.org; Jiafei =
Pan
> <jiafei.pan@nxp.com>; Leo Li <leoyang.li@nxp.com>; Vladimir Oltean
> <vladimir.oltean@nxp.com>; Jiafei Pan <jiafei.pan@nxp.com>
> Subject: [PATCH v2] softirq: add irq off checking for __raise_softirq_irq=
off
>=20
> __raise_softirq_irqoff() will update per-CPU mask of pending softirqs,
> it need to be called in irq disabled context in order to keep it atomic
> operation, otherwise it will be interrupted by hardware interrupt,
> and per-CPU softirqs pending mask will be corrupted, the result is
> there will be unexpected issue, for example hrtimer soft irq will
> be losed and soft hrtimer will never be expire and handled.
>=20
> Enable CONFIG_PROVE_LOCKING to use lockdep_assert_irqs_disabled() to
> check hardirqs and softirqs status, and provide warning in irqs enabled
> context.
>=20
> Signed-off-by: Jiafei Pan <Jiafei.Pan@nxp.com>
> ---
> Changes in v2:
> - use lockdep_assert_irqs_disabled()
> - removed extra comments
> - changed commit message
>=20
>  kernel/softirq.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index bf88d7f62433..09229ad82209 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -481,6 +481,7 @@ void raise_softirq(unsigned int nr)
>=20
>  void __raise_softirq_irqoff(unsigned int nr)
>  {
> +	lockdep_assert_irqs_disabled();
>  	trace_softirq_raise(nr);
>  	or_softirq_pending(1UL << nr);
>  }
> --
> 2.17.1

