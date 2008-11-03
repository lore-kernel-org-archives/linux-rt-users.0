From: Bo Hansen <bh@newtec.dk>
Subject: Trouble compiling 2.6.26.6-rt11 for ARM
Date: Mon, 03 Nov 2008 16:02:56 +0100
Message-ID: <490F12A0.4030500@newtec.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pasmtpa.tele.dk ([80.160.77.114]:53753 "EHLO pasmtpA.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755667AbYKCPC5 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 3 Nov 2008 10:02:57 -0500
Received: from [192.168.0.180] (cpe.atm2-0-1011223.0x50c6e022.odnxx2.customer.tele.dk [80.198.224.34])
	by pasmtpA.tele.dk (Postfix) with ESMTP id F1D09800F75
	for <linux-rt-users@vger.kernel.org>; Mon,  3 Nov 2008 16:02:55 +0100 (CET)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I am trying to compile 2.6.26.6-rt11 for an ARM-based board using
AT91RM9200,
but get the following error message when I compile:

  LD      .tmp_vmlinux1
kernel/built-in.o(.text+0xdf08): In function `$a':
: undefined reference to `wrong_size_cmpxchg'
kernel/built-in.o(.text+0xe05c): In function `$a':
: undefined reference to `wrong_size_cmpxchg'
kernel/built-in.o(.text+0xe32c): In function `$a':
: undefined reference to `wrong_size_cmpxchg'
make: *** [.tmp_vmlinux1] Error 1

I get the message both using my custom board and the EK-board from Atme=
l.
The cross-compiler is version 3.4.1.

Any ideas of what has gone wrong?


Best ragards,
Bo Hansen




--=20

Med venlig hilsen/ Best regards<br>
<br>
Bo Hansen<br>
<br>
Newtec A/S<br>
St=E6rmoseg=E5rdsvej 18<br>
5230 Odense M<br>
Denmark<br>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
