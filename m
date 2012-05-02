From: Marcus Liebhardt <marcus.liebhardt@yujinrobot.com>
Subject: real-time CAN bus with Linux on ARM (Beagleboard/bone)
Date: Wed, 2 May 2012 11:27:03 +0900
Message-ID: <CAKG=6c7PCBrBCvBYSnz8pXGeiudFvS3tQpAi1b3ZK1ker_HEUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:48520 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758065Ab2EBC1E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 1 May 2012 22:27:04 -0400
Received: by obbtb18 with SMTP id tb18so289450obb.19
        for <linux-rt-users@vger.kernel.org>; Tue, 01 May 2012 19:27:04 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi everybody!

Due to bandwidth and latency problems, I am currently investigating a
set-up involving CAN bus, an ARM board and a Linux RTOS to improve our
motion control framework. For development and testing purpose, I have
the following set-up in mind:
A master node consisting of the Beaglebone [1] (similar to the
Beagleboard, powered by an ARM Cortex A8) in combination with a CAN
Cape [2] (includes two MCP2515 CAN controllers and additionally allows
the use of the integrated CAN controller of the ARM microprocessor).
The other nodes in the CAN network are custom boards.

Before going into details about performance and configuration, I like
to ask, if there is anybody out there who successfully applied the
RT-patch to a kernel working on the Beagleboard?
There have been discussions on this list and elsewhere about this
topic, but I couldn't find out, if someone finally succeeded in this.
However, this paper [3] made me believe it is possible.

Since I am no expert in ARM software development, Linux, CAN nor
real-time systems, I'm looking for a working solution with a (as)
simple (as possible) configuration.
In my investigation I took a look at Xenomai (see [4] for example
set-up), but discarded it, because I couldn't find real-time safe
drivers for the mentioned CAN devices.
Using the Linux RT-patch seems to be less work than setting up Xenomai
and writing specific modules for it. Also, telling from what I read in
this interesting discussion [5] it should be well-suited for our
requirements - we need 10 ms cycles and latencies below 1 ms should be
enough, since that is already much better than what we have now.

However, the CAN support still gives me an headache. The CAN cape
manufacturer claims a SocketCAN support. However, I'm not sure, if the
SocketCAN driver is suitable for RT applications. As far as I
understood, the RT patch will not change or affect the SocketCAN
driver, meaning that it will not make this driver real-time safe. So,
I am wondering if a SocketCAN device will actually support the cycle
time and latency we need. I read, that one can tune the RT system by
configuring it according to one's needs. For example, I could adapt
the priorities of the IRQs connected to the CAN device. Assuming what
I wrote so far is correct - please correct my if otherwise - my
question is:
Do you think the described set-up is feasible and will support our requ=
irements?

Thanks a lot for your feedback!

Best regards,
Marcus Liebhardt

[1] http://beagleboard.org/bone
[2] http://www.towertech.it/en/products/hardware/tt3201-can-cape/
[3] https://www.osadl.org/fileadmin/dam/rtlws/12/Brown.pdf
[4] http://veter-project.blogspot.com/2011/09/real-time-enough-about-pw=
ms-and-shaky.html
[5] http://www.spinics.net/lists/linux-rt-users/msg05648.html

--=20
Dipl.-Ing. (M.Sc.) Marcus Liebhardt
Control Engineer
Yujin Robot
=C1=D6=BC=D2: =B4=EB=C7=D1=B9=CE=B1=B9 =BC=AD=BF=EF=BD=C3 =B1=DD=C3=B5=B1=
=B8 =B0=A1=BB=EA=B5=BF 345-30 =B3=B2=BC=BA=C7=C1=B6=F3=C0=DA #601, 153-=
023.
Address: Door #601, Namsung-Plaza, 345-30 Gasan-dong, Guemcheon-gu,
Seoul, 153-023, Republic of Korea
Website: http://www.yujinrobot.com
Email: marcus.liebhardt@yujinrobot.com
Phone: +82-2-2104-0435
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
