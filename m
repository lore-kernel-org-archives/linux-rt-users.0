From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: kernel 3.2.0 with rt patch-3.2-rt10.patch.gz hangs up Ethernet
 module
Date: Tue, 16 Jun 2015 10:11:58 +0200
Message-ID: <20150616081158.GI19996@pengutronix.de>
References: <loom.20150616T094748-860@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Marcus lu <marcus.lu@delta.com.tw>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42217 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910AbbFPIMB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 16 Jun 2015 04:12:01 -0400
Content-Disposition: inline
In-Reply-To: <loom.20150616T094748-860@post.gmane.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

On Tue, Jun 16, 2015 at 07:58:06AM +0000, Marcus lu wrote:
> I try kernel version 3.2.0 and RT patch patch-3.2-rt10.patch.gz on TI=
=20
> AM335x EVM(Cortex A8), I find out a problem.=20
Is there a reason you're not using the latest and greatest 3.2-stable
plust the matching lates -rt patch? Also 3.2 is already old and the
am335x support in mainline is good, so better use a more recent release=
=2E

> My test steps as below :
>=20
> 1. In pure linux directory, I use zcat ../../patch-3.2-rt10.patch.gz =
|=20
> patch -p1 command. (pure means I install TI=E2=80=99s SDK : ti-sdk-am=
335x-evm-
> 0.6.00.00.00-linux-x86-install.bin without changing anything)=20
>=20
> In linux directory :=20
> 2. make ARCH=3Darm CROSS_COMPILE=3D/home/marcus/ti-sdk-am335x-evm-
> 06.00.00.00/linux-devkit/sysroots/i686-arago-linux/usr/bin/arm-linux-
> gnueabihf- tisdk_am335x-evm_defconfig=20
> 3. make ARCH=3Darm CROSS_COMPILE=3D/home/marcus/ti-sdk-am335x-evm-
> 06.00.00.00/linux-devkit/sysroots/i686-arago-linux/usr/bin/arm-linux-
> gnueabihf- menuconfig=20
> 4. Select kernel Features and preemption Model Fully Preemptible=20
> Kernel(RT)=20
> 5. Save .config=20
> 6. make ARCH=3Darm CROSS_COMPILE=3D/home/marcus/ti-sdk-am335x-evm-
> 06.00.00.00/linux-devkit/sysroots/i686-arago-linux/usr/bin/arm-linux-
> gnueabihf- uImage=20
> 7. After building successfully, copy uImage to SD card and power on t=
he=20
> EVM board.
>=20
> 8. Executing iperf -s on linux platform and execute iperf.exe =E2=80=93=
c=20
> 10.0.0.180 =E2=80=93w 100M =E2=80=93t 1200 =E2=80=93I 10 on win 7 pla=
tform.=20
> 9. Ethernet module on linux platform hangs up.(I can=E2=80=99t ping m=
y PC in=20
> linux platform even though I use ipconfig eth0 down and ipconfig eth0=
 up=20
> command)=20
>=20
> Could you give me some suggestion?
Try a vanilla kernel. Vendor kernel tend to use non-optimal stuff that
stands in your way when you start to do things.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig     =
       |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
