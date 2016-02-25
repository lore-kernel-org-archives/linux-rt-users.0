From: <Martin.Wirth@dlr.de>
Subject: AW: Large latencies with 4.4.1-rt6
Date: Thu, 25 Feb 2016 12:47:31 +0000
Message-ID: <1A2AF5F768264E479963C4D8C015EB691B6973E6@dlrexmbx03.intra.dlr.de>
References: <1A2AF5F768264E479963C4D8C015EB691B692C5C@dlrexmbx03.intra.dlr.de>
 <2742233.B1dMNehWr7@dabox>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <linux-rt-users@vger.kernel.org>
To: <tim@krieglstein.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailhost.dlr.de ([129.247.252.32]:42056 "EHLO mailhost.dlr.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752279AbcBYMrf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 25 Feb 2016 07:47:35 -0500
In-Reply-To: <2742233.B1dMNehWr7@dabox>
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Tim

> -----Urspr=FCngliche Nachricht-----
> Von: Tim Sander [mailto:tim@krieglstein.org]
> Gesendet: Donnerstag, 25. Februar 2016 13:34
> An: Wirth, Martin
> Cc: linux-rt-users@vger.kernel.org
> Betreff: Re: Large latencies with 4.4.1-rt6
>=20
> Hi Martin
>=20
> Am Freitag, 19. Februar 2016, 17:02:20 schrieb Martin.Wirth@dlr.de:
> > I today switched from 4.1.15-rt17 to 4.4.1-rt6.
> > Now I'm seeing large latencies of more than 1 ms.
> > They occur sporadic ( every few minutes) and show up for example
> > running
> It would be interesting to know the platform the rt kernel is running=
 on?

This is an intel  i7-4700EQ CPU @ 2.40GHz machine  on an ADLINK cPCI-65=
30 board.

> I have also seen a latency increase with 4.4.1-rtX releases. I have t=
he
> impression that some stable kernel updates made it worse. Care to tes=
t 4.4-
> rt3 or 4.4-rt4? Had not the chance to pin them down by now.
>=20
The worst case cyclictest latencies (running over serveral hours) with =
pre 4.4.x-rt versions=20
were below 10 =B5s for an idle system and below 23 =B5s for a kernel co=
mpile with make -j4.
Since this is a machine with is in lab-use during the day I hesitate a =
bit to try too=20
early 4.4.x version which might be instable enough to eat my disk.

Best regards,

Martin
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
