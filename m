Return-Path: <SRS0=HWFh=7I=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E9AC433E0
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 May 2020 15:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB384206D5
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 May 2020 15:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mobileye.onmicrosoft.com header.i=@Mobileye.onmicrosoft.com header.b="Bq+k2MEp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbgEZPBn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 May 2020 11:01:43 -0400
Received: from mail-vi1eur05on2074.outbound.protection.outlook.com ([40.107.21.74]:6090
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728110AbgEZPBm (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 May 2020 11:01:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNlBON5GjZZX+/v4cfaGgBRoeuPhEYkIEwQQJQaGqTNk/0gV5oXUiSQO+mRW28LtP5ZebQZLz6l/JRt/Bw1lgaCJNUbDXrKtgqrt04Sm1K6i7Wt2pVHlAYkC96Gfv0KMqzaafQ5oNGdnJnWepu3TMQ/K1ujb11pQdRIoeCEo7tbSFrtxG0jyR71f+PVz4e7q+kF43+1XRCQLH0FiVxb35OASfxi4ja3xvHFTcrm+yDQ5f27u79YUwZKDYTouYkfDocbKE9zfxLLmL2xXjSMUSfg3g5rD69rbCZ/FruLiPsnXPLnfdZO5DquYPbSFjmsKn/lzZpvKD+ruzoXmGuMKFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Whp2aB9Qshslvp8xBztLydzHyaDuY7L2YIx9CfH7mVU=;
 b=Zw0AqxLmtdUrD3YEJxwH17EgJSwIaVNsx6hASu9jP4r5Ttr80+IZbE5kyGo/KOpAFoP6vV/2k91xfNJLbvjQH0IMrn5mmKO6aj5auSACmTbhAn3cne7BKPG1xau0rm3c0iwB72cyLWfQ8dm6uHJNaorlGASRidoTh3yHfPltmwOabG8S7diK40JMIJxBzo3ebXTvLOdgzGAQ3LZncclCrqocRsspGs7okWtZt+2YvmCcQVLMCqSiZm+6KPryEgkOtZRhXwaDZ/xdIJwzAgHlYuvXEr8Lpgoyktq+SscPuKBgd5KCG55pIXnO7+4snzefht8Wlqh3uVBJ7V/MYVfnLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mobileye.com; dmarc=pass action=none header.from=mobileye.com;
 dkim=pass header.d=mobileye.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Mobileye.onmicrosoft.com; s=selector2-Mobileye-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Whp2aB9Qshslvp8xBztLydzHyaDuY7L2YIx9CfH7mVU=;
 b=Bq+k2MEpP/B8rOlg+2Wodw8JXtR4waIKpi/z2euJ/3wb4M4IKwtlWMEtrpKQ51eTWUEq9qwEqQzTiepTQG1AN9L9G8KlSrDPvlGRomJfI3xsK14xm8GrnWUOufR2EIpo8MB3aC/cTdMEmoNEAIHUeQboAuxzBLA7sjoPW2alkQU=
Received: from AM0PR09MB3794.eurprd09.prod.outlook.com (2603:10a6:208:181::15)
 by AM0PR09MB3426.eurprd09.prod.outlook.com (2603:10a6:208:16e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Tue, 26 May
 2020 15:01:38 +0000
Received: from AM0PR09MB3794.eurprd09.prod.outlook.com
 ([fe80::684a:f459:15f6:3e1c]) by AM0PR09MB3794.eurprd09.prod.outlook.com
 ([fe80::684a:f459:15f6:3e1c%6]) with mapi id 15.20.3021.029; Tue, 26 May 2020
 15:01:38 +0000
From:   Elana Copperman <Elana.Copperman@mobileye.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Vladimir Kondratiev (Mobileye)" 
        <63dc4b5d-c467-4bfb-bce5-74485907c850@intel.mail.onmicrosoft.com>
Subject: Re: cgroups CPU time management + PREEMPT_RT
Thread-Topic: cgroups CPU time management + PREEMPT_RT
Thread-Index: AdYkm/M/lU1yRRU5Sia9bqNtzqcgHQABswywAO9u+OsAADfTaQAAPKEAAAAUa8ACwgHSAAAAMu7HAAC8TOs=
Date:   Tue, 26 May 2020 15:01:38 +0000
Message-ID: <AM0PR09MB379432CB4C255440C91B932899B00@AM0PR09MB3794.eurprd09.prod.outlook.com>
References: <AM0PR09MB3794D873EEAE20CD9201D14299A50@AM0PR09MB3794.eurprd09.prod.outlook.com>
 <AM0PR09MB3794E9CFE8BA31852B712DAD99A50@AM0PR09MB3794.eurprd09.prod.outlook.com>
 <AM0PR09MB3794F5E857CB761859BBEF0B99BE0@AM0PR09MB3794.eurprd09.prod.outlook.com>
 <AM0PR09MB3794A1DA3C38B31A4A16E9DD99BE0@AM0PR09MB3794.eurprd09.prod.outlook.com>
 <20200512093612.416899e1@gandalf.local.home>
 <AM0PR09MB3794A35CEC4017897544E40999BE0@AM0PR09MB3794.eurprd09.prod.outlook.com>,<20200526143340.ooykhoszyd4lxi2g@linutronix.de>,<AM0PR09MB37947DEF27E4D91EE8B0BD1A99B00@AM0PR09MB3794.eurprd09.prod.outlook.com>
In-Reply-To: <AM0PR09MB37947DEF27E4D91EE8B0BD1A99B00@AM0PR09MB3794.eurprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=mobileye.com;
x-originating-ip: [77.124.25.28]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8eb8e02f-483a-401b-233d-08d80185b107
x-ms-traffictypediagnostic: AM0PR09MB3426:
x-ld-processed: 4f85ba13-6953-46a6-9c5b-7599fd80e9aa,ExtAddr
x-microsoft-antispam-prvs: <AM0PR09MB34268E6333DF11015895798999B00@AM0PR09MB3426.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 041517DFAB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1JvAx7D719OoPIrgcm9nJMq/SxpT6GUisHAIvRX1psncziBaatOzdj87DF/UzkDLHOD5lhqplYCYhgOf8qywBX0K1oWn53cLiOoRA7nSidL9yBO3JKi2wSaovtwSM8QlXwf/HzN4GoY4rwTkimfA8XfQdbqX4W0+z5WluNrTBavDuQD10bTgvj7sd1ek1C+SfQuSORVWjyZRsmnqOl9nDpvymqUDTnA8AWFfzvjiDrFHRo6V4CVfeX/GWLPQT5wj6cBVkYFOsUqvhBUzKuD6L6n+7YAKV8+FlyGBD+u1tNu2S5GibJr9x/dTVXbJaNjp96Ehb570k2wr0i7mET03tx19V6D+DxqUVh52sPcEAHLYU0UYVxGCogYXbwMi/+BhXQ0rq9QoR8gYrm8a5QBIBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR09MB3794.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39850400004)(396003)(346002)(376002)(136003)(366004)(316002)(54906003)(52536014)(26005)(7696005)(71200400001)(966005)(478600001)(6916009)(9686003)(55016002)(76116006)(4326008)(53546011)(8676002)(8936002)(86362001)(186003)(2906002)(64756008)(33656002)(2940100002)(66946007)(66446008)(66476007)(5660300002)(66556008)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: j9A4GLRXZ35Y0zXnZMa/kQ5czn8RNbNFo4jSNUi42vsxIaLrFLbsiSp14kYjr6nOZpzgJxFTQVm+hoK4dBaO9go9Woe9TgjFxgiCavQaApPbSExih3OdyVoO/vkYXM/LRm8RD+8uXKb1goJplVEp/ROk9fabTZnDvmJhBkj+M5m4Q9t5HMmmhdm9kp06RGI7pYuBSEr4sM7QqbvsWOSFMBYbaE+4beLV7WpfNlyoTOQKOmse3H5CheSDUXTqV1oL6yOJOLD8EVaUsbO/Q30wX2aJrKmgqnf+C6QDTonX5cvKynkh1XTsSpYNDl4r8s5nh7rCxL7MjH5he1h9r9LOrR38bqpv/EqbEz4oWJCv7RflS0ldceZqfV6lo3u4ypJ/ePVLxxTKU2d7zaGfIrGPJSUrb6KiHtZpwDFJlen/IUtSTTaEAhKPtQM8MxUncErO1b0pjn4h8+Yd9r4CvegMK0fjT40xVYb1h3ZarVhB8Gk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mobileye.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb8e02f-483a-401b-233d-08d80185b107
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2020 15:01:38.4601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4f85ba13-6953-46a6-9c5b-7599fd80e9aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zGzo8EYcOKnIjuG+C2I14M1zQoCzmLF0WeeAM0EJvPeLu5wTFoTnl0KGg+3/HNn/Rf9JZdoAWWfDTQf9M2vo/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB3426
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Thanks, Sebastian, for your reply.=0A=
Yes, it is about RT_GROUP_SCHED (and related parameters such as cpu.rt_runt=
ime_us and cpu.rt_period_us).=A0 The documentation=A0 (such as=A0 =A0https:=
//www.kernel.org/doc/Documentation/scheduler/sched-rt-group.txt=A0) is fuzz=
y on details and is not dated, so it was not clear if we were missing anyth=
ing.=0A=
=0A=
Anyhow, thanks for the confirmation.=A0 I think we will go back to the orig=
inal plan and avoid using cgroups for managing CPU time for RT tasks.=A0 =
=A0Perhaps with time and experience on the implementation, we may have a be=
tter view on how to properly enable this.=0A=
Regards=0A=
Elana=0A=
=0A=
=0A=
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>=0A=
Sent: Tuesday, May 26, 2020 5:33 PM=0A=
To: Elana Copperman <Elana.Copperman@mobileye.com>=0A=
Cc: Steven Rostedt <rostedt@goodmis.org>; linux-rt-users <linux-rt-users@vg=
er.kernel.org>; Thomas Gleixner <tglx@linutronix.de>; Vladimir Kondratiev (=
Mobileye) <63dc4b5d-c467-4bfb-bce5-74485907c850@intel.mail.onmicrosoft.com>=
=0A=
Subject: Re: cgroups CPU time management + PREEMPT_RT =0A=
=A0=0A=
On 2020-05-12 13:41:03 [+0000], Elana Copperman wrote:=0A=
> =0A=
> =0A=
=0A=
I think you missed to write a reply or I didn't find it.=0A=
So if this is about RT_GROUP_SCHED then it is disabled in RT because it=0A=
was once broken. Since then people asked about it and I told them to=0A=
please test it and report back what the results are but I never got a=0A=
reply back.=0A=
=0A=
Sebastian=
