Return-Path: <SRS0=5J30=EC=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292EBC388F9
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Oct 2020 10:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FB5B22281
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Oct 2020 10:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="VXvMwB+n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897629AbgJ0KPL (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 27 Oct 2020 06:15:11 -0400
Received: from mout.gmx.net ([212.227.15.19]:56227 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897625AbgJ0KPL (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 27 Oct 2020 06:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603793676;
        bh=YHRRfYRGc91VNM79s1hEOE/V83DGdQaW7vfwAUIEhbs=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=VXvMwB+nMS88B9widyrIpun7F6dLu5XRxZ4Mo2lif+j9zPppifh9XHGZ7yznz4Jd7
         IKOfW4Um5rpjvgb856yaQEZURHSKvVtvi0662Us0OvfMARInrniW4opuzseVzpGTnp
         xBdUOI6VX/YBROoR/bV50i3JRrThvRd2zabgvzuo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.simpson.net ([185.146.51.69]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2wGs-1kYSzQ1sLc-003NrA; Tue, 27
 Oct 2020 11:14:36 +0100
Message-ID: <7bbfce68bdd01e1d48d3d2c6f9581654e380bf2d.camel@gmx.de>
Subject: Re: kvm+nouveau induced lockdep  gripe
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Hillf Danton <hdanton@sina.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Skeggs <bskeggs@redhat.com>
Date:   Tue, 27 Oct 2020 11:14:34 +0100
In-Reply-To: <20201027090019.3vteojm43ljqqe33@linutronix.de>
References: <20201021125324.ualpvrxvzyie6d7d@linutronix.de>
         <a23a826af7c108ea5651e73b8fbae5e653f16e86.camel@gmx.de>
         <20201023090108.5lunh4vqfpkllmap@linutronix.de>
         <20201024022236.19608-1-hdanton@sina.com>
         <20201024050000.8104-1-hdanton@sina.com>
         <20201026173107.quylcy6fgjvrqat6@linutronix.de>
         <431e81699f2310eabfe5af0a3de400ab99d9323b.camel@gmx.de>
         <20201026195308.wsbk7xy57wuzfbao@linutronix.de>
         <0dfae65db2f0d3ef603c1db34f37cee63f7f41f4.camel@gmx.de>
         <20201027090019.3vteojm43ljqqe33@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:9Q42f24oJLVXjhDwIWgKy4YtoPVEn9FY5YJ3sdrQ1zC1X230qhr
 mm42WixXXkQBsp3F4Bi/HdKWnmFWd5on/LYNdtmk3310N9CVYn86P3B6r4VF+Qm2IIltfHd
 igoH+l/J/IUQ/piA0GO0ALzJFqztf5w8eIzgUNhbLbWGlIhDV1ITGpoMa9PY5sYjloXSLJH
 oiiBR9EPQHbx9OpADWklw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GpoAzFEgslA=:xERN4cSh7R5W6dZzOfffXW
 q8JTCCyb1qOVcC/fZxzc+TcFXKFwBSziz8Gbx5anqQfge/3MrtyDxTCHLa6wt8YA6TyZEZIiU
 /QVwLKYxkfDDjEGNoylcxNQ1Tyxc4x6l8iQ5TJROppGVcsYrurUjExfPr0BV8DyVH531vRBiU
 5HbXpJfJsDxKxpqarDbmJfuKJBzD/JGELXzZkhTv/wfKpbAhrgQOZKqYqafZQl45wXeEvob1T
 +N28QdYeDbNHjU9jgdBMuVvTsZjRi1NCBTeczee1SA7n0vOOdOPXmpErXccu1C2Z45UCn55Bq
 XIi2NEScj1yhuflVTMeU9XkjXFMPuZ4CHKY/qgixY0dbb3hBAu4+3tXs49NywlhK0exNTOtro
 xcKvvS0P5JnjGyOKwGcIAvMtZVoib1VPRGQzzf9jhPqUiWsnIg86SecLvCd6nQ6dKkLWldpZo
 E9WzfXQZ6uaYLHmp8V5P7vP8CY/aRaW3s81Hv4vxAW06+OekDCigXQRSqPj9St1hEDRy4KohA
 uKZjwiVGhdBdHAz8CF6+PX2JZIK0a5jbWY9SXy6zhCB8c0mBtsd+BjZe6LwmlTaIWD/1FYHtB
 obxXYH7DhrRos8jF9NCHyiCSNhkioAR2mkDTBsTlbsBp5zazOmm2RK4kuXk52SetcJO3fYzSF
 w8ZuV90TymWW1EsKjE3nNIy/LnezXzkP2/pnjcm7MFSiEjRZT8hMD+Qfa9XyjhEOGPxrybP98
 T0SpDXCTHglZRiZQjrI34+X2TuX5JJrxx5sW6K0tYy4KIrwVKevuyK2bUONP9BvarDFmFABca
 b1vasnIGOG8BaRLOvc/O2zbybj3S+g2y/o3Y0vM45l3ggBXqK9PCWReU3IZgNMBL6LvoOMtel
 kY/roVgeE0RU4knHrFzQ==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 2020-10-27 at 10:00 +0100, Sebastian Andrzej Siewior wrote:
> Let me try if I can figure out when this broke.

My money is on...
710da3c8ea7df (Juri Lelli 2019-07-19 16:00:00 +0200 5317)       if (pi)
710da3c8ea7df (Juri Lelli 2019-07-19 16:00:00 +0200 5318)               cpuset_read_lock();
...having just had an unnoticed consequence for nouveau.

	-Mike

