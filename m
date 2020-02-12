Return-Path: <SRS0=WKTr=4A=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0653C2BA83
	for <linux-rt-users@archiver.kernel.org>; Wed, 12 Feb 2020 12:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC67320714
	for <linux-rt-users@archiver.kernel.org>; Wed, 12 Feb 2020 12:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sigfoxgroup.onmicrosoft.com header.i=@sigfoxgroup.onmicrosoft.com header.b="Qv1/WKJx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbgBLMK1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 12 Feb 2020 07:10:27 -0500
Received: from mail-eopbgr90124.outbound.protection.outlook.com ([40.107.9.124]:7344
        "EHLO FRA01-MR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727511AbgBLMK1 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 12 Feb 2020 07:10:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgsi1sxGsv+/xnyYdKY5rybcAwFdAWlssouHe1fQVN9tnHQiiJbq5ARvP8XcocX4v3H8buHBl9aqrc5Yd4upYSNDmi5F2l43vMLpcdFDndvXNGr26EQaw8yqIpMLjMEUBPdOql8DSw3EwhLg6R1Z11Jp2a+jS5r2GLmdqUAfHxByKMLb+nq89HGBZyDhFs7c33KgXg0XceQd/szMNs2Uh7hc00jIjEf4le9A5FdxUQAKrJQ9bWubOMfhu5th0qlG4yYTl26KENaqZNjlcN7abY8csjehCmmjfVbepKXFtmMQYI/zHwqhl3jS9+5gvEOkCzuBKxkEWS6Rcn2zrtPNaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbLyRdyjlgPdHzIc6StFYT6IEmI84qy+89Z6wTZzF3w=;
 b=Zxn3EuRY/3060NklJ45+bSxJDxedCileyPCh2LOzqK4Xzz5XUO26KVYQM+onA28cTzczPSoNVYLXQuy3H7OlHVXt1JSLs8ZXLuw8jal2MRz/DCUaoDaz9ooiQEKnyRLmffsVdJxAKOskd4USyGEs9eBqLip8/eb4PWy3cw6zGgCzsgCcQN0/Ap8MP+u4K66b8cAGxQI0ojlU0NA3j+snAXa3oNaZXPOS/TqMRD3UBqqOJ8UPji1LPCYaF+3uXtBVRyaVnwhn5WKrgJR8nw/GsZOY6YLeXiNmnSHNo9OT1NPWPyfedE1mnxJcRMAox0VScVGLfsDibXubNYoujrEpnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sigfox.com; dmarc=pass action=none header.from=sigfox.com;
 dkim=pass header.d=sigfox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sigfoxgroup.onmicrosoft.com; s=selector2-sigfoxgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbLyRdyjlgPdHzIc6StFYT6IEmI84qy+89Z6wTZzF3w=;
 b=Qv1/WKJxWkqAitXOCS/oD5fuGDDLQEQ+NcF8e7guSAF8ZEeZcvail2Ro3SkavB3oXQx09IgRQKYOI5/AAyQSFoxhSjS5LlADb2KtaWOQh/gwvtclqYps4MBrPQCgmYXC5QL0q+F7gPuRZuiCqXOlPhyfQ/I4PjW8UXGrsu/hWcA=
Received: from PR2PR08MB4681.eurprd08.prod.outlook.com (52.133.109.85) by
 PR2PR08MB5227.eurprd08.prod.outlook.com (52.133.109.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Wed, 12 Feb 2020 12:10:24 +0000
Received: from PR2PR08MB4681.eurprd08.prod.outlook.com
 ([fe80::c5a8:cbea:a35f:8954]) by PR2PR08MB4681.eurprd08.prod.outlook.com
 ([fe80::c5a8:cbea:a35f:8954%7]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 12:10:23 +0000
From:   Sebastien Fabre <sebastien.fabre@sigfox.com>
To:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: Crash tool issue since printk re-implementation
Thread-Topic: Crash tool issue since printk re-implementation
Thread-Index: AQHV4Z0DMneVuOIHDECluE/mKO5t0w==
Date:   Wed, 12 Feb 2020 12:10:23 +0000
Message-ID: <PR2PR08MB4681072153BF9E79416BD305951B0@PR2PR08MB4681.eurprd08.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sebastien.fabre@sigfox.com; 
x-originating-ip: [217.114.204.178]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e072956-38c0-4756-3e66-08d7afb489f0
x-ms-traffictypediagnostic: PR2PR08MB5227:
x-microsoft-antispam-prvs: <PR2PR08MB5227B211F78673A87BA84CC3951B0@PR2PR08MB5227.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0311124FA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(39850400004)(136003)(366004)(346002)(376002)(189003)(199004)(33656002)(8676002)(8936002)(66476007)(186003)(2906002)(316002)(4744005)(81166006)(76116006)(44832011)(66446008)(7696005)(64756008)(66556008)(66946007)(81156014)(5660300002)(52536014)(6506007)(71200400001)(55016002)(9686003)(6916009)(478600001)(26005)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:PR2PR08MB5227;H:PR2PR08MB4681.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: sigfox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zX1aPv5qywCsKLQ0zYeHbq5lHsc66EE8I83ndQsjnjgQtabx3BxqmvLcS6MIQmIjUTlxo3lNFpLCxwbZc7nV6WKIPL7aGXgheZq44mMvMe2EWyMn76fmOOzBMQroZbYz7GfDQRy8q/WT0nKeO0IXQB99vpwLoeiWNtWYlEM3lFKawKV6f/Vye4WzuVRs9s+xzKpuWI2z7DxCkAI/KqaPh+m7NgPBai2sLK54djmiTR5aMLru0XwQjSNOtE7EyUoQseCCPvXI0XE3DyeWWWdB50MA0+GV5+GMn2OZxpesCVlek83VVVMbFzZKM96eH1E+a7KVAObuv9dh0cQ6nKZt0zvvcm34nVL6kycwCgtCxn2+ahNSwg8tEpQw1KqOFt7PgaFmL4G1OaGgEnPDbpPo+UPZBoyz1ZVGQE8tgbfbLl+ca7JLBeV98RMqV9/W51o5
x-ms-exchange-antispam-messagedata: 4DRf50LcHJPHaSP45kxj7sjcCrDoieo0+phmZJgSvRK/OukrOOQ7koTV26tLYCA7/1rlASIv5eLefKtdxzoMlGxRNma03bow5seBZRYOZ0vMoyYLr9lYu3SXS2HLnBR0h6oF0T5KDtcWwHuvej95Cw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sigfox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e072956-38c0-4756-3e66-08d7afb489f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2020 12:10:23.8662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcbc8bb1-061e-4b94-9f70-3ad917b0c8d3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a5Kl642fKXRTMxuAVWIE/8BI33J1J1Uz6yTmjLfEqxFoJkhhKcXCAnOiJyMitjVEZttBiqv4fFfnqUgJxV0xy6szIhMTDVyq9nHAuMV0VW4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR08MB5227
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello,=0A=
=0A=
Since kernel v5.0, PREEMPT_RT patches contain printk re-implementation. Thi=
s re-implementation removes some log symbols in =0A=
VMCOREINFO and crash tool cannot retrieve kernel logs (because symbols no m=
ore exist).=0A=
Is this impact on crash expected? If so, how can we retrieve a functional c=
rash tool with kernel v5.0 (and following) ?=0A=
=0A=
Thanks,=0A=
Fabre Sebastien=
