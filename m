From: Victor henri <nadaeck@hotmail.com>
Subject: disk thread problem when using RT-kernel
Date: Sat, 29 Jan 2011 22:41:47 +0100
Message-ID: <SNT110-W222DEC20897CB3D9F79E20A8E00@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from snt0-omc1-s7.snt0.hotmail.com ([65.55.90.18]:2036 "EHLO
	snt0-omc1-s7.snt0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751350Ab1A2Vls convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 29 Jan 2011 16:41:48 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Hello:=20

I have a problem since almost one year now. I'm using linuxsampler, tha=
t allows that load very big sample files (one of my .gig file is 1.6 G =
for only one piano sound); this use disk streaming.

I always have such problem only when i use the RT kernel :=20

0x7f6eef1ee860 Disk stream not available in time!=20

After several message slike that, i get :

DiskThread: there was no free slot
Disk stream order failed!

Then the sounds clicks, then stops for 10 to 20 seconds, then i can pla=
y again, then it'll come again...

This arrives on both Gentoo and Ubuntu 10.10 64 bits; BUT there is one =
thing however : there is ONE kernel with wich it doesn't arrive : the 2=
=2E6.31.11-rt from Ubuntu lucid (RT kernel was in the repositories in U=
buntu untill 10.04 Lucid, then now i have to either take it=A0 from Abo=
gani's ppa (for lucid or natty) or compile it myself with the rt-patch =
from kernel.org; i've tried all of that, and nothings works, except for=
 the 2.6.31.11-rt from in the repositories of Ubuntu Lucid-updates)

Here are some technical details:
=A0=A0=A0 - I have laptop Asus Core i7 for gamers (supposed to be very =
fast);to be noted : it also happens on another Asus Core I7, but NOT on=
 an another Asus Core i3; 4Go RAM;
=A0=A0=A0 - when i compile myself i choose : real-time preemption (of c=
ourse) and Timer frequency 1000 Hz, either on Gentoo or on Ubuntu with =
kernel from kernel.org; nothing else is changed in Ubuntu.
=A0=A0=A0 - i've tried with the no-op cfq scheduler also; i use ext3 on=
 Gentoo and ext4 on Ubuntu;
=A0=A0=A0 - have a nvidia garphic card, but no proprietary driver insta=
lled....

Could please someone help me? i LOVE RT-kernel and its capabilities....


i have posted that to several lists, including linuxsampler's without s=
ucces....

Victor


 		 	   		  --
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
