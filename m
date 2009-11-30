From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Ethernet issues with lite5200 board from linux-2.6.31
Date: Mon, 30 Nov 2009 08:59:08 -0700
Message-ID: <fa686aa40911300759h153b3300uc54b5d1871bfc839@mail.gmail.com>
References: <d1f76ba30911300038w272578dfx9adb116bde493e00@mail.gmail.com>
	<d1f76ba30911300150g10c1382clb2958245ebf94362@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Carsten Emde <ce@ceag.ch>,
	Clark Williams <williams@redhat.com>,
	Frank Rowand <frank.rowand@am.sony.com>,
	Robin Gareus <robin@gareus.org>,
	Gregory Haskins <ghaskins@novell.com>,
	Philippe Reynes <philippe.reynes@isismpp.fr>,
	Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
	Will Schmidt <will_schmidt@vnet.ibm.com>,
	Darren Hart <dvhltc@us.ibm.com>, Jan Blunck <jblunck@suse.de>,
	Sven-Thorsten Dietrich <sdietrich@novell.com>,
	Jon Masters <jcm@redhat.com>,
	Mark Knecht <markknecht@gmail.com>,
	John Kacur <jkacur@redhat.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
To: Yogesh Chaudhari <mr.yogesh@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:35917 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570AbZK3P7W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 30 Nov 2009 10:59:22 -0500
In-Reply-To: <d1f76ba30911300150g10c1382clb2958245ebf94362@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Nov 30, 2009 at 2:50 AM, Yogesh Chaudhari <mr.yogesh@gmail.com>=
 wrote:
> Hello,
> =A0 =A0 =A0 =A0 I am running linux kernel with rt patch on embedded b=
oard
> based on lite5200 eval board. From linux-2.6.31 release, in which the
> mdio patch has gone inside, =A0the fec ethernet does not come up on t=
his
> board. I get the following message at startup:
> mpc52xx MII bus: probed
> mdio_bus f0003000: error probing PHY at address 1
>
>
> After the bootup if I try to do a ifconfig I get the message:
> net eth2: of_phy_connect failed
>
>
> If I change the value of reg in dts file (lite5200.dts) to 0 then thi=
s
> ethernet comes up. However upto this kernel version, this was not
> required.
>
> Ethernet does not come up on board with original lite5200.dts file

Is your board based on the Lite5200 or the Lite5200B?  The phys are at
different addresses on those two revisions of the board.  There is a
different .dts file for each board.

> phy0: ethernet-phy@1 {
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg=
 =3D <1>;
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
>
> Ethernet comes up on board with this change
> phy0: ethernet-phy@1 {
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg=
 =3D <0>;
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};

Some PHYs treat address 0 as the 'broadcast' address.  You need to
fill in this field (and modify the ethernet-phy@<address> node name)
to reflect the address that your phy is actually at.

g.
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
